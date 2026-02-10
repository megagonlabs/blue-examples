###### Parsers, Formats, Utils
from dataclasses import dataclass
from typing import Any, Optional
import argparse
import json
import logging
import textwrap
import uuid

###### Blue
from blue.agent import AgentFactory, Worker
from blue.agents.openai import OpenAIAgent
from blue.agents.plan import AgenticPlan
from blue.session import Session
from blue.stream import Message
from blue.utils import string_utils, json_utils

###### Blue Plate Reactive Agent
import copy

from utils import (
    add_action_to_history,
    add_assistant_message,
    add_user_message,
    build_action_schema_from_agent_definitions,
    conversation_history_to_str,
    generate_markdown,
    render_markdown,
)


# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

MAX_OBSERVATION_LENGTH = 2048

DISABLED_INPUTS_OVERRIDE = {
    "DEFAULT": {
        "name": "DEFAULT",
        "description": "Disabled input",
        "properties": {
            "display_name": "DEFAULT",
            "listens": {"includes": [], "excludes": []},
        },
    },
}

DEFAULT_AGENT_DEFINITIONS = [
    {
        "name": "RECIPE_RETRIEVAL",
        "description": "Retrieves a recipe based on available ingredients and check if there are missing ingredients against the recipe requirements.",
        "parameters": {
            "type": "object",
            "properties": {
                "ingredients": {
                    "type": "array",
                    "description": "Optional list of available ingredients to check against the recipe requirements.",
                    "items": {"type": "string"},
                },
            },
            "required": ["ingredients"],
            "additionalProperties": False,
        },
    },
    {
        "name": "TALK_TO_USER",
        "description": "Present results to the user (Markdown supported) and pause to await input or confirmation.",
        "parameters": {
            "type": "object",
            "properties": {
                "message": {
                    "type": "string",
                    "description": "Message to display to the user (Markdown supported).",
                }
            },
            "required": ["message"],
            "additionalProperties": False,
        },
    },
    {
        "name": "FILTER_RECIPE",
        "description": "Present a form to the user to filter retrieved recipes based on criteria such as cooking time, cuisine type, and difficulty level and return the filtered list.",
        "parameters": {
            "type": "object",
            "properties": {
                "recipe_ref": {
                    "type": "string",
                    "description": "Memory index reference to the retrieved recipes to filter.",
                    "pattern": "^\$\d+$",
                }
            },
            "required": ["recipe_ref"],
            "additionalProperties": False,
        },
    },
    {
        "name": "PRESENT_RECIPES",
        "description": "Format and present the retrieved recipes to the user in a readable format. The input must be a memory index reference to the output of FILTER_RECIPE agent.",
        "parameters": {
            "type": "object",
            "properties": {
                "recipe_ref": {
                    "type": "string",
                    "description": "Memory index reference to the output of FILTER_RECIPE agent.",
                    "pattern": "^\$\d+$",
                }
            },
            "required": ["recipe_ref"],
            "additionalProperties": False,
        },
    },
    {
        "name": "COOKING_IMAGE_GENERATOR",
        "description": "Given a recipe text, generate step-by-step cooking images for the recipe.",
        "parameters": {
            "type": "object",
            "properties": {
                "dishName": {
                    "type": "string",
                    "description": "Name of the dish to generate cooking images for.",
                },
                "description": {
                    "type": "string",
                    "description": "Text description of the recipe steps.",
                },
                "ingredients": {
                    "type": "array",
                    "description": "List of ingredients for the recipe.",
                    "items": {"type": "string"},
                },
                "instructions": {
                    "type": "array",
                    "description": "List of cooking instructions for the recipe.",
                    "items": {"type": "string"},
                },
            },
            "required": ["dishName", "description", "ingredients", "instructions"],
            "additionalProperties": False,
        },
    },
]

DEFAULT_SYSTEM_PROMPT = """You are a helpful cooking assistant that helps users create recipes based on ingredients they have.

You operate using the ReAct (Reasoning + Acting) framework: for each step, you generate a thought explaining your reasoning, then specify an action to execute.

# Response Format
You MUST respond with a JSON object containing:
- "thought": A concise sentence describing your reasoning for the next step
- "action": An object with "name" (the agent to call) and "arguments" (parameters as a dictionary)

Example response (JSON):
```
- thought: "I need to extract ingredients from the user's image before suggesting recipes.",
- action:
    - name: "INGREDIENT_EXTRACTOR"
    - arguments:
        - input: "USER_IMAGE_DATA"
```

# Available Agents

```
${agent_definitions}
```

# Workflow Guidelines (First complete this sequence without asking for additional user input)
1. When you receive an image, use INGREDIENT_EXTRACTOR to identify ingredients.
2. After extraction, use TALK_TO_USER to confirm the identified ingredients.
3. Use RECIPE_RETRIEVAL to fetch relevant recipes based on the ingredients.
4. Use FILTER_RECIPE to let the user filter results.
5. Use PRESENT_RECIPES to display the final recipes.
6. Use TALK_TO_USER to await user feedback.

# Important Rules
- Always explain your reasoning in the "thought" field before taking action
- Call only ONE agent per response
- Wait for observation feedback before proceeding to the next step
- Be conversational and friendly while maintaining the structured JSON format
- Do not use TALK_TO_USER to merely acknowledge receipt or announce the next step (e.g. "Okay, I will retrieve recipes now"). Instead, directly call the next agent (e.g. RECIPE_RETRIEVAL).
- Don't repeat actions that have already been taken unless absolutely necessary
"""


DEFAULT_RESPONSE_FORMAT = {
    "type": "json_schema",
    "json_schema": {
        "name": "ReActResponse",
        "schema": {
            "type": "object",
            "properties": {
                "thought": {
                    "type": "string",
                    "description": "A short sentence describing the agent's thought process.",
                },
                "action": {
                    "type": "object",
                    "description": "The action to be taken by the agent.",
                    "properties": {
                        "name": {
                            "type": "string",
                            "description": "The name of the agent to call.",
                        },
                        "arguments": {
                            "type": "object",
                            "description": "A dictionary of arguments for the agent.",
                        },
                    },
                    "required": ["name", "arguments"],
                    "additionalProperties": False,
                },
            },
            "required": ["thought", "action"],
            "additionalProperties": False,
        },
        "strict": True,
    },
}
DEFAULT_TOOL_CONTEXT_IN_RESPONSE_FORMAT = "$.json_schema.schema.properties"
DEFAULT_TOOL_CONTEXT_FIELD_IN_RESPONSE_FORMAT = "action"


@dataclass
class ReActResponse:
    """Response structure for ReAct (Reasoning + Acting) framework.

    Encapsulates the agent's reasoning and the next action to execute.

    Attributes:
        thought: A concise sentence describing the agent's reasoning.
        action: Dictionary containing 'name' (agent to call) and 'arguments' (parameters).
    """

    thought: str
    action: dict[str, Any]

    def __str__(self) -> str:
        """Format the response as a human-readable string.

        Returns:
            Formatted string with thought and action details.
        """
        return f"**Thought:** {self.thought}\n**Action:** `{json.dumps(self.action)}`"


def get_response_format(properties: Optional[dict] = None) -> dict:
    """Get the structured response format for the ReAct agent."""

    properties = properties if properties is not None else {}

    # Create base response format structure
    response_format = copy.deepcopy(properties.get("response_format", DEFAULT_RESPONSE_FORMAT))

    # Build action schema from agent definitions
    agent_definitions = properties.get("agent_definitions", DEFAULT_AGENT_DEFINITIONS)
    action_schema = build_action_schema_from_agent_definitions(agent_definitions)

    # Use json_query_set to assign action schema to response format
    tool_context = properties.get("tool_context_in_response_format", DEFAULT_TOOL_CONTEXT_IN_RESPONSE_FORMAT)
    tool_context_field = properties.get(
        "tool_context_field_in_response_format", DEFAULT_TOOL_CONTEXT_FIELD_IN_RESPONSE_FORMAT
    )

    logging.info(f"Response format template: {response_format}")
    json_utils.json_query_set(response_format, tool_context_field, action_schema, context=tool_context)
    logging.info(f"Final response format: {response_format}")
    return response_format


############################
### Agent.ReactiveBluePlateAgent


## Given a user input, executes multiple agents to perform a task
## Interleaves thought -> action calling -> observation -> thought loops
#
class ReactiveBluePlateAgent(OpenAIAgent):
    """Reactive cooking assistant using ReAct framework for multi-agent orchestration.

    This agent coordinates multiple sub-agents (ingredient extraction, dish ideation,
    recipe retrieval) using a thought-action-observation loop to help users create
    recipes based on available ingredients.
    """

    def __init__(self, **kwargs: Any) -> None:
        """Initialize the reactive Blue Plate agent.

        Args:
            **kwargs: Keyword arguments passed to parent OpenAIAgent.
        """
        if "name" not in kwargs:
            kwargs["name"] = "reactive_blue_plate"
        super().__init__(**kwargs)

        # Track whether initial image has been received from user
        self.image_received: bool = False
        # Store conversation history for the current session
        self.conversation_history: list[dict[str, str]] = []

    def _initialize_inputs(self) -> None:
        """Initialize input parameters for the agent.

        Sets up OBSERVATION input channel for receiving results from sub-agents.
        """
        super()._initialize_inputs()

        # Add OBSERVATION input for processing results from sub-agents
        # This input does NOT listen to any session stream tags - it only processes
        # direct connections from plans
        self.add_input("OBSERVATION", description="Observation processing input")

    def _initialize_outputs(self) -> None:
        """Initialize outputs for the agent, tagged as DOC for markdown rendering.

        Defines the DEFAULT output with DOC tag to enable markdown form-based
        rendering in the GUI, similar to DocumenterAgent.
        """
        self.add_output("DEFAULT", description="markdown output", tags=["DOC"])

    def _think(self, conversation_history: list[dict[str, str]], properties: Optional[dict] = None) -> ReActResponse:
        """Generate a thought and action using the LLM based on conversation history.

        Args:
            conversation_history: List of conversation turns with roles and content.
            properties: Optional properties for API call configuration.

        Returns:
            ReActResponse containing the agent's thought and next action.
        """
        # Prepare API call properties
        call_properties = copy.deepcopy(properties) if properties is not None else {}

        # Set the conversation history via input_json
        call_properties["input_json"] = conversation_history

        # Extract the last turn as input for the API call
        last_turn = conversation_history[-1]
        input_data = last_turn.get("content", "")
        ## `input_data` will be assigned to the "content" field of the last item in input_json
        call_properties["input_context"] = "$[-1]"  # last item in input_json
        call_properties["input_context_field"] = "content"

        # Set response format for structured output
        call_properties["openai.response_format"] = get_response_format(call_properties)

        logging.info(f"Response format: {call_properties['openai.response_format']}")

        # Disable use_tools for this specific call (we're using structured outputs instead)
        call_properties["use_tools"] = False

        try:
            # Execute API call using standard method
            output = self.execute_api_call(input=input_data, properties=call_properties, additional_data=None)

            logging.info(f"THOUGHT: Received response: {output}")

            # Parse the structured JSON response content
            content = json.loads(output)
            thought = content.get("thought", "")
            action = content.get("action", {})

            # Ensure action has required fields
            action["name"] = action.get("name", "")
            action["arguments"] = action.get("arguments", {})

            return ReActResponse(thought=thought, action=action)

        except Exception as e:
            logging.error(f"Error in _think: {str(e)}")
            return ReActResponse(thought="Error generating thought.", action={})

    def _handle_initial_image_input(
        self,
        data: Any,
        worker: Worker,
        conversation_history: list[dict[str, str]],
    ) -> Optional[list[Any]]:
        """Handle the initial image input from the user.

        Validates the image, creates a plan to extract ingredients, and updates
        the conversation history.

        Args:
            data: The input data to validate and process.
            worker: The worker instance for plan submission.
            conversation_history: The conversation history to update.

        Returns:
            List containing response message and EOS marker, or None if validation fails.
        """
        # Validate that first input is an image
        if (
            data is None
            or len(data) == 0
            or not isinstance(data, dict)
            or not data.get("content_type", "").startswith("image/")
        ):
            return [
                "Please provide an image of the ingredients you have.",
                Message.EOS,
            ]

        # Mark image as received and begin processing
        self.image_received = True

        # Create plan: USER_IMAGE_INPUT -> INGREDIENT_EXTRACTOR -> OBSERVATION
        p = AgenticPlan(scope=worker.prefix)
        p.define_input(label="USER_IMAGE_INPUT", value=data)
        p.define_agent(
            name="INGREDIENT_EXTRACTOR",
            label="INGREDIENT_EXTRACTOR",
            properties={"inputs": DISABLED_INPUTS_OVERRIDE},
        )
        p.define_agent(
            name=self.name,
            label=self.name,
            properties={"inputs": DISABLED_INPUTS_OVERRIDE},
        )
        p.connect_input_to_agent(
            from_input="USER_IMAGE_INPUT",
            to_agent="INGREDIENT_EXTRACTOR",
            to_agent_input="DEFAULT",
        )
        p.connect_agent_to_agent(
            from_agent="INGREDIENT_EXTRACTOR",
            to_agent=self.name,
            to_agent_input="OBSERVATION",
        )
        p.submit(worker)
        logging.info("DEFAULT: Submitted plan for image ingredient extraction")

        # Update conversation history
        add_user_message(
            conversation_history,
            "Please extract the ingredients from the image and suggest recipes.\n\n[USER_IMAGE_INPUT]",
        )
        add_assistant_message(
            conversation_history,
            "Image received. I will call INGREDIENT_EXTRACTOR to extract ingredients from the image. Once I have the ingredients, I will retrieve relevant recipes using RECIPE_RETRIEVAL. Finally, I will present the recipes to the user and wait for their feedback.",
        )
        add_action_to_history(
            conversation_history,
            "INGREDIENT_EXTRACTOR",
            {"input": "USER_IMAGE_INPUT"},
        )

        worker.set_session_data("CONVERSATION_HISTORY", conversation_history)
        return ["Image received. Processing...", Message.EOS]

    def _handle_user_text_input(
        self,
        data: Any,
        worker: Worker,
    ) -> None:
        """Handle subsequent user text input after the image has been received.

        Creates a plan to route user input to the OBSERVATION channel for processing.

        Args:
            data: The user input data.
            worker: The worker instance for plan submission.
        """
        # Create plan to route user input to OBSERVATION channel
        p = AgenticPlan(scope=worker.prefix)
        input_label = f"INPUT_{str(uuid.uuid4())[:8]}"
        input_data = {
            "type": "USER",
            "content": data,
        }

        p.define_input(label=input_label, value=input_data)
        p.define_agent(
            name=self.name,
            label=self.name,
            properties={"inputs": DISABLED_INPUTS_OVERRIDE},
        )
        p.connect_input_to_agent(
            from_input=input_label,
            to_agent=self.name,
            to_agent_input="OBSERVATION",
        )
        p.submit(worker)
        logging.info("DEFAULT: Submitted plan for user input processing.")

    def _parse_and_store_observation(
        self,
        data: Any,
        data_memory: dict[str, Any],
        worker: Worker,
    ) -> tuple[str, str, Optional[str]]:
        """Parse observation data and store in memory if needed.

        Args:
            data: The observation data to parse.
            data_memory: The agent's data memory.
            worker: The worker instance for session management.

        Returns:
            Tuple of (observation_text, observation_type, memory_index).
        """
        observation = data

        # Extract observation type if available
        observation_type = "UNKNOWN"
        if isinstance(observation, dict):
            observation_type = observation.get("type", "UNKNOWN")
            if observation_type != "UNKNOWN":
                observation = observation.get("content", "")

        # Store in memory or truncate if needed
        memory_idx = None
        if observation_type not in ["USER", "SYSTEM"]:
            # Save the observation to memory
            memory_idx = f"${len(data_memory)}"
            data_memory[memory_idx] = observation
            worker.set_session_data("DATA_MEMORY", data_memory)
        elif len(observation) > MAX_OBSERVATION_LENGTH:
            observation = textwrap.shorten(
                observation,
                width=MAX_OBSERVATION_LENGTH,
                placeholder="... [truncated]",
            )
            logging.info(f"OBSERVATION: Truncated observation to: {observation}")

        return observation, observation_type, memory_idx

    def _should_prompt_for_user_confirmation(self, conversation_history: list[dict[str, str]]) -> bool:
        """Check if user confirmation is needed after consecutive actions.

        Args:
            conversation_history: The conversation history.

        Returns:
            True if confirmation prompt is needed, False otherwise.
        """
        MAX_CONSECUTIVE_ACTIONS = 3
        assistant_count = 0
        talk_to_user_count = 0
        for turn in reversed(conversation_history):
            if turn["role"] == "assistant" and '"action"' in turn["content"]:
                assistant_count += 1
                if "TALK_TO_USER" in turn["content"]:
                    talk_to_user_count += 1
            if assistant_count >= MAX_CONSECUTIVE_ACTIONS:
                break
        return talk_to_user_count == 0 and assistant_count >= MAX_CONSECUTIVE_ACTIONS

    def _handle_user_confirmation_prompt(
        self,
        response: ReActResponse,
        conversation_history: list[dict[str, str]],
        observation: str,
        observation_type: str,
        worker: Worker,
        properties: dict[str, Any],
    ) -> None:
        """Prompt user for confirmation when consecutive actions exceed threshold.

        Args:
            response: The original response before modification.
            conversation_history: The conversation history.
            observation: The observation text.
            observation_type: The type of observation.
            worker: The worker instance.
            properties: Agent properties including debug_mode.
        """
        _thought = response.thought
        _thought += " However, I have been suggesting actions without hearing back from the user. I should check if they would like to continue."
        _response = ReActResponse(
            thought=_thought,
            action={
                "name": "TALK_TO_USER",
                "arguments": {
                    "message": "I've suggested several actions without hearing back from you. Would you like to continue? Please respond with your input."
                },
            },
        )
        add_assistant_message(conversation_history, str(_response))
        worker.set_session_data("CONVERSATION_HISTORY", conversation_history)
        if observation_type not in ["USER", "SYSTEM"]:
            render_markdown(f"**Observation:** {observation}", worker)
        self._render_response(_response, conversation_history, worker, properties)

    def _render_response(
        self,
        response: ReActResponse,
        conversation_history: list[dict[str, str]],
        worker: Worker,
        properties: dict[str, Any],
    ) -> None:
        """Render the response to the user with optional debug information.

        Args:
            response: The response to render.
            conversation_history: The conversation history for debug output.
            worker: The worker instance.
            properties: Agent properties including debug_mode.
        """
        render_markdown(str(response), worker=worker)

    def _handle_observation_input(
        self,
        data: Any,
        stream_id: str,
        conversation_history: list[dict[str, str]],
        data_memory: dict[str, Any],
        worker: Worker,
        properties: dict[str, Any],
    ) -> Optional[list[Any]]:
        """Handle observation input from sub-agents.

        Parses observation, stores in memory, updates conversation history,
        generates next thought/action, and executes if needed.

        Args:
            data: The observation data.
            stream_id: The stream ID for logging.
            conversation_history: The conversation history.
            data_memory: The agent's data memory.
            worker: The worker instance.
            properties: Agent properties including debug_mode.
        """
        # Parse and store observation
        observation, observation_type, memory_idx = self._parse_and_store_observation(data, data_memory, worker)
        observation_text = textwrap.shorten(
            str(observation), width=MAX_OBSERVATION_LENGTH, placeholder="... [truncated]"
        )
        logging.info(f"OBSERVATION [{stream_id}]: Data: {observation}")

        # Add observation to conversation history
        if observation_type == "USER":
            add_user_message(conversation_history, observation_text)
        elif observation_type == "SYSTEM":
            add_assistant_message(conversation_history, observation_text)
        else:
            if memory_idx is not None:
                observation_text += f"\n\nThe full data has been saved to memory index {memory_idx}."
            add_assistant_message(
                conversation_history,
                f"I got the following output:\n\n{observation_text}",
            )

        # Generate next thought and action
        if properties.get("debug_mode", False):
            debug_text = (
                "**DEBUG INFO:**\n\n" + "````markdown\n" + conversation_history_to_str(conversation_history) + "\n````"
            )
            render_markdown(debug_text, worker=worker)
        response = self._think(conversation_history)

        # Check if user confirmation is needed
        if self._should_prompt_for_user_confirmation(conversation_history):
            return self._handle_user_confirmation_prompt(
                response, conversation_history, observation_text, observation_type, worker, properties
            )

        # Add response to conversation history
        add_assistant_message(conversation_history, str(response))
        worker.set_session_data("CONVERSATION_HISTORY", conversation_history)

        # Render the response
        self._render_response(response, conversation_history, worker, properties)

        # Handle TALK_TO_USER action
        if response.action["name"] == "TALK_TO_USER":
            return [response.action["arguments"]["message"], Message.EOS]

        # Execute the action (call sub-agent)
        return self._act(response.action, data_memory=data_memory, worker=worker)

    def _act(self, action: dict[str, Any], data_memory: dict[str, Any], worker: Worker) -> None:
        """Execute the specified action by orchestrating appropriate sub-agents.

        Args:
            action: Dictionary containing 'name' (agent to call) and 'arguments' (parameters).
            data_memory: The agent's data memory for storing/retrieving information.
            worker: The worker instance for plan submission and session management.
        """
        action_name = action.get("name")
        action_arguments = action.get("arguments", {})

        if not action_name:
            logging.error("No action name provided.")
            return

        logging.info(f"ACT: Executing action {action_name} with arguments {action_arguments}")

        # Handle RECIPE_RETRIEVAL action: fetch recipe and check for missing ingredients
        if action_name == "RECIPE_RETRIEVAL":
            p = AgenticPlan(scope=worker.prefix)

            input_label = f"INPUT_{str(uuid.uuid4())[:8]}"

            # Set up plan: input -> DISH_IDEATION -> RECIPE_RETRIEVAL -> OBSERVATION (back to this agent)
            # DISH_IDEATION will suggest dish names based on available ingredients
            # RECIPE_RETRIEVAL will fetch the recipe and check for missing ingredients
            p.define_input(label=input_label, value=action_arguments)
            p.define_agent(
                name="DISH_IDEATION",
                label="dish_ideation_agent",
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.define_agent(
                name="RECIPE_RETRIEVAL",
                label="recipe_retrieval_agent",
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.define_agent(
                name=self.name,
                label=self.name,
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.connect_input_to_agent(
                from_input=input_label,
                to_agent="dish_ideation_agent",
                to_agent_input="DEFAULT",
            )
            p.connect_agent_to_agent(
                from_agent="dish_ideation_agent",
                to_agent="recipe_retrieval_agent",
                to_agent_input="DEFAULT",
            )
            p.connect_agent_to_agent(
                from_agent="recipe_retrieval_agent",
                to_agent=self.name,
                to_agent_input="OBSERVATION",
            )
            p.submit(worker)
            logging.info("ACT: Submitted plan for recipe retrieval.")
            return

        if action_name == "FILTER_RECIPE":
            p = AgenticPlan(scope=worker.prefix)

            recipe_ref = action_arguments.get("recipe_ref", "")
            recipe_data: dict = data_memory.get(recipe_ref, "")

            logging.info(
                f"ACT: Filtering recipes from memory ref {recipe_ref} with data [{type(recipe_data)}] {str(recipe_data)[:300]}..."
            )

            dummy_input_label = f"INPUT_{str(uuid.uuid4())[:8]}"
            recipe_label = f"INPUT_{str(uuid.uuid4())[:8]}"

            # Set up plan: input -> FILTER_RECIPE -> OBSERVATION (back to this agent)
            p.define_input(label=dummy_input_label, value="TRIGGER")  # Dummy input to trigger presenter
            p.define_input(label=recipe_label, value=recipe_data)
            # Note: When properties["instructable"] of Presenter agent is True, any string input will trigger
            # the form presentation.
            p.define_agent(
                name="PRESENTER___BLUE_PLATE",
                label="presenter_form_agent",
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.define_agent(
                name="RECIPE_QUERY_EXECUTOR",
                label="recipe_query_executor_agent",
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.define_agent(
                name=self.name,
                label=self.name,
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.connect_input_to_agent(
                from_input=dummy_input_label,
                to_agent="presenter_form_agent",
                to_agent_input="DEFAULT",
            )
            p.connect_input_to_agent(
                from_input=recipe_label,
                to_agent="recipe_query_executor_agent",
                to_agent_input="RECIPES",
            )
            p.connect_agent_to_agent(
                from_agent="presenter_form_agent",
                to_agent="recipe_query_executor_agent",
                to_agent_input="FILTERS",
            )
            p.connect_agent_to_agent(
                from_agent="recipe_query_executor_agent",
                to_agent=self.name,
                to_agent_input="OBSERVATION",
            )
            p.submit(worker)
            logging.info("ACT: Submitted plan for recipe filtering.")
            return

        if action_name == "PRESENT_RECIPES":
            p = AgenticPlan(scope=worker.prefix)

            recipe_ref = action_arguments.get("recipe_ref", "")
            recipe_data = data_memory.get(recipe_ref, "")
            if isinstance(recipe_data, str):
                try:
                    recipe_data = json.loads(recipe_data)
                except:
                    logging.info(f"ACT: Invalid recipe data format for ref {recipe_ref}: {recipe_data}")
                    recipe_data = {}
            logging.info(f"ACT: Presenting recipes from memory ref {recipe_ref} with data [{type(recipe_data)}]...")
            logging.info(recipe_data)

            # Retrieve full recipe data
            recipe_id_to_full_recipe = {}
            for memory in data_memory.values():
                # Show the first 300 characters in memory
                logging.info(f"Checking memory item: {str(memory)[:300]}...")
                if isinstance(memory, str):
                    try:
                        memory = json.loads(memory)
                    except:
                        continue
                logging.info(f"Processing memory item: {type(memory)}")
                if not isinstance(memory, dict):
                    continue
                logging.info(f"Memory keys: {list(memory.keys())}")
                if "results" not in memory:
                    continue
                logging.info(f"Memory data: [{type(memory['results'])}] {str(memory['results'])[:300]}...")
                if not isinstance(memory["results"], list):
                    continue
                logging.info(f"First item in result: {str(memory['results'][0])[:300]}...")
                for result in memory["results"]:
                    if not isinstance(result, dict):
                        continue
                    for recipe in result.get("recipes", []):
                        r_id = recipe.get("recipe_id")
                        if not isinstance(r_id, int):
                            logging.warning(f"Invalid recipe_id format: {r_id} in recipe {recipe}")
                            continue
                        recipe_id_to_full_recipe[r_id] = recipe

            logging.info(
                f"Full recipe mapping: {list(recipe_id_to_full_recipe.keys())[:10]}... (total {len(recipe_id_to_full_recipe)})"
            )

            chosen_recipes = []
            if "result" not in recipe_data or not isinstance(recipe_data["result"], list):
                logging.info(f"ACT: Invalid recipe data format for ref {recipe_ref}: {recipe_data}")
                recipe_data["result"] = []
            for r in recipe_data["result"]:
                r_id = r["recipe_id"]
                if not isinstance(r_id, int):
                    logging.warning(f"Invalid recipe_id format: {r_id} in recipe {r}")
                    continue

                if r_id in recipe_id_to_full_recipe:
                    recipe = recipe_id_to_full_recipe[r_id]
                    recipe["instructions"] = r["instructions"]
                    chosen_recipes.append(recipe)
            logging.info(f"Chosen recipes: {chosen_recipes}")

            input_label = f"INPUT_{str(uuid.uuid4())[:8]}"
            if not chosen_recipes:
                input_data = "No recipes found that match those preferences."
                p.define_input(label=input_label, value=input_data)
                p.define_agent(
                    name=self.name,
                    label=self.name,
                    properties={"inputs": DISABLED_INPUTS_OVERRIDE},
                )
                p.connect_input_to_agent(
                    from_input=input_label,
                    to_agent=self.name,
                    to_agent_input="OBSERVATION",
                )
                p.submit(worker)
                return

            markdown_text = generate_markdown(chosen_recipes)
            input_data = {
                "type": "SYSTEM",  # Do not show the observation for this system message
                "content": markdown_text,
            }
            p.define_input(label=input_label, value=input_data)
            p.define_agent(
                name=self.name,
                label=self.name,
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.connect_input_to_agent(
                from_input=input_label,
                to_agent=self.name,
                to_agent_input="OBSERVATION",
            )
            p.submit(worker)

            # Show the markdown in the GUI as well
            render_markdown(markdown_text, worker)

        if action_name == "COOKING_IMAGE_GENERATOR":
            p = AgenticPlan(scope=worker.prefix)

            dish_name = action_arguments.get("dishName", "")
            description = action_arguments.get("description", "")
            ingredients = action_arguments.get("ingredients", [])
            instructions = action_arguments.get("instructions", [])
            logging.info(f"ACT: Generating cooking images for dish {dish_name}...")
            input_label = f"INPUT_{str(uuid.uuid4())[:8]}"
            input_data = json.dumps(
                {
                    "dishName": dish_name,
                    "description": description,
                    "ingredients": ingredients,
                    "instructions": instructions,
                }
            )
            p.define_input(label=input_label, value=input_data)
            p.define_agent(
                name="RECIPE_VISUALIZER",
                label="recipe_visualizer_agent",
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.define_agent(
                name=self.name,
                label=self.name,
                properties={"inputs": DISABLED_INPUTS_OVERRIDE},
            )
            p.connect_input_to_agent(
                from_input=input_label,
                to_agent="recipe_visualizer_agent",
                to_agent_input="DEFAULT",
            )
            p.connect_agent_to_agent(
                from_agent="recipe_visualizer_agent",
                to_agent=self.name,
                to_agent_input="OBSERVATION",
            )
            p.submit(worker)
            logging.info("ACT: Submitted plan for cooking image generation.")
        return

    def default_processor(
        self,
        message: Message,
        input: str = "DEFAULT",
        properties: Optional[dict[str, Any]] = None,
        worker: Optional[Worker] = None,
    ) -> Optional[list[Any]]:
        """Process messages based on input type.

        Routes messages to appropriate handlers based on input channel (DEFAULT for user,
        OBSERVATION for sub-agent results). Manages the thought-action-observation loop.

        Args:
            message: The message to process.
            input: The input channel type (DEFAULT for user, OBSERVATION for sub-agents).
            properties: Optional agent properties.
            worker: The worker instance for message processing.

        Returns:
            List containing response message and EOS marker, or None if no response.
        """
        logging.info(f"default_processor - input: {input}, message type: {message.content_type}")
        logging.info(message)

        if not worker:
            worker = self.create_worker(None)

        # Get stream ID
        stream_id = message.getStream()

        # Initialize properties if not provided
        properties = copy.deepcopy(properties) if properties else {}

        # Initialize conversation history in session data with system prompt
        if not worker.get_session_data("CONVERSATION_HISTORY"):
            conversation_history = []
            system_prompt_template = properties.get("system_prompt_template", DEFAULT_SYSTEM_PROMPT)
            agent_definitions = properties.get("agent_definitions", DEFAULT_AGENT_DEFINITIONS)
            agent_definitions_str = json.dumps(agent_definitions, indent=2)
            system_prompt = string_utils.safe_substitute(
                system_prompt_template, agent_definitions=agent_definitions_str
            )
            conversation_history.append({"role": "system", "content": system_prompt})
            worker.set_session_data("CONVERSATION_HISTORY", conversation_history)

        if not worker.get_session_data("DATA_MEMORY"):
            worker.set_session_data("DATA_MEMORY", {})

        # Retrieve existing conversation history from session
        conversation_history: list[dict[str, str]] = worker.get_session_data("CONVERSATION_HISTORY")  # type: ignore

        # Retrieve data memory from session
        data_memory: dict[str, Any] = worker.get_session_data("DATA_MEMORY")  # type: ignore

        # Handle stream control messages
        if message.isBOS():
            # Beginning of stream: initialize data buffer
            worker.set_data(f"stream_{self.name}_{input}", [])
            logging.info(f"{input}: Received BOS")
            return

        if message.isData():
            # Data message: append to buffer
            data = message.getData()
            worker.append_data(f"stream_{self.name}_{input}", data)
            logging.info(f"{input}: Received data: {data}")
            return

        if message.isEOS():
            # # End of stream: process accumulated data
            data = worker.get_data(f"stream_{self.name}_{input}")  # type: ignore

            if not isinstance(data, list):
                error_msg = f"Expected list data but got {type(data)}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            if len(data) != 1:
                error_msg = f"Expected single item in data list but got {len(data)} items: {data}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            data = data[0]
        else:
            return

        logging.info(f"{input}: Start processing data: {textwrap.shorten(str(data), width=100)}")

        # Route message based on input channel
        if input == "DEFAULT":  # Handle user input
            # First interaction: expect image input from user
            if not self.image_received:
                return self._handle_initial_image_input(data, worker, conversation_history)

            # Handle subsequent user text input (after image received)
            self._handle_user_text_input(data, worker)
            return

        elif input == "OBSERVATION":
            # Handle observation from sub-agents --> generate next thought and action
            return self._handle_observation_input(
                data, stream_id, conversation_history, data_memory, worker, properties
            )

        else:
            logging.warning(f"Unknown input type: {input}")

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="blue_plate", type=str)
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
            _class=ReactiveBluePlateAgent,
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
            a = ReactiveBluePlateAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = ReactiveBluePlateAgent(name=args.name, session=session, properties=properties)
        # wait for session
        if session:
            session.wait()
