#!/usr/bin/env bash
set -euo pipefail

RAW_DIR="${RAW_DIR:-../data/recipes/raw_data}"
OUT_DIR="${OUT_DIR:-../data/recipes/processed}"
DB_NAME="${DB_NAME:-recipes}"

TABLES_DIR="$OUT_DIR/tables"
DDL="$TABLES_DIR/ddl.txt"

log() { echo -e "\n==> $*\n"; }

# 1) Process raw -> processed
log "Processing raw dataset -> processed outputs"
python data_prep_recipes.py --raw-dir "$RAW_DIR" --out-dir "$OUT_DIR"

log "Processing complete. Outputs are in: $OUT_DIR"

# Basic checks
[[ -f "$DDL" ]] || { echo "Missing DDL: $DDL"; exit 1; }
for f in recipes.csv ingredients.csv nutrition.csv tags.csv recipe_ingredients.csv recipe_tags.csv; do
  [[ -f "$TABLES_DIR/$f" ]] || { echo "Missing CSV: $TABLES_DIR/$f"; exit 1; }
done

# 2) Create DB (no-op if exists), create tables, import CSVs
log "Creating database (if missing): $DB_NAME"
createdb "$DB_NAME" 2>/dev/null || true
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -f "$DDL"

# Parent tables first
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\copy public.recipes FROM '$TABLES_DIR/recipes.csv' WITH CSV HEADER"
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\copy public.ingredients FROM '$TABLES_DIR/ingredients.csv' WITH CSV HEADER"
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\copy public.nutrition FROM '$TABLES_DIR/nutrition.csv' WITH CSV HEADER"
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\copy public.tags FROM '$TABLES_DIR/tags.csv' WITH CSV HEADER"

# Join tables last
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\copy public.recipe_ingredients FROM '$TABLES_DIR/recipe_ingredients.csv' WITH CSV HEADER"
psql -d "$DB_NAME" -v ON_ERROR_STOP=1 -c "\copy public.recipe_tags FROM '$TABLES_DIR/recipe_tags.csv' WITH CSV HEADER"

log "Done. Tables in $DB_NAME:"

# Quick verify
psql -d "$DB_NAME" -c "\dt"
