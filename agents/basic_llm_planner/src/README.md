# Basic LLM Planner

This is a basic implementation of a LLM (Large Language Model) planner. The goal of this planner is to take a high-level task description and break it down into smaller, manageable sub-tasks that can be executed by an LLM. 

- **Input:** A task expressed in natural language, which may be the output of the intent understanding module in a dialogue interface. The input is assumed to be fully specified and unambiguous.
- **Output:** The decomposed task plan, represented in two forms:
   - A directed acyclic graph (DAG) in json format, returned to the user-facing UI
   - A Blue Plan object. If a coordinator exists in a session, the plan will be picked up and executed.

## Usage

### Plan and execute
1. Create and deploy this agent with a proper name (e.g., BASIC_LLM_PLANNER) and the following configuration
 ```python
    {
      "input_context_field": "content",
      "input_json": "[{\"role\": \"user\"}]",
      "service_url": "ws://blue_service_openai:8001",
      "input_field": "messages",
      "output_path": "$.choices[0].message.content",
      "input_context": "$[0]",
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
      "output_strip": true,
      # Configure the task decomposition 
      "openai.api": "ChatCompletion",
      "openai.top_p": 1,
      "openai.presence_penalty": 0,
      "openai.frequency_penalty": 0,
      "decomposer.task_description": "You're tasked with solving grade school-level math word problems that require multi-step reasoning. Given a natural language problem, you must interpret the text, identify the relevant quantities and operations, and break down the problem into smaller, manageable subtasks. Each subtask involves a basic arithmetic calculation to arrive at the correct final answer. Since the problems are designed to be solvable by a bright middle school student, you are supposed to apply only fundamental arithmetic operations such as addition, subtraction, multiplication, and division.",
      "decomposer.demonstrations": [
         {
            "input": "Chris earned $1000 in his job, and he spent $200 on a new phone. He also bought a new laptop for $800. ...",
            "output": "<expected DAG>"
         },
         {
            "input": "Jannet has 20 eggs, half of them are brown and 1/4 of them are ...",
            "output": "<expected DAG>"
         }
      ],
      # Configure executor properites in the generated plan
      "executor.openai.model": "gpt-4.1-mini-2025-04-14",
      "executor.openai.max_tokens":1024,
      "executor.use_tools":false,
      "executor.tool_discovery":false,

   }
```
- `decomposer.task_description` and `decomposer.demonstrations` are **optional.**
   - `decomposer.task_description`: A description of the task to be decomposed. This will replace `{{ task_description }}` in the default prompt (`prompts.py`).
   - `decomposer.demonstrations`: Examples of input-output pairs to guide the decomposition. This will replace the example section in the default prompt. By default, this is set to `DECOMPOSER_DEMONSTRATIONS` in `demonstrations.py`.
- `executor.openai.model` defaults to `openai.model` if note provided.


2. Deploy [BLOCKING_OPENAI](https://github.com/rit-git/blue/tree/dev/agents/blocking_openai_agent) (with this exact name) 
```json
{
    "include_extra_input": true,
    "wait_for_inputs": ["DEFAULT"],
    "service_url": "ws://blue_service_openai:8001"
}
```
3. Deploy the `COORDINATOR` agent. 

4. Start a new session with the `BASIC_LLM_PLANNER` and the `COORDINATOR`. 

5. Provide a task like "Jannet has 20 eggs. Half of them are brown and one-fourth of them are white. How many more brown eggs does Jannet have than white eggs?" You should see the decomposed task plan, each executor fulfilling a subtask and return a final result "5".

### Tool-calling execution
To enable tool-calling capbility of the `BLOCKING_OPENAI` executors, in the `BASIC_LLM_PLANNER` properties, set `executor.use_tools":true` and set `executor.tool_discovery` accordingly.

To test with the Math example, build and run the `basic calculator tool`. Update the configuration on the UI to have `add` and `sub` and any necessary functions under the basic calculator tool.

### Returning results back to another agent.
By default, the coordinator will send the output of the final (sink) node back to the emitting planner (BASIC_LLM_PLANNER:RESULT_EXECUTION). The planner will process such input by directly sending it back to the UI.
When you need to direct final plan execution results to another agent, set the following properites. For example, if the dialogue manager is calling the planner to plan and execute a task, it can specify:
```json
"executor.plan_return_to_agent": "DIALOGUE_MANAGER"
"executor.plan_return_to_agent_input":"FROM_PLANNER"
```

## More Under the Hood

### Overall workflow
- Given a user input, decompose the task into sub-tasks by calling the OpenAI API.
- Show the plan and execute it by assigning the sub-tasks to the `BLOCKING_OPENAI` agent with tools.
- Now the planner allows one step to depend on multiple previous steps, using [the `wait_for` logic of BlockingAgent](https://github.com/rit-git/blue/blob/dev/lib/src/blue/agents/blocking_agent.py#L25).



### Workflow in `default_processor()`

The agent processes two logical inputs: the default trigger (`DEFAULT`) used to decompose and launch a plan, and `RESULT_EXECUTION` used to receive the final execution result. Processing follows the stream lifecycle (BOS / DATA / EOS) and uses per-stream state via the worker (set_data / append_data / get_data).

1. DEFAULT input (task decomposition & plan submission)
   - BOS: initialize the stream buffer with `worker.set_data("stream", [])`.
   - DATA: append incoming pieces with `worker.append_data("stream", str(data))`.
   - EOS:
     - Aggregate the stream into a single user task string: `" ".join(worker.get_data("stream"))`.
     - Call `decompose_task(user_input)` which invokes the OpenAI API (via `execute_api_call`) using properties:
       - `decomposer.task_description` and `decomposer.demonstrations` (if provided).
     - The API returns a plan text (string). The agent attempts to parse it as JSON to obtain the plan DAG.
     - Convert the parsed LLM plan into a Blue `Plan` with `compile_action_plan(worker, plan_dag, task)`:
       - Builds an `LLMPlan` and creates a `Plan(scope=worker.prefix)`.
       - Defines a global input `USERTASK` with the original task.
       - For each node in the LLM plan:
         - Format an executor prompt using `EXECUTOR_PROMPT2`.
         - Define a `BLOCKING_OPENAI` agent (label `SUBTASK_EXECUTOR_{idx}`) with properties taken from planner properties (executor model, max tokens, use_tools, tool_discovery, and `input_template` set to the formatted prompt).
         - Set `wait_for_inputs` to the incoming dependencies (or `USERTASK` for source nodes).
         - Connect inputs: global input to source nodes, and agent-to-agent connections for dependent nodes (to_agent_input uses `FROM_{src}`).
       - Connect the sink node back to the planner by linking the sink agent's output to this planner agent's input `RESULT_EXECUTION`, or as configured in the properties `executor.plan_return_to_agent` and `
     - Submit the compiled `Plan` with `action_plan.submit(worker)`.
     - Returns a UI-visible message like `Generated plan:\n{plan_text}` followed by `Message.EOS`.
     - Errors while parsing or submitting the plan are logged and returned as messages (e.g., invalid plan or submission error).

2. RESULT_EXECUTION input (receive execution result)
   - BOS: initialize the result stream buffer with `worker.set_data("stream", [])`.
   - DATA: append partial results with `worker.append_data("stream", str(data))`.
   - EOS:
     - Aggregate the execution outputs: `" ".join(worker.get_data("stream"))`.
     - Return the final answer to the user as `Answer: {output}` followed by `Message.EOS`.

Notes
- `compile_action_plan()` relies on `LLMPlan` to interpret nodes and dependencies, and uses `BLOCKING_OPENAI` for executing subtasks with `wait_for_inputs` so steps can depend on multiple predecessors.
- The planner sets executor agent properties from its own properties (e.g., `executor.openai.model`, `executor.openai.max_tokens`, `executor.use_tools`, `executor.tool_discovery`) to control execution behaviour.


### Changelog
- **v3.0.0** (2025-08-25): Support multi-input & Make the decomposer prompt customizable
- **v2.0.0** (2025-08-07): Inherit OpenAIAgent and call the API internally to decompose the task into sub-tasks.
- **v0.1.0** (2025-07-23): Initial version with basic task decomposition (no execution)
- **v1.0.0** (2025-07-30): Initial version with basic task decomposition and execution
- **v1.1.0** (2025-08-01): Updated the code following the latest Blue changes ([#921](https://github.com/rit-git/blue/issues/921)). Some minor refactoring and code cleanup.
