# Basic LLM Planner

This is a basic implementation of a LLM (Large Language Model) planner. The goal of this planner is to take a high-level task description and break it down into smaller, manageable sub-tasks that can be executed by an LLM.

- **Input:** A task expressed in natural language, which may be the output of the intent understanding module in a dialogue interface. The input is assumed to be fully specified and unambiguous.
- **Output:** A directed acyclic graph (DAG) of execution agents.


## v1: Plan Generation and Execution

- Given a user input, decompose the task into sub-tasks using the OpenAI agent (`OPENAI___ROGUEAGENT`).
- Show the plan and execute it by assigning the sub-tasks to the `OPENAI___ROGUEAGENT` agent with tools.
    - Currently, Blue does not allow us to use the same agent template with different properties within the same plan.
    - Therefore, we need to create distinct templates on the UI beforehand: `OPENAI___ROGUEAGENT_0`, `OPENAI___ROGUEAGENT_1`, etc.
        - For the current demo, **we need 4 templates:** `OPENAI___ROGUEAGENT_0`, `OPENAI___ROGUEAGENT_1`, `OPENAI___ROGUEAGENT_2`, and `OPENAI___ROGUEAGENT_3`.

**Setup**

- Create the agent templates `OPENAI___ROGUEAGENT_0`, ... `OPENAI___ROGUEAGENT_4` by copying the `OPENAI___ROGUEAGENT` template.
- Build and run the basic calculator tool.
    - Update the configuration on the UI to have `add` and `sub` under the basic calculator tool.
- Build and run this agent.
- In the session, include the following agents:
    - `BASIC_LLM_PLANNER` (this agent)
    - `COORDINATOR` (for executing the plan)
    - `OPENAI___ROGUEAGENT` (for the task decomposition)
    - `OPENAI___ROGUEAGENT_0` (for the first sub-task)
    - `OPENAI___ROGUEAGENT_1` (for the second sub-task)
    - `OPENAI___ROGUEAGENT_2` (for the third sub-task)
    - `OPENAI___ROGUEAGENT_3` (for the fourth sub-task)


**Workflow in `default_processor()`**

1. **Collect User Input:**
   - On BOS (beginning of stream), initialize the stream data as an empty list in the worker.
   - On DATA, append incoming data to the stream.
   - On EOS (end of stream), collect all user input from the stream using `stream_data = worker.get_data('stream')`. Concatenate the stream data into a single string representing the user's task description.
2. **Decompose Task:**
   - Use the OpenAI agent to decompose the high-level user task into a list of sub-tasks.
   - The result will be returned to this agent as `RESULT_PLAN`.
3. **Show Plan and Execute:**
   - On receiving `RESULT_PLAN`, log the result and show it on the UI.
   - For each sub-task, create a new `OPENAI___ROGUEAGENT` agent with the sub-task as input.
   - Connect the last sub-task executor to this planner agent as `RESULT_EXECUTION`.
   - Submit the sub-task for execution.
   - The result will be returned to this agent as `RESULT_EXECUTION`.
4. **Show Execution Result:**
   - On receiving `RESULT_EXECUTION`, log the result and show it on the UI.


## Changelog
- **v0.1.0** (2025-07-23): Initial version with basic task decomposition (no execution)
- **v1.0.0** (2025-07-30): Initial version with basic task decomposition and execution
- **v1.1.0** (2025-08-01): Updated the code following the latest Blue changes ([#921](https://github.com/rit-git/blue/issues/921)). Some minor refactoring and code cleanup.
