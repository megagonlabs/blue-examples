# Installation

This guide covers the additional setup needed for the Data Explorer and Visualization demo beyond the base Blue platform installation.

## Prerequisites

- **Blue platform installed and running** - Follow Blue QUICK-START.md or LOCAL-INSTALLATION.md
- **Blue CLI installed and configured** - Required for agent registration
- **OpenAI API key** - Required for LLM-powered agents

## What This Demo Adds

This demo requires five agents working together:
1. **Interaction Controller** - Orchestrates the workflow - [README](../../agents/interaction_controller/README.md)
2. **Data Exploration Agent** - Performs automated EDA - [README](../../agents/data_exploration/README.md)
3. **Data Visualization Agent** - Creates Vega-Lite visualizations - [README](../../agents/data_visualization/README.md)
4. **NL-to-SQL Agent** (shipped with Blue) - Converts natural language questions to SQL
5. **Task Coordinator Agent** (shipped with Blue) - Coordinates task execution across agents (required for Interaction Controller)

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

### 3. Build and Register the Required Agents

Build each agent:

```bash
# 1. Interaction Controller Agent
cd blue-examples/agents/interaction_controller
./docker_build_agent.sh

# 2. Data Exploration Agent
cd blue-examples/agents/data_exploration
./docker_build_agent.sh

# 3. Data Visualization Agent
cd blue-examples/agents/data_visualization
./docker_build_agent.sh

# 4. NL2SQL Agent (shipped with Blue)
# Check if already built during Blue default agent building before running
cd blue/agents/nl2sql
./docker_build_agent.sh

# 5. Task Coordinator Agent (shipped with Blue)
# Check if already built during Blue default agent building before running
cd blue/agents/task_coordinator
./docker_build_agent.sh
```

Register all agents using the provided configuration:

```bash
cd blue-examples/demos/data_explorer_visualization
blue registry agent update agents.json
```

### 4. Deploy Agents

In the Blue UI (`http://localhost:3000`):

1. Navigate to **Agents**
2. Deploy each of the five agents:
   - `Task Coordinator Agent`
   - `NL-to-SQL Agent`
   - `Interaction Controller`
   - `Data Exploration Agent`
   - `Data Visualization Agent`
3. Verify all agents show as "Running"

**Note**: Each agent's README contains detailed configuration options and properties.

## Verification

Verify all five agents are running:
```bash
docker ps | grep blue-agent
```

You should see containers for all five agents.


## Troubleshooting

- Verify OpenAI API key is set: `echo $OPENAI_API_KEY`
- Ensure all five agents are deployed and running
  - Check blue platform logs: `docker logs <platform-api-container-name> `
  - Check agent logs: `docker logs <agent-container-name>`
- Check that data registry has synced database schemas



