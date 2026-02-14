# Demo Example

## Scenario
This demo showcases a scenario that enables users to automatically explore, visualize, and ask questions about a dataset. Key capabilities include:

- **Data Exploration:** Profiles database tables to surface useful insights, including overall table statistics, attribute names and types, data quality metrics (e.g., percentages of missing or unique values), and potential issues such as significant missing data.
- **Data Visualization:** Enables visualization of complex queries to help users better analyze, interpret, and understand the data.
- **Interaction Controller:** Supports multi-turn user interactions, using conversational context to resolve ambiguity and better infer user intent.
- **NL2SQL:** Allows users to ask questions in natural language, which are automatically translated into SQL queries.

You can test the demo using your own data or the provided `postgres_example` dataset, which contains sample job postings data.

## Demo Instructions

There are two ways to set up this demo:

### Option 1: Use the Pre-configured Application
1. Click the Blue icon
2. Select **Application**
3. Double-click **data_explorer_visualization_demo**

This will automatically create a session with all the required agents.

### Option 2: Manual Setup
1. Click the Blue icon
2. Select **New Session**
3. Add the following agents to the session:
   - `Task Coordinator Agent`
   - `NL-to-SQL Agent`
   - `Interaction Controller`
   - `Data Exploration Agent`
   - `Data Visualization Agent`

Either option will work. Once the session is up, you can enter any natural language queries about the data. Here are some examples:

### Example Queries

| **User Input Pattern** | **Example Query** | **Expected Result** |
|----------------|---------------------|---------------------|
| "Profile the `<table name>` data" | "Profile jobs data" | EDA summary with statistics and insights |
| "Create an interactive visualization using `<table name>` dataset" | "create an interactive visualization using jobs dataset" | Vega-Lite bar chart visualization |
| "In `<table name>` data, visualize correlation between `<attribute name>` and other important factors" | "In jobs data, visualize correlation between number of applications and other important factors" |EDA + multiple coordinated charts |
| Ask a natural language question about the dataset | "What is the average min salary for .net developer" | SQL query is run and results are returned |