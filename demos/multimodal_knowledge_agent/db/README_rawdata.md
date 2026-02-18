# Recipe Data Preprocessing Script

This script preprocesses the raw **Food.com recipe dataset** from Kaggle and converts it into formats suitable for both **vector databases** (e.g., ChromaDB) and **relational databases** (e.g., Postgres).

**Dataset source:**  
https://www.kaggle.com/datasets/shuyangli94/food-com-recipes-and-user-interactions/data

The dataset contains **180K+ recipes** from Food.com and was originally introduced in the following paper:

> **Generating Personalized Recipes from Historical User Preferences**  
> Bodhisattwa Prasad Majumder*, Shuyang Li*, Jianmo Ni, Julian McAuley  
> *EMNLP 2019*  
> https://www.aclweb.org/anthology/D19-1613/

---

## Outputs

The script produces the following artifacts:

### JSONL (for vector databases)
- `recipes_with_reviews.jsonl`  at default path `../data/recipes/processed/recipes_with_reviews.jsonl`
dp
### CSV Tables (for relational databases)
Generated under:  
`../data/recipes/processed/tables/`

- `recipes.csv`
- `ingredients.csv`
- `recipe_ingredients.csv`
- `tags.csv`
- `recipe_tags.csv`
- `nutrition.csv`

These tables are designed to be directly importable into databases such as **Postgres**.

---

## Usage

### 1. Download the Dataset
Download the dataset from Kaggle and place the files in `../data/recipes/raw_data`


### 2. Run the Script
From the repository root, run:

```bash
python data_prep_recipes.py \
  --raw-dir ../data/recipes/raw_data \
  --out-dir ../data/recipes/processed
```

---

## Instructions to create Postgres DB

### 1. Create a database (adjust user and file path if needed)

**Notes and tips:**
- createdb defaults to local socket connection
- Explicitly add host flag (e.g. -h 10.0.189.83) to tell it where to connect if not using default. Alternatively, set environment variables once so all Postgres CLI tools know where the server is. This is true for all the follow up instructions. 

```bash
export PGHOST=10.0.189.93
export PGUSER=postgres
```


```bash
createdb recipes
# or using psql
psql -c "CREATE DATABASE recipes;"
```


### 2. Apply the DDL to create tables

```bash
psql -d recipes -f ../data/recipes/processed/tables/ddl.txt
```

### 3. Import CSV files

The CSV tables are located in `../data/recipes/processed/tables/`.

Import all tables in the correct order (parent tables first, then join/child tables):

```bash
# Parent tables first
psql -d recipes -c "\\copy public.recipes FROM '../data/recipes/processed/tables/recipes.csv' WITH CSV HEADER"
psql -d recipes -c "\\copy public.ingredients FROM '../data/recipes/processed/tables/ingredients.csv' WITH CSV HEADER"
psql -d recipes -c "\\copy public.nutrition FROM '../data/recipes/processed/tables/nutrition.csv' WITH CSV HEADER"
psql -d recipes -c "\\copy public.tags FROM '../data/recipes/processed/tables/tags.csv' WITH CSV HEADER"


# Join tables last (they reference parent tables via foreign keys)
psql -d recipes -c "\\copy public.recipe_ingredients FROM '../data/recipes/processed/tables/recipe_ingredients.csv' WITH CSV HEADER"
psql -d recipes -c "\\copy public.recipe_tags FROM '../data/recipes/processed/tables/recipe_tags.csv' WITH CSV HEADER"
```c

**Notes and tips:**
- Ensure the target tables exist (created via the DDL) before importing CSVs.
- If you get "missing data for column X" errors, check if:
  - The CSV file has that column (check headers)
  - The column has data in all rows (some columns like `description` may be empty/nullable in the source data)
  - The column order matches between CSV and table schema
- Import parent tables before join/child tables to avoid foreign key constraint errors.

### 4. Create a database dump

After importing CSVs and verifying the data, create a backup dump:

```bash
pg_dump -U postgres -d recipes -F p -f recipes_db_dump.sql

# restore with:
psql -U postgres -d recipes -f recipes_db_dump.sql
```

Or use custom format (more flexible for restore):


### 5. Link to data registry

Follow the instructions at [postgres_db/README.md](../postgres_db/README.md) on how to link to the data registry.


