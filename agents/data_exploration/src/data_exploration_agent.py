###### Parsers, Formats, Utils
import argparse
import json
import logging

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.data.registry import DataRegistry
from blue.session import Session
from blue.stream import ControlCode
from default_prompts import *
from eda_sql_queries import *
from status import StatusMessage

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)


##### Helper functions
def build_markdown_form(markdown):
    data_schema = {"type": "object", "properties": {}}
    ui_schema = {
        "type": "Markdown",
        "scope": "#/properties/content",
        "props": {"style": {"line-height": "0.7"}},
    }
    data = {"content": markdown}
    return {"schema": data_schema, "uischema": ui_schema, "data": data}


############################
### Agent.DataExplorationAgent
#
class DataExplorationAgent(OpenAIAgent):
    """
    Performs automated Exploratory Data Analysis (EDA) on database tables.

    Automatically selects relevant tables from natural language queries, classifies
    columns by type, computes statistical summaries, and generates markdown reports.
    Uses OpenAI models for query interpretation and SQL for data profiling.
    """

    def __init__(self, **kwargs):
        if "name" not in kwargs:
            kwargs["name"] = "DATA_EXPLORATION_AGENT"
        super().__init__(**kwargs)

    def _initialize_properties(self):
        super()._initialize_properties()

    ####### inputs / outputs
    def _initialize_inputs(self):
        self.add_input("DEFAULT", description="input text query")

    def _initialize_outputs(self):
        self.add_output("DEFAULT", description="data summary", tags=["DATA"])

    def _init_registry(self):
        """Initialize the data registry."""
        # create instance of data registry
        platform_id = self.properties["platform.name"]
        prefix = "PLATFORM:" + platform_id
        self.registry = DataRegistry(
            id=self.properties["data_registry.name"],
            prefix=prefix,
            properties=self.properties,
        )

    ####### helper functions
    def _execute_sql(self, query, source, database, collection):
        results = self.registry.execute_query(query, source, database, collection)
        return results

    def _fetch_data(self, source, database, collection, entity, limit=5000):
        query = f"SELECT * FROM {collection}.{entity} LIMIT {limit}"
        return self._execute_sql(query, source, database, collection)

    # helper functions for data profiling
    def _table_desc(self, source, database, collection, entity):
        query = query_table_desc.format(collection=collection, entity=entity)
        return self._execute_sql(query, source, database, collection)

    def _profile_numerical_col(self, source, database, collection, entity, column):
        full_table = f"{collection}.{entity}" if collection else entity
        query = query_num_basic.format(full_table=full_table, column=column)
        results = self.registry.execute_query(query, source, database, collection)
        query_freq = query_num_freq.format(full_table=full_table, column=column)
        results_freq = self.registry.execute_query(
            query_freq, source, database, collection
        )
        return {**results[0], f"frequency_({column})": results_freq}

    def _profile_categorical_col(self, source, database, collection, entity, column):
        full_table = f"{collection}.{entity}" if collection else entity
        query = query_category_basic.format(full_table=full_table, column=column)
        results = self.registry.execute_query(query, source, database, collection)
        query_freq = query_category_freq_top20.format(full_table=full_table, column=column)
        results_freq = self.registry.execute_query(
            query_freq, source, database, collection
        )
        return {**results[0], f"frequency_({column})": results_freq}

    def _profile_id_col(self, source, database, collection, entity, column):
        full_table = f"{collection}.{entity}" if collection else entity
        query = query_id_basic.format(full_table=full_table, column=column)
        results = self.registry.execute_query(query, source, database, collection)
        return results[0]

    def _profile_text_json_col(self, source, database, collection, entity, column):
        full_table = f"{collection}.{entity}" if collection else entity
        query = query_long_basic.format(full_table=full_table, column=column)
        results = self.registry.execute_query(query, source, database, collection)
        return results[0]

    def _profile_date_col(self, source, database, collection, entity, column):
        full_table = f"{collection}.{entity}" if collection else entity
        query = query_date_basic.format(full_table=full_table, column=column)
        results = self.registry.execute_query(query, source, database, collection)
        return results[0]

    # helper functions for data discovery
    def _list_all_sources(self):
        sources = self.registry.get_sources()
        postgres_sources = [
            src
            for src in sources
            if src.get("properties").get("connection").get("protocol") == "postgres"
        ]
        return [src["name"] for src in postgres_sources]

    def _list_source_databases(self, source):
        databases = self.registry.get_source_databases(source=source)
        return [db["name"] for db in databases] if databases else []

    def _list_source_database_collections(self, source, database):
        collections = self.registry.get_source_database_collections(source, database)
        return [col["name"] for col in collections] if collections else []

    def _list_source_database_entities(self, source, database):
        collections = self._list_source_database_collections(source, database)
        entity_scopes = []
        for collection in collections:
            entities = self.registry.get_source_database_collection_entities(
                source, database, collection
            )
            entity_scopes.extend(
                [[source, database, collection, e["name"]] for e in entities]
            )
        return entity_scopes

    def _list_all_scopes(self):
        scopes = []
        for src in self._list_all_sources():
            for db in self._list_source_databases(src):
                this_scopes = self._list_source_database_entities(src, db)
                scopes.extend(this_scopes)
        return scopes

    ####### default processor
    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if message.isEOS():
            stream_data = ""
            if worker:
                stream_data = " ".join(worker.get_data("stream_data"))
            task_input = stream_data
            logging.info(f"Data exploration task: {task_input}")

            # Initialize status message handler for tracking progress
            st = StatusMessage(self.name, worker)

            # TODO: Sync data registry for db builder

            # Check if any tables exist
            st.append_status("finding relevant table(s)...")
            all_scopes = self._list_all_scopes()
            if not all_scopes:
                error_msg = "❌ No tables found in the data registry."
                logging.error(error_msg)
                st.append_status(f"failed: no tables in registry", 1.0)
                worker.write_data(error_msg, output="TEXT")
                worker.write_eos(output="TEXT")
                return None

            # Use LLM to identify relevant tables from user query
            input_template = self.properties.get(
                "select_scope_prompt", SELECT_SCOPE_PROMPT
            )
            scopes = "\n".join(["/".join(scope) for scope in all_scopes])
            logging.info(f"\n\n===scopes:\n\n {scopes}\n\n")

            selected_scopes_json = None
            for attempt in range(3):
                try:
                    selected_scopes = self.execute_api_call(
                        task_input,
                        properties={
                            "input_template": input_template,
                            "openai.response_format": {"type": "json_object"},
                        },
                        additional_data={"scopes": scopes},
                    )
                    selected_scopes_json = json.loads(selected_scopes)
                    if "selected" in selected_scopes_json:
                        selected_scopes_json = selected_scopes_json["selected"]
                        # Accept any non-empty list (will process first element if multiple returned)
                        if (
                            isinstance(selected_scopes_json, list)
                            and len(selected_scopes_json) > 0
                        ):
                            break
                        else:
                            logging.warning(
                                f"Attempt {attempt + 1}: LLM returned empty 'selected' array"
                            )
                    else:
                        logging.warning(
                            f"Attempt {attempt + 1}: LLM response missing 'selected' key"
                        )
                except json.JSONDecodeError as e:
                    logging.error(
                        f"Attempt {attempt + 1}: Failed to parse LLM response as JSON: {e}"
                    )

            # Validate we got at least one valid table selection
            if (
                not selected_scopes_json
                or not isinstance(selected_scopes_json, list)
                or len(selected_scopes_json) == 0
            ):
                error_msg = f"❌ Could not identify a relevant table for the query: '{task_input}'\n\nPlease try rephrasing your request or specify a table name from the available tables."
                logging.error(error_msg)
                st.append_status("failed: no matching table", 1.0)
                worker.write_data(error_msg, output="TEXT")
                worker.write_eos(output="TEXT")
                return None
            logging.info(f"\n\n===selected:\n\n {selected_scopes_json}\n\n")

            # Profile the selected table (use first element only)
            scope = selected_scopes_json[0]
            summary = []
            to_vis = []
            if not worker.get_session_data("VIS_DATA"):
                worker.set_session_data("VIS_DATA", [])

            source = scope.get("source", "")
            database = scope.get("database", "")
            collection = scope.get("collection", "")
            entity = scope.get("table", "")
            if not source or not database or not collection or not entity:
                error_msg = f"❌ Invalid table selection - {scope}"
                logging.error(error_msg)
                st.append_status(f"failed: incomplete table info", 1.0)
                worker.write_data(error_msg, output="TEXT")
                worker.write_eos(output="TEXT")
                return None

            summary.append(
                f"Based on task input '{task_input}', EDA agent selected the following data:\n[{source}/{database}/{collection}/{entity}]\n\n"
            )

            # Get table-level statistics
            st.append_status(
                f"analyzing selected table [{source}/{database}/{collection}/{entity}]"
            )
            table_desc = self._table_desc(source, database, collection, entity)
            summary.append(f"Table summary:\n{table_desc}\n\n")

            # Retrieve column metadata
            st.append_status(
                f"gathering columns info from [{source}/{database}/{collection}/{entity}]"
            )
            attributes = self.registry.get_source_database_collection_entity_attributes(
                source, database, collection, entity
            )
            cols_desc = ""
            for attr in attributes:
                attr_name = attr["name"]
                attr_properties = attr.get("properties", {})
                cols_desc += f"Column: {attr_name}, Properties: {attr_properties}\n"
            summary.append(cols_desc)

            # Classify columns using LLM (numerical, categorical, id-like, text/json, date)
            st.append_status(
                f"categorizing columns of [{source}/{database}/{collection}/{entity}]"
            )
            input_template = self.properties.get(
                "classify_columns_prompt", CLASSIFY_COLUMNS_PROMPT
            )
            logging.info(f"\n\n===cols_desc:\n\n {cols_desc}\n\n")
            col_profile_types_json = None
            for attempt in range(3):
                try:
                    col_profile_types = self.execute_api_call(
                        cols_desc,
                        properties={
                            "input_template": input_template,
                            "openai.response_format": {"type": "json_object"},
                        },
                        additional_data={
                            "scope": f"{source}/{database}/{collection}/{entity}"
                        },
                    )
                    col_profile_types_json = json.loads(col_profile_types)
                    if "columns" in col_profile_types_json:
                        col_profile_types_json = col_profile_types_json["columns"]
                        if (
                            isinstance(col_profile_types_json, list)
                            and len(col_profile_types_json) > 0
                        ):
                            break
                        else:
                            logging.warning(
                                f"Attempt {attempt + 1}: LLM returned empty columns array"
                            )
                    else:
                        logging.warning(
                            f"Attempt {attempt + 1}: LLM response missing 'columns' key"
                        )
                except json.JSONDecodeError as e:
                    logging.error(
                        f"Attempt {attempt + 1}: Failed to parse LLM response as JSON: {e}"
                    )
                except Exception as e:
                    logging.error(f"Attempt {attempt + 1}: LLM API call failed: {e}")

            # Validate we got valid column classifications
            if (
                not col_profile_types_json
                or not isinstance(col_profile_types_json, list)
                or len(col_profile_types_json) == 0
            ):
                error_msg = f"❌ Failed to classify columns for table [{source}/{database}/{collection}/{entity}] after 3 attempts."
                logging.error(error_msg)
                st.append_status("failed: column classification error", 1.0)
                worker.write_data(error_msg, output="TEXT")
                worker.write_eos(output="TEXT")
                return None
            logging.info(f"\n\n===cols_types:\n\n {col_profile_types_json}\n\n")

            # Compute statistics for each column based on its type
            for col in col_profile_types_json:
                name = col["name"]
                profile_type = col["profile_type"]

                st.update_status(
                    f"analyzing [{name}] column of [{source}/{database}/{collection}/{entity}]"
                )
                if profile_type == "numerical":
                    res = self._profile_numerical_col(
                        source, database, collection, entity, name
                    )
                elif profile_type == "categorical":
                    res = self._profile_categorical_col(
                        source, database, collection, entity, name
                    )
                elif profile_type == "id-like":
                    res = self._profile_id_col(
                        source, database, collection, entity, name
                    )
                elif profile_type == "text/json":
                    res = self._profile_text_json_col(
                        source, database, collection, entity, name
                    )
                elif profile_type == "date":
                    res = self._profile_date_col(
                        source, database, collection, entity, name
                    )
                for key in res:
                    if key.startswith("frequency_("):
                        to_vis.append(
                            {
                                "source": f"{source}/{database}/{collection}/{entity}",
                                "description": key,
                                "data": res[key],
                            }
                        )
                        worker.append_session_data(
                            "VIS_DATA",
                            {
                                "source": f"{source}/{database}/{collection}/{entity}",
                                "description": key,
                                "data": res[key],
                            },
                        )
                logging.info(f"\n\n===res {name} {profile_type}:\n\n {res}\n\n")
                logging.info(
                    f'\n\n===session data {worker.get_session_data("VIS_DATA")}:\n\n {res}\n\n'
                )
                summary.append(f"\n\nColumn [{name}] summary:\n {res}\n\n")

            # Generate summary report using LLM
            st.append_status(f"writing a summary report")
            input_template = self.properties.get(
                "write_response_prompt", WRITE_RESPONSE_PROMPT
            )
            response = self.execute_api_call(
                "\n".join(summary),
                properties={"input_template": input_template},
                additional_data={},
            )
            logging.info(f"\n\n===final res {response}:\n\n {res}\n\n")
            worker.write_control(
                ControlCode.CREATE_FORM,
                build_markdown_form(response),
                output="TEXT",
            )
            st.append_status("done", 1.0)
            worker.write_eos(output="TEXT")
        elif message.isBOS():
            # init stream to empty array
            if worker:
                worker.set_data("stream_data", [])
            pass
        elif message.isData():
            # store data value
            data = message.getData()
            logging.info(data)

            if worker:
                worker.append_data("stream_data", data)

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="DATA_EXPLORATION_AGENT", type=str)
    parser.add_argument("--session", type=str)
    parser.add_argument("--properties", type=str)
    parser.add_argument("--loglevel", default="INFO", type=str)
    parser.add_argument("--serve", type=str)
    parser.add_argument("--platform", type=str, default="default")
    parser.add_argument("--registry", type=str, default="default")

    args = parser.parse_args()

    # set logging
    logging.getLogger().setLevel(args.loglevel.upper())

    # set properties
    properties = {}
    p = args.properties
    if p:
        # decode json
        properties = json.loads(p)

    if args.serve:
        platform = args.platform

        af = AgentFactory(
            _class=DataExplorationAgent,
            _name=args.serve,
            _registry=args.registry,
            platform=platform,
            properties=properties,
        )
        af.wait()
    else:
        a = None
        session = None
        if args.session:
            # join an existing session
            session = Session(cid=args.session)
            a = DataExplorationAgent(
                name=args.name, session=session, properties=properties
            )
        else:
            # create a new session
            session = Session()
            a = DataExplorationAgent(
                name=args.name, session=session, properties=properties
            )

        # wait for session
        if session:
            session.wait()
