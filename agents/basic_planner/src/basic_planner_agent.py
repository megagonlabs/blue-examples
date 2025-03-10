###### Parsers, Formats, Utils
import argparse
import logging
import json
import copy
import re

###### Blue
from blue.agent import Agent, AgentFactory
from blue.session import Session
from blue.plan import Plan

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s", level=logging.ERROR, datefmt="%Y-%m-%d %H:%M:%S")

############################
### Agent.BasicPlannerAgent
#
class BasicPlannerAgent(Agent):
    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "BASIC_PLANNER"
        super().__init__(**kwargs)

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if input == "DEFAULT":

            if message.isEOS():
                ### create a basic plan
                # plan with a scope of session
                ## W1
                # p = Plan(scope=worker.session)
                # p.define_input("I", value=10)
                # p.define_agent("COUNTER", label="C", properties={"f": 3})
                # p.define_agent_input("DEFAULT", "COUNTER")
                # p.define_agent_output("DEFAULT", "C")
                # p.define_agent("BASIC_PLANNER", label="BP")
                # p.define_agent_input("RESULT", "BASIC_PLANNER")
                # p.define_output("R")

                # p.connect_input_to_agent(from_input="I", to_agent="C")
                # p.connect_agent_to_output(from_agent="C", to_output="R")
                # p.connect_agent_to_agent(from_agent="C", to_agent="BP", to_agent_input="RESULT")  

                ## W2
                p = Plan(scope=worker.session)
                p.define_input("I", value=10)
                # p.define_agent("COUNTER", label="C", properties={"f": 3})
                # p.define_agent_input("DEFAULT", "COUNTER")
                # p.define_agent_output("DEFAULT", "C")
                # p.define_agent("BASIC_PLANNER", label="BP")
                # p.define_agent_input("RESULT", "BASIC_PLANNER")
                p.define_output("R")

                p.connect_input_to_agent(from_input="I", to_agent="COUNTER")
                p.connect_agent_to_output(from_agent="COUNTER", to_output="R")
                p.connect_agent_to_agent(from_agent="COUNTER", to_agent="BASIC_PLANNER", to_agent_input="RESULT")  

                # define_input(self, name, label=None, value=None, stream=None, properties={}, save=False):
                # define_output(self, name, label=None, value=None, stream=None, properties={}, save=False):
                # define_agent(self, name, label=None, properties={}, save=False):
                # define_agent_input(self, name, agent, label=None, stream=None, properties={}, save=False):
                # define_agent_output(self, name, agent, label=None, properties={}, save=False):   
                # connect_input_to_agent(self, from_input=None, to_agent=None, to_agent_input=None):
                # connect_agent_to_agent(self, from_agent=None, from_agent_output=None, to_agent=None, to_agent_input=None):
                # connect_agent_to_output(self, from_agent=None, from_agent_output=None, to_output=None):
                # connect_input_to_output(self, from_input=None, to_output=None): 
                
                # submit plan
                p.submit(worker)

        elif input == "RESULT":
            if message.isData():
                ### show plan result
                data = message.getData()
                logging.info(data)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--name', default="BASIC_PLANNER", type=str)
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
        
        af = AgentFactory(_class=BasicPlannerAgent, _name=args.serve, _registry=args.registry, platform=platform, properties=properties)
        af.wait()
    else:
        a = None
        session = None

        if args.session:
            # join an existing session
            session = Session(cid=args.session)
            a = BasicPlannerAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = BasicPlannerAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()


