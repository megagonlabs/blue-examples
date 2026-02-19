This demo uses two databases:

1. Postgres → structured filtering over recipes
2. ChromaDB → semantic (vector) recipe retrieval

You can either:

- Use the small example dataset (~1k recipes) → Follow the instruction in [`../installation.md`](../installation.md)
OR
- Process the full raw dataset (>230k recipes) and import into Postgres → Follow the instruction below

----

## Full Dataset

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











