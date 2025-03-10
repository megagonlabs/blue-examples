###### Parsers, Formats, Utils
import argparse
import logging
import json
from os import write

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.session import Session
from blue.stream import ControlCode
from blue.plan import Plan
from blue.utils import string_utils, json_utils, uuid_utils

##### Agent

import util_functions

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)


class DialogueManagerAgent(OpenAIAgent):

    def __init__(self, **kwargs):
        logging.info("In Init Function===============================================")
        if "name" not in kwargs:
            kwargs["name"] = "DIALOGUE_MANAGER"
        super().__init__(**kwargs)
        # self.policy = {
        #     "investigate": [
        #         ["USER.TEXT", "NL2SQL.DEFAULT"],
        #         ["NL2SQL.DEFAULT", "QUERYEXECUTOR.DEFAULT"],
        #         ["QUERYEXECUTOR.DEFAULT", self.name + "RESULT"],
        #     ],
        #     "job_search": [
        #         ["USER.TEXT", "OPENAI_EXTRACTOR.DEFAULT"],
        #         ["OPENAI_EXTRACTOR.DEFAULT", "NL2SQL.DEFAULT"],
        #         ["NL2SQL.DEFAULT", "QUERYEXECUTOR.DEFAULT"],
        #         ["QUERYEXECUTOR.DEFAULT", self.name + "RESULT"],
        #     ],
        #     "summarize": [
        #         ["USER.TEXT", "OPENAI_EXTRACTOR.DEFAULT"],
        #         ["OPENAI_EXTRACTOR.DEFAULT", "NL2SQL.DEFAULT"],
        #         ["NL2SQL.DEFAULT", "QUERYEXECUTOR.DEFAULT"],
        #         ["QUERYEXECUTOR.DEDAULT", "SUMMARIZER.DEFAULT"],
        #         ["SUMMARIZER.DEFAULT", self.name + "RESULT"],
        #     ],
        #     "OOD": "Intent not supported",
        # }

    # def process_output(self, output_data, properties=None):
    #     logging.info("Entered process_output")
    #     # get properties, overriding with properties provided
    #     properties = self.get_properties(properties=properties)

    #     logging.info(output_data)
    #     # get gpt plan as json
    #     plan = json.loads(output_data)
    #     logging.info("Plan:")
    #     logging.info(json.dumps(plan, indent=4))
    #     logging.info(
    #         "========================================================================================================"
    #     )
    #     return plan

    #### INTENT
    def identify_intent(self, worker, data, id=None):
        logging.info("Identifying intent")

        logging.info(str(data))
        inp = f"\nUser text: {data}.\nPossible intents: {self.properties['intents']}."

        p = Plan(scope=worker.prefix)
        # set input
        p.define_input("DEFAULT", value=inp)
        # set plan
        p.connect_input_to_agent(from_input="DEFAULT", to_agent="OPENAI___CLASSIFIER")
        p.connect_agent_to_agent(
            from_agent="OPENAI___CLASSIFIER",
            to_agent=self.name,
            to_agent_input="INTENT",
        )

        # submit plan
        p.submit(worker)

        logging.info("Sent off intent classification request")
        return

    def build_intent_plan(self, worker, intent):
        logging.info("Building intent plan")
        logging.info(intent)
        p = Plan(scope=worker.prefix)
        if intent == "investigate":
            p.define_input("DEFAULT", value=self.user_input)
            p.connect_input_to_agent(from_input="DEFAULT", to_agent="NL2SQL")
            p.connect_agent_to_agent(
                from_agent="NL2SQL", to_agent="QUERYEXECUTOR", to_agent_input="DEFAULT"
            )
            p.connect_agent_to_agent(
                from_agent="QUERYEXECUTOR", to_agent=self.name, to_agent_input="RESULT"
            )
        elif intent == "job_search":
            p.define_input("DEFAULT", value=self.user_input)
            p.connect_input_to_agent(
                from_input="DEFAULT", to_agent="OPENAI___EXTRACTOR"
            )
            p.connect_agent_to_agent(
                from_agent="OPENAI___EXTRACTOR",
                to_agent="NL2SQL",
                to_agent_input="DEFAULT",
            )
            p.connect_agent_to_agent(
                from_agent="NL2SQL", to_agent="QUERYEXECUTOR", to_agent_input="DEFAULT"
            )
            p.connect_agent_to_agent(
                from_agent="QUERYEXECUTOR", to_agent=self.name, to_agent_input="RESULT"
            )
        elif intent == "summarize":
            p.define_input("DEFAULT", value=self.user_input)
            p.connect_input_to_agent(
                from_input="DEFAULT", to_agent="OPENAI___EXTRACTOR"
            )
            p.connect_agent_to_agent(
                from_agent="OPENAI___EXTRACTOR",
                to_agent="NL2SQL",
                to_agent_input="DEFAULT",
            )
            p.connect_agent_to_agent(
                from_agent="NL2SQL", to_agent="QUERYEXECUTOR", to_agent_input="DEFAULT"
            )
            p.connect_agent_to_agent(
                from_agent="QUERYEXECUTOR",
                to_agent="SUMMARIZER",
                to_agent_input="DEFAULT",
            )
            p.connect_agent_to_agent(
                from_agent="SUMMARIZER", to_agent=self.name, to_agent_input="RESULT"
            )
        else:
            p.define_input("DEFAULT", value=self.user_input)
            p.connect_input_to_agent(
                from_input="DEFAULT", to_agent="OPENAI___ROGUEAGENT"
            )
            p.connect_agent_to_agent(
                from_agent="OPENAI___ROGUEAGENT",
                to_agent=self.name,
                to_agent_input="RESULT",
            )

        p.submit(worker)
        logging.info("Submitted intent plan")
        return

    # def next_action(self, intent):
    #     return self.policy[intent]

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        logging.info("Entered default_processor")
        logging.info(message)
        logging.info(input)
        stream = message.getStream()

        if input == "DEFAULT":
            if message.isData():
                data = message.getData()
                self.user_input = data
                self.identify_intent(worker, data)

        elif input == "INTENT":
            if message.isData():
                data = message.getData()
                logging.info("Data type")
                logging.info(type(data))
                logging.info(str(data))

                intent = json.loads(data)["intent"]
                self.build_intent_plan(worker, intent)

        elif input == "RESULT":
            if message.isData():
                if worker:
                    data = message.getData()
                    logging.info("In results")
                    logging.info(data)
                    return data

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="DIALOGUE_MANAGER", type=str)
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
            _class=DialogueManagerAgent,
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
            a = DialogueManagerAgent(
                name=args.name, session=session, properties=properties
            )
        else:
            # create a new session
            session = Session()
            a = DialogueManagerAgent(
                name=args.name, session=session, properties=properties
            )

        # wait for session
        if session:
            session.wait()
