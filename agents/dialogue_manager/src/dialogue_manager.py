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
from blue.agents.plan import AgenticPlan
from blue.utils import string_utils, json_utils, uuid_utils
from prompts import USER_INTENT_PROMPT

##### Agent

import util_functions

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

dialogue_manager_properties = {
    "service_url": "ws://blue_service_openai:8001",
    "input_context_field": "content",
    "input_context": "$[0]",
    "input_field": "messages",
    "input_json": '[{"role":"user"}]',
    "input_template": USER_INTENT_PROMPT,
    "openai.api": "ChatCompletion",
    "openai.frequency_penalty": 0,
    "openai.max_tokens": 1024,
    "openai.model": "gpt-4.1-mini-2025-04-14",
    "openai.presence_penalty": 0,
    "openai.temperature": 0,
    "openai.top_p": 1,
}

class DialogueManagerAgent(OpenAIAgent):

    def __init__(self, **kwargs):
        if "name" not in kwargs:
            kwargs["name"] = "DIALOGUE_MANAGER"
        super().__init__(**kwargs)

    def _initialize_properties(self):
        super()._initialize_properties()

        # init properties (override default properties)
        for key in dialogue_manager_properties:
            self.properties[key] = dialogue_manager_properties[key]

    def _initialize_inputs(self):
        self.add_input("DEFAULT", description="trigger", includes=["USER"])

    def _initialize_outputs(self):
        return

    def identify_intent(self, worker, data, id=None):
        intents = [f"Name: {intent} | Description: {self.properties['intents'][intent]['description']}" for intent in self.properties['intents']]
        inp = f"\nUser text: {data}.\nPossible intents: {intents}."

        p = AgenticPlan(scope=worker.prefix)
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
        
        p = AgenticPlan(scope=worker.prefix)
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

    def intent_rewriter(self, worker, data, id=None):
        '''
        Calls OPENAI Rewriter Agent
        Returns a concise rewritten summary of the conversation history
        '''
        p = AgenticPlan(scope=worker.prefix)
        # set input
        inp = f"Conversation History:\n{data}"
        p.define_input("DEFAULT", value=inp)
        # set plan
        p.connect_input_to_agent(from_input="DEFAULT", to_agent=self.properties['intent_rewriter_agent'])
        p.connect_agent_to_agent(
            from_agent=self.properties['intent_rewriter_agent'],
            to_agent=self.name,
            to_agent_input="INTENT_REWRITER",
        )
        # submit plan
        p.submit(worker)

        logging.info("Sent off intent rewriting request")
        return

    def llm_planner(self, worker, data, id=None):
        '''invokes Basic LLM Planner'''
        p = AgenticPlan(scope=worker.prefix)
        # set input
        p.define_input("DEFAULT", value=data)
        # set plan
        p.connect_input_to_agent(from_input="DEFAULT", to_agent=self.properties['llm_planner'])
        p.connect_agent_to_agent(
            from_agent=self.properties['llm_planner'],
            to_agent=self.name,
            to_agent_input="FROM_PLANNER",
        )
        # submit plan
        p.submit(worker)

        logging.info("Sent off llm planning request")
        return

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        conversation_memory = properties.get('conversation_memory', True)   # use conv history
        use_intent_rewrite = properties.get('use_intent_rewrite', True)     # use intent rewrite
        round_limit = properties.get('round_limit', 3)                      # max conversation rounds before plan
        stream = message.getStream()

        if not worker: 
            worker = self.create_worker(None)
        
        if conversation_memory and not worker.get_session_data("CONVERSATION_HISTORY"):
            worker.set_session_data("CONVERSATION_HISTORY", [])

        if input == "DEFAULT":
            if message.isData():
                data = message.getData()

                # define properties for openai api call
                properties = {
                    "task_description": self.properties.get("task_description", None),
                    "demonstrations": self.properties.get("demonstrations", [])
                }
                
                if not conversation_memory:
                    # no conversation memory --> no intent rewrite
                    use_intent_rewrite = False
                    assistant_response = self.execute_api_call(data, properties=properties, additional_data={})
                else:
                    # dialogue policy
                    conversation_history = worker.get_session_data("CONVERSATION_HISTORY")
                    user_utterance = f'{{"role": "user", "content": {data}}}'
                    conversation_history.append(user_utterance)
                    assistant_response = self.execute_api_call("\n".join(conversation_history), properties=properties, additional_data={})

                # check whether to plan based on dialogue policy
                # or if n turns of conversation have occurred
                is_plan = False
                if  (
                        assistant_response.lower() == "plan"
                        or (conversation_memory and (len(conversation_history)+1)/2 >= round_limit)
                ):
                    is_plan = True
                worker.set_session_data("IS_PLAN", is_plan)

                data = f'{{"role": "user", "content": {data}}}'
                if conversation_memory:
                    worker.append_session_data("CONVERSATION_HISTORY", data)
                    if not is_plan:
                        # write clarification question
                        worker.write_data(assistant_response, output="TEXT")
                        worker.write_eos(output="TEXT")
                        assistant_response = f'{{"role": "assistant", "content": {assistant_response}}}'
                        worker.append_session_data("CONVERSATION_HISTORY", assistant_response)

                    conversation_history = worker.get_session_data("CONVERSATION_HISTORY")
                    conversation_history = "\n".join(conversation_history)

                    if use_intent_rewrite: 
                        # intent rewrite
                        self.intent_rewriter(worker, conversation_history)
                    
                    if not use_intent_rewrite and is_plan: 
                        # plan
                        worker.write_data("Generating Plan", output="TEXT")
                        worker.write_eos(output="TEXT")
                        self.llm_planner(worker, conversation_history)

                else:
                    # if no conversation memory, generate plan
                    worker.write_data("Generating Plan", output="TEXT")
                    worker.write_eos(output="TEXT")
                    self.llm_planner(worker, data)


        elif input == "INTENT":
            if message.isData():
                data = message.getData()
                intent = json.loads(data)["intent"]
                return self.build_action_plan(worker, intent)
        
        elif input == "INTENT_REWRITER":
            if message.isData():
                data = message.getData()
                rewrite = json.loads(data)["rewrite"]
                is_plan = worker.get_session_data("IS_PLAN")

                if is_plan:
                    assistant_response = f"Generating Plan"
                    worker.write_data(assistant_response, output="TEXT")
                    worker.write_eos(output="TEXT")
                    return self.llm_planner(worker, rewrite)
                else:
                    assistant_response = f"Intent: {rewrite}"
                    return

        elif input == "RESULT":
            if message.isData():
                if worker:
                    data = message.getData()
                    return data

        elif input == "FROM_PLANNER":
            if message.isData():
                if worker:
                    data = message.getData()
                    worker.write_data("The final answer is ::: ", output="TEXT")
                    worker.write_data(data, output="TEXT")
                    worker.write_eos(output="TEXT")
            return
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