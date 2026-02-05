import json
from pathlib import Path
import pandas as pd

categories_path = Path("../data/recipes/processed/recipe_categories.json")

## Read category Info from a predefined JSON file
def read_category_info(category_info_path: Path) -> pd.DataFrame:
    with open(category_info_path, "r") as f:
        category_info = json.load(f)
    return category_info
# category_info = read_category_info(categories_path)

## Given a list of recipe IDs, returns an SQL query string to fetch associated tags
def get_tag_lookup_query(recipe_ids: list[int]) -> str:
    recipe_ids_str = ",".join([str(rid) for rid in recipe_ids])
    query = "SELECT tags.tag_id, tags.tag_name, count(tags.tag_id) FROM recipe_tags, tags WHERE recipe_tags.recipe_id in ({recipe_ids_str}) and tags.tag_id=recipe_tags.tag_id group by tags.tag_id;" .format(recipe_ids_str=recipe_ids_str)
    return query

# Given a dataframe of tags with their counts, return categories with tags.
def get_tags_for_qa(tags_from_recipes: pd.DataFrame, category_info: dict) -> list[dict]:
    qa_tags = []
    for category_item in category_info:
        category_tags = []
        category = category_item["category"]
        tags = category_item["tags"]
        for tag in tags:
            tag_id = tag['tag_id']
            if tag_id in tags_from_recipes["tag_id"].values:
                category_tags.append(tag)
        if len(category_tags) > 0:
            qa_tags.append({"category": category, "tags": category_tags})
    return qa_tags


# recommended usage; 
# pass the recipe IDs and output of the fitler agent to get the filter query to pass to QueryExecutor Agent
def get_filter_query(recipe_ids, filters): 
    category_info = read_category_info(Path("../data/recipes/processed/recipe_categories.json"))

    # get tag ids from category info based on filter tag names
    tag_names_to_ids = {}
    for cat_info in category_info:
        tags = cat_info['tags']
        for tag in tags:
            tag_names_to_ids[tag['tag_name']] = tag['tag_id']

    filter_tag_ids = []
    for filter_name in filters.keys():
        if filter_name in tag_names_to_ids and filters[filter_name] == True:
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
            cook_time = int(cook_time)

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
        calories_max=calories_max
    )
    return query

# recommended usage; 
# read category_info, for a list of recipe IDs get the tag lookup query, execute the query to get tags_from_recipes dataframe, then call get_tags_for_qa to get the final tags for QA.


## Filter Query Builder
def build_recipe_filter_query(
    recipe_ids=None,
    tag_ids=None,                      # list[int]
    cook_time_max=None,                # int
    ingredient_count_max=None,         # int
    num_steps_max=None,                # int
    avg_rating_min=None,               # float
    calories_max=None,                 # float
    saturated_fat_max=None,            # float
    total_fat_max=None,                # float
    protein_min=None,                  # float
    sugar_max=None                     # float
):
    """
    Build SQL query dynamically based on optional filters.
    Only the required JOINs are included.
    """

    # Base SELECT
    select_clause = """
SELECT DISTINCT r.recipe_id
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