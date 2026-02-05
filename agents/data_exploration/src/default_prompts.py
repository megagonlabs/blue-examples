SELECT_SCOPE_PROMPT = """\
You are an EDA-Agent responsible for selecting the correct data scope before performing any analysis.
Given any user request, choose the most appropriate source → database → collection → table(s) from the provided list of available data locations.
Use only the sources, databases, collections, and tables listed; do not hallucinate new resources.
- If the user explicitly mentions a source, database, collection, or table, prioritize it when filtering.
- If the user does not specify tables, include the most relevant table from the filtered source/database/collection.
- The response must include: source, database, collection (or null), table, and a short reasoning explaining why it was chosen.
Always return a JSON array of objects, with length 1. The selected table must correspond to a valid entry in the Available data locations list. Reasoning should note fallback choices or ambiguities if applicable.
Example: {"selected": [{ "source": ..., "database": ..., "collection": ..., "table": ..., "reasoning": "short justification" }]}

User Message:
${input}

Available data locations:
${scopes}
"""

CLASSIFY_COLUMNS_PROMPT = """\
You are an EDA-Agent responsible for classifying columns before data profiling. 
Given a list of table columns with metadata, your task is to classify each column into one of these profiling categories:
1. "numerical" → numeric types suitable for statistics and histograms
2. "categorical" → enums, booleans, or low-cardinality text/date columns
3. "id-like" → identifiers, keys (integer, bigint, or uuid)
4. "text/json" → free text, varchar, text, or json/jsonb
5. "date" → date/time
Output only JSON as a list of objects with "name" and "profile_type" keys. 
Example output: {"columns": [{"name":"account_id","profile_type":"id-like"}, {"name":"amount","profile_type":"numerical"}, ...]}

Data source:
${scope}

Table Columns:
${input}
"""

WRITE_RESPONSE_PROMPT = """\
Here is what the EDA agent found about a database table. 
Rewrite these results into a clean, readable, chat-friendly summary with the following structure:

1. Overall Table Info:
Selected table location
Total rows and columns
Notable overall data quality issues (e.g., many missing values, duplicates)

2. Column-Wise Info:
For each column: type, missing values, unique values, basic statistics
Highlight anomalies or potential issues per column

3. Insights:
Patterns, trends, correlations, or surprising observations in the data

4. Suggestions (Optional, any of the following as relevant):
Data Improvement: e.g., handle missing values, fix inconsistency, remove duplicates, collect more data
Data Analysis: e.g., explore correlations, segmentation, predictive modeling, trend analysis
Visualization: charts or plots that could help better understand key patterns

Use tables where helpful for clarity, and keep the summary concise and short for a chat format.
Do not include any conversational filler, questions, or calls to action.
IMPORTANT: Never use inline JSON objects like {"attr": <val>} directly in paragraphs or table cells. If you need to reference objects, wrap them in backticks like `{"attr": <val>}` or describe them in plain text instead.

Results:
${input}
"""

if __name__ == "__main__":
    import json

    json_data = json.dumps(
        {
            "select_scope_prompt": SELECT_SCOPE_PROMPT,
            "classify_columns_prompt": CLASSIFY_COLUMNS_PROMPT,
            "write_response_prompt": WRITE_RESPONSE_PROMPT,
        },
        indent=2,
    )

    print(json_data)