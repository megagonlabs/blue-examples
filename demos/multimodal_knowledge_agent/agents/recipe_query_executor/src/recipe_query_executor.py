###### Parsers, Formats, Utils
from typing import Any, Optional
import argparse
import copy
import json
import logging
import textwrap

###### Blue
from blue.agent import AgentFactory, Worker
from blue.agents.query_executor import QueryExecutorAgent
from blue.session import Session
from blue.stream import Message

###### Recipe Query Executor Agent
from pathlib import Path
import pandas as pd

CATEGORIES_PATH = Path("./data/recipe_categories.json")


def read_category_info(category_info_path: Path = CATEGORIES_PATH) -> list[dict[str, Any]]:
    """
    Read category information from a predefined JSON file.

    Args:
        category_info_path: Path to the category info JSON file.

    Returns:
        list[dict[str, Any]]: A list of category information dictionaries.
    """
    with open(category_info_path, "r") as f:
        category_info = json.load(f)
    return category_info


def get_tag_lookup_query(recipe_ids: list[int]) -> str:
    """
    Generate an SQL query string to fetch associated tags for a list of recipe IDs.

    Args:
        recipe_ids: A list of recipe IDs to fetch tags for.

    Returns:
        str: The SQL query string.
    """
    recipe_ids_str = ",".join([str(rid) for rid in recipe_ids])
    query = "SELECT tags.tag_id, tags.tag_name, count(tags.tag_id) FROM recipe_tags, tags WHERE recipe_tags.recipe_id in ({recipe_ids_str}) and tags.tag_id=recipe_tags.tag_id group by tags.tag_id;".format(
        recipe_ids_str=recipe_ids_str
    )
    return query


def get_tags_for_qa(tags_from_recipes: pd.DataFrame, category_info: list[dict[str, Any]]) -> list[dict[str, Any]]:
    """
    Filter categories and tags based on tags found in a specific set of recipes.

    Args:
        tags_from_recipes: DataFrame containing the tags retrieved from the database.
        category_info: The full category information list.

    Returns:
        list[dict[str, Any]]: Filtered categories and tags relevant for QA.
    """
    qa_tags = []
    for category_item in category_info:
        category_tags = []
        category = category_item["category"]
        tags = category_item["tags"]
        for tag in tags:
            tag_id = tag["tag_id"]
            if tag_id in tags_from_recipes["tag_id"].values:
                category_tags.append(tag)
        if len(category_tags) > 0:
            qa_tags.append({"category": category, "tags": category_tags})
    return qa_tags


def get_filter_query(recipe_ids: list[int], filters: dict[str, Any]) -> str:
    """
    Build a filter query based on recipe IDs and user-provided filters.

    Args:
        recipe_ids: A list of recipe IDs to filter.
        filters: A dictionary of filter criteria (e.g., tags, cook time, calories).

    Returns:
        str: The generated SQL filter query.
    """
    category_info = read_category_info()

    # get tag ids from category info based on filter tag names
    tag_names_to_ids = {}
    for cat_info in category_info:
        tags = cat_info["tags"]
        for tag in tags:
            tag_names_to_ids[tag["tag_name"]] = tag["tag_id"]

    filter_tag_ids = []
    for filter_name in filters.keys():
        if filter_name in tag_names_to_ids and filters[filter_name]:
            filter_tag_ids.append(tag_names_to_ids[filter_name])

    calories_max = None
    if "calories" in filters:
        cal = filters["calories"]
        if cal is not None and len(cal) > 0:
            calories_max = float(cal)

    cook_time = None
    if "cook_time" in filters:
        cook = filters["cook_time"]
        if cook is not None and len(cook) > 0:
            cook_time = int(cook)

    steps_max = None
    if "steps" in filters:
        steps = filters["steps"]
        if steps is not None and len(steps) > 0:
            steps_max = int(steps)

    ingredients_max = None
    if "ingredients" in filters:
        ingredients = filters["ingredients"]
        if ingredients is not None and len(ingredients) > 0:
            ingredients_max = int(ingredients)

    query = build_recipe_filter_query(
        recipe_ids=recipe_ids,
        tag_ids=filter_tag_ids,
        cook_time_max=cook_time,
        ingredient_count_max=ingredients_max,
        num_steps_max=steps_max,
        calories_max=calories_max,
    )
    return query


# recommended usage;
# read category_info, for a list of recipe IDs get the tag lookup query, execute the query to get tags_from_recipes dataframe, then call get_tags_for_qa to get the final tags for QA.


def build_recipe_filter_query(
    recipe_ids: Optional[list[int]] = None,
    tag_ids: Optional[list[int]] = None,
    cook_time_max: Optional[int] = None,
    ingredient_count_max: Optional[int] = None,
    num_steps_max: Optional[int] = None,
    avg_rating_min: Optional[float] = None,
    calories_max: Optional[float] = None,
    saturated_fat_max: Optional[float] = None,
    total_fat_max: Optional[float] = None,
    protein_min: Optional[float] = None,
    sugar_max: Optional[float] = None,
) -> str:
    """
    Build SQL query dynamically based on optional filters.

    Only the required JOINs are included in the generated SQL statement.

    Args:
        recipe_ids: Optional list of recipe IDs to limit the search.
        tag_ids: Optional list of tag IDs that all returned recipes must have.
        cook_time_max: Maximum cooking time in minutes.
        ingredient_count_max: Maximum number of ingredients.
        num_steps_max: Maximum number of steps.
        avg_rating_min: Minimum average rating.
        calories_max: Maximum calories.
        saturated_fat_max: Maximum saturated fat (PDV).
        total_fat_max: Maximum total fat (PDV).
        protein_min: Minimum protein (PDV).
        sugar_max: Maximum sugar (PDV).

    Returns:
        str: The generated SQL query.
    """

    # Base SELECT
    select_clause = """
SELECT DISTINCT r.recipe_id, r.instructions
FROM recipes r
"""

    joins = []
    where = []
    ctes = []

    # -------------------------
    # TAG FILTERS (via CTE)
    # -------------------------
    if tag_ids:
        tag_id_list = ", ".join(str(t) for t in tag_ids)

        ctes.append(f"""
recipe_filtered_by_tags AS (
    SELECT rt.recipe_id
    FROM recipe_tags rt
    WHERE rt.tag_id IN ({tag_id_list})
    GROUP BY rt.recipe_id
    HAVING COUNT(*) = {len(tag_ids)}
)
""")

        # Join the CTE
        joins.append("JOIN recipe_filtered_by_tags rf ON rf.recipe_id = r.recipe_id")

    # -------------------------------------
    # OPTIONAL: recipe_ids filtering
    # -------------------------------------
    if recipe_ids:
        ids_str = ", ".join(str(i) for i in recipe_ids)
        where.append(f"r.recipe_id IN ({ids_str})")

    # -------------------------
    # COOK TIME
    # -------------------------
    if cook_time_max is not None:
        where.append(f"r.cook_time_min <= {cook_time_max}")

    # -------------------------
    # INGREDIENT COUNT
    # -------------------------
    if ingredient_count_max is not None:
        where.append(f"r.ingredient_count <= {ingredient_count_max}")

    # -------------------------
    # STEP COUNT
    # -------------------------
    if num_steps_max is not None:
        where.append(f"r.num_steps <= {num_steps_max}")

    # -------------------------
    # AVERAGE RATING
    # -------------------------
    if avg_rating_min is not None:
        where.append(f"r.avg_rating >= {avg_rating_min}")

    # -------------------------
    # NUTRITION (conditional JOIN)
    # -------------------------
    nutrition_filters = []

    if calories_max is not None:
        nutrition_filters.append(f"n.calories <= {calories_max}")

    if saturated_fat_max is not None:
        nutrition_filters.append(f"n.saturated_fat_pdv <= {saturated_fat_max}")

    if total_fat_max is not None:
        nutrition_filters.append(f"n.total_fat_pdv <= {total_fat_max}")

    if protein_min is not None:
        nutrition_filters.append(f"n.protein_pdv >= {protein_min}")

    if sugar_max is not None:
        nutrition_filters.append(f"n.sugar_pdv <= {sugar_max}")

    # add join only if nutrition filter requested
    if nutrition_filters:
        joins.append("JOIN nutrition n ON n.recipe_id = r.recipe_id")
        where.extend(nutrition_filters)

    # Final assembly
    cte_sql = ""
    if ctes:
        cte_sql = "WITH " + ",".join(ctes)

    join_sql = "\n".join(joins)
    where_sql = ""
    if where:
        where_sql = "WHERE " + " AND ".join(where)

    sql = f"""
{cte_sql}{select_clause}{join_sql}
{where_sql};
"""

    # Strip leading whitespace
    s = "\n".join(line.rstrip() for line in sql.split("\n"))
    s = s.replace("\n\n", "\n")
    return s


class RecipeQueryExecutorAgent(QueryExecutorAgent):
    """
    Agent responsible for executing SQL queries on the recipe database.

    Attributes:
        recipe_ids: List of recipe IDs to filter.
        filters: Dictionary of filter criteria.
    """

    def __init__(self, **kwargs: Any) -> None:
        """
        Initialize the RecipeQueryExecutorAgent.

        Args:
            **kwargs: Keyword arguments passed to parent QueryExecutorAgent.
        """
        if "name" not in kwargs:
            kwargs["name"] = "recipe_query_executor"

        self.recipe_ids: list[int] = []
        self.filters: dict[str, Any] = {}
        super().__init__(**kwargs)

    def build_and_execute_query(self, recipe_ids: list[int], filters: dict[str, Any]) -> dict[str, Any]:
        """
        Build and execute an SQL query based on recipe IDs and filters.

        Args:
            recipe_ids: List of recipe IDs to filter.
            filters: Dictionary of filter criteria.

        Returns:
            dict[str, Any]: The results of the SQL query execution with fields:
                - message: Summary message about the query results.
                - error: Any error encountered during execution.
                - result: The actual query results.
                - query: The executed SQL query.
                - source: The data source queried.
                - question: The original question prompting the query.
        """
        query = get_filter_query(recipe_ids, filters)
        logging.info(f"\nQuery: {query}")
        if "source" not in self.properties:
            self.properties["source"] = "Recipes/recipes/public"
        output: dict[str, Any] = self.execute_sql_query(self.properties["source"], query)
        if output["result"] is None:
            message = "No results returned from query."
        else:
            message = f"Number of results: {len(output['result'])}"

        # Logging
        for key, val in output.items():
            logging.info(f"\nOutput [{key}]: {textwrap.shorten(str(val), width=200)}")
        return {
            "message": message,
            "error": output["error"],
            "result": output["result"],
            "query": output["query"],
            "source": output["source"],
            "question": output["question"],
        }

    def default_processor(
        self,
        message: Message,
        input: str = "DEFAULT",
        properties: Optional[dict[str, Any]] = None,
        worker: Optional[Worker] = None,
    ) -> Optional[list[Any]]:
        """
        Process messages based on input channel.

        Routes messages from RECIPES or FILTERS channels, accumulating data
        and triggering query execution when both inputs are received.

        Args:
            message: The message to process.
            input: The input channel ("RECIPES" or "FILTERS").
            properties: Optional agent properties.
            worker: The worker instance for session management.

        Returns:
            Optional[list[Any]]: Query results or None if more data is needed.
        """
        logging.info(
            f"default_processor - input: {input}, message type: {message.content_type}, message: {textwrap.shorten(str(message), width=200)}"
        )

        if input not in ["RECIPES", "FILTERS"]:
            logging.warning(f"Unknown input: {input}")
            return None

        # Initialize worker if not provided
        if not worker:
            worker = self.create_worker(None)

        # Initialize properties if not provided
        properties = copy.deepcopy(properties) if properties else {}

        # Handle stream control messages
        if message.isBOS():
            # Beginning of stream: initialize data buffer
            worker.set_data(f"stream_{self.name}_{input}", [])
            logging.info(f"{input}: Received BOS")
            return

        if message.isData():
            # Data message: append to buffer
            data = message.getData()
            worker.append_data(f"stream_{self.name}_{input}", data)
            logging.info(f"{input}: Received data (type: {type(data)}): {data}")
            return

        if message.isEOS():
            # # End of stream: process accumulated data
            data = worker.get_data(f"stream_{self.name}_{input}")  # type: ignore

            if not isinstance(data, list):
                error_msg = f"Expected list data but got {type(data)}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            if len(data) != 1:
                error_msg = f"Expected single item in data list but got {len(data)} items: {data}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            data = data[0]

            if isinstance(data, str):
                try:
                    data = json.loads(data)
                except Exception as e:
                    error_msg = f"Error: Failed to parse JSON input for {input}: {str(e)}"
                    logging.error(error_msg)
                    return [{"error": error_msg}, Message.EOS]

            if not isinstance(data, dict):
                error_msg = f"Expected dict data but got {type(data)}: {data}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
        else:
            return

        logging.info(f"{input}: Start processing data: {textwrap.shorten(str(data), width=200)}")

        if input == "RECIPES":
            # Extract recipe IDs
            recipe_ids = []
            for dish in data.get("results", []):
                for recipe in dish.get("recipes", []):
                    rid_str = str(recipe.get("recipe_id", ""))
                    try:
                        rid_val = int(rid_str.replace("REC-", ""))
                        recipe_ids.append(rid_val)
                    except ValueError:
                        error_msg = f"Invalid recipe ID format: {rid_str}. Expected 'REC-XX'."
                        logging.error(error_msg)
                        return [{"error": error_msg}, Message.EOS]
            self.recipe_ids = recipe_ids

            logging.info("Waiting for filters to execute query.")
            return None

        elif input == "FILTERS":
            # Retrieve accumulated stream data
            self.filters = data

            if not self.recipe_ids:
                error_msg = "No recipe IDs received. Please retrieve recipes first."
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

            return [self.build_and_execute_query(self.recipe_ids, self.filters), Message.EOS]

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="RECIPEQUERYEXECUTOR", type=str)
    parser.add_argument("--session", type=str)
    parser.add_argument("--properties", type=str)
    parser.add_argument("--loglevel", default="INFO", type=str)
    parser.add_argument("--serve", type=str)
    parser.add_argument("--platform", type=str, default="default")
    parser.add_argument("--registry", type=str, default="default")

    args = parser.parse_args()

    # logging
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
            _class=RecipeQueryExecutorAgent,
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
            a = RecipeQueryExecutorAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = RecipeQueryExecutorAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()
