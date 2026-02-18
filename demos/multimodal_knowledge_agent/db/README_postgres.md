### Set up Postgres DB

1. Start the database container. Run from this directory: 

```bash
docker run -d --name workspace \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=blueplate \
  -e POSTGRES_DB=recipes \
  -p 5432 \
  -v "$(pwd)/<path to sql dump>:/docker-entrypoint-initdb.d/init.sql:ro" \
  postgres
```

To load different data, replace the path to dump:

example_data/asian_recipes_sample_dump.sql or example_data/other_recipes_sample_dump.sql

OR

recipes_data/recipes_db_dump.sql if using dump created from processing the raw data

What this does

- starts Postgres container named workspace

- creates database recipes

- exposes database on localhost:5432

- loads example data automatically on first startup


2. Verify the data is loaded correctly:

```bash
docker exec workspace psql -U postgres -d recipes -c "\dt"
```

You should see tables listed.

3. Register database in Blue platform

Use this configuration:

```json
{
    "connection": {
        "host": "localhost",
        "port": 5432,
        "protocol": "postgres",
        "user": "postgres",
        "password": "blueplate"
    },
    "metadata": {}
}
```

Always use localhost when connecting from your machine. 

4. Verify Blue platform can access the database

Log in to the blue web application. Click in Data under registries, and then click on `recipes` dataset in the registry. Under Actions select `Edit` and rename the `source` to `Recipes`. `Save` and then select `Synchronize`. 



If you reload the page now you should see `Recipes` database listed under Databases. If you click on `recipes` and then `public` you can explore the database schema.

