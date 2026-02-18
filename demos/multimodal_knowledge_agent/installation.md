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

This project uses two databases:
- **Relational database** (PostgreSQL) for recipe data. See [`postgres_db/README.md`](postgres_db/README.md) for setup instructions for example data. If using raw, full dataset, follow instructions at  [`data_prep/README.md`](data_prep/README.md) 

- **Vector database** (ChromaDB) for recipe embeddings. See [`vector_db/README.md`](vector_db/README.md) for setup.

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