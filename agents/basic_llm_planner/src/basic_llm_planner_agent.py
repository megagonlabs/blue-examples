###### Parsers, Formats, Utils

import argparse
import logging
import json

from blue.agent import Agent, AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.plan import Plan
from blue.session import Session
from blue.stream import Message

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

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


## Structure

Represent the plan as a **Directed Acyclic Graph (DAG)** where:

* Each **node** includes:
  * `index`: an integer index representing the node's position in the graph
  * `name`: a concise, high-level description of the subtask
  * `instruction`: a detailed instruction tailored to the agent, including how to incorporate inputs from incoming nodes. Use the `{{index}}` placeholder to indicate where the agent should use the output from previous nodes.
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


## Example

Input: Chris earned $1000 in his job, and he spent $200 on a new phone. He also bought a new laptop for $800. Pat returned $100 to Chris for a previous loan. How much money does Chris have left?

```json
{
    "nodes": [
        {
            "index": 0,
            "name": "Identify income",
            "instruction": "Identify the total income from Chris's job."
        },
        {
            "index": 1,
            "name": "Subtract phone cost",
            "instruction": "Subtract $200 from [0]."
        },
        {
            "index": 2,
            "name": "Subtract laptop cost",
            "instruction": "Subtract $800 from [1]."
        },
        {
            "index": 3,
            "name": "Add loan repayment",
            "instruction": "Add $100 to [2]."
        }
    ],
    "edges": [
        ["0", "1"],
        ["1", "2"],
        ["2", "3"]
    ]
}
```

## Input

${input}"""

EXECUTOR_PROMPT = """You're a helpful assistant. Return only the output (numerical value) without any additional text or formatting.

Task: {name}
{instruction}

[{parent_index}] = ${input}"""

sample_user_input = "Chris earned $1000 in his job, and he spent $200 on a new phone. He also bought a new laptop for $800. Pat returned $100 to Chris for a previous loan. How much money does Chris have left?"
sample_plan_text = """{
    "nodes": [
        {
            "index": 0,
            "name": "Identify income",
            "instruction": "Identify the total income from Chris's job."
        },
        {
            "index": 1,
            "name": "Subtract phone cost",
            "instruction": "Subtract $200 from [0]."
        },
        {
            "index": 2,
            "name": "Subtract laptop cost",
            "instruction": "Subtract $800 from [1]."
        },
        {
            "index": 3,
            "name": "Add loan repayment",
            "instruction": "Add $100 to [2]."
        }
    ],
    "edges": [
        ["0", "1"],
        ["1", "2"],
        ["2", "3"]
    ]
}"""

basic_llm_planner_properties = {
    "executor_input_template": EXECUTOR_PROMPT,
    "input_context_field": "content",
    "input_context": "$[0]",
    "input_field": "messages",
    "input_json": "[{\"role\":\"user\"}]",
    "input_template": DECOMPOSER_PROMPT,
    "openai.api": "ChatCompletion",
    "openai.frequency_penalty": 0,
    "openai.max_tokens": 1024,
    "openai.model": "gpt-4.1-mini-2025-04-14",
    "openai.presence_penalty": 0,
    "openai.temperature": 0,
    "openai.top_p": 1,
}


############################
### Agent.BasicLLMPlannerAgent
#
class BasicLLMPlannerAgent(OpenAIAgent):
    def __init__(self, **kwargs):
        if "name" not in kwargs:
            kwargs["name"] = "BASIC_LLM_PLANNER"
        super().__init__(**kwargs)

    def _initialize_properties(self):
        super()._initialize_properties()

        # init properties (override default properties)
        for key in basic_llm_planner_properties:
            self.properties[key] = basic_llm_planner_properties[key]

    ####### inputs / outputs
    def _initialize_inputs(self):
        self.add_input("DEFAULT", description="trigger", includes=["USER"])

    def _initialize_outputs(self):
        return

    def decompose_task(self, worker=None):
        """Call an OpenAI service to decompose a task into subtasks"""
        user_input = ""

        if worker:
            user_input = " ".join(worker.get_data("stream"))

        worker.set_data("user_input", user_input)
        logging.info(f"worker.get_data('user_input'): {worker.get_data('user_input')}")

        # Call the OpenAI API to decompose the task
        plan_text = self.execute_api_call(user_input, properties={}, additional_data={})
        logging.info("Decomposed task plan: {plan_text}".format(plan_text=plan_text))
        return plan_text

    def run_task(self, worker, plan):
        # (1) nodes are indexed from 0, with smaller indices being executed first.
        # (2) the workflow is strictly linear.
        # (3) the edges are sorted in the order of execution.
        action_plan = Plan(scope=worker.prefix)

        # Define executors
        for node in plan["nodes"]:
            index = node["index"]
            prompt = EXECUTOR_PROMPT.format(
                name=node["name"],
                instruction=node["instruction"],
                parent_index="context" if index == 0 else index - 1,
                input="{input}",
            )

            # For now, we assume that there are only a few tools available (tool_discovery=False)
            # and we can use the same OpenAI agent for all subtasks.
            action_plan.define_agent(
                "OPENAI___ROGUEAGENT",
                label=f"SUBTASK_EXECUTOR_{index}",
                properties={
                    "openai.model": self.properties["openai.model"],
                    "openai.max_tokens": self.properties["openai.max_tokens"],
                    "input_template": prompt,
                    "use_tools": True,
                    "tool_discovery": False,
                },
            )
            logging.info(
                f"Defined subtask executor: SUBTASK_EXECUTOR_{index} with prompt: {prompt}"
            )

        # Define message flow
        action_plan.define_input("DEFAULT", value=worker.get_data("user_input"))
        for index in range(len(plan["nodes"])):
            if index == 0:
                # Connect the user input to the first subtask executor
                action_plan.connect_input_to_agent(
                    from_input="DEFAULT",
                    to_agent="SUBTASK_EXECUTOR_0",
                    to_agent_input="DEFAULT",
                )
                logging.info(
                    "Connected input to first subtask executor: SUBTASK_EXECUTOR_0 [DEFAULT]"
                )
                continue
            # Connect the agent to the next agent
            action_plan.connect_agent_to_agent(
                from_agent=f"SUBTASK_EXECUTOR_{index - 1}",
                to_agent=f"SUBTASK_EXECUTOR_{index}",
                to_agent_input="DEFAULT",
            )
            logging.info(
                f"Connected subtask executor: SUBTASK_EXECUTOR_{index - 1} to SUBTASK_EXECUTOR_{index} [DEFAULT]"
            )

        # Connect the last agent to this planner agent to show the result on the UI
        action_plan.connect_agent_to_agent(
            from_agent=f"SUBTASK_EXECUTOR_{len(plan['nodes']) - 1}",
            to_agent=self.name,
            to_agent_input="RESULT_EXECUTION",
        )
        logging.info(
            f"Connected last subtask executor: SUBTASK_EXECUTOR_{len(plan['nodes']) - 1} to this planner agent: {self.name} [RESULT_EXECUTION]"
        )

        # Submit the subtask
        action_plan.submit(worker)
        logging.info("Sent off subtask execution request")

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if input == "DEFAULT":
            if message.isEOS():
                # Decompose task
                # The result will return to this agent as RESULT_PLAN
                output = self.decompose_task(worker)
                logging.info(f"Task decomposition result: {output}")

                return_message = (
                    f"Generated plan:\n{output}"  # this will be shown on the UI
                )

                # For demo purpose, use the sample plan for testing
                logging.info(f"Sample user input: {sample_user_input}")
                worker.set_data("user_input", sample_user_input)
                logging.info(f"Sample plan: {sample_plan_text}")
                output = sample_plan_text

                # Parse the output as JSON
                try:
                    plan_dag = json.loads(output)
                    if "nodes" not in plan_dag:
                        return [
                            f"Error: the plan text does not contain a 'nodes' field: {output}",
                            Message.EOS,
                        ]
                    if "edges" not in plan_dag:
                        return [
                            f"Error: the plan text does not contain a 'edges' field: {output}",
                            Message.EOS,
                        ]
                except json.JSONDecodeError as e:
                    logging.error(f"Failed to parse plan JSON: {e}")
                    return [
                        f"Error parsing plan: {output}\nError message: {e}",
                        Message.EOS,
                    ]
                self.run_task(worker, plan_dag)

                return_message += (
                    "\n\nFor demo purpose, using a pre-defined sample below.\n"
                )
                return_message += f"User input: {sample_user_input}\nPlan:\n{output}"
                return [
                    return_message,
                    Message.EOS,
                ]
            elif message.isBOS():
                # Initialize stream to empty array
                if worker:
                    worker.set_data("stream", [])
            elif message.isData():
                # Store data value
                data = message.getData()

                if worker:
                    worker.append_data("stream", str(data))
        elif input == "RESULT_EXECUTION":
            if message.isEOS():
                output = ""
                if worker:
                    output = " ".join(worker.get_data("stream"))
                logging.info(f"Subtask execution result: {output}")

                # Return the result to the user
                return [f"Answer: {output}", Message.EOS]
            elif message.isBOS():
                # Initialize stream to empty array
                if worker:
                    worker.set_data("stream", [])
            elif message.isData():
                # Store result from OpenAI agent
                data = message.getData()

                if worker:
                    worker.append_data("stream", str(data))
        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="BASIC_LLM_PLANNER", type=str)
    parser.add_argument("--session", type=str)
    parser.add_argument("--properties", type=str)
    parser.add_argument("--loglevel", default="INFO", type=str)
    parser.add_argument("--serve", type=str)
    parser.add_argument("--platform", type=str, default="default")
    parser.add_argument("--registry", type=str, default="default")

    args = parser.parse_args()

    # set logging
    logging.getLogger().setLevel(args.loglevel.upper())

    # set properties
    properties = {}
    p = args.properties
    if p:
        # decode json
        properties = json.loads(p)

    if args.serve:
        platform = args.platform

        af = AgentFactory(
            _class=BasicLLMPlannerAgent,
            _name=args.serve,
            _registry=args.registry,
            platform=platform,
            properties=properties,
        )
        af.wait()
    else:
        a = None
        session = None

        if args.session:
            # join an existing session
            session = Session(cid=args.session)
            a = BasicLLMPlannerAgent(
                name=args.name, session=session, properties=properties
            )
        else:
            # create a new session
            session = Session()
            a = BasicLLMPlannerAgent(
                name=args.name, session=session, properties=properties
            )

        # wait for session
        if session:
            session.wait()
