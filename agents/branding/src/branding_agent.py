###### Parsers, Formats, Utils
import argparse
import logging
import json

###### Blue
from blue.agent import Agent, AgentFactory
from blue.stream import Message
from blue.session import Session


############################
### Agent.CounterAgent
#
class BrandingAgent(Agent):
    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "BRANDING"
        super().__init__(**kwargs)

    ####### inputs / outputs
    def _initialize_inputs(self):
        self.add_input("DEFAULT", description="input text")

    def _initialize_outputs(self):
        self.add_output("DEFAULT", description="number of words counted")

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if message.isEOS():
            # get all data received from stream
            stream_data = ""
            if worker:
                stream_data = worker.get_data('stream') #stream data = user input

            # output to stream
            text = " ".join(stream_data)
            count = len(text.split(" "))
            count = count +1
            return [count, Message.EOS]

        elif message.isBOS():
            # init stream to empty array
            if worker:
                worker.set_data('stream', [])
        elif message.isData():
            # store data value
            data = message.getData()

            if worker:
                worker.append_data('stream', data)

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--name', default="BRANDING", type=str)
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

        af = AgentFactory(_class=BrandingAgent, _name=args.serve, _registry=args.registry, platform=platform, properties=properties)
        af.wait()
    else:
        a = None
        session = None

        if args.session:
            # join an existing session
            session = Session(cid=args.session)
            a = BrandingAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = BrandingAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()
