###### Parsers, Formats, Utils

import argparse
import logging
import json

from blue.stream import Message

###### Blue
from blue.agent import Agent, AgentFactory
from blue.session import Session
from blue.plan import Plan

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s", level=logging.ERROR, datefmt="%Y-%m-%d %H:%M:%S")

PROMPT = """\
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
  * `id`: a unique identifier
  * `name`: a concise, high-level description of the subtask
  * `instruction`: a detailed instruction tailored to the agent, including how to incorporate inputs from incoming nodes.
* Each **edge** represents a **dependency or collaboration requirement** between nodes (e.g., information exchange, sequencing, coordination between agents).


## Formatting Instructions

* Output format (JSON):
```json
{
  "nodes": [
    {
      "id": "node_id",
      "name": "subtask name",
      "instruction": "detailed and context-aware instruction for the agent",
      ...
    },
    ...
  ],
  "edges": [
    ["from_node_id", "to_node_id"],
    ...
  ]
}
```
* Do **not** include any additional text or explanations.
* Do **not** wrap the JSON output in code blocks or markdown formatting.


## Input

${input}"""

############################
### Agent.BasicLLMPlannerAgent
#
class BasicLLMPlannerAgent(Agent):
    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "BASIC_LLM_PLANNER"
        super().__init__(**kwargs)


    def decompose_task(self, worker=None):
        """Call an OpenAI agent to decompose a task into subtasks"""
        user_input = ""

        if worker:
            user_input = " ".join(worker.get_data('stream'))

        # What if worker is None?
        p = Plan(scope=worker.prefix)
        # set input
        p.define_input("DEFAULT", value=user_input)
        # define an task decomposer agent
        properties = {
            "input_template": PROMPT
        }
        p.define_agent("OPENAI___ROGUEAGENT", label="OPENAI___ROGUEAGENT___TASK_DECOMPOSER", properties=properties)
        # set plan
        p.connect_input_to_agent(from_input="DEFAULT", to_agent="OPENAI___ROGUEAGENT___TASK_DECOMPOSER")
        p.connect_agent_to_agent(from_agent="OPENAI___ROGUEAGENT___TASK_DECOMPOSER", to_agent=self.name, to_agent_input="RESULT")

        # submit plan
        p.submit(worker)

        logging.info("Sent off task decomposition request")
        return

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if input == "DEFAULT":
            if message.isEOS():
                # Decompose task
                self.decompose_task(worker)
            elif message.isBOS():
                # Initialize stream to empty array
                if worker:
                    worker.set_data('stream', [])
            elif message.isData():
                # Store data value
                data = message.getData()
                logging.info(data)

                if worker:
                    worker.append_data('stream', str(data))
        elif input == "RESULT":
            if message.isEOS():
                output = ""
                if worker:
                    output = " ".join(worker.get_data('stream'))
                logging.info(f"Task decomposition result: {output}")
                return [output, Message.EOS]
            elif message.isBOS():
                # Initialize stream to empty array
                if worker:
                    worker.set_data('stream', [])
            elif message.isData():
                # Store result from OpenAI agent
                data = message.getData()
                logging.info(f"Received task decomposition: {data}")

                if worker:
                    worker.append_data('stream', str(data))
        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--name', default="BASIC_LLM_PLANNER", type=str)
    parser.add_argument('--session', type=str)
    parser.add_argument('--properties', type=str)
    parser.add_argument('--loglevel', default="INFO", type=str)
    parser.add_argument('--serve', type=str)
    parser.add_argument('--platform', type=str, default='default')
    parser.add_argument('--registry', type=str, default='default')

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

        af = AgentFactory(_class=BasicLLMPlannerAgent, _name=args.serve, _registry=args.registry, platform=platform, properties=properties)
        af.wait()
    else:
        a = None
        session = None

        if args.session:
            # join an existing session
            session = Session(cid=args.session)
            a = BasicLLMPlannerAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = BasicLLMPlannerAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()
