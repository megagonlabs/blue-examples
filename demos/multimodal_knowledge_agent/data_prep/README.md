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
python data_prep/data_prep_recipes.py \
  --raw-dir data/recipes/raw_data \
  --out-dir data/recipes/processed
```

---

## Instructions to create Postgres DB


1. Create a database (adjust user if needed):

```bash
createdb -U postgres recipes
# or using psql
psql -U postgres -c "CREATE DATABASE recipes;"
```

2. Apply the DDL to create tables:

```bash
psql -U postgres -d recipes -f ../data/recipes/processed/tables/ddl.txt
```

3. Import CSV files: 

You can now import CSV tables generated under `../data/recipes/processed/tables/` 

Example: 
```bash
psql -U postgres -d recipes -c "COPY public.recipes FROM '../data/recipes/processed/tables/recipes.csv' WITH CSV HEADER"
```

Notes and tips:
- Ensure the target tables exist (create them via the DDL) and column ordering in the CSV matches the table schema. 

4. Create a database dump: 

After you have imported the csv files and imported the data, you can create a database dump: 

```bash
pg_dump -U postgres -d recipes -F p -f recipes_db_dump.sql
# restore with:
psql -U postgres -d recipes -f recipes_db_dump.sql
```

5. Follow the instructions at postgres_db/README.md on how to link to the data registry.


