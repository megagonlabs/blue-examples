####### Parsers, Formats, Utils
import argparse
import logging
import json


###### Communication
import asyncio

###### Blue
from blue.tools.servers.mcp_server import MCPToolServer
from blue.tools.tool import Tool

#### functions
def add(numbers: list[int]) -> int:
    result = 0
    for number in numbers:
        result += int(number)
    return result


def get_weather(city_name: str) -> str:
    return "39 F, sunny."


# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s", level=logging.ERROR, datefmt="%Y-%m-%d %H:%M:%S")

class WeatherToolServer(MCPToolServer):
    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "WEATHER"
        super().__init__(**kwargs)


    def initialize_tools(self):
        add_tool = Tool(
            name = "add",
            description = "adds numbers and returns the addition as a result",
            properties = {},
            function = add,
            parameters = {},
            validator = lambda params: 'numbers' in params and type(params['numbers']) == list and all([type(number) in [int, float] for number in params['numbers']]),
            explainer = lambda output, params:  { "output": output, "params": params}
        )
        self.add_tool(add_tool)

        weather_tool = Tool(
            name = "get_weather",
            description = "Gets the weather for a given city.",
            properties = {},
            function = get_weather,
            parameters = {},
            validator = None,
            explainer = None
        )
        self.add_tool(weather_tool)

        
    
if __name__ == "__main__":
    logging.info('starting.')
 

    parser = argparse.ArgumentParser()
    parser.add_argument("--name", type=str, default="WEATHER")
    parser.add_argument("--properties", type=str)
    parser.add_argument("--loglevel", default="INFO", type=str)
    parser.add_argument("--platform", type=str, default="default")

    args = parser.parse_args()

    # set logging
    logging.getLogger().setLevel(args.loglevel.upper())

    # set properties
    properties = {}
    p = args.properties

    print(args)
    if p:
        # decode json
        properties = json.loads(p)
        print("properties:")
        print(json.dumps(properties, indent=3))
        print("---")

    # create tool server
    tool_server = WeatherToolServer(name=args.name, properties=properties)

    # run
    tool_server.start()
    
 