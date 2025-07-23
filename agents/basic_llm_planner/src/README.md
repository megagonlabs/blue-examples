# Basic LLM Planner

This is a basic implementation of a LLM (Large Language Model) planner. The goal of this planner is to take a high-level task description and break it down into smaller, manageable sub-tasks that can be executed by an LLM.

- **Input:** A task expressed in natural language, which may be the output of the intent understanding module in a dialogue interface. The input is assumed to be fully specified and unambiguous.
- **Output:** A directed acyclic graph (DAG) of execution agents.


## v0: Plan Generation without Execution

- Given a user input, decompose the task into sub-tasks using the OpenAI agent (`OPENAI___ROGUEAGENT`).
- Show the plan without executing it.


**Workflow in `default_processor()`**

1. **Collect User Input:**
   - On BOS (beginning of stream), initialize the stream data as an empty list in the worker.
   - On DATA, append incoming data to the stream.
   - On EOS (end of stream), collect all user input from the stream using `stream_data = worker.get_data('stream')`. Concatenate the stream data into a single string representing the user's task description.
2. **Decompose Task:**
   - Use the OpenAI agent to decompose the high-level user task into a list of sub-tasks.
3. **Show Plan:**
   - Return the plan for inspection, but do not execute any sub-tasks.
