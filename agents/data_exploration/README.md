# Data Exploration Agent

The Data Exploration Agent performs automated Exploratory Data Analysis (EDA) on database tables. It:

- Identifies relevant tables based on user queries
- Categorizes columns by type (numerical, categorical, id-like, text/json, date)
- Generates type-appropriate statistics (histograms, frequencies, missing values)
- Creates markdown summaries with insights and suggestions
- Stores visualization-ready data for downstream agents

## Usage

1. Build `DATA_EXPLORATION_AGENT` agent

```bash
cd agents/data_exploration
./docker_build_agent.sh
```

2. Set agent properties

**Option A: Automatic (via CLI)**
```bash
cd agents/data_exploration
blue registry agent update agent.json
```

**Option B: Manual (via UI)**
- Create a `DATA_EXPLORATION_AGENT` agent with the following properties:
 ```json
 {
 }
```
- Add input `DEFAULT` and configure it with:
  - listens: **excludes** `USER`

3. Deploy `DATA_EXPLORATION_AGENT` agent on UI.

