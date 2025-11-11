# Basic LLM Planner

This is a basic implementation of an LLM (Large Language Model) planner. The goal of this planner is to take a high-level task description and break it down into smaller, manageable sub-tasks that can be executed by an LLM.

- **Input:** A task expressed in natural language, which may be the output of the intent understanding module in a dialogue interface. The input is assumed to be fully specified and unambiguous.
- **Output:** The decomposed task plan, represented in two forms:
   - A directed acyclic graph (DAG) in JSON format, returned to the user-facing UI.
   - A Blue Plan object. If a coordinator exists in a session, the plan will be picked up and executed.

## Usage

### Quickstart

Follow the instructions in [`demos/basic_llm_planner/README.md`](../../../demos/basic_llm_planner/README.md) to try out the planner:

1. Load [`agent.json`](../agent.json) into your Blue platform.
2. Deploy the `BLOCKING_OPENAI` and `COORDINATOR` agents in addition to the `BASIC_LLM_PLANNER`.
3. Start a new session with `BASIC_LLM_PLANNER` and `COORDINATOR`.
4. Provide a task such as:
   "Jannet has 20 eggs. Half of them are brown and one-fourth of them are white. How many more brown eggs does Jannet have than white eggs?"
   You should see the decomposed task plan, with each executor fulfilling a subtask and returning a final result: "5".

### Tool-calling execution

To enable tool-calling capability for the `BLOCKING_OPENAI` executors, set `executor.use_tools: true` in the `BASIC_LLM_PLANNER` properties, and configure `executor.tool_discovery` accordingly.

To test with the Math example, build and run the `basic calculator tool`. Update the configuration on the UI to include `add`, `sub`, and any necessary functions under the basic calculator tool.

### Returning results to another agent

By default, the coordinator will send the output of the final (sink) node back to the emitting planner (`BASIC_LLM_PLANNER:RESULT_EXECUTION`). The planner will process such input by directly sending it back to the UI.

If you need to direct final plan execution results to another agent, set the following properties. For example, if the dialogue manager is calling the planner to plan and execute a task, specify:
```json
"executor.plan_return_to_agent": "DIALOGUE_MANAGER",
"executor.plan_return_to_agent_input": "FROM_PLANNER"
```

## More Under the Hood

### Overall workflow

- Given a user input, decompose the task into sub-tasks by calling the OpenAI API.
- Display the plan and execute it by assigning the sub-tasks to the `BLOCKING_OPENAI` agent with tools.
- The planner now allows one step to depend on multiple previous steps, using [the `wait_for` logic of BlockingAgent](https://github.com/megagonlabs/blue/blob/v1.0/lib/src/blue/agents/blocking_agent.py).

### Workflow in `default_processor()`

The agent processes two logical inputs: the default trigger (`DEFAULT`) used to decompose and launch a plan, and `RESULT_EXECUTION` used to receive the final execution result. Processing follows the stream lifecycle (BOS / DATA / EOS) and uses per-stream state via the worker (`set_data` / `append_data` / `get_data`).

1. **DEFAULT input (task decomposition & plan submission)**
   - **BOS:** Initialize the stream buffer with `worker.set_data("stream", [])`.
   - **DATA:** Append incoming pieces with `worker.append_data("stream", str(data))`.
   - **EOS:**
     - Aggregate the stream into a single user task string: `" ".join(worker.get_data("stream"))`.
     - Call `decompose_task(user_input)`, which invokes the OpenAI API (via `execute_api_call`) using properties:
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
       - Connect the sink node back to the planner by linking the sink agent's output to this planner agent's input `RESULT_EXECUTION`, or as configured in the properties `executor.plan_return_to_agent` and `executor.plan_return_to_agent_input`.
     - Submit the compiled `Plan` with `action_plan.submit(worker)`.
     - Returns a UI-visible message like `Generated plan:\n{plan_text}` followed by `Message.EOS`.
     - Errors while parsing or submitting the plan are logged and returned as messages (e.g., invalid plan or submission error).

2. **RESULT_EXECUTION input (receive execution result)**
   - **BOS:** Initialize the result stream buffer with `worker.set_data("stream", [])`.
   - **DATA:** Append partial results with `worker.append_data("stream", str(data))`.
   - **EOS:**
     - Aggregate the execution outputs: `" ".join(worker.get_data("stream"))`.
     - Return the final answer to the user as `Answer: {output}` followed by `Message.EOS`.

**Notes**
- `compile_action_plan()` relies on `LLMPlan` to interpret nodes and dependencies, and uses `BLOCKING_OPENAI` for executing subtasks with `wait_for_inputs` so steps can depend on multiple predecessors.
- The planner sets executor agent properties from its own properties (e.g., `executor.openai.model`, `executor.openai.max_tokens`, `executor.use_tools`, `executor.tool_discovery`) to control execution behaviour.

### Changelog

- **v3.0.0** (2025-08-25): Support multi-input & make the decomposer prompt customizable.
- **v2.0.0** (2025-08-07): Inherit OpenAIAgent and call the API internally to decompose the task into sub-tasks.
- **v1.1.0** (2025-08-01): Updated the code following the latest Blue changes. Minor refactoring and code cleanup.
- **v1.0.0** (2025-07-30): Initial version with basic task decomposition and execution.
- **v0.1.0** (2025-07-23): Initial version with basic task decomposition (no execution).
