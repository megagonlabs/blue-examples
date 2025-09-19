###### Parsers, Formats, Utils
import argparse
import logging
import json

from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.agents.plan import AgenticPlan
from blue.session import Session
from blue.stream import Message
from pydantic import ValidationError

from demonstrations import DECOMPOSER_DEMONSTRATIONS
from llm_plan_utils import LLMPlan
from prompts import DECOMPOSER_PROMPT, EXECUTOR_PROMPT2

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

USER_TASK_INPUT = 'USERTASK'
SUBTASK_LABEL = "SUBTASK_EXECUTOR_{idx}"
RESULT_EXECUTION = "RESULT_EXECUTION"

basic_llm_planner_properties = {
    "input_context_field": "content",
    "input_context": "$[0]",
    "input_field": "messages",
    "input_json": '[{"role":"user"}]',
    "input_template": DECOMPOSER_PROMPT,
    "openai.api": "ChatCompletion",
    "openai.frequency_penalty": 0,
    "openai.max_tokens": 1024,
    "openai.model": "gpt-4.1-mini-2025-04-14",
    "openai.presence_penalty": 0,
    "openai.temperature": 0,
    "openai.top_p": 1,
    "decomposer.task_description": None,
    "decomposer.demonstrations": DECOMPOSER_DEMONSTRATIONS,
    "executor.openai.model": "gpt-4.1-mini-2025-04-14",
    "executor.openai.max_tokens":1024,
    "executor.use_tools":False,
    "executor.tool_discovery":False,
}

# to control where plan execution returns to
# "executor.plan_return_to_agent" default: self.name)
# "executor.plan_return_to_agent_input", default RESULT_EXECUTION)

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
        return

    def _initialize_outputs(self):
        return

    def decompose_task(self, user_input):
        """Call an OpenAI service to decompose a task into subtasks"""

        # Call the OpenAI API to decompose the task
        properties = {
            "task_description": self.properties.get("decomposer.task_description", None),
            "demonstrations": self.properties.get("decomposer.demonstrations", [])
        }
        plan_text = self.execute_api_call(user_input, properties=properties, additional_data={})

        logging.info("Decomposed task plan: {plan_text}".format(plan_text=plan_text))
        return plan_text

    def compile_action_plan(self, worker, plan: dict, task: str):
        """
        Converts LLM plan to a valid blue plan and submit
        """
        llm_plan = LLMPlan(plan)
        action_plan = AgenticPlan(scope=worker.prefix)

        # define input
        action_plan.define_input(USER_TASK_INPUT, value=task)

        for idx, node in llm_plan.nodes.items():
            prompt = EXECUTOR_PROMPT2.format(
                agent_id=node["index"],
                name=node["name"],
                instruction=node["instruction"],
                context="{input}",
            )

            in_coming = llm_plan.get_incoming(idx)
            if len(in_coming) == 0:
                in_coming = [
                    USER_TASK_INPUT
                ]  # provide global user task to all source nodes

            # define agents
            node_label = SUBTASK_LABEL.format(idx=idx)
            action_plan.define_agent(
                "BLOCKING_OPENAI_AGENT",
                label=node_label,
                properties={
                    "openai.model": self.properties.get(
                        "executor.openai.model", self.properties["openai.model"]
                    ),
                    "openai.max_tokens": self.properties.get(
                        "executor.openai.max_tokens",
                        self.properties.get("openai.max_tokens"),
                    ),
                    "use_tools": self.properties.get("executor.use_tools", True),
                    "tool_discovery": self.properties.get(
                        "executor.tool_discovery", False
                    ),
                    "input_template": prompt,
                    "wait_for_inputs": in_coming,
                },
            )
            logging.info(
                f"Defined subtask executor: {node_label} with prompt: {prompt}, wait on {in_coming}"
            )

            # connect agents
            for src in in_coming:
                if src == USER_TASK_INPUT:
                    action_plan.connect_input_to_agent(
                        from_input=USER_TASK_INPUT,
                        to_agent=node_label,
                        to_agent_input=USER_TASK_INPUT,
                    )
                    logging.info(
                        f"Connected INPUT {USER_TASK_INPUT} to AGENT {node_label}"
                    )
                else:
                    src_label = SUBTASK_LABEL.format(idx=src)
                    action_plan.connect_agent_to_agent(
                        from_agent=src_label,
                        to_agent=node_label,
                        to_agent_input=f"FROM_{src}",
                    )
                    logging.info(f"Connected AGENT {src_label} to AGENT {node_label}")

        # connect the sink node back to planner
        sink = llm_plan.get_sink()
        sink_label = SUBTASK_LABEL.format(idx=sink)
        return_to_agent=self.properties.get("executor.plan_return_to_agent", self.name)
        return_to_agent_input=self.properties.get("executor.plan_return_to_agent_input", RESULT_EXECUTION)
        logging.info(
            f"TOAGENTS {return_to_agent}:{return_to_agent_input}"
        )
        action_plan.connect_agent_to_agent(
            from_agent=sink_label,
            to_agent=return_to_agent,
            to_agent_input=return_to_agent_input
        )
        logging.info(
            f"Connected sink node {sink_label} to this planner agent: {return_to_agent}:{return_to_agent_input}"
        )

        return action_plan

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

                try:
                    plan_dag = json.loads(output)
                    llm_plan = LLMPlan(plan_dag)
                    plan_only_mode = properties.get('plan_only_mode', False)
                    if plan_only_mode:
                        # no execution; return LLM plan 
                        p = AgenticPlan(scope=worker.prefix)
                        p.define_input("DEFAULT", value=plan_dag)
                        # set plan
                        p.connect_input_to_agent(from_input="DEFAULT", to_agent=self.name)
                        p.connect_agent_to_agent(
                            from_agent=self.name,
                            to_agent=self.properties["executor.plan_return_to_agent"],
                            to_agent_input=self.properties["executor.plan_return_to_agent_input"],
                        )
                        # submit plan
                        p.submit(worker)
                        return

                    action_plan = self.compile_action_plan(
                        worker=worker, plan=plan_dag, task=user_input
                    )
                    action_plan.submit(worker)

                except ValidationError as e:
                    logging.error(f"Invalid plan: {e}")
                    return [
                        f"Invalid plan: {e}",
                        Message.EOS,
                    ]
                except Exception as e:
                    logging.error(f"Error submitting plan: {e}")
                    return [
                        f"Error submitting plan: {e}",
                        Message.EOS,
                    ]

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
        elif input == RESULT_EXECUTION:
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
