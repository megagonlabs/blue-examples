### Set Up Postgres DB with Example Data

1. From this directory, run:

```bash
docker run -d --name workspace \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=blueplate \
  -e POSTGRES_DB=recipes \
  -p 5449:5432 \
  -v "$(pwd)/example_data/asian_recipes_sample_dump.sql:/docker-entrypoint-initdb.d/init.sql:ro" \
  postgres
```
Note that you can switch to non asian recipes by changing the dump reference to other_recipes_sample_dump.sql.

This mounts the SQL dump into `/docker-entrypoint-initdb.d/`, which PostgreSQL automatically executes on first startup.


2. Verify the data is loaded correctly:

```bash
docker exec -it workspace psql -U postgres -d recipes -c "\dt"
```

3. Create a Data Registry Entry

To register this database in the Blue platform data registry, use:

```json
{
    "connection": {
        "host": "10.0.174.72",  // Replace with your actual host IP
        "port": 5449,
        "protocol": "postgres",
        "user": "postgres",
        "password": "blueplate"
    },
    "metadata": {}
}
```

4. Select Actions → Synchronize

5. Reload the page - you should now see the recipes database listed under Databases. You can explore the database schema by clicking on recipes → public to verify the data is loaded correctly.
