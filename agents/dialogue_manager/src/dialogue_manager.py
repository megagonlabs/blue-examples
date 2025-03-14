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
        if "name" not in kwargs:
            kwargs["name"] = "DIALOGUE_MANAGER"
        super().__init__(**kwargs)

    #### INTENT
    def identify_intent(self, worker, data, id=None):
        intents = [f"Name: {intent} | Description: {self.properties['intents'][intent]['description']}" for intent in self.properties['intents']]
        inp = f"\nUser text: {data}.\nPossible intents: {intents}."

        p = Plan(scope=worker.prefix)
        # set input
        p.define_input("DEFAULT", value=inp)
        # set plan
        p.connect_input_to_agent(from_input="DEFAULT", to_agent=self.properties['intent_classifier_agent'])
        p.connect_agent_to_agent(
            from_agent=self.properties['intent_classifier_agent'],
            to_agent=self.name,
            to_agent_input="INTENT",
        )

        # submit plan
        p.submit(worker)

        logging.info("Sent off intent classification request")
        return

    def build_action_plan(self, worker, intent):
        """Given an intent class, determine next action and build the corresponding plan"""
        if intent not in self.properties['intents']:
            return "User input not compatible with any of the specified intents."
        
        p = Plan(scope=worker.prefix)
        plan_diagram = self.properties['intents'][intent]['plan']
        p.define_input(plan_diagram[0][1], value=self.user_input)
        p.connect_input_to_agent(from_input=plan_diagram[0][1], to_agent=plan_diagram[0][0])
        for i in range(1, len(plan_diagram)):
             p.connect_agent_to_agent(
                from_agent=plan_diagram[i-1][0], to_agent=plan_diagram[i][0], to_agent_input=plan_diagram[i][1]
            )
        p.submit(worker)
        logging.info(f"Built plan for intent: {intent}")
        return f"Executing plan for intent: {intent}."

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        stream = message.getStream()

        if input == "DEFAULT":
            if message.isData():
                data = message.getData()
                self.user_input = data
                self.identify_intent(worker, data)

        elif input == "INTENT":
            if message.isData():
                data = message.getData()
                intent = json.loads(data)["intent"]
                return self.build_action_plan(worker, intent)

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
