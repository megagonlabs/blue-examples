###### Parsers, Formats, Utils
import argparse
import logging
import json
from os import write

###### Blue
from blue.agent import AgentFactory, AgentRegistry
from blue.agents.openai import OpenAIAgent
from blue.session import Session
from blue.stream import ControlCode
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
        self.policy = {
            "investigate": [
                ["USER.TEXT", "NL2SQL.DEFAULT"],
                ["NL2SQL.DEFAULT", "QUERYEXECUTOR.DEFAULT"],
                ["QUERYEXECUTOR.DEFAULT", self.name + "RESULT"],
            ],
            "job_search": [
                ["USER.TEXT", "OPENAI_EXTRACTOR.DEFAULT"],
                ["OPENAI_EXTRACTOR.DEFAULT", "NL2SQL.DEFAULT"],
                ["NL2SQL.DEFAULT", "QUERYEXECUTOR.DEFAULT"],
                ["QUERYEXECUTOR.DEFAULT", self.name + "RESULT"],
            ],
            "summarize": [
                ["USER.TEXT", "OPENAI_EXTRACTOR.DEFAULT"],
                ["OPENAI_EXTRACTOR.DEFAULT", "NL2SQL.DEFAULT"],
                ["NL2SQL.DEFAULT", "QUERYEXECUTOR.DEFAULT"],
                ["QUERYEXECUTOR.DEDAULT", "SUMMARIZER.DEFAULT"],
                ["SUMMARIZER.DEFAULT", self.name + "RESULT"],
            ],
            "OOD": "Intent not supported",
        }

    def process_output(self, output_data, properties=None):
        logging.info("Entered process_output")
        # get properties, overriding with properties provided
        properties = self.get_properties(properties=properties)

        logging.info(output_data)
        # get gpt plan as json
        plan = json.loads(output_data)
        logging.info("Plan:")
        logging.info(json.dumps(plan, indent=4))
        logging.info(
            "========================================================================================================"
        )

        return plan

    #### INTENT
    def identify_intent(self, worker, user_stream, id=None):
        # create a unique id
        if id is None:
            id = util_functions.create_uuid()

        # intent plan
        intent_plan = [
            ["USER.TEXT", "OPENAI_CLASSIFIER.DEFAULT"],
            ["OPENAI_CLASSIFIER.DEFAULT", self.name + ".INTENT"],
        ]

        # build query plan
        plan = util_functions.build_plan(intent_plan, user_stream, id=id)

        # write plan
        # TODO: change to tags=["HIDDEN"]
        util_functions.write_to_new_stream(worker, plan, "PLAN", tags=["PLAN"], id=id)

        return

    def next_action(self, intent):
        return self.policy[intent]

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        logging.info("Entered default_processor")
        stream = message.getStream()

        if input == "DEFAULT":

            if message.isEOS():
                stream = message.getStream()

                self.identify_intent(worker, stream)

        elif input == "INTENT":
            if message.isData():
                if worker:
                    data = message.getData()
                    stream = message.getStream()
                    logging.info(json.dumps(data, indent=3))

                    if "intent" in data:
                        intent = data["intent"]
                        action = self.next_action(worker, intent)
                        # TODO: change to check if a plan object
                        if isinstance(action, list):
                            plan = util_functions.build_plan(action, stream)

                            util_functions.write_to_new_stream(
                                worker, plan, "PLAN", tags=["PLAN"]
                            )
                        else:
                            return action

        elif input == "RESULT":
            if message.isData():
                if worker:
                    data = message.getData()
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
