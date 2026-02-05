###### Parsers, Formats, Utils
import argparse
import json
import logging
import re
import time

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.session import Session
from blue.stream import Message
from blue.utils import string_utils, json_utils

###### Dish Ideation Agent
from typing import Optional
import asyncio
import copy


# Set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

# Default prompts for dish ideation and deduplication
DEFAULT_IDEATION_SYSTEM_PROMPT = """${persona}

Task:
Given the available ingredients, brainstorm diverse, appealing dish names that a home cook could plausibly make primarily using the provided ingredients. It's acceptable to omit some listed ingredients and to assume a small number of widely available pantry items (e.g., salt, pepper, oil). It's also acceptable to introduce a small number of easy-to-purchase grocery items (e.g., pasta, tortillas, canned tomatoes, cheese, stock) when reasonable; avoid niche or hard-to-find ingredients.

Requirements:
- Generate exactly ${n_candidates_per_persona} unique dish names.
- Emphasize diversity across techniques, and meal types (e.g., stir-fry, soup, salad, bowl, bake, sandwich, pasta, rice dish), and across which subset of ingredients is used.
- Do not attempt to use all listed ingredients in each dish; vary the subset used, including some ideas that focus on only a few key ingredients.
- Names should be concise (2–7 words), specific, and enticing.
- Avoid duplicates or near-duplicates; avoid vague names ("Tasty Dinner") and brand names.
- Do not include explanations or additional text.

Output format:
Return a JSON array of exactly ${n_candidates_per_persona} strings (dish names only), with no trailing commentary or extra keys."""
DEFAULT_IDEATION_USER_PROMPT = "You have the following ingredients available: ${input}"

DEFAULT_DEDUPLICATE_SYSTEM_PROMPT = """Goal:
From multiple persona-generated lists of dish names, produce a single, normalized, diverse, and deduplicated set with short descriptions.

Input:
- A JSON array of dish name strings (potentially with duplicates or near-duplicates).

Rules:
- Deduplicate aggressively by both name similarity and concept similarity (e.g., "Garlic Chicken Fried Rice" vs. "Garlicky Chicken and Rice Stir-Fry" → keep one).
- Prefer the name that is clearer, more specific, and broadly appealing; avoid overly niche or verbose variants.
- Normalize names:
  - Title Case.
  - 2–7 words.
  - Use "and" instead of "&".
  - No emojis, brand names, or parenthetical qualifiers.
- Encourage variety:
  - Balance across cuisines and techniques (e.g., stir-fry, soup, salad, bowl, bake, sandwich, pasta, rice dish).
- For each retained name, generate a concise short_description (1–2 sentences) that conveys the dish's core idea and typical flavor/technique. Do not include brand names or health claims.

Output format:
- Return a JSON array of up to ${max_n_candidates} objects.
- Each object: {"name": "<dish name>", "short_description": "<1–2 sentences>"}
- No extra keys, comments, or trailing text."""
DEFAULT_DEDUPLICATE_USER_PROMPT = "Here is the list of dish names: ${input}"

# Response format
DEFAULT_IDEATION_RESPONSE_FORMAT = {
    "type": "json_schema",
    "json_schema": {
        "name": "dish_name_list",
        "schema": {
            "type": "object",
            "properties": {
                "dish_names": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "A list of dish names generated based on the provided ingredients.",
                }
            },
            "required": ["dish_names"],
            "additionalProperties": False,
        },
        "strict": True,
    },
}
DEFAULT_DEDUPLICATION_RESPONSE_FORMAT = {
    "type": "json_schema",
    "json_schema": {
        "name": "dish_name_list",
        "schema": {
            "type": "object",
            "properties": {
                "dish_ideas": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "properties": {
                            "name": {"type": "string"},
                            "short_description": {"type": "string"},
                        },
                        "required": ["name", "short_description"],
                        "additionalProperties": False,
                    },
                    "description": "A list of deduplicated and normalized dish names with short descriptions.",
                }
            },
            "required": ["dish_ideas"],
            "additionalProperties": False,
        },
        "strict": True,
    },
}

# Default personas for diverse dish ideation
DEFAULT_PERSONAS = [
    "You're a Japanese home cook who prioritizes umami-rich, mild flavors.",
    "You're a Mexican street-food lover who favors bold but approachable flavors.",
    "You're an Indian vegetarian who prefers mild-to-medium spice and pantry-friendly staples.",
    "You're a busy parent with three kids and only 20 minutes to cook on weeknights.",
    "You're a college student on a tight budget cooking with just a stovetop and microwave.",
    "You're a health-conscious athlete seeking high-protein, low-carb meals.",
    "You're a beginner cook who wants one-pan, five-ingredient recipes with minimal prep.",
]

# Default values
DEFAULT_MAX_CONCURRENT_REQUESTS = 10  # Maximum concurrent API requests
DEFAULT_MAX_N_CANDIDATES = 16  # Maximum number of candidate dish ideas to return
DEFAULT_N_CANDIDATES_PER_PERSONA = 10  # Number of candidates to generate per persona


def strip_markdown_code_blocks(text: str) -> str:
    """Strip markdown code blocks from the given text."""
    text = text.strip()
    r_code_block = re.compile(r"```[a-zA-Z0-9]*\n(.*?)```", re.DOTALL)
    match = r_code_block.search(text)
    if match:
        text = match.group(1)
        return text.strip()
    return text


############################
### Agent.DishIdeationAgent
#
class DishIdeationAgent(OpenAIAgent):
    """
    Agent that generates diverse dish name candidates from available ingredients.

    Uses persona fan-out to generate varied ideas, then deduplicates and normalizes
    the results into a final candidate set with short descriptions.

    Properties (in addition to OpenAIAgent properties):
    ----------
    | Name                                   | Type        | Default                                | Description                                                                 |
    |----------------------------------------|-------------|----------------------------------------|-----------------------------------------------------------------------------|
    | `n_candidates_per_persona`             | `int`       | `DEFAULT_N_CANDIDATES_PER_PERSONA`     | Number of dish names generated per persona.                                 |
    | `max_n_candidates`                     | `int`       | `DEFAULT_MAX_N_CANDIDATES`             | Maximum number of final deduplicated dish ideas to return.                 |
    | `max_concurrent_requests`              | `int`       | `DEFAULT_MAX_CONCURRENT_REQUESTS`      | Maximum concurrent API calls during persona fan-out.                       |
    | `ideation_personas`                    | `list[str]` | `DEFAULT_PERSONAS`                     | List of culinary personas used for diverse generation.                      |
    | `ideation_system_prompt_template`      | `str`       | `DEFAULT_IDEATION_SYSTEM_PROMPT`       | Instructions for persona-based generation.                                  |
    | `ideation_user_prompt_template`        | `str`       | `DEFAULT_IDEATION_USER_PROMPT`         | User prompt template for ideation.                                          |
    | `deduplication_system_prompt_template` | `str`       | `DEFAULT_DEDUPLICATE_SYSTEM_PROMPT`    | Instructions for merging and normalization.                                 |
    | `deduplication_user_prompt_template`   | `str`       | `DEFAULT_DEDUPLICATE_USER_PROMPT`      | User prompt template for deduplication.                                     |
    | `ideation_response_format`             | `dict`      | `DEFAULT_IDEATION_RESPONSE_FORMAT`     | JSON schema definition for structured dish name list.                       |
    | `deduplication_response_format`        | `dict`      | `DEFAULT_DEDUPLICATION_RESPONSE_FORMAT`| JSON schema definition for final dish ideas with descriptions.              |

    Inputs:
    - DEFAULT: JSON object containing an "ingredients" key with a list of ingredients.

    Outputs:
    - DEFAULT: JSON object containing "dish_ideas", which is a list of candidate dish objects.
    """

    def __init__(self, **kwargs):
        if "name" not in kwargs:
            kwargs["name"] = "DISH_IDEATION"
        super().__init__(**kwargs)

    def create_message(self, input_data, properties=None, additional_data=None):
        """Create message to send to service based on input data and properties.
        Overrides ServiceClient.create_message to support system prompt substitution and injection.

        Parameters:
            input_data: Input data to create the message.
            properties: Optional properties to override.
            additional_data: Additional data to be used for creating the message.

        Returns:
            Created message.
        """
        # Get properties (overridden with provided properties)
        props = self.get_properties(properties=properties)

        # 1. Prepare system prompt if template is provided
        system_prompt = None
        if "system_prompt_template" in props and props["system_prompt_template"]:
            template = props["system_prompt_template"]

            # Use additional_data for substitution if provided, along with properties
            data = {}
            if additional_data:
                data.update(additional_data)

            # Substitute placeholders in system prompt template
            system_prompt = string_utils.safe_substitute(template, **props, **data)

        # 2. Call super to create basic message structure and inject user input
        message = super().create_message(input_data, properties, additional_data)

        # 3. Inject system prompt into message if system_context exists
        if system_prompt and "system_context" in props:
            # Extract the input object (usually message['messages'])
            input_field = props["input_field"]
            input_object = message[input_field]

            # Use default 'content' field if not specified, or maybe we should reuse input_context_field?
            # ServiceClient uses 'input_context_field' for user_prompt.
            # OpenAI messages standard is 'content'.
            context_field = "content"

            # Inject system prompt at system_context path (e.g. "$[0]")
            json_utils.json_query_set(
                input_object,
                context_field,
                system_prompt,
                context=props["system_context"],
            )

        return message

    async def _call_ideation_for_persona(
        self,
        persona: str,
        ingredients: list[str],
        semaphore: Optional[asyncio.Semaphore] = None,
        properties: Optional[dict] = None,
    ) -> list[str]:
        """
        Generate dish name candidates for a single persona (async).

        Args:
            persona: Persona description
            ingredients: List of available ingredients
            semaphore: Optional semaphore to limit concurrent requests
            properties: Optional properties for API calls

        Returns:
            List of dish name strings
        """
        start_time = time.time()

        api_properties = copy.deepcopy(properties) if properties else {}

        logging.info(f"[PERF] Starting ideation API call for persona: {persona[:50]}...")

        # User prompt with a placeholder for ingredients ${input}
        input_template = api_properties.get("ideation_user_prompt_template", DEFAULT_IDEATION_USER_PROMPT)
        api_properties["input_template"] = input_template
        input_data = json.dumps(ingredients)

        # System prompt template with persona and n_candidates
        system_prompt_template = api_properties.get("ideation_system_prompt_template", DEFAULT_IDEATION_SYSTEM_PROMPT)
        api_properties["system_prompt_template"] = system_prompt_template
        ## These values will replace placeholders in the system prompt template
        ## persona -> ${persona}
        additional_data = {"persona": persona}

        # Set response format
        api_properties["openai.response_format"] = api_properties.get(
            "ideation_response_format", DEFAULT_IDEATION_RESPONSE_FORMAT
        )

        # Set default values if not provided
        if "n_candidates_per_persona" not in api_properties:
            api_properties["n_candidates_per_persona"] = DEFAULT_N_CANDIDATES_PER_PERSONA

        # Call OpenAI API directly using create_message, get_service_address, and async_call_service
        try:
            message_create_start = time.time()
            logging.info("[PERF] Creating message for API call...")
            # Create message with user prompt and system prompt substitution
            message = self.create_message(
                input_data,
                properties=api_properties,
                additional_data=additional_data,
            )
            logging.info(f"[PERF] Message created in {time.time() - message_create_start:.2f}s")

            api_call_start = time.time()
            url = self.get_service_address(properties=api_properties)
            logging.info(f"[PERF] Calling ideation API at {url}...")

            # Use semaphore to limit concurrent requests if provided
            if semaphore:
                async with semaphore:
                    r = await self.async_call_service(url, message)
            else:
                r = await self.async_call_service(url, message)

            logging.info(f"[PERF] Ideation API call completed in {time.time() - api_call_start:.2f}s")
            response_json = json.loads(r)

            logging.info(f"Response status: {response_json.get('status')}")

            if response_json.get("status") == "success":
                # Extract inner data and use standard processing
                api_response_data = response_json.get("data", {})

                output = self.create_output(api_response_data, properties=api_properties)
                output = self.process_output(output, properties=api_properties)

                logging.info(f"Received response from API (first 200 chars): {str(output)[:200]}")

                # Parse JSON response
                candidates: list[str] = json.loads(output)["dish_names"]

                if not isinstance(candidates, list):
                    logging.error(f"Expected list from ideation, got {type(candidates)}")
                    return []

                logging.info(f"Successfully parsed {len(candidates)} candidates from response")
                logging.info(f"[PERF] Total time for persona ideation: {time.time() - start_time:.2f}s")
                return candidates
            else:
                logging.error(f"API call failed with status: {response_json.get('status')}")
                logging.error(f"Error: {response_json.get('error')}")
                return []

        except json.JSONDecodeError as e:
            logging.error(f"Failed to parse JSON from ideation response: {e}")
            logging.error(f"Response was: {output if 'output' in locals() else r}")
            logging.info(f"[PERF] Failed after {time.time() - start_time:.2f}s")
            return []
        except Exception as e:
            logging.error(f"Error calling ideation for persona: {e}")
            import traceback

            logging.error(f"Traceback: {traceback.format_exc()}")
            logging.info(f"[PERF] Failed after {time.time() - start_time:.2f}s")
            return []

    def _generate_all_candidates(self, ingredients: list[str], properties: Optional[dict] = None) -> list[str]:
        """
        Generate candidates from all personas using parallel execution (fan-out).

        Uses asyncio to make truly concurrent API calls for each persona,
        significantly reducing total execution time compared to sequential processing.
        The async approach allows WebSocket connections to operate concurrently without blocking.
        Uses a semaphore to limit the number of concurrent requests to avoid overwhelming the service.

        Args:
            ingredients: List of available ingredients
            properties: Optional dictionary of agent properties

        Returns:
            Combined list of all dish name candidates from all personas
        """
        if properties is None:
            properties = {}

        start_time = time.time()

        # Run async tasks concurrently using asyncio.gather with semaphore control
        all_results = asyncio.run(self._async_generate_all_candidates(ingredients, properties=properties))

        # Flatten results
        all_candidates = []
        for candidates in all_results:
            if candidates:
                all_candidates.extend(candidates)

        logging.info(f"[PERF] All personas completed in {time.time() - start_time:.2f}s")
        logging.info(f"Total candidates from all personas: {len(all_candidates)}")
        return all_candidates

    async def _async_generate_all_candidates(
        self,
        ingredients: list[str],
        properties: Optional[dict] = None,
    ) -> list[list[str]]:
        """
        Async helper to generate candidates from all personas concurrently.

        Args:
            ingredients: List of available ingredients
            properties: Properties for API calls

        Returns:
            List of candidate lists (one per persona)
        """
        if properties is None:
            properties = {}

        # Maximum number of concurrent API requests
        max_concurrent: int = properties.get("max_concurrent_requests", DEFAULT_MAX_CONCURRENT_REQUESTS)

        # Create semaphore to limit concurrent requests
        semaphore = asyncio.Semaphore(max_concurrent)

        # Create tasks for all personas with semaphore control
        personas: list[str] = properties.get("ideation_personas", DEFAULT_PERSONAS)
        tasks = [
            self._call_ideation_for_persona(persona, ingredients, semaphore, properties=properties)
            for persona in personas
        ]

        # Execute all tasks concurrently and gather results
        # Semaphore ensures only max_concurrent requests run at the same time
        # If any task fails, it returns an empty list due to exception handling in _call_ideation_for_persona
        results = await asyncio.gather(*tasks, return_exceptions=True)

        # Handle exceptions
        processed_results = []
        for idx, result in enumerate(results, 1):
            if isinstance(result, Exception):
                logging.error(f"[PERF] Persona {idx}/{len(personas)} failed with error: {result}")
                processed_results.append([])
            else:
                processed_results.append(result)

        return processed_results

    def _deduplicate_and_normalize(self, all_candidates: list[str], properties: Optional[dict] = None) -> list[dict]:
        """
        Deduplicate and normalize candidates with descriptions.

        Args:
            all_candidates: List of dish name strings from all personas

        Returns:
            List of dicts with 'name' and 'short_description' keys
        """
        start_time = time.time()
        logging.info(f"[PERF] Starting deduplication of {len(all_candidates)} candidates...")

        api_properties = copy.deepcopy(properties) if properties else {}

        # User prompt with placeholder for dish names ${input}
        input_template = api_properties.get("deduplication_user_prompt_template", DEFAULT_DEDUPLICATE_USER_PROMPT)
        api_properties["input_template"] = input_template
        input_data = json.dumps(all_candidates)

        # System prompt template with placeholders
        api_properties["system_prompt_template"] = api_properties.get(
            "deduplication_system_prompt_template", DEFAULT_DEDUPLICATE_SYSTEM_PROMPT
        )

        # Set response format
        api_properties["openai.response_format"] = api_properties.get(
            "deduplication_response_format", DEFAULT_DEDUPLICATION_RESPONSE_FORMAT
        )

        # Set default values if not provided
        if "max_n_candidates" not in api_properties:
            api_properties["max_n_candidates"] = DEFAULT_MAX_N_CANDIDATES

        try:
            api_start = time.time()
            logging.info("[PERF] Calling deduplication API...")

            message = self.create_message(input_data, properties=api_properties)

            logging.info(f"[PERF] Message for deduplication: {message}")

            dedup_api_call_start = time.time()
            url = self.get_service_address(properties=api_properties)
            logging.info(f"[PERF] Calling deduplication API at {url}...")
            r = self.call_service(url, message)
            logging.info(f"[PERF] Deduplication API call completed in {time.time() - dedup_api_call_start:.2f}s")
            response_json = json.loads(r)

            logging.info(f"Dedup response status: {response_json.get('status')}")

            if response_json.get("status") == "success":
                # Extract inner data and use standard processing
                api_response_data = response_json.get("data", {})

                output = self.create_output(api_response_data, properties=api_properties)
                output = self.process_output(output, properties=api_properties)

                logging.info(f"Received deduplication response (first 200 chars): {str(output)[:200]}")

                # Parse JSON response
                final_candidates: list[dict] = json.loads(output)["dish_ideas"]

                if not isinstance(final_candidates, list):
                    logging.error(f"Expected list from deduplication, got {type(final_candidates)}")
                    return []

                # Validate structure
                for candidate in final_candidates:
                    if (
                        not isinstance(candidate, dict)
                        or "name" not in candidate
                        or "short_description" not in candidate
                    ):
                        logging.error(f"Invalid candidate structure: {candidate}")
                        return []

                logging.info(f"Deduplicated to {len(final_candidates)} final candidates")
                logging.info(f"[PERF] Total deduplication time: {time.time() - start_time:.2f}s")
                return final_candidates
            else:
                logging.error(f"Dedup API call failed with status: {response_json.get('status')}")
                logging.error(f"Error: {response_json.get('error')}")
                return []

        except json.JSONDecodeError as e:
            logging.error(f"Failed to parse JSON from deduplication response: {e}")
            logging.error(f"Response was: {output if 'output' in locals() else r}")
            logging.info(f"[PERF] Deduplication failed after {time.time() - start_time:.2f}s")
            return []
        except Exception as e:
            logging.error(f"Error during deduplication: {e}")
            import traceback

            logging.error(f"Traceback: {traceback.format_exc()}")
            logging.info(f"[PERF] Deduplication failed after {time.time() - start_time:.2f}s")
            return []

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        """
        Process incoming messages for dish ideation.

        BOS: Initialize stream state
        DATA: Accumulate ingredient data
        EOS: Parse ingredients, generate candidates, deduplicate, and return results
        """

        if input != "DEFAULT":
            return None

        if message.isEOS():
            total_start_time = time.time()
            logging.info("[PERF] ========== Starting dish ideation processing ==========")

            # Retrieve accumulated stream data
            stream_data = []
            if worker:
                stream_data = worker.get_data("stream_data")

            if not isinstance(stream_data, list) or len(stream_data) != 1:
                error_msg = "Error: Expected a single JSON object of ingredients"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

            stream_data = stream_data[0]  # Get the single JSON object

            # If `stream_data` is a string, parse it as JSON
            if isinstance(stream_data, str):
                try:
                    stream_data = json.loads(stream_data)
                except Exception as e:
                    error_msg = f"Error: Failed to parse JSON input: {str(e)}"
                    logging.error(error_msg)
                    return [{"error": error_msg}, Message.EOS]

            if not isinstance(stream_data, dict) or "ingredients" not in stream_data:
                error_msg = 'Error: JSON object must contain an "ingredients" key with a list of ingredients'
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

            logging.info(f"Processing ingredients: {stream_data}")

            # Extract ingredients
            ingredients: list[str] = stream_data["ingredients"]
            if not isinstance(ingredients, list) or not all(isinstance(ing, str) for ing in ingredients):
                error_msg = f"Error: 'ingredients' must be a list of strings. Got: {ingredients}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            if len(ingredients) == 0:
                error_msg = "Error: No ingredients provided"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

            try:
                # Step 1: Generate candidates from all personas
                logging.info("Step 1: Generating candidates from personas...")
                all_candidates = self._generate_all_candidates(ingredients, properties=properties)

                if len(all_candidates) == 0:
                    error_msg = "Error: Failed to generate any candidates from personas"
                    logging.error(error_msg)
                    return [{"error": error_msg}, Message.EOS]

                # Step 2: Deduplicate and normalize
                logging.info("Step 2: Deduplicating and normalizing candidates...")
                final_candidates = self._deduplicate_and_normalize(all_candidates)

                if len(final_candidates) == 0:
                    error_msg = "Error: Failed to deduplicate and normalize candidates"
                    logging.error(error_msg)
                    return [{"error": error_msg}, Message.EOS]

                # Return final output
                output = []
                for candidate in final_candidates:
                    candidate["ingredient_list"] = ingredients
                    output.append(candidate)
                logging.info(f"Successfully generated {len(final_candidates)} dish candidates")
                logging.info(
                    f"[PERF] ========== Total processing time: {time.time() - total_start_time:.2f}s =========="
                )

                return [{"dish_ideas": output}, Message.EOS]

            except Exception as e:
                error_msg = f"Error processing dish ideation: {str(e)}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

        elif message.isBOS():
            # Initialize stream to empty array
            if worker:
                worker.set_data("stream_data", [])

        elif message.isData():
            # Accumulate data values
            data = message.getData()
            logging.info(f"Received data: {data} (type: {type(data)})")

            if worker:
                worker.append_data("stream_data", data)

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="DISH_IDEATION", type=str)
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
            _class=DishIdeationAgent,
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
            a = DishIdeationAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = DishIdeationAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()
