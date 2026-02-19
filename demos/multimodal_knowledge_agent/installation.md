# Installation

## Prerequisites

- Python >= 3.10
- blue_cli >= 1.1
- blue_platform >= 1.1
- OpenAI API key

For Blue package installation, see the official docs:

- [Quickstart guide](https://github.com/megagonlabs/blue/blob/v1.0/QUICK-START.md)
- [Local installation guide](https://github.com/megagonlabs/blue/blob/v1.0/LOCAL-INSTALLATION.md)

(TODO: replace them with the latest doc links)

## Setup

### 1. Database Setup

Preprocessed example files are already included under: `../data/recipes/processed`

#### 1.1 Postgres set up (via Blue UI)

We will use the `recipes_example` dataset shipped with Blue. We will enable agents to discover this data by:

1. Log in to the Blue web app
2. Go to `Data` under `Registries`
3. Open `recipes_example`
4. Select Actions → Duplicate. Set `source` name to `Recipes`. Click `Create`
5. Select Actions → Synchronize
6. Refresh and confirm `recipes` appears under Databases
7. Note that the agents rely on a data source named `Recipes` in the data registry.

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

To deploy an agent:

1. In the agent registry, click the agent.
2. Click **Actions > Deploy**.

![deploy agent](assets/mm_knowledge_agent_deploy.png)

Once deployed, the agent status should show "container: running".

See [`demo_example.md`](demo_example.md) for usage examples.
