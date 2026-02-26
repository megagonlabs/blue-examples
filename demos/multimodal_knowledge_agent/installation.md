# Installation

## Prerequisites

- Python >= 3.10
- blue_cli >= 1.1
- blue_platform >= 1.1
- OpenAI API key

For Blue package installation, see the official docs: [Quickstart guide](https://blue.megagon.info/latest/quickstart.html)

## Installation Steps

### 1. Database Setup

We have provided some preprocessed example synthetic data files under: `../data/recipes/processed`

#### 1.1 Postgres set up (via Blue UI)

1. Create a new database `recipes_example` on the existing postgres shipped with Blue.

```bash
docker exec -it "$(docker ps -q --filter 'ancestor=postgres:16.0' | head -n 1)" \
psql -U postgres -c "CREATE DATABASE recipes_example;"
```

2. Upload the example data into the database

```bash
docker exec -i "$(docker ps -q --filter 'ancestor=postgres:16.0' | head -n 1)" psql -U postgres -d recipes_example < "data/recipes/processed/asian_recipes_sample_dump.sql"
```

Next we will enable agents to discover this data:

3. Log in to the Blue web app
4. Go to `Data` under `Registries`
5. Open `recipes_example`
6. Select Actions → Duplicate. Set `source` name to `Recipes`. Click `Create`
7. Select Actions → Synchronize
8. Refresh and confirm `recipes` appears under Databases
9. Note that the agents rely on a data source named `Recipes` in the data registry.

#### 1.2. ChromaDB set up

##### 1. Install dependencies

```bash
pip install chromadb fastapi uvicorn openai requests
export OPENAI_API_KEY="your-api-key-here"
```

##### 2. Start the server

```bash
cd db
./start_vector_db.sh
```

The server will start at `http://localhost:8000` and automatically index the example data.

##### 3. Verify ChromaDB is working

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

If you want to use the full data, follow the instructions at [`db/README.md`](db/README.md)

### 2. Build Agents

Build all agent Docker images:

```bash
cd agents && bash docker_build_all_agents.sh
```

Ensure Docker is installed and running.

### 3. Register Agents

Add agents to the registry:

```bash
blue registry agent update agent.json
```

This creates registry entries from `agent.json`:

![agent registry](assets/mm_knowledge_agent_registry.png)

Note: that during the agent registration process:
1. You will need to login via the browser
2. You will need to then return to the CLI to confirm the agent registry changes

### 4. Deploy Agents

In the Blue UI (`http://localhost:3000`):

1. Navigate to **Agents**
2. Deploy the following agents:
    - Blue System Agents:
        - `Task Coordinator Agent`
        - `Presenter Agent`
    - Demo-specific Agents:
        - `Blue Plate Agent`
        - `Reactive Blue Plate Agent`
        - `Ingredient Extractor Agent`
        - `Recipe Retrieval Agent`
        - `Dish Ideation Agent`
        - `Recipe Query Executor Agent`
        - `Recipe Visualizer Agent`
3. Verify all agents show as "Running"

![deploy agent](assets/mm_knowledge_agent_deploy.png)

See [`demo_example.md`](demo_example.md) for usage examples.
