###### Parsers, Formats, Utils
import argparse
import logging
import json
import copy
import re

###### Blue
from blue.agent import Agent, AgentFactory
from blue.agents.coordinator import CoordinatorAgent
from blue.session import Session
from blue.stream import ControlCode
from blue.plan import Plan
from blue.utils import json_utils, string_utils, uuid_utils

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
                # plan
                p = Plan(prefix=worker.prefix)
                # set input
                a_value = 10
                p.set_input_value("a", a_value)
                # set plan
                p.add_input_to_agent_step("a", "COUNTER")
                p.add_agent_to_agent_step("COUNTER", self.name, to_param="RESULT")
                
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


