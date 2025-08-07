# Basic LLM Planner

This is a basic implementation of a LLM (Large Language Model) planner. The goal of this planner is to take a high-level task description and break it down into smaller, manageable sub-tasks that can be executed by an LLM.

- **Input:** A task expressed in natural language, which may be the output of the intent understanding module in a dialogue interface. The input is assumed to be fully specified and unambiguous.
- **Output:** A directed acyclic graph (DAG) of execution agents.


## v2.0: Plan Generation and Execution

- Given a user input, decompose the task into sub-tasks by calling the OpenAI API.
- Show the plan and execute it by assigning the sub-tasks to the `OPENAI___ROGUEAGENT` agent with tools.

**Setup**

- Build and run the basic calculator tool.
    - Update the configuration on the UI to have `add` and `sub` under the basic calculator tool.
- Build this agent and set the properties in the UI:
    ```json
    {
      "openai.api": "ChatCompletion",
      "input_context_field": "content",
      "input_json": "[{\"role\": \"user\"}]",
      "service_url": "ws://blue_service_openai:8001",
      "input_field": "messages",
      "output_path": "$.choices[0].message.content",
      "input_context": "$[0]",
      "openai.frequency_penalty": 0,
      "output_transformations": [
         {
               "transformation": "replace",
               "from": "```json",
               "to": ""
         },
         {
               "transformation": "replace",
               "from": "```",
               "to": ""
         }
      ],
      "openai.top_p": 1,
      "openai.presence_penalty": 0,
      "output_strip": true
   }
    ```
- Start the agent by "Deploy".
- In the session, include the following agents:
    - `BASIC_LLM_PLANNER` (this agent)
    - `COORDINATOR` (for executing the plan)
    - Note: With the latest blue library/platform, `OPENAI___ROGUEAGENT` is automatically added to the session by the coordinator.


**Workflow in `default_processor()`**

1. **Collect User Input:**
   - On BOS (beginning of stream), initialize the stream data as an empty list in the worker.
   - On DATA, append incoming data to the stream.
   - On EOS (end of stream), collect all user input from the stream using `stream_data = worker.get_data('stream')`. Concatenate the stream data into a single string representing the user's task description.
2. **Decompose Task:**
   - Use the OpenAI API to decompose the high-level user task into a list of sub-tasks.
   - See `decompose_task()` method for details.
       - `OpenAIAgent.execute_api_call()` (= [`ServiceClient.execute_api_call()`](https://github.com/rit-git/blue/blob/dev/lib/src/blue/utils/service_utils.py)) is called to send the user input to the OpenAI API and receive a response.
3. **Show Plan and Execute:**
   - On receiving the response from the API, log the result and show it on the UI.
   - For each sub-task, create a new `OPENAI___ROGUEAGENT` agent with the sub-task as input.
   - Connect the last sub-task executor to this planner agent as `RESULT_EXECUTION`.
   - Submit the sub-task for execution.
   - The result will be returned to this agent as `RESULT_EXECUTION`.
   - See `run_task()` method for details.
4. **Show Execution Result:**
   - On receiving `RESULT_EXECUTION`, log the result and show it on the UI.


## Changelog
- **v2.0.0** (2025-08-07): Inherit OpenAIAgent and call the API internally to decompose the task into sub-tasks.
- **v0.1.0** (2025-07-23): Initial version with basic task decomposition (no execution)
- **v1.0.0** (2025-07-30): Initial version with basic task decomposition and execution
- **v1.1.0** (2025-08-01): Updated the code following the latest Blue changes ([#921](https://github.com/rit-git/blue/issues/921)). Some minor refactoring and code cleanup.
