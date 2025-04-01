# Visualizer

Visualizer is an agent to that has a built in template property (`template`) for visualizing data that is populated from query results. Queries can either be specified in natural language or SQL, through `questions` and `queries` properties. Each question (or query) in these properties have an id and the corresponding natural language question or sql query (optionally source for SQL). Once all queries are executed the template can refer to query results through these ids within the template. The visualization template is expressed in [vega-lite](https://vega.github.io/). 


The following animation displays a visualizer agent issuing a single natural language query and rendering a visualization with the query result:

![Demo of Visualizer agent](/docs/images/visualizer.gif)

---

## Features

- **Natural Language Queries:** Allows users to specify any number of natural language queries
- **SQL Queries:** Allows users to specifies queries directly in SQL
- **Coordinator Agent:** Users coordinator agent to instruct NL2SQL (for NL queries) and QUERY_EXECUTOR (for SQL queries) agents.
- **Templates:** Uses templates where data from queries can be substituted
- **Visualizations:** Renders charts for any vega-lite specification
  
---

## Input & Output

### Input

- **DEFAULT:** Triggers execution of queries.

### Output

- **VIS:** Visualization in vega

---

## Properties
 
- `template`: vega-lite specification of a visualization, with substitutions for ids for each each query results
- `questions`: id and question pairs expressed in natural language
- `queries`: id and query pairs expressed in SQL

---

## Code Overview

The `VISUALIZER` agent is defined [here](https://github.com/megagonlabs/blue/blob/v0.9/lib/blue/agents/visualizer.py))

- **Processing:**
  - Iterate over all questions:
    - Create a plan for each question invoking the `NL2SQL` agent
    - Store query result by query id
  - Iterate over all queries:
    - Create a plan for each query invoking the `QUERY_EXECUTOR` agent
    - Store query result by query id
  - Subsitute query results in template by the respective query ids
  - Render visualization

---

## Try it out

To try out the agent, first follow the [quickstart guide](https://github.com/megagonlabs/blue/blob/v0.9/QUICK-START.md) to deploy the `Visualizer Agent` (`VISUALIZER`), `Task Coordinator Agent` (`COORDINATOR`), `Query Executor Agent` (`QUERY_EXECUTOR`), and `NL-to-SQL Agent` (`NL2SQL`) agents.

Once deployed create a new session and add the above agents to the session. Note: For this example you need to add `Visualizer Agent - Example` (`VISUALIZER___EXAMPLE`) agent instead of `VISUALIZER`.

In the UI, enter some text.

| **User Input** | **Result** |
|--------------------------------|---------|
| 'go' | bar chart |

