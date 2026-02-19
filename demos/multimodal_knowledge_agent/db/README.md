This demo uses two databases:

1. Postgres → structured filtering over recipes
2. ChromaDB → semantic (vector) recipe retrieval

You can either:

- Use the small example dataset (~1k recipes)
OR
- Process the full raw dataset (>230k recipes) and import into Postgres

----

## Option 1 — Quick Start (Example Dataset)

Preprocessed example files are already included under: `../data/recipes/processed`

### 1. Postgres set up (via Blue UI)

We will use the `recipes_example` dataset shipped with Blue. We will enable agents to discover this data by:

1. Log in to the Blue web app
2. Go to `Data` under `Registries`
3. Open `recipes_example`
4. Select Actions → Duplicate. Set `source` name to `Recipes`. Click `Create`
5. Select Actions → Synchronize
6. Refresh and confirm `recipes` appears under Databases
7. Note that the agents rely on a data source named `Recipes` in the data registry.

### 2. ChromaDB set up

#### 1. Install dependencies 

```bash
pip install chromadb fastapi uvicorn openai requests
export OPENAI_API_KEY="your-api-key-here"
```

#### 2. Start the server

```bash
cd db
./start_vector_db.sh
```

The server will start at `http://localhost:8000` and automatically index the example data.

#### 3. Verify ChromaDB is working

Check server health:
```bash
curl http://localhost:8000/
```

Expected response:
```json
{
    "status": "ok",
    "message": "Vector Database API is running",
    "indexed_documents": 50,
    "indexed_sources": ["example_asian_recipes.jsonl", "example_other_recipes.jsonl"]
}
```

Try a simple search:
```bash
curl -X POST http://localhost:8000/query \
  -H "Content-Type: application/json" \
  -d '{"query": "spicy Asian noodles", "top_k": 3}'
```


---

## Option 2 — Full Dataset

#### 1. Download the dataset from Kaggle and place the files in `../data/recipes/raw_data`

#### 2. Process and Import into Remote Postgres

Use the unified pipeline script:

By default, the script uses a local socket for postgres. If connecting to a remote host, either use -h or set env vars once:

```bash
export PGHOST=10.0.189.93
export PGUSER=postgres
```

Then run the following 
```bash
./recipes_process_and_import.sh
```

This script will:

- Process raw data into structured CSV tables
- Create the recipes database
- Create tables using generated DDL
- Import CSVs in correct foreign-key order


#### 3. Set up the docker container.

Create a database dump
```bash 
pg_dump -U postgres -d recipes -F p -f <path to sql dump>
```

```bash 
docker run -d --name workspace \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=blueplate \
  -e POSTGRES_DB=recipes \
  -p 5432 \
  -v "$(pwd)/<path to sql dump>:/docker-entrypoint-initdb.d/init.sql:ro" \
  postgres
  ```

Verify the data is loaded correctly: 

```bash 
docker exec workspace psql -U postgres -d recipes -c "\dt"
```

#### 4. Register Database in Blue

1. Log in to the Blue web application. 
2. Click in `Data` under `Registries`. Click on `Add Source`. 
3. Use `Recipes` as source name
4. Use the following configuration properties: 

```json
{
    "connection": {
        "host": "localhost", // Or replace with your actual host IP
        "port": 5432,
        "protocol": "postgres",
        "user": "postgres",
        "password": "blueplate"
    },
    "metadata": {}
}
```

5. Select Actions → Synchronize
6. Reload the page and verify `recipes` → `public` schema is visible.
7. Note that the agents rely on a data source named `Recipes` in the data registry.


#### 5. Set up the chromaDB server

Follow instructions from Option 1 to index the files automatically.











