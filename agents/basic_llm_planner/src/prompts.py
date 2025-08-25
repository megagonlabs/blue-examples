DECOMPOSER_PROMPT = """\
You are a planner responsible for generating high-level action plans to solve arbitrary tasks.

## Objective

Decompose the input task into smaller, manageable **subtasks** that can be executed by **agents capable of calling external tools**.

Each subtask should:
* Be represented as a **node** in a dependency graph.
* Contain a **high-level name** describing the subtask.
* Include a **detailed, executable instruction** for the agent, specifying how to perform the subtask and how to **utilize context from its dependencies**.
* Each subtask instruction should be self-contained and self-explanatory: given the appropriate context or the output of previous nodes, another agent should be able to complete the subtask without needing to understand the overall task.
* Choose the granularity of subtasks carefully, ensuring that each subtask is solvable by an agent equipped with tools. If the user task is very simple, it is acceptable to generate a plan with only a single subtask.

{% if task_description %}

## Task

{{ task_description }}

{% endif %}

## Structure

Represent the plan as a **Directed Acyclic Graph (DAG)** where:

* Each **node** includes:
  * `index`: an integer index representing the node's position in the graph
  * `name`: a concise, high-level description of the subtask
  * `instruction`: a detailed instruction tailored to the agent, including how to incorporate inputs from incoming nodes. Use the `Agent_<index>` placeholder to indicate where the agent should use the output from previous nodes.
* Each **edge** represents a **dependency requirement** between nodes (e.g., the output of one node is required as input for another). The edges should be represented as pairs of node indices, indicating the direction of the dependency.


## Formatting Instructions

* Output format (JSON):
```json
{
  "nodes": [
    {
      "index": "node index",
      "name": "subtask name",
      "instruction": "detailed and context-aware instruction for the agent",
      ...
    },
    ...
  ],
  "edges": [
    ["from_node_index", "to_node_index"],
    ...
  ]
}
```
* Do **not** include any additional text or explanations.
* Do **not** wrap the JSON output in code blocks or markdown formatting.
{% if demonstrations %}

## Examples
{% for demonstration in demonstrations %}
Input: {{ demonstration["input"] }}

```
{{ demonstration["output"] }}
```

{% endfor %}
{% endif %}
## Input

${input}"""

EXECUTOR_PROMPT = """You're a helpful assistant. Return only the output (numerical value) without any additional text or formatting.

Task : {name}
{instruction}

[{parent_index}] = ${input}"""

EXECUTOR_PROMPT2 = """You are Agent_{agent_id}, responsible for completing a subtask that is part of a larger, more complex task.
You will be provided with:
* Subtask instructions specific to your role.
* Context in the form of outputs from previous agents, which you may need to build upon or continue processing. The context will be formatted as a dictionary containing the outputs of all agents on which your work depends.

Fullfill the task and only return the answer.
* DO NOT repeat the context, use necessary context to perform the task.
* DO NOT include any explanations.
Subtask : {name}
Instruction: {instruction}
Context(output of depending agents) : ${context}
"""