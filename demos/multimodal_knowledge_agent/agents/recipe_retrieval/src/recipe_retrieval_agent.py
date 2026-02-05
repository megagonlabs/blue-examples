"""
Recipe Retrieval Agent for Blue Plate.

This agent queries a ChromaDB-based vector database to retrieve
similar recipes based on a query string.
"""

###### Parsers, Formats, Utils
import argparse
import copy
import logging
import json
from typing import Any, Optional

###### HTTP Client
import requests

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.session import Session
from blue.stream import Message

# Set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(
    format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d]"
    "(%(filename)s:%(lineno)d) %(name)s -  %(message)s",
    level=logging.ERROR,
    datefmt="%Y-%m-%d %H:%M:%S",
)

# Default prompt and response format for missing ingredient detection
DEFAULT_MISSING_INGREDIENT_DETECTION_PROMPT = """Compare the provided ingredients with the recipe's required ingredients and identify which recipe ingredients are NOT available (missing).

Provided ingredients: ${input}
Recipe requires: ${recipe_ingredients}

Instructions:
- Identify ALL ingredients from the recipe that are NOT in the provided list
- Consider common substitutions and variations (e.g., "egg" matches "eggs", "red bell pepper" matches "bell peppers")
- Include ALL missing ingredients, even common pantry items like salt, pepper, oil, butter
- Return ONLY a JSON array of missing ingredient names
- If nothing is missing, return empty array []

Output format: ["ingredient1", "ingredient2", ...]"""
DEFAULT_MISSING_INGREDIENT_DETECTION_RESPONSE_FORMAT = {
    "type": "json_schema",
    "json_schema": {
        "name": "missing_ingredient_detection",
        "schema": {
            "type": "object",
            "properties": {
                "missing_ingredients": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "A list of missing ingredients",
                }
            },
            "required": ["missing_ingredients"],
            "additionalProperties": False,
        },
        "strict": True,
    },
}

# Default values
DEFAULT_CHROMADB_URL = "http://host.docker.internal:8000"
DEFAULT_CHROMADB_TIMEOUT = 30
DEFAULT_CHROMADB_SOURCE = None
DEFAULT_TOPK = 1


class RecipeRetrievalAgent(OpenAIAgent):
    """
    Agent that retrieves recipes from a ChromaDB vector database.

    This agent accepts a query string (e.g., dish name or ingredient),
    queries the ChromaDB API, and returns matching recipes with their
    recipe_id, dish_name, and ingredients.

    Also uses OpenAI to detect missing ingredients when input ingredients
    are provided.
    """

    def __init__(self, **kwargs: Any) -> None:
        """
        Initialize the RecipeRetrievalAgent.

        Args:
            **kwargs: Keyword arguments passed to the parent Agent class.
        """
        if "name" not in kwargs:
            kwargs["name"] = "RECIPE_RETRIEVAL"
        super().__init__(**kwargs)

    def _query_chromadb(self, query: str, top_k: int | None = None, source: str | None = None) -> list[dict[str, Any]]:
        """
        Query the ChromaDB vector database for similar recipes.

        Args:
            query: The search query (e.g., dish name or ingredient).
            top_k: Number of results to return. Uses property default if None.
            source: Optional source filter for the recipes.

        Returns:
            List of recipe dictionaries containing recipe_id, dish_name,
            and ingredients.

        Raises:
            requests.RequestException: If the API request fails.
        """
        chromadb_url = self.properties.get("chromadb_url", DEFAULT_CHROMADB_URL)
        timeout = self.properties.get("timeout", DEFAULT_CHROMADB_TIMEOUT)

        if top_k is None:
            top_k = self.properties.get("top_k", DEFAULT_TOPK)

        if source is None:
            source = self.properties.get("source", DEFAULT_CHROMADB_SOURCE)

        # Build request payload
        payload = {
            "query": query,
            "top_k": top_k,
            "source": source,
        }

        # Try multiple URL configurations with fallback
        urls_to_try = [chromadb_url]

        # Add fallback URLs if using default host.docker.internal
        if "host.docker.internal" in chromadb_url:
            # Add Docker bridge network gateway as fallback
            fallback_url = chromadb_url.replace("host.docker.internal", "172.17.0.1")
            urls_to_try.append(fallback_url)

            # Add host network gateway as another fallback
            fallback_url2 = chromadb_url.replace("host.docker.internal", "host-gateway")
            urls_to_try.append(fallback_url2)

        last_error = None
        for url in urls_to_try:
            endpoint = f"{url}/query"
            logging.info(f"Attempting to query ChromaDB at {endpoint} with payload: {payload}")

            try:
                response = requests.post(
                    endpoint,
                    json=payload,
                    timeout=timeout,
                )
                response.raise_for_status()

                result = response.json()
                logging.info(
                    f"Successfully connected to {url}. "
                    f"Received {len(result) if isinstance(result, list) else 1} "
                    "results from ChromaDB"
                )

                # Update property to use successful URL for future requests
                if url != chromadb_url:
                    logging.info(f"Updating chromadb_url from {chromadb_url} to {url}")
                    self.properties["chromadb_url"] = url

                return self._extract_recipe_info(result)

            except requests.exceptions.ConnectionError as e:
                last_error = e
                logging.warning(f"Failed to connect to {url}: {e}. Trying next URL...")
                continue
            except requests.exceptions.Timeout as e:
                last_error = e
                logging.warning(f"Request to {url} timed out after {timeout}s: {e}. Trying next URL...")
                continue
            except requests.exceptions.RequestException as e:
                last_error = e
                logging.warning(f"Request to {url} failed: {e}. Trying next URL...")
                continue

        # All URLs failed
        error_msg = (
            f"Failed to connect to ChromaDB after trying {len(urls_to_try)} "
            f"URL(s): {urls_to_try}. "
            f"Last error: {last_error}. "
            "Please check:\n"
            "1. ChromaDB server is running\n"
            "2. Docker network configuration (use --add-host or --network host)\n"
            "3. Set CHROMADB_URL environment variable to correct host"
        )
        logging.error(error_msg)
        raise requests.exceptions.ConnectionError(error_msg)

    def _extract_recipe_info(self, api_response: dict[str, Any] | list[dict[str, Any]]) -> list[dict[str, Any]]:
        """
        Extract recipe_id, dish_name, and ingredients from API response.

        Args:
            api_response: The raw response from the ChromaDB API.

        Returns:
            List of dictionaries with recipe_id, dish_name, and ingredients.
        """
        recipes = []

        # Handle both list and dict responses
        if isinstance(api_response, dict):
            # If response has a "results" or "data" key, use that
            if "results" in api_response:
                items = api_response["results"]
            elif "data" in api_response:
                items = api_response["data"]
            else:
                items = [api_response]
        else:
            items = api_response

        for item in items:
            # Check if data is nested in a "document" field (ChromaDB format)
            if "document" in item:
                item = item["document"]

            recipe = {}

            # Extract recipe_id (try common field names)
            recipe["recipe_id"] = item.get("recipe_id") or item.get("id") or item.get("_id") or "unknown"

            # Extract dish_name (try common field names)
            recipe["dish_name"] = (
                item.get("dish_name") or item.get("name") or item.get("title") or item.get("dish") or "unknown"
            )

            # Extract ingredients (try common field names)
            ingredients = item.get("ingredients") or item.get("ingredient_list") or item.get("ingredient") or []

            # Ensure ingredients is a list
            if isinstance(ingredients, str):
                # Try to parse as JSON, otherwise split by comma
                try:
                    ingredients = json.loads(ingredients)
                except json.JSONDecodeError:
                    ingredients = [ing.strip() for ing in ingredients.split(",") if ing.strip()]

            recipe["ingredients"] = ingredients
            recipes.append(recipe)

        return recipes

    def _detect_missing_ingredients(
        self, input_ingredients: list[str], recipe_ingredients: list[str], properties: Optional[dict] = None
    ) -> dict[str, list[str]]:
        """
        Use OpenAI to detect which recipe ingredients are missing from input.

        Args:
            input_ingredients: List of ingredients provided by user.
            recipe_ingredients: List of ingredients required by recipe.
            properties: Optional properties for the OpenAI call.

        Returns:
            List of missing ingredient names.
        """
        logging.info(f"Input ingredients: {input_ingredients}")
        logging.info(f"Recipe ingredients: {recipe_ingredients}")
        if not input_ingredients or not recipe_ingredients:
            return {"missing_ingredients": []}

        call_properties = copy.deepcopy(properties) if properties else {}
        additional_data = {}

        # Build prompt for API Call
        ## ${input} will be replaced with input data
        call_properties["input_template"] = call_properties.get(
            "missing_ingredient_detection_prompt_template", DEFAULT_MISSING_INGREDIENT_DETECTION_PROMPT
        )

        # Set response format for API Call
        call_properties["openai.response_format"] = call_properties.get(
            "missing_ingredient_detection_response_format", DEFAULT_MISSING_INGREDIENT_DETECTION_RESPONSE_FORMAT
        )

        # Prepare input data
        input_data = ", ".join(input_ingredients)

        # Prepare recipe ingredients string
        additional_data["recipe_ingredients"] = ", ".join(recipe_ingredients)

        try:
            output = self.execute_api_call(input_data, properties=call_properties, additional_data=additional_data)

            # Parse JSON array
            missing: dict[str, list[str]] = json.loads(output)

            logging.info(f"Detected {len(missing['missing_ingredients'])} missing ingredients")
            return missing

        except json.JSONDecodeError as e:
            logging.error(f"Failed to parse JSON from OpenAI response: {e}")
            return {"missing_ingredients": []}
        except Exception as e:
            logging.error(f"Error detecting missing ingredients: {e}")
            import traceback

            logging.error(f"Traceback: {traceback.format_exc()}")
            return {"missing_ingredients": []}

    def _validate_ingredient_list(self, ingredient_list: Any) -> list[str]:
        """Validate the ingredient_list field.

        Args:
            ingredient_list: The value to validate.

        Returns:
            Validated list of ingredients.

        Raises:
            ValueError: If the value is invalid.
        """
        if not isinstance(ingredient_list, list):
            raise ValueError("Field 'ingredient_list' must be an array")
        for idx, item in enumerate(ingredient_list):
            if not isinstance(item, str):
                raise ValueError(f"Item at index {idx} in 'ingredient_list' must be a string")
        return ingredient_list

    def _validate_topk_override(self, top_k_value: Any) -> int:
        """Validate the top_k override value.

        Args:
            top_k_value: The value to validate.

        Returns:
            Validated top_k integer.

        Raises:
            ValueError: If the value is invalid.
        """
        if not isinstance(top_k_value, int):
            raise ValueError("Field 'top_k' must be an integer")
        if top_k_value < 1:
            raise ValueError("Field 'top_k' must be >= 1")
        if top_k_value > 20:
            raise ValueError("Field 'top_k' must be <= 20")
        return top_k_value

    def _validate_dish_idea(self, dish_idea: Any) -> dict[str, Any]:
        """Validate a single dish idea object.

        Args:
            dish_idea: The dish idea to validate.

        Returns:
            Validated dish idea dictionary.

        Raises:
            ValueError: If the dish idea is invalid.
        """
        if not isinstance(dish_idea, dict):
            raise ValueError("Each dish idea must be a JSON object")

        # Validate dish_name
        dish_name = dish_idea.get("name")
        if not dish_name or not isinstance(dish_name, str):
            raise ValueError("Field 'name' is required and must be a string")

        # Validate optional ingredient_list
        ingredient_list = dish_idea.get("ingredient_list", [])
        if ingredient_list:
            ingredient_list = self._validate_ingredient_list(ingredient_list)

        validated_idea = {
            "dish_name": dish_name,
            "ingredient_list": ingredient_list,
        }

        # Validate optional top_k override
        top_k_value = dish_idea.get("top_k")
        if top_k_value is not None:
            top_k_value = self._validate_topk_override(top_k_value)
            validated_idea["top_k"] = top_k_value

        return validated_idea

    def default_processor(
        self,
        message: Message,
        input: str = "DEFAULT",
        properties: Optional[dict[str, Any]] = None,
        worker: Optional[Any] = None,
    ) -> list[Any] | None:
        """
        Process incoming messages for recipe retrieval.

        Accepts input formats:
        1. Plain text: "egg sandwich"
        2. JSON array: [{"dish_name": "...", "ingredient_list": [...]}, ...]

        Message types:
            - BOS: Initialize stream state
            - DATA: Accumulate query data
            - EOS: Execute query and return results

        Args:
            message: The incoming message to process.
            input: The input stream identifier.
            properties: Optional properties for processing.
            worker: The worker context for state management.

        Returns:
            List containing results and EOS message, or None for
            intermediate processing.
        """
        if input != "DEFAULT":
            return None

        if message.isEOS():
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

            if not isinstance(stream_data, dict) or "dish_ideas" not in stream_data:
                error_msg = 'Error: JSON object must contain an "dish_ideas" key with a list of dish ideas'
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

            logging.info(f"Processing dish ideas: {stream_data}")

            # Extract dish_ideas
            parsed_items: list[dict[str, Any]] = stream_data["dish_ideas"]
            if not isinstance(parsed_items, list):
                error_msg = f"Error: 'dish_ideas' must be a list. Got: {type(parsed_items)}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            if len(parsed_items) == 0:
                error_msg = "Error: No dish ideas provided"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

            try:
                # Process each dish in the input
                results = []
                for item in parsed_items:
                    # Validate dish idea structure
                    item = self._validate_dish_idea(item)
                    query = dish_name = item["dish_name"]
                    ingredient_list = item.get("ingredient_list", [])
                    top_k_override = item.get("top_k")

                    # Query ChromaDB for recipes
                    recipes = self._query_chromadb(query, top_k=top_k_override)

                    # If input ingredients were provided, detect missing ingredients for each recipe
                    if ingredient_list:
                        logging.info(
                            f"Detecting missing ingredients for {len(recipes)} recipes "
                            f"(input has {len(ingredient_list)} ingredients) for dish: {dish_name}"
                        )
                        for recipe in recipes:
                            recipe_ingredients = recipe.get("ingredients", [])
                            if recipe_ingredients:
                                missing = self._detect_missing_ingredients(
                                    ingredient_list, recipe_ingredients, properties=properties
                                )
                                recipe["missing_ingredients"] = missing["missing_ingredients"]
                            else:
                                recipe["missing_ingredients"] = []

                    # Build output for this dish
                    dish_output = {
                        "dish_name": dish_name,
                        "query": query,
                        "count": len(recipes),
                        "recipes": recipes,
                    }

                    # Include ingredient_list if provided
                    if ingredient_list:
                        dish_output["ingredient_list"] = ingredient_list

                    results.append(dish_output)

                    logging.info(f"Successfully retrieved {len(recipes)} recipes for dish: {dish_name}")

                # Build final output
                output = {
                    "count": len(results),
                    "results": results,
                }

                logging.info(f"Successfully processed {len(results)} dishes")
                return [output, Message.EOS]

            except ValueError as e:
                error_msg = str(e)
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            except requests.exceptions.RequestException as e:
                error_msg = f"Error querying ChromaDB: {str(e)}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]
            except Exception as e:
                error_msg = f"Error processing recipe retrieval: {str(e)}"
                logging.error(error_msg)
                return [{"error": error_msg}, Message.EOS]

        elif message.isBOS():
            # Initialize stream to empty array
            if worker:
                worker.set_data("stream_data", [])

        elif message.isData():
            # Accumulate data values
            data = message.getData()
            logging.info(f"Received data: {data}")

            if worker:
                worker.append_data("stream_data", data)

        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Recipe Retrieval Agent for Blue Plate")
    parser.add_argument("--name", default="RECIPE_RETRIEVAL", type=str)
    parser.add_argument("--session", type=str)
    parser.add_argument("--properties", type=str)
    parser.add_argument("--loglevel", default="INFO", type=str)
    parser.add_argument("--serve", type=str)
    parser.add_argument("--platform", type=str, default="default")
    parser.add_argument("--registry", type=str, default="default")

    args = parser.parse_args()

    # Set logging level
    logging.getLogger().setLevel(args.loglevel.upper())

    # Parse properties from JSON
    properties: dict[str, Any] = {}
    if args.properties:
        properties = json.loads(args.properties)

    if args.serve:
        # Run as a service factory
        platform = args.platform

        af = AgentFactory(
            _class=RecipeRetrievalAgent,
            _name=args.serve,
            _registry=args.registry,
            platform=platform,
            properties=properties,
        )
        af.wait()
    else:
        # Run as a standalone agent
        session = None
        if args.session:
            # Join an existing session
            session = Session(cid=args.session)
            agent = RecipeRetrievalAgent(
                name=args.name,
                session=session,
                properties=properties,
            )
        else:
            # Create a new session
            session = Session()
            agent = RecipeRetrievalAgent(
                name=args.name,
                session=session,
                properties=properties,
            )

        # Wait for session to complete
        if session:
            session.wait()
