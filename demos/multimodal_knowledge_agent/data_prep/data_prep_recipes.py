"""
Features:
- Reads RAW_recipes.csv and RAW_interactions.csv
- Produces a joined JSONL of recipes with reviews
- Produces processed table CSVs in processed/tables: recipes, ingredients, recipe_ingredients, tags, recipe_tags, nutrition

Usage:
    python data_prep/data_prep_recipes.py --raw-dir data/recipes/raw_data --out-dir data/recipes/processed

"""
import argparse
import ast
import json
from pathlib import Path
import numpy as np
import pandas as pd
import re


def normalize_text(s: str) -> str:
    if s is None or (isinstance(s, float) and np.isnan(s)):
        return ''
    if not isinstance(s, str):
        s = str(s)
    # Replace common line separators with space
    s = s.replace('\r', ' ').replace('\n', ' ').replace('\t', ' ')
    # Collapse multiple punctuation-only delimiters like || or ;; into a single pipe
    s = re.sub(r'(\|\|)+', ' | ', s)
    s = re.sub(r'(;;)+', ';', s)
    # Collapse whitespace
    s = re.sub(r'\s+', ' ', s)
    return s.strip()


def normalize_list_column(col_val):
    if col_val is None:
        return []
    if isinstance(col_val, (list, tuple)):
        out = []
        for item in col_val:
            if isinstance(item, str):
                out.append(normalize_text(item))
            else:
                out.append(item)
        return out
    return col_val


def read_recipes_csv(recipe_csv: Path, interaction_csv: Path) -> pd.DataFrame:
    recipes = pd.read_csv(recipe_csv)
    # Text normalization helpers are at module-level to reuse across functions
    # Parse columns saved as strings and normalize text inside list-like columns
    for col in ('nutrition', 'steps', 'ingredients', 'tags'):
        if col in recipes.columns:
            recipes[col] = recipes[col].apply(lambda x: ast.literal_eval(x) if pd.notna(x) else [])
            if col in ('steps', 'ingredients', 'tags'):
                recipes[col] = recipes[col].apply(normalize_list_column)

    # Read interactions and group by recipe_id into JSON list per recipe
    reviews = pd.read_csv(interaction_csv)
    # Normalize text in object columns of interactions to avoid embedded newlines
    for c in reviews.select_dtypes(include=['object']).columns:
        reviews[c] = reviews[c].apply(lambda x: normalize_text(x) if pd.notna(x) else x)
    if 'recipe_id' not in reviews.columns:
        raise RuntimeError('INTERACTION CSV missing recipe_id column')
    # Convert grouped reviews to dict of lists
    review_map = {}
    for rid, group in reviews.groupby('recipe_id'):
        review_map[str(rid)] = group.to_dict(orient='records')

    # Attach reviews to recipes
    reviews_col = []
    for _, row in recipes.iterrows():
        rid = str(row['id']) if 'id' in row else None
        reviews_col.append(review_map.get(rid, []))
    recipes['reviews'] = reviews_col
    return recipes


def write_jsonl(recipes: pd.DataFrame, out_path: Path):
    out_path.parent.mkdir(parents=True, exist_ok=True)
    jsonl_records = []
    with out_path.open('w', encoding='utf-8') as f:
        for _, row in recipes.iterrows():
            recipe = {}
            recipe['recipe_id'] = str(row['id'])
            recipe['name'] = row.get('name')
            recipe['description'] = row.get('description')
            recipe['cook_time_min'] = row.get('minutes')
            recipe['ingredients'] = row.get('ingredients')
            recipe['ingredient_count'] = row.get('n_ingredients') if 'n_ingredients' in row else (len(row.get('ingredients') or []))
            recipe['instructions'] = row.get('steps')
            recipe['tags'] = row.get('tags')
            recipe['n_steps'] = row.get('n_steps') if 'n_steps' in row else (len(row.get('steps') or []))
            recipe['reviews'] = row.get('reviews')
            recipe['review_count'] = len(recipe['reviews'])
            recipe['average_rating'] = np.mean([rev.get('rating') for rev in recipe['reviews']]) if recipe['review_count'] > 0 else None
            nutrition = row.get('nutrition') or []
            if isinstance(nutrition, (list, tuple)) and len(nutrition) >= 6:
                nutrition_obj = {
                    'calories': float(nutrition[0]),
                    'total_fat_pdv': float(nutrition[1]),
                    'sugar_pdv': float(nutrition[2]),
                    'sodium_pdv': float(nutrition[3]),
                    'protein_pdv': float(nutrition[4]),
                    'saturated_fat_pdv': float(nutrition[5])
                }
            elif isinstance(nutrition, dict):
                nutrition_obj = nutrition
            else:
                nutrition_obj = {}
            recipe['nutrition'] = nutrition_obj
            jsonl_records.append(recipe)
            f.write(json.dumps(recipe))
            f.write('\n')
    return jsonl_records


def build_tables(jsonl_records, tables_out_dir: Path):
    tables_out_dir.mkdir(parents=True, exist_ok=True)
    formatted_recipes = pd.DataFrame(jsonl_records)

    # Normalize & serialize text fields for safe CSV output
    formatted_recipes['name'] = formatted_recipes['name'].apply(lambda x: normalize_text(x) if pd.notna(x) else '')
    formatted_recipes['description'] = formatted_recipes['description'].apply(lambda x: normalize_text(x) if pd.notna(x) else '')

    def instructions_to_text(x):
        if isinstance(x, (list, tuple)):
            return ' || '.join([normalize_text(s) for s in x if s is not None])
        return normalize_text(x or '')

    formatted_recipes['instructions_text'] = formatted_recipes['instructions'].apply(instructions_to_text)

    # Recipes table
    recipes_df = formatted_recipes[['recipe_id', 'name', 'description', 'cook_time_min', 'ingredient_count', 'n_steps', 'review_count', 'average_rating', 'instructions_text']].copy()
    recipes_df = recipes_df.rename(columns={'instructions_text': 'instructions'})
    recipes_df.to_csv(tables_out_dir / 'recipes.csv', index=False)

    # Ingredients
    all_ingredients = set()
    for ingredients in formatted_recipes['ingredients']:
        for ing in ingredients:
            if isinstance(ing, str):
                all_ingredients.add(ing.strip().lower())
    ingredients_list = sorted(all_ingredients)
    ingredients_df = pd.DataFrame({'ingredient_id': range(1, len(ingredients_list)+1), 'ingredient_name': ingredients_list})
    ingredients_df.to_csv(tables_out_dir / 'ingredients.csv', index=False)

    # recipe_ingredients
    name_to_id = dict(zip(ingredients_df['ingredient_name'], ingredients_df['ingredient_id']))
    recipe_ingredients = []
    for _, row in formatted_recipes.iterrows():
        rid = row['recipe_id']
        for ing in row['ingredients'] or []:
            if not isinstance(ing, str):
                continue
            ing_name = ing.strip().lower()
            iid = name_to_id.get(ing_name)
            if iid:
                recipe_ingredients.append({'recipe_id': rid, 'ingredient_id': iid})
    pd.DataFrame(recipe_ingredients).to_csv(tables_out_dir / 'recipe_ingredients.csv', index=False)

    # Tags
    all_tags = set()
    for tags in formatted_recipes['tags']:
        for tag in tags:
            if isinstance(tag, str):
                all_tags.add(tag.strip().lower())
    tags_list = sorted(all_tags)
    tags_df = pd.DataFrame({'tag_id': range(1, len(tags_list)+1), 'tag_name': tags_list})
    tags_df.to_csv(tables_out_dir / 'tags.csv', index=False)

    # recipe_tags
    tag_map = dict(zip(tags_df['tag_name'], tags_df['tag_id']))
    recipe_tags = []
    for _, row in formatted_recipes.iterrows():
        rid = row['recipe_id']
        for tag in row['tags'] or []:
            if not isinstance(tag, str):
                continue
            t = tag.strip().lower()
            tid = tag_map.get(t)
            if tid:
                recipe_tags.append({'recipe_id': rid, 'tag_id': tid})
    pd.DataFrame(recipe_tags).to_csv(tables_out_dir / 'recipe_tags.csv', index=False)

    # Nutrition
    nutrition_rows = []
    for _, row in formatted_recipes.iterrows():
        rid = row['recipe_id']
        n = row.get('nutrition') or {}
        nutrition_rows.append({
            'recipe_id': rid,
            'calories': n.get('calories'),
            'total_fat_pdv': n.get('total_fat_pdv'),
            'sugar_pdv': n.get('sugar_pdv'),
            'sodium_pdv': n.get('sodium_pdv'),
            'protein_pdv': n.get('protein_pdv'),
            'saturated_fat_pdv': n.get('saturated_fat_pdv')
        })
    pd.DataFrame(nutrition_rows).to_csv(tables_out_dir / 'nutrition.csv', index=False)

    return {
        'recipes': len(recipes_df),
        'ingredients': len(ingredients_df),
        'recipe_ingredients': len(recipe_ingredients),
        'tags': len(tags_df),
        'recipe_tags': len(recipe_tags),
        'nutrition': len(nutrition_rows)
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--raw-dir', type=Path, default=Path('../data/recipes/raw_data'), help='Directory with RAW_recipes.csv and RAW_interactions.csv')
    parser.add_argument('--out-dir', type=Path, default=Path('../data/recipes/processed'), help='Output processed directory')
    args = parser.parse_args()

    recipe_csv = args.raw_dir / 'RAW_recipes.csv'
    interaction_csv = args.raw_dir / 'RAW_interactions.csv'
    jsonl_out = args.out_dir / 'recipes_with_reviews.jsonl'
    tables_dir = args.out_dir / 'tables'

    print(f"Reading recipes from {recipe_csv} and interactions from {interaction_csv}")
    recipes = read_recipes_csv(recipe_csv, interaction_csv)
    print(f"Read {len(recipes)} recipes")

    print(f"Writing JSONL to {jsonl_out}")
    jsonl_records = write_jsonl(recipes, jsonl_out)
    print(f"Wrote {len(jsonl_records)} JSONL records")

    print(f"Building tables in {tables_dir}")
    stats = build_tables(jsonl_records, tables_dir)
    print("Done. Table counts:")
    for k, v in stats.items():
        print(f"  {k}: {v}")


if __name__ == '__main__':
    main()
