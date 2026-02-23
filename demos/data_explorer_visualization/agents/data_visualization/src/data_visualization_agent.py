import argparse
import json
import logging

import jsonschema
import requests

from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.data.registry import DataRegistry
from blue.session import Session
from blue.stream import ControlCode
from blue.tools.tool import Tool
from default_prompts import REACT_SYSTEM_PROMPT, VIS_DESC_PROMPT
from status import StatusMessage


# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

# Lazy-loaded Vega schema cache (shared across all agent instances)
_VEGA_SCHEMA_CACHE = None


def get_vega_schema():
    """Lazily load Vega-Lite schema on first use. Cached for all subsequent calls."""
    global _VEGA_SCHEMA_CACHE
    if _VEGA_SCHEMA_CACHE is None:
        try:
            _VEGA_SCHEMA_CACHE = requests.get(
                "https://vega.github.io/schema/vega-lite/v5.json", timeout=10
            ).json()
            logging.info("Vega-Lite schema loaded successfully")
        except Exception as e:
            logging.warning(
                f"Failed to load Vega-Lite schema: {e}. Validation will be skipped."
            )
            _VEGA_SCHEMA_CACHE = {}
    return _VEGA_SCHEMA_CACHE


def validate_vegalite_spec(vega_spec: str) -> str:
    """Check if a Vega-Lite JSON specification is valid"""
    try:
        vega_spec = json.loads(vega_spec)
        schema = get_vega_schema()
        if schema:
            jsonschema.validate(instance=vega_spec, schema=schema)
        else:
            return "Failed to load Vega-Lite schema. Try again."
        return "Valid Vega-Lite JSON"
    except json.JSONDecodeError as e:
        return f"Invalid JSON: {str(e)}"
    except jsonschema.ValidationError as e:
        return f"Invalid Vega-Lite spec: {e.message}"


def build_vis_form(vegalite_specs):
    if not isinstance(vegalite_specs, list):
        vegalite_specs = [vegalite_specs]

    data_schema = {"type": "object", "properties": {}}
    ui_schema = {
        "type": "VerticalLayout",
        "elements": [
            {"type": "Vega", "scope": f"#/properties/vis_{i}", "props": {"style": {}}}
            for i, _ in enumerate(vegalite_specs)
        ],
    }
    data = {f"vis_{i}": spec for i, spec in enumerate(vegalite_specs)}
    return {"schema": data_schema, "uischema": ui_schema, "data": data}


def count_charts(vegalite_specs):
    """
    Counts the number of charts in a Vega-Lite spec that may use
    hconcat, vconcat, or concat to combine multiple charts.
    """
    # Check for concatenation keys
    for key in ["hconcat", "vconcat", "concat"]:
        if key in vegalite_specs:
            # Recursively count all sub-specs in the array
            return sum(count_charts(sub_spec) for sub_spec in vegalite_specs[key])

    # If none of the concat keys are present, it's a single chart
    return 1





############################
### Agent.DataVisualizationAgent
#
class DataVisualizationAgent(OpenAIAgent):
    """
    Generates interactive data visualizations in Vega-Lite.

    Accepts natural language requests and produces valid Vega-Lite v5 JSON
    visualizations. Uses ReAct agents with LangChain for data discovery and
    OpenAI models for specification generation.
    """

    def __init__(self, **kwargs):
        if "name" not in kwargs:
            kwargs["name"] = "DATA_VISUALIZATION_AGENT"
        super().__init__(**kwargs)

    def _initialize_properties(self):
        super()._initialize_properties()

    ####### inputs / outputs
    def _initialize_inputs(self):
        self.add_input(
            "DEFAULT", description="text request or request with tabular data"
        )

    def _initialize_outputs(self):
        self.add_output("DEFAULT", description="visualization", tags=["VIS"])

    def _start(self):
        super()._start()
        self._init_registry()
        # Initialize local tools
        self._initialize_local_tools()

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

    def _initialize_local_tools(self):
        """Initialize local tools."""
        self.local_tools = {}

        # Create Tool instances using bound methods
        list_database_tables_tool = Tool(
            name="list_database_tables",
            function=self._list_all_scopes,
            description="Get a list of all tables in the data registry in [source, database, collection, entity] format",
        )
        self.local_tools["list_database_tables"] = list_database_tables_tool

        get_table_info_tool = Tool(
            name="get_table_info",
            function=self._get_table_info,
            description="Retrieve column names and metadata for a given table",
        )
        self.local_tools["get_table_info"] = get_table_info_tool

        execute_sql_query_tool = Tool(
            name="execute_sql_query",
            function=self._execute_sql_with_validation,
            description="Execute sql query on selected table. CRITICAL: Check column types from get_table_info BEFORE writing queries. For numeric columns (integer, bigint, numeric, double precision): use directly in aggregates, NO casting or regex needed. For varchar/text columns with numeric data: (1) Filter in WHERE with regex (e.g., WHERE col ~ '^-?[0-9]+(\\.[0-9]+)?$'), (2) Cast in SELECT (e.g., AVG(col::numeric)). NEVER use CASE WHEN or regex inside aggregates. NEVER use regex operators on non-varchar columns.",
        )
        self.local_tools["execute_sql_query"] = execute_sql_query_tool

        peek_table_data_tool = Tool(
            name="peek_table_data",
            function=self._peek_table_data,
            description="Retrieve 5 sample rows with selected columns from table",
        )
        self.local_tools["peek_table_data"] = peek_table_data_tool

        validate_vegalite_spec_tool = Tool(
            name="validate_vegalite_spec",
            function=validate_vegalite_spec,
            description="Check if a Vega-Lite JSON specification is valid",
        )
        self.local_tools["validate_vegalite_spec"] = validate_vegalite_spec_tool

    ####### helper functions
    def _validate_sql_query(self, query: str, source: str, database: str, collection: str) -> dict:
        """
        Validate SQL query for undefined tables, columns, and unsafe numeric casts.
        Returns dict with validation result and actionable error message.
        """
        import re
        
        # Check for CASE WHEN inside aggregate functions - this is almost always wrong
        case_in_agg_pattern = r'(AVG|SUM|MIN|MAX)\s*\(\s*CASE\s+WHEN'
        if re.search(case_in_agg_pattern, query, re.IGNORECASE):
            return {
                "valid": False,
                "error": (
                    "CASE WHEN statement found inside aggregate function (AVG/SUM/MIN/MAX). "
                    "This causes type errors. Instead: (1) Filter rows in WHERE clause using regex, "
                    "(2) Then cast in SELECT. Example: WHERE salary ~ '^[0-9]+' ... SELECT AVG(salary::numeric)"
                ),
            }
        
        cache_key = f"{source}:{database}:{collection}"
        unsafe_numeric_cols = getattr(self, '_unsafe_numeric_cache', {}).get(cache_key, [])
        
        # Get available tables
        available_tables = []
        try:
            entities = self.registry.get_source_database_collection_entities(source, database, collection)
            available_tables = [f"{collection}.{e['name']}" for e in entities]
        except Exception:
            pass
        
        # Check for unsafe numeric casts (mixed-data varchar columns must be filtered)
        for col in unsafe_numeric_cols:
            pattern1 = rf'{re.escape(col)}\s*::\s*numeric'
            pattern2 = rf'CAST\s*\(\s*{re.escape(col)}\s+AS\s+numeric\s*\)'
            
            if re.search(pattern1, query, re.IGNORECASE) or re.search(pattern2, query, re.IGNORECASE):
                return {
                    "valid": False,
                    "error": (
                        f"Column '{col}' contains mixed data (numbers and non-numeric values). "
                        "Do not cast directly. Use one of these approaches: "
                        f"(1) Filter to numeric-only first, e.g., WHERE {col} ~ '^[0-9]+(\\.[0-9]+)?$' "
                        "then cast in SELECT/aggregates; "
                        "(2) Use CASE to convert non-numeric values to NULL; or "
                        "(3) Group non-numeric values separately."
                    ),
                }
        
        # Check for undefined tables
        from_pattern = r'FROM\s+([a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*)'
        join_pattern = r'JOIN\s+([a-zA-Z_][a-zA-Z0-9_]*\.[a-zA-Z_][a-zA-Z0-9_]*)'
        from_matches = re.findall(from_pattern, query, re.IGNORECASE)
        join_matches = re.findall(join_pattern, query, re.IGNORECASE)
        tables_in_query = set(from_matches + join_matches)
        
        for table_ref in tables_in_query:
            if table_ref not in available_tables:
                return {
                    "valid": False,
                    "error": (
                        f"Table '{table_ref}' does not exist in the selected source/database/collection: "
                        f"{source}/{database}/{collection}. Available tables: {', '.join(available_tables)}. "
                        "Use the list_database_tables tool to see all available tables."
                    )
                }
        
        # Get available columns and types for tables referenced in query
        # Cache full table_info to avoid redundant DB calls
        if not hasattr(self, '_table_info_cache'):
            self._table_info_cache = {}
        
        available_columns = {}
        col_type_map = {}  # Maps column names to their types
        varchar_cols_by_table = {}
        
        for table_ref in tables_in_query:
            cache_key = f"{source}:{database}:{table_ref}"
            
            # Use cached table_info if available
            if cache_key in self._table_info_cache:
                table_info = self._table_info_cache[cache_key]
            else:
                try:
                    entity_name = table_ref.split('.')[-1]
                    table_info = self._get_table_info(source, database, collection, entity_name)
                    self._table_info_cache[cache_key] = table_info
                except Exception:
                    continue
            
            # Extract columns and types from cached/fetched table_info
            if table_info and 'table_info' in table_info and table_info['table_info']:
                col_names = table_info['table_info'][0].get('columns', [])
                col_types = table_info['table_info'][0].get('column_types', [])
                
                available_columns[table_ref] = col_names
                
                # Build type map and varchar list in one pass
                varchar_cols = []
                for i, col in enumerate(col_names):
                    if i < len(col_types):
                        col_type_map[col] = col_types[i]
                        if col_types[i] in ('character varying', 'varchar', 'text'):
                            varchar_cols.append(col)
                
                varchar_cols_by_table[table_ref] = varchar_cols
        
        # Check for undefined columns
        qualified_col_pattern = r'\b([a-zA-Z_][a-zA-Z0-9_]*)\.([a-zA-Z_][a-zA-Z0-9_]*)\b'
        qualified_matches = re.findall(qualified_col_pattern, query, re.IGNORECASE)
        
        for table_or_alias, col_name in qualified_matches:
            # Skip SQL keywords and functions
            sql_keywords = {'COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'ARRAY_AGG', 'information_schema'}
            if table_or_alias.upper() in sql_keywords or col_name.upper() in sql_keywords:
                continue
            
            found = False
            matching_table = None
            
            for table_ref in available_columns.keys():
                table_name = table_ref.split('.')[-1]
                if table_or_alias.lower() == table_name.lower() or table_or_alias.lower() == table_ref.lower():
                    if col_name in available_columns[table_ref]:
                        found = True
                        break
                    else:
                        matching_table = table_ref
            
            if matching_table and not found:
                available_cols = available_columns[matching_table]
                return {
                    "valid": False,
                    "error": f"Column '{col_name}' does not exist in table '{matching_table}'. Available columns: {', '.join(available_cols)}. Use get_table_info tool to verify column names."
                }
        
        # Check for regex operators on non-varchar columns (col_type_map already built above)
        regex_pattern = r'(\b\w+)\s*~\s*[\'"]'
        regex_matches = re.findall(regex_pattern, query, re.IGNORECASE)
        for col_name in regex_matches:
            if col_name in col_type_map:
                col_type = col_type_map[col_name]
                if col_type not in ('character varying', 'varchar', 'text', 'unknown'):
                    return {
                        "valid": False,
                        "error": (
                            f"Column '{col_name}' has type '{col_type}' (not varchar/text) but you're using regex operator '~' on it. "
                            f"Regex operators only work on text types. Since this column is already numeric, you don't need regex filtering. "
                            f"Just use the column directly in your query and aggregates."
                        ),
                    }
        
        # Check for AVG/SUM/MIN/MAX on varchar columns without ::numeric cast
        for table_ref, varchar_cols in varchar_cols_by_table.items():
            for col in varchar_cols:
                # Pattern: AVG(column_name) without ::numeric or CAST
                agg_pattern = rf'(AVG|SUM|MIN|MAX)\s*\(\s*{re.escape(col)}\s*\)'
                if re.search(agg_pattern, query, re.IGNORECASE):
                    # Make sure it's not followed by ::numeric
                    cast_pattern = rf'(AVG|SUM|MIN|MAX)\s*\(\s*{re.escape(col)}\s*::\s*numeric\s*\)'
                    if not re.search(cast_pattern, query, re.IGNORECASE):
                        return {
                            "valid": False,
                            "error": (
                                f"Column '{col}' is varchar/text type but used in aggregate function without casting. "
                                f"You MUST: (1) Filter to numeric rows in WHERE: WHERE {col} ~ '^-?[0-9]+(\\.[0-9]+)?$' "
                                f"(2) Then cast in aggregate: AVG({col}::numeric)"
                            ),
                        }
        
        return {"valid": True, "error": None}
    
    def _execute_sql(self, query, source, database, collection):
        """Execute SQL query directly without validation (for internal use)."""
        results = self.registry.execute_query(query, source, database, collection)
        return results

    def _execute_sql_with_validation(self, query, source, database, collection):
        """Execute SQL query with validation (for user-facing Tool)."""
        # Validate query - check for unsafe casts, undefined tables, and undefined columns
        validation = self._validate_sql_query(query, source, database, collection)
        if not validation["valid"]:
            return f"SQL ERROR: {validation['error']}"
        
        results = self.registry.execute_query(query, source, database, collection)
        logging.info(f"SQL query results--------------------\n{query}--------------------\n{results}")
        if not results:
            return "SQL RESULT: empty result set. Try another SQL query."
        return results

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

    def _get_table_info(
        self, source: str, database: str, collection: str, entity: str
    ) -> dict:
        """Retrieve column names and metadata for a given table, including detection of numeric data stored as varchar"""
        # Get basic column info
        query = f"""\
SELECT
    (SELECT COUNT(*) FROM {collection}.{entity}) AS total_rows,
    ARRAY_AGG(column_name ORDER BY ordinal_position) AS columns,
    ARRAY_AGG(data_type ORDER BY ordinal_position) AS column_types
FROM information_schema.columns
WHERE table_name = '{entity}'
AND table_schema = '{collection}';
"""
        basic_info = self._execute_sql(query, source, database, collection)
        
        varchar_numeric_cols = []
        unsafe_numeric_cols = []
        
        if basic_info and len(basic_info) > 0:
            row = basic_info[0]
            logging.info(f'___info____{basic_info}')
            columns = row.get('columns', [])
            column_types = row.get('column_types', [])
            
            for col_name, col_type in zip(columns, column_types):
                if col_type in ('character varying', 'varchar', 'text'):
                    # Check entire column for mixed data - if ANY non-numeric value exists, mark as unsafe
                    check_query = f"""\
SELECT 
    COUNT(*) FILTER (WHERE {col_name} ~ '^-?[0-9]+(\\.[0-9]+)?$') AS numeric_count,
    COUNT(*) FILTER (WHERE {col_name} IS NOT NULL AND {col_name} !~ '^-?[0-9]+(\\.[0-9]+)?$') AS non_numeric_count,
    COUNT(*) AS total_count
FROM {collection}.{entity};
"""
                    try:
                        result = self._execute_sql(check_query, source, database, collection)
                        if result and len(result) > 0:
                            numeric_count = result[0].get('numeric_count', 0)
                            non_numeric_count = result[0].get('non_numeric_count', 0)
                            total_count = result[0].get('total_count', 0)
                            
                            if non_numeric_count == 0 and numeric_count > 0:
                                # Pure numeric column - safe to cast
                                varchar_numeric_cols.append(col_name)
                            elif non_numeric_count > 0:
                                # Mixed data: contains non-numeric values - unsafe to cast
                                unsafe_numeric_cols.append(col_name)
                    except Exception:
                        pass
        
        if not hasattr(self, '_unsafe_numeric_cache'):
            self._unsafe_numeric_cache = {}
        cache_key = f"{source}:{database}:{collection}"
        self._unsafe_numeric_cache[cache_key] = unsafe_numeric_cols
        
        return {
            "table_info": basic_info,
            "varchar_columns_with_numeric_data": varchar_numeric_cols,
            "varchar_columns_with_mixed_data": unsafe_numeric_cols,
            "note": "IMPORTANT: Check 'column_types' to determine handling. Columns already stored as numeric types (integer, bigint, numeric, double precision) can be used directly in aggregates - NO regex filtering or casting needed. For varchar/text columns: 'varchar_columns_with_numeric_data' are safe to cast after filtering (WHERE col ~ '^[0-9]+', then col::numeric). 'varchar_columns_with_mixed_data' contain non-numeric values - filter in WHERE with regex, then cast in SELECT. NEVER use regex operators on non-varchar columns."
        }

    def _peek_table_data(
        self,
        source: str,
        database: str,
        collection: str,
        entity: str,
        col_names: list[str],
    ) -> list:
        """Retrieve 5 sample rows with selected columns from table"""
        # Handle case where col_names might be passed as a comma-separated string
        if isinstance(col_names, str):
            col_names = [c.strip() for c in col_names.split(",") if c.strip()]
        query = f"SELECT {', '.join(col_names)} FROM {collection}.{entity} LIMIT 5"
        return self._execute_sql(query, source, database, collection)

    def explain_vis(self, vegalite_specs) -> str:
        """Prompt LLM to generate an explanation for the visualization."""
        properties = {
            "input_context_field": "content",
            "input_context": "$[0]",
            "input_field": "messages",
            "input_json": '[{"role": "user"}]',
            "input_template": self.properties.get("vis_desc_prompt", VIS_DESC_PROMPT),
            "openai.response_format": {"type": "text"},
        }
        try:
            response = self.execute_api_call(
                json.dumps(vegalite_specs),
                properties=properties,
                additional_data={"vegalite_specs": vegalite_specs},
            )
            vis_desc = response.get("content", "Unable to generate explanation.")
        except Exception as e:
            logging.error(f"Error generating visualization explanation: {e}")
            vis_desc = "Unable to generate explanation for this visualization."
        return vis_desc

    ####### default processor
    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if message.isEOS():
            # compute stream data
            stream_data_lst = []
            if worker:
                # stream_data = " ".join(worker.get_data('stream_data'))
                stream_data_lst = worker.get_data("stream_data")

            if not stream_data_lst:
                return

            # Initialize status message handler for tracking progress
            st = StatusMessage(self.name, worker)

            st.append_status("adding session data tools...")

            def list_session_data() -> list:
                """View all data currently stored in the session"""
                return worker.get_session_data("VIS_DATA")

            def get_session_data_by_key(source: str, description: str) -> dict:
                """Retrieve specific session data using a key"""
                for d in worker.get_session_data("VIS_DATA"):
                    if d["source"] == source and d["description"] == description:
                        return d
                return {}

            # add two more tools
            list_session_data_tool = Tool(
                name="list_session_data",
                function=list_session_data,
                description="View all data currently stored in the session",
            )
            self.local_tools["list_session_data"] = list_session_data_tool

            get_session_data_by_key_tool = Tool(
                name="get_session_data_by_key",
                function=get_session_data_by_key,
                description="Retrieve specific session data using a key",
            )
            self.local_tools["get_session_data_by_key"] = get_session_data_by_key_tool

            max_iter = self.properties.get("max_iter", 30)
            iteration = 0
            # Initialize messages
            system_prompt = self.properties.get(
                "react_system_prompt", REACT_SYSTEM_PROMPT
            )
            messages = [
                {"role": "system", "content": system_prompt},
                {
                    "role": "user",
                    "content": "\n".join([str(d) for d in stream_data_lst]),
                },
            ]

            # Build tool schemas
            tool_schemas = []
            for name, tool in self.local_tools.items():
                parameters = tool.get_parameters()
                openai_params = {"type": "object", "properties": {}, "required": []}

                if parameters:
                    for param_name, param_info in parameters.items():
                        py_type = param_info.get("type", "string")

                        json_type = "string"
                        if py_type in ["int", "integer"]:
                            json_type = "integer"
                        elif py_type in ["float", "number"]:
                            json_type = "number"
                        elif py_type == "bool":
                            json_type = "boolean"
                        elif "list" in py_type.lower():
                            json_type = "array"

                        param_schema = {"type": json_type}
                        if json_type == "array":
                            param_schema["items"] = {"type": "string"}

                        openai_params["properties"][param_name] = param_schema

                        if param_info.get("required", True):
                            openai_params["required"].append(param_name)

                tool_schemas.append(
                    {
                        "type": "function",
                        "function": {
                            "name": tool.name,
                            "description": tool.description,
                            "parameters": openai_params,
                        },
                    }
                )

            vis_json = {}

            while iteration < max_iter:
                iteration += 1
                logging.info(f"-----------ITER {iteration}-------------")
                st.append_status(f"iteration {iteration}")

                # If we've done several iterations without producing a spec, prompt explicitly
                if iteration > max_iter-5 and not vis_json:
                    messages.append(
                        {
                            "role": "user",
                            "content": "You have gathered enough data. Now please generate the final Vega-Lite v5 JSON specification. Do not call any more tools - just output the JSON.",
                        }
                    )

                # Inject tool schemas for this call
                # All other config (input_json=null, output_path, model settings, etc.)
                # should be set in frontend properties
                call_props = {
                    "openai.tools": tool_schemas,
                    "openai.tool_choice": "auto",
                }

                try:
                    response_message = self.execute_api_call(
                        messages, properties=call_props
                    )
                except Exception as e:
                    logging.error(f"Error calling OpenAI: {e}")
                    break

                messages.append(response_message)

                tool_calls = response_message.get("tool_calls")
                if tool_calls:
                    for tool_call in tool_calls:
                        function_name = tool_call["function"]["name"]
                        arguments_str = tool_call["function"]["arguments"]
                        tool_call_id = tool_call["id"]

                        logging.info(
                            f"Calling tool: {function_name} with args: {arguments_str}"
                        )
                        st.update_status(
                            f"iteration {iteration} - Calling tool [{function_name}] with args: {arguments_str[:30]}"
                        )

                        tool_result = ""
                        try:
                            if function_name in self.local_tools:
                                arguments = json.loads(arguments_str)
                                
                                # Filter arguments to only include valid parameters
                                # This prevents TypeError when LLM provides extra arguments
                                tool = self.local_tools[function_name]
                                valid_params = tool.get_parameters()
                                if valid_params:
                                    filtered_args = {
                                        k: v for k, v in arguments.items() 
                                        if k in valid_params
                                    }
                                    # Log if we're filtering out arguments
                                    if len(filtered_args) != len(arguments):
                                        removed = set(arguments.keys()) - set(filtered_args.keys())
                                        logging.warning(
                                            f"Filtered out invalid arguments for {function_name}: {removed}"
                                        )
                                    arguments = filtered_args
                                
                                tool_result = tool.function(**arguments)
                            else:
                                tool_result = f"Error: Tool {function_name} not found."
                        except Exception as e:
                            error_str = str(e)
                            # Check for PostgreSQL type casting errors in aggregate functions
                            if "does not exist" in error_str and ("AVG" in error_str or "SUM" in error_str or "MIN" in error_str or "MAX" in error_str):
                                tool_result = f"ERROR: Aggregate function failed. Common causes: (1) Using CASE WHEN or regex inside aggregates - DON'T. (2) Using regex ~ on non-varchar columns. (3) Aggregating varchar without casting. SOLUTION: Check column types with get_table_info first. For numeric columns: use directly. For varchar: filter in WHERE (e.g., WHERE col ~ '^[0-9]+'), then cast in SELECT (AVG(col::numeric)). Original error: {e}"
                            else:
                                tool_result = f"Error executing tool {function_name}: {e}"

                        messages.append(
                            {
                                "role": "tool",
                                "tool_call_id": tool_call_id,
                                "content": str(tool_result),
                            }
                        )
                        logging.info(f"Tool call result: {tool_result}")
                else:
                    content = response_message.get("content", "")
                    logging.info(f"Final response content: {content}")
                    st.update_status(f"iteration {iteration} - Final response")
                    try:
                        json_str = content
                        if "```json" in content:
                            json_str = content.split("```json")[1].split("```")[0]
                        elif "```" in content:
                            json_str = content.split("```")[1].split("```")[0]

                        # Validate the spec using the existing validation function
                        validation_result = validate_vegalite_spec(json_str.strip())
                        if validation_result == "Valid Vega-Lite JSON":
                            vis_json = json.loads(json_str.strip())
                            logging.info(
                                "Successfully parsed and validated Vega-Lite spec"
                            )
                            break
                        else:
                            logging.warning(
                                f"Invalid Vega-Lite spec: {validation_result}"
                            )
                            messages.append(
                                {
                                    "role": "user",
                                    "content": f"The Vega-Lite specification is invalid: {validation_result}. Please fix the spec and output a valid Vega-Lite v5 JSON specification.",
                                }
                            )
                            continue
                    except Exception as e:
                        logging.warning(f"Failed to parse JSON from response: {e}")
                        # Prompt the model to try again with proper JSON
                        messages.append(
                            {
                                "role": "user",
                                "content": "Your response was not valid JSON. Please output ONLY the Vega-Lite v5 JSON specification wrapped in ```json``` code blocks.",
                            }
                        )
                        continue

            # If we exited the loop without a valid spec, log a warning
            if not vis_json:
                logging.warning(
                    f"Loop completed after {iteration} iterations without producing a valid Vega-Lite spec"
                )
                worker.write_data(
                    f"Loop completed after {iteration} iterations without producing a valid Vega-Lite spec",
                )
                worker.write_eos()
                st.append_status("done", 1.0)
                return

            st.append_status("rendering generated visualization...")

            logging.info(vis_json)
            vis_form = build_vis_form(vis_json)
            worker.write_control(ControlCode.CREATE_FORM, vis_form, output="VIS")

            num_charts = count_charts(vis_json)
            vis_desc = self.explain_vis(vis_json)
            worker.write_data(f"Rendered {num_charts} visualization(s).\n\n{vis_desc}")
            worker.write_eos()
            st.append_status("done", 1.0)
            return
        elif message.isBOS():
            # init stream to empty array
            if worker:
                worker.set_data("stream_data", [])
            pass
        elif message.isData():
            # store data value
            data = message.getData()

            if worker:
                worker.append_data("stream_data", data)

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="DATA_VISUALIZATION_AGENT", type=str)
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
            _class=DataVisualizationAgent,
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
            a = DataVisualizationAgent(
                name=args.name, session=session, properties=properties
            )
        else:
            # create a new session
            session = Session()
            a = DataVisualizationAgent(
                name=args.name, session=session, properties=properties
            )

        # wait for session
        if session:
            session.wait()
