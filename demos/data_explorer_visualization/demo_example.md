# Demo Example

## Quick Start

1. Create a new session in the Blue web application
2. Add the following agents to the session:
   - `INTERACTION_CONTROLLER`
   - `DATA_EXPLORATION_AGENT`
   - `DATA_VISUALIZATION_AGENT`
   - `NL2SQL`
   - `COORDINATOR`

3. Try example queries:

| **User Input** | **Expected Result** |
|----------------|---------------------|
| "Profile the `<table name>` data" | EDA summary with statistics and insights |
| "Create an interactive visualization using `<table name>` dataset" | Vega-Lite bar chart visualization |
| "In `<table name>` data, visualize correlation between `<attribute name>` and other important factors" | EDA + multiple coordinated charts |