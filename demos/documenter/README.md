# Documenter

Documenter is an agent to that has a built in template property (`template`) for building documents data that is populated from query results. Queries can either be specified in natural language or SQL, through `questions` and `queries` properties. Each question (or query) in these properties have an id and the corresponding natural language question or sql query (optionally source for SQL). Once all queries are executed the template can refer to query results through these ids within the template. The document template is expressed in [Jinja](https://jinja.palletsprojects.com/en/stable/). Final document is rendered in markdown format. Optionally, the agent can also use `OPENAI Hiliter Agent` (`OPENAI___HILITER`) to hilight spans with the topics specified in the `hilite` property.

The following animation displays a documenter agent issuing a single natural language query and rendering a document with the query result:

![Demo of Documenter agent](/docs/images/documenter.gif)

---

## Features

- **Natural Language Queries:** Allows users to specify any number of natural language queries
- **SQL Queries:** Allows users to specifies queries directly in SQL
- **Coordinator Agent:** Uses coordinator agent to instruct NL2SQL (for NL queries) and QUERY_EXECUTOR (for SQL queries) agents.
- **OPENAI Hiliter Agent:** Uses hiliter agent to optionaly hilite spans in the document
- **Templates:** Uses templates where data from queries can be substituted
- **Markdown:** Renders documents with markdown specification
  
---

## Input & Output

### Input

- **DEFAULT:** Triggers execution of queries.

### Output

- **DOC:** Document in markdown

---

## Properties
 
- `template`: Jinja specification of a document, with substitutions for ids for each each query results
- `questions`: id and question pairs expressed in natural language
- `queries`: id and query pairs expressed in SQL

---

## Code Overview

The `DOCUMENTER` agent is defined [here](https://github.com/megagonlabs/blue/blob/v0.9/lib/blue/agents/documenter.py))

- **Processing:**
  - Iterate over all questions:
    - Create a plan for each question invoking the `NL2SQL` agent
    - Store query result by query id
  - Iterate over all queries:
    - Create a plan for each query invoking the `QUERY_EXECUTOR` agent
    - Store query result by query id
  - Subsitute query results in template by the respective query ids
  - Optionally, use `OPENAI___HILITER` to hilite document for specified topics
  - Render document

---

## Try it out

To try out the agent, first follow the [quickstart guide](https://github.com/megagonlabs/blue/blob/v0.9/QUICK-START.md) to deploy the `Document Builder Agent` (`DOCUMENTER`), `Task Coordinator Agent` (`COORDINATOR`), `Query Executor Agent` (`QUERY_EXECUTOR`),  `NL-to-SQL Agent` (`NL2SQL`), and `OPENAI Agent` (`OPENAI`) agents.

Once deployed create a new session and add the above agents to the session. Note: For this example add `Document Builder Agent - Example` (`DOCUMENTER___EXAMPLE`) and `OPENAI Hiliter Agent` (`OPENAI___HILITER`) agents.

In the UI, enter some text.

| **User Input** | **Result** |
|--------------------------------|---------|
| 'software engineer' | markdown document |

