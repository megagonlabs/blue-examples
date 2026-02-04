# Installation

This guide covers the additional setup needed for the Data Explorer and Visualization demo beyond the base Blue platform installation.

## Prerequisites

- **Blue platform installed and running** - Follow Blue QUICK-START.md or LOCAL-INSTALLATION.md
- **Blue CLI installed and configured** - Required for agent registration
- **OpenAI API key** - Required for LLM-powered agents

## What This Demo Adds

This demo requires four agents working together:
1. **NL2SQL Agent** (shipped with Blue) - Converts natural language questions to SQL
2. **Data Exploration Agent** - Performs automated EDA - [README](../../agents/data_exploration/README.md)
3. **Data Visualization Agent** - Creates Vega-Lite visualizations - [README](../../agents/data_visualization/README.md)
4. **Interaction Controller Agent** - Orchestrates the workflow - [README](../../agents/interaction_controller/README.md)

## Installation Steps

### 1. Configure OpenAI API Key

Add your OpenAI API key to your environment file (e.g., `localhost.envrc`):
```bash
export OPENAI_API_KEY="your-api-key-here"
```

### 2. Set Up Example Data

#### postgres_example

This demo uses the `postgres_example` dataset which is shipped with Blue. To enable agents to discover this data:

1. Open the Blue web application and log in
2. Navigate to **Data** under registries
3. Click on `postgres_example` dataset in the registry
4. Select **Actions** → **Synchronize**
5. Reload the page - you should now see the `postgres` database listed under **Databases**

You can explore the database schema by clicking on `postgres` → `public` to verify the data is loaded correctly.

#### postgres_workspace

This demo also uses the `postgres_workspace` dataset which contains prebuilt data for the data explorer and visualization.

1. From this directory, run:

```bash
docker run -d --name postgres_workspace \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=workspace \
  -p 5449:5432 \
  -v "$(pwd)/postgres_workspace.sql:/docker-entrypoint-initdb.d/init.sql:ro" \
  postgres
```

This mounts the SQL dump into `/docker-entrypoint-initdb.d/`, which PostgreSQL automatically executes on first startup.

2. Verify the data is loaded correctly:

```bash
docker exec -it postgres_workspace psql -U postgres -d workspace -c "\dt"
```

3. Create a Data Registry Entry

To register this database in the Blue platform data registry, use:

```json
{
    "connection": {
        "host": "10.0.175.210",  // Replace with your actual host IP
        "port": 5449,
        "protocol": "postgres",
        "user": "postgres",
        "password": "postgres"
    },
    "metadata": {}
}
```
4. Select **Actions** → **Synchronize**

### 3. Build and Deploy the Four Agents

Build and register each agent (refer to individual agent READMEs for details):

```bash
# 1. NL2SQL Agent (shipped with Blue)
cd blue/agents/nl2sql
./docker_build_agent.sh
blue registry agent update agent.json

# 2. Data Exploration Agent
cd blue-examples/agents/data_exploration
./docker_build_agent.sh
blue registry agent update agent.json

# 3. Data Visualization Agent
cd blue-examples/agents/data_visualization
./docker_build_agent.sh
blue registry agent update agent.json

# 4. Interaction Controller Agent
cd blue-examples/agents/interaction_controller
./docker_build_agent.sh
blue registry agent update agent.json
```

### 4. Deploy Agents

In the Blue UI (`http://localhost:3000`):

1. Navigate to **Agents**
2. Deploy each of the four agents:
   - `NL2SQL`
   - `DATA_EXPLORATION_AGENT`
   - `DATA_VISUALIZATION_AGENT`
   - `INTERACTION_CONTROLLER`
3. Verify all agents show as "Running"

**Note**: Each agent's README contains detailed configuration options and properties.

## Verification

Verify all four agents are running:
```bash
docker ps | grep blue-agent
```

You should see containers for all four agents.


## Troubleshooting

- Verify OpenAI API key is set: `echo $OPENAI_API_KEY`
- Ensure all four agents are deployed and running
  - Check blue platform logs: `docker logs <platform-api-container-name> `
  - Check agent logs: `docker logs <agent-container-name>`
- Check that data registry has synced database schemas



