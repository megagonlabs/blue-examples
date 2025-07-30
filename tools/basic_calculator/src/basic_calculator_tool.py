####### Parsers, Formats, Utils
import argparse
import logging
import json
from typing import List


###### Communication
import asyncio

###### Blue
from blue.tools.servers.mcp_server import MCPToolServer
from blue.tools.tool import Tool
from blue.utils import tool_utils


#### functions
def add(numbers: list[int]) -> int:
    logging.info(f"`add` called with: {numbers}")
    result = 0
    for number in numbers:
        result += int(number)
    logging.info(f"`add` result: {result}")
    return result

def sub(number1: int, number2: int) -> int:
    logging.info(f"`sub` called with: {number1}, {number2}")
    result = int(number1) - int(number2)
    logging.info(f"`sub` result: {result}")
    return result


# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s", level=logging.ERROR, datefmt="%Y-%m-%d %H:%M:%S"
)


class BasicCalculatorToolServer(MCPToolServer):
    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "BASICCALCULATOR"
        super().__init__(**kwargs)

    def initialize_tools(self):
        add_tool = Tool(
            "add",
            add,
            description="adds numbers and returns the addition as a result",
            validator=lambda params: 'numbers' in params and type(params['numbers']) == list and all([type(number) in [int, float] for number in params['numbers']]),
            explainer=lambda output, params: {"output": output, "params": params},
        )
        sub_tool = Tool(
            "sub",
            sub,
            description="subtracts two numbers and returns the result",
            validator=lambda params: 'number1' in params and type(params['number1']) in [int, float] and 'number2' in params and type(params['number2']) in [int, float],
            explainer=lambda output, params: {"output": output, "params": params},
        )
        self.add_tool(add_tool)
        self.add_tool(sub_tool)


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

    # create tool server
    tool_server = BasicCalculatorToolServer(name=args.name, properties=properties)

    # run
    tool_server.start()
