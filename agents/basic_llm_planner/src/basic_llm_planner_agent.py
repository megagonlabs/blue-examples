###### Parsers, Formats, Utils
import argparse
import logging
import json


from blue.agent import Agent, AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.plan import Plan
from blue.session import Session
from blue.stream import Message
from llm_plan_utils import LLMPlan
from prompts import *
from demonstrations import *

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

USER_TASK_INPUT = 'USERTASK'
SUBTASK_LAEBL = "SUBTASK_EXECUTOR_{idx}"

basic_llm_planner_properties = {
    #"executor_input_template": EXECUTOR_PROMPT,
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

    def decompose_task(self, user_input):
        """Call an OpenAI service to decompose a task into subtasks"""


        # Call the OpenAI API to decompose the task
        #plan_text = self.execute_api_call(user_input, properties={}, additional_data={})
        plan_text = sample_plan_text2

        logging.info("Decomposed task plan: {plan_text}".format(plan_text=plan_text))
        return plan_text
    


    def compile_action_plan(self, worker, plan, task):
        """
        Converts LLM plan to a valid blue plan and submit
        """
        llm_plan = LLMPlan(plan)
        action_plan = Plan(scope=worker.prefix)

        # define input 
        action_plan.define_input(USER_TASK_INPUT, value = task)

        for idx, node in llm_plan.nodes.items():

            prompt = EXECUTOR_PROMPT2.format(
                agent_id = node['index'],
                name=node["name"],
                instruction=node["instruction"],
                context="{input}"
            )
            
            in_coming = llm_plan.get_incoming(idx)
            if len(in_coming) == 0:
                in_coming = [USER_TASK_INPUT] # provide global user task to all source nodes

            # define agents 
            node_label = SUBTASK_LAEBL.format(idx=idx)
            action_plan.define_agent(
                "BLOCKING_OPENAI_AGENT",
                label=node_label,
                properties={
                    "openai.model": self.properties["openai.model"],
                    "openai.max_tokens": self.properties["openai.max_tokens"],
                    "input_template": prompt,
                    "use_tools": True,
                    "tool_discovery": False,
                    'wait_for_inputs': in_coming
                },
            )
            logging.info(
                        f"Defined subtask executor: {node_label} with prompt: {prompt}, wait on {in_coming}"
                    )
            
            # connect agents
            for src in in_coming:
                if src == USER_TASK_INPUT:
                    action_plan.connect_input_to_agent(from_input=USER_TASK_INPUT,
                                                    to_agent=node_label,
                                                    to_agent_input=USER_TASK_INPUT)
                    logging.info(
                            f"Connected INPUT {USER_TASK_INPUT} to AGENT {node_label}"
                        )
                else:
                    src_label = SUBTASK_LAEBL.format(idx=src)
                    action_plan.connect_agent_to_agent(from_agent=src_label,
                                                    to_agent=node_label,
                                                    to_agent_input=f"FROM_{src}")
                    logging.info(
                            f"Connected AGENT {src_label} to AGENT {node_label}"
                        )

        # connect sinking node back to planner
        sink = llm_plan.get_sink()
        sink_label = SUBTASK_LAEBL.format(idx=sink)

        action_plan.connect_agent_to_agent(
            from_agent=sink_label,
            to_agent=self.name,
            to_agent_input="RESULT_EXECUTION",
        )
        logging.info(
            f"Connected sink node {sink_label} to this planner agent: {self.name} [RESULT_EXECUTION]"
        )

        return action_plan




    # TODO: remove deprecated code for linear plan processing
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

                user_input = ""
                if worker:
                    user_input = " ".join(worker.get_data("stream"))
                logging.info(f"User input task:{user_input}")

                output = self.decompose_task(user_input)
                logging.info(f"Task decomposition result: {output}")

                return_message = (
                    f"Generated plan:\n{output}"  # this will be shown on the UI
                )

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
                 # Submit the subtask
                action_plan = self.compile_action_plan(worker=worker, plan=plan_dag, task=user_input)
                action_plan.submit(worker)
                logging.info("Sent off subtask execution request")

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
