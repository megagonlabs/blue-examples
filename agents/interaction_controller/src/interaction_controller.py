###### Parsers, Formats, Utils
import argparse
import logging
import json

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.session import Session
from blue.stream import ControlCode
from blue.agents.plan import AgenticPlan
from blue.data.registry import DataRegistry

##### Agent

import util_functions

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

def build_plan_form(plan: list, current_step: int):
    data_schema = {
        "type": "object",
        "properties": {}
    }
    ui_schema = {
        "type": "Mermaid",
        "scope": "#/properties/plan",
        "props": {
            "style": {}
        }
    }
    mermaid_plan = "graph TD\n"
    for i, step in enumerate(plan):
        logging.info(f"Building plan form step {i}: {step}")
        logging.info(f"type(step): {type(step)}")
        if i < current_step:
            status = "✅"
        elif i == current_step:
            status = "⏳"
        else:
            status = ""
        mermaid_plan += f'{i}[\"{i} [{step["agent"]}] {step["summarized_instruction"][:30]} {status}\"]\n'
    for i in range(1, len(plan)):
        mermaid_plan += f"{i-1}-->{i};\n"
        
    data = {"plan": mermaid_plan}
    return {"schema": data_schema, "uischema": ui_schema, "data": data}

class InteractionControllerAgent(OpenAIAgent):
    '''
    The Interaction Controller Agent is responsible for routing the user request to necessary agents to complete the task. 

    Interaction Controller supports
    - Storing and managing conversations with user to better understand and contextualize user intent
    - Generating a linear plan based on user intent and registry metadata 
    - Managing execution flow and coordination between agents
    '''
    def __init__(self, **kwargs):
        if "name" not in kwargs:
            kwargs["name"] = "INTERACTION_CONTROLLER"
        super().__init__(**kwargs)

    def _initialize_properties(self):
        super()._initialize_properties()

    def _initialize_inputs(self):
        self.add_input("DEFAULT", description="trigger", includes=["USER"])

    def _initialize_outputs(self):
        return
    
    def _init_registry(self):
        """Initialize the data registry."""
        # create instance of data registry
        platform_id = self.properties["platform.name"]
        prefix = 'PLATFORM:' + platform_id
        self.registry = DataRegistry(id=self.properties['data_registry.name'], prefix=prefix, properties=self.properties)
        logging.info("Initialized Data Registry")

    def plan_executor(self, worker):
        '''
        Executes each agent in plan, one at a time
        '''
        agents = worker.get_session_data("AGENTS")
        instructions = worker.get_session_data("INSTRUCTIONS")
        i = worker.get_session_data("ITERATOR")
        
        if i == len(agents):
            # execution complete
            logging.info("Plan execution completed.")
            worker.write_data("Plan execution completed.", output="TEXT")
            worker.write_eos(output="TEXT")
            plan_form = build_plan_form(
                    worker.get_session_data("LLM_PLAN"), 
                    worker.get_session_data("ITERATOR")
                )
            worker.write_control(ControlCode.CREATE_FORM, plan_form, output="PLAN_VIS")
            return
        
        # execute agent
        agent = agents[i]
        p = AgenticPlan(scope=worker.prefix)
        logging.info(f"Submitting instruction to agent {agent}: {instructions[i]}")
        try:
            worker.write_data(f"Executing {agent} Agent", output="TEXT")
            worker.write_eos(output="TEXT")
            p.define_input("DEFAULT", value=instructions[i])
            p.connect_input_to_agent(from_input="DEFAULT", to_agent=agent, to_agent_input="DEFAULT")
            p.connect_agent_to_agent(from_agent=agent, to_agent=self.name, to_agent_input="REACT")
            plan_form = build_plan_form(
                    worker.get_session_data("LLM_PLAN"), 
                    worker.get_session_data("ITERATOR")
                )
            worker.write_control(ControlCode.CREATE_FORM, plan_form, output="PLAN_VIS")
            p.submit(worker)
        except Exception as e:
            logging.error(f"Error during plan execution: {e}")
            
    def registry_search(self, data):
        '''
        Search relevant registry details for registry-aware planning
        '''
        scope="/"
        tries = 0
        data_registry = []
        while tries < 3:
            results = self.registry.search_records(data, scope=scope)
            logging.info(f"Type: {type(results)}")
            logging.info(f"Data aware planner search results: {results}")
            if results and len(results) > 0:
                data_registry = [{"name": x["name"], "type": x["type"], "scope": x["scope"]} for x in results]
                depth = results[0]['scope'].count('/')
                if depth > 1:
                    break
                else:
                    scope = f"{scope}{results[0]['name']}/"
            tries += 1
        return data_registry
    
    def get_user_intent_for_data_visualization(self, worker, data): # TO BE DEPRECATED
        properties = {
            "task_description": self.properties.get("task_description", None),
            "demonstrations": self.properties.get("demonstrations", []),
            "input_template": self.properties.get("user_intent_for_data_visualization_prompt", "")
        }
        response = self.execute_api_call(data, properties=properties, additional_data={})
        return response.strip().lower() == "visualize"

    def invoke_eda(self, worker, data): # TO BE DEPRECATED
        p = AgenticPlan(scope=worker.prefix)
        p.define_input("DEFAULT", value=data)
        p.connect_input_to_agent(from_input="DEFAULT", to_agent="DATA_EXPLORATION_AGENT", to_agent_input="DEFAULT")
        p.connect_agent_to_agent(from_agent="DATA_EXPLORATION_AGENT", to_agent=self.name, to_agent_input="FROM_EDA")
        eda_plan = [
                {
                    "agent": "EDA",
                    "summarized_instruction": data
                }
            ]
        worker.set_session_data("EDA_PLAN", eda_plan)
        plan_form = build_plan_form( 
            eda_plan,
            0
        )
        
        worker.write_control(ControlCode.CREATE_FORM, plan_form, output="PLAN_VIS")
        p.submit(worker)

    def get_user_intent_for_data_profiling(self, worker, data): # TO BE DEPRECATED
        properties = {
            "task_description": self.properties.get("task_description", None),
            "demonstrations": self.properties.get("demonstrations", []),
            "input_template": self.properties.get("user_intent_for_data_profiling_prompt", "")
        }
        response = self.execute_api_call(data, properties=properties, additional_data={})
        logging.info(f"User intent for data filing response: {response}")
        return response.strip().lower() == "profile"

    def invoke_vis(self, worker, data): # TO BE DEPRECATED
        p = AgenticPlan(scope=worker.prefix)
        p.define_input("DEFAULT", value=data)
        p.connect_input_to_agent(from_input="DEFAULT", to_agent="DATA_VISUALIZATION_AGENT", to_agent_input="DEFAULT")
        p.connect_agent_to_agent(from_agent="DATA_VISUALIZATION_AGENT", to_agent=self.name, to_agent_input="FROM_VIS")
        vis_plan = [
                {
                    "agent": "VIS",
                    "summarized_instruction": data
                }
            ]
        worker.set_session_data("VIS_PLAN", vis_plan)
        plan_form = build_plan_form(
            vis_plan,
            0
        )
        worker.write_control(ControlCode.CREATE_FORM, plan_form, output="PLAN_VIS")
        p.submit(worker)

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        conversation_memory = properties.get('conversation_memory', True)
        stream = message.getStream()

        if not worker: 
            worker = self.create_worker(None)

        if conversation_memory and not worker.get_session_data("CONVERSATION_HISTORY"):
            worker.set_session_data("CONVERSATION_HISTORY", [])

        logging.info(f"Interaction Controller received input: {input}")

        if input == "DEFAULT":
            if message.isData():
                data = message.getData()
                
                # REMOVE ONCE USE CASE FINALIZED 
                # if self.get_user_intent_for_data_profiling(worker, data) == True:
                #     self.invoke_eda(worker, data)
                #     return None
                
                # if self.get_user_intent_for_data_visualization(worker, data) == True:
                #     self.invoke_vis(worker, data)
                #     return None
                
                properties = {
                    "task_description": self.properties.get("task_description", None),
                    "demonstrations": self.properties.get("demonstrations", []),
                    "input_template": self.properties.get("user_context_prompt", "")
                }
                # context aware user utterance
                if conversation_memory:
                    conversation_history = worker.get_session_data("CONVERSATION_HISTORY")
                    logging.info(f"Current Conversation History: {conversation_history}")
                    user_utterance = f'{{"role": "user", "content": {data}}}'
                    conversation_history.append(user_utterance)
                    worker.append_session_data("CONVERSATION_HISTORY", user_utterance)
                    user_request = self.execute_api_call("\n".join(conversation_history), properties=properties, additional_data={})
                    logging.info(f"User Utterance after context processing: {user_request}")
                else:
                    user_request = data

                # sync registry before planning
                self.registry.sync_source_database_collection(source="postgres_workspace", database="workspace", collection="public")
                logging.info("Synchronized source, database, and collection with Data Registry")

                # search registry based on user request
                data_registry = self.registry_search(user_request)
                logging.info(f"Data Registry after search: {data_registry}")

                # generate plan based on user request and registry
                plan_prompt = f"Data Registry:\n{data_registry}"
                plan_prompt = plan_prompt + self.properties.get("plan_prompt", "")
                properties = {
                    "task_description": self.properties.get("task_description", None),
                    "demonstrations": self.properties.get("demonstrations", []),
                    "openai.response_format": {"type": "json_object"},
                    "input_template": plan_prompt
                }
                worker.write_data(f"Generating Plan...", output="TEXT")
                worker.write_eos(output="TEXT")
                llm_plan = self.execute_api_call(user_request, properties=properties, additional_data={})

                # summarize instructions for easier visualization
                properties = {
                    "task_description": self.properties.get("task_description", None),
                    "demonstrations": self.properties.get("demonstrations", []),
                    "openai.response_format": {"type": "json_object"},
                    "input_template": self.properties.get("summarize_instructions_prompt", "")
                }
                llm_plan_summarized = self.execute_api_call(json.dumps(llm_plan), properties=properties, additional_data={})
                llm_plan_summarized = json.loads(llm_plan_summarized)

                llm_plan = json.loads(llm_plan)
                logging.info(f"LLM Planner Response json: {llm_plan}")

                # output generated plan
                plan = llm_plan["plan"]
                worker.write_data("Plan Generated:", output="TEXT")
                worker.write_data(f"{plan}", output="TEXT")
                worker.write_eos(output="TEXT")

                # store relevant session data
                agents = [x["agent"] for x in plan]
                instructions = [x["instruction"] for x in plan]
                worker.set_session_data("AGENTS", agents)
                worker.set_session_data("INSTRUCTIONS", instructions)
                worker.set_session_data("ITERATOR", 0)  # iterate through linear plan step by step
                worker.set_session_data("LLM_PLAN", llm_plan_summarized["plan"])
                logging.info(f"Agents in plan: {agents}")
                
                # execute plan
                self.plan_executor(worker)
        elif input == "REACT":
            if worker:
                # iterate through linear plan step by step
                i = worker.get_session_data("ITERATOR")
                worker.set_session_data("ITERATOR", i+1) 

                #sync registry
                self.registry.sync_source_database_collection(source="postgres_workspace", database="workspace", collection="public")
                logging.info("Synchronized source, database, and collection with Data Registry")
                
                #continue plan execution
                self.plan_executor(worker)
        elif input == "FROM_VIS": # TO BE DEPRECATED
            if worker:
                plan_form = build_plan_form(
                    worker.get_session_data("VIS_PLAN"), 
                    1
                )
                worker.write_control(ControlCode.CREATE_FORM, plan_form, output="PLAN_VIS")
                worker.write_data("Visualization completed.", output="TEXT")
                worker.write_eos(output="TEXT") 
        elif input == "FROM_EDA": # TO BE DEPRECATED
            if worker:
                plan_form = build_plan_form(
                     worker.get_session_data("EDA_PLAN"), 
                    1
                )
                worker.write_control(ControlCode.CREATE_FORM, plan_form, output="PLAN_VIS")
                worker.write_data("Profiling completed.", output="TEXT")
                worker.write_eos(output="TEXT")         
        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="INTERACTION_CONTROLLER", type=str)
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
            _class=InteractionControllerAgent,
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
            a = InteractionControllerAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = InteractionControllerAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()