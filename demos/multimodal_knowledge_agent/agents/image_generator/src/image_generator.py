###### Parsers, Formats, Utils
import argparse
import logging
import json
import re
import os

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.stream import ControlCode
from blue.session import Session
from blue.utils import uuid_utils


# Default properties (can be overridden in the UI)
image_generator_properties = {
    "timeout": 30,
    "output_strip": True,
    "openai.image_model": "dall-e-3",
    "openai.image_size": "1024x1024",
    "openai.image_quality": "standard",
    "openai.image_n": 1,
    "image.style_description": "Anime art style, bright vibrant colors, clean white marble countertop background, soft anime shading, warm color tones, high-quality anime illustration, top-down 45-degree angle view, Studio Ghibli food style",
    "image.prompt_template": "Recipe: {dish_name}. Full cooking process: {all_steps_str}. GENERATE IMAGE FOR STEP {step_num}: {current_instruction}. Show ONLY these ingredients that have been used so far: {ingredients_in_image}. Do NOT show ingredients not yet used. Do NOT include any items, utensils, tools, or elements that are not explicitly mentioned in the current step instruction. Focus ONLY on what is directly described in step {step_num}. Exclude unnecessary background items, kitchen tools, or decorative elements unless specifically required by the instruction. Style: {style_description}. No text, no watermarks. The image must be anime art style.",
    "parse_recipe.prompt_template": "Convert the following recipe text into a JSON object with this exact structure:\n\n{\n\"dishName\": \"name of the dish\",\n\"description\": \"brief description\",\n\"ingredients\": [\"ingredient1\", \"ingredient2\", ...],\n\"instructions\": [\"step1\", \"step2\", ...]\n}\n\nRecipe text:\n```\n{recipe_input}\n```\n\nReturn ONLY the parsed recipe text, no explanation or markdown code blocks.",
    "extract_ingredients.prompt_template": "You are analyzing a cooking instruction to determine which ingredients are being used.\n\nAvailable ingredients:\n{ingredients_str}\n\nInstruction step: \"{instruction}\"\n\nTask: Return ONLY a JSON array of ingredient names (exactly as listed above) that are actively being used, handled, or should be visible in this cooking step.\n\nRules:\n- Only include ingredients that are explicitly mentioned or clearly implied in this step\n- Use the exact ingredient names from the list above\n- If no ingredients from the list are used in this step, return an empty array []\n- Return ONLY the JSON array, no explanation\n\nExample output: [\"Cherry tomatoes, halved\", \"Fresh basil leaves\"]",
}

#########################
### RecipeStepImageAgent
#
class ImageGeneratorAgent(OpenAIAgent):
    """
    Agent that generates step-by-step images for recipe instructions using DALLE.
    Takes a recipe with dish name, ingredients, and instructions as input,
    and generates consistent-style images for each cooking step.

    Properties (in addition to OpenAIAgent properties):
    ----------
    | Name                                   | Type   | Default                     | Description                                                                 |
    |----------------------------------------|--------|-----------------------------|-----------------------------------------------------------------------------|
    | `timeout`                              | `int`  | `30`                        | Timeout in
    | `output_strip`                         | `bool` | `True`                      | Whether to strip whitespace from the output.                                |
    | `openai.max_tokens`                    | `int`  | `300`                       | Maximum number of tokens for the OpenAI response.                           |
    | `openai.image_model`                   | `str`  | `dall-e-3`                  | Model to use for image generation (e.g., `dall-e-2`, `dall-e-3`).           |
    | `openai.image_size`                    | `str`  | `1024x1024`                 | Size of the generated image (e.g., `256x256`, `512x512`, `1024x1024`).      |
    | `openai.image_quality`                 | `str`  | `standard`                  | Quality setting for image generation (e.g., `standard`, `high`).            |
    | `openai.image_n`                       | `int`  | `1`                         | Number of images to generate per prompt.                                    |
    | `use_tools`                            | `bool` | `False`                     | Whether to enable tool usage.                                               |
    | `image.style_description`              | `str`  |                             | Description of the desired art style for generated images.                  |
    | `image.prompt_template`                | `str`  |                             | Template for generating image prompts based on recipe steps.                |
    | `parse_recipe.prompt_template`         | `str`  |                             | Template for parsing recipe text into structured JSON.                      |
    | `extract_ingredients.prompt_template`  | `str`  |                             | Template for extracting ingredients used in a cooking step.                 |

    Inputs:
    - DEFAULT: Text input to be sent to this agent.

    Outputs:
    - DEFAULT: Generated image output from OpenAI, tagged as `IMAGE`.
    """

    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "IMAGE_GENERATOR"
        super().__init__(**kwargs)

    def _initialize_inputs(self):
        """Initialize input parameters for the image generator agent."""
        return

    def _initialize_outputs(self):
        """Initialize outputs for the image generator agent, tagged as IMAGE."""
        self.add_output("DEFAULT", description="Generated image output", tags=["IMAGE"])

    def _initialize_properties(self):
        """Initialize default properties for DALLE image generation via Blue OpenAI service."""
        super()._initialize_properties()

        # Load properties from agent.json and override only changed values
        loaded_count = 0
        for key, value in image_generator_properties.items():
            # Only override if the value is different from the default
            if key not in self.properties or self.properties[key] != value:
                self.properties[key] = value
                loaded_count += 1

        logging.info(f"Loaded {loaded_count} properties from agent.json (total properties: {len(image_generator_properties)})")

        # Log key DALL-E properties to verify they're loaded
        logging.info(f"DALL-E model: {self.properties.get('openai.image_model', 'NOT SET')}")
        logging.info(f"Image size: {self.properties.get('openai.image_size', 'NOT SET')}")
        logging.info(f"Has image prompt template: {'image.prompt_template' in self.properties}")

        # Always override these image-specific properties
        self.properties["input_field"] = "prompt"
        self.properties["output_path"] = "$.data[0].url"

    def parse_recipe(self, recipe_input: str) -> dict:
        """
        Parse recipe from JSON format.

        Expected JSON format:
        {
          "dishName": "Recipe Name",
          "description": "Recipe description",
          "ingredients": ["ingredient1", "ingredient2", ...],
          "instructions": ["step1", "step2", ...]
        }

        Returns dict with: dish_name, description, ingredients, instructions
        """
        empty_result = {
            "dish_name": "",
            "description": "",
            "ingredients": [],
            "instructions": []
        }

        # First, try direct JSON parsing
        try:
            recipe_data = json.loads(recipe_input)

            # Validate required fields exist
            if all(k in recipe_data for k in ("dishName", "ingredients", "instructions")):
                result = {
                    "dish_name": recipe_data.get("dishName", ""),
                    "description": recipe_data.get("description", ""),
                    "ingredients": recipe_data.get("ingredients", []),
                    "instructions": recipe_data.get("instructions", [])
                }
                logging.info(f"Successfully parsed JSON: {result['dish_name']}")
                return result
            else:
                logging.info("JSON parsed but missing required fields, trying GPT...")
                raise ValueError("Missing required fields")

        except (json.JSONDecodeError, ValueError, KeyError) as e:
            # logging.warning(f"Failed to parse recipe JSON: {e}. Attempting GPT-based parsing...")

            # Fallback: Try using GPT to convert to JSON

            # Get prompt template from properties
            prompt_template = self.properties.get("parse_recipe.prompt_template")
            prompt = prompt_template.format(recipe_input=recipe_input)

            # Create message for OpenAI using parent class method
            message = self.create_message(prompt, properties=self.properties)

            url = self.get_service_address(properties=self.properties)
            logging.info("Calling GPT to parse recipe text...")

            response = self.call_service(url, message)

            if response is None:
                logging.error("GPT parsing returned None")
                return empty_result

            response_json = json.loads(response)

            content = response_json['data']['choices'][0]['message']['content'].strip()

            # Remove markdown code blocks if present
            if content.startswith("```json"):
                content = content[7:]
            elif content.startswith("```"):
                content = content[3:]
            if content.endswith("```"):
                content = content[:-3]
            content = content.strip()

            # Parse the GPT-generated JSON
            recipe_data = json.loads(content)

            result = {
                "dish_name": recipe_data.get("dishName", ""),
                "description": recipe_data.get("description", ""),
                "ingredients": recipe_data.get("ingredients", []),
                "instructions": recipe_data.get("instructions", [])
            }

            logging.info(f"Successfully parsed recipe using GPT: {result['dish_name']}")
            return result

    def extract_ingredients_for_step_with_llm(self, instruction: str, all_ingredients: list) -> list:
        """
        Use GPT-5-mini to predict which ingredients are used in a specific instruction step.

        Args:
            instruction: The instruction text for one step
            all_ingredients: List of all available ingredients

        Returns:
            List of ingredients that should appear in this step's image
        """
        try:
            ingredients_str = "\n".join([f"- {ing}" for ing in all_ingredients])

            # Get prompt template from properties
            prompt_template = self.properties.get("extract_ingredients.prompt_template")
            prompt = prompt_template.format(
                ingredients_str=ingredients_str,
                instruction=instruction
            )

            # Create message for OpenAI using parent class method
            message = self.create_message(prompt, properties=self.properties)

            # Call OpenAI service
            url = self.get_service_address(properties=self.properties)
            logging.info(f"Calling LLM for ingredient extraction: {instruction[:50]}...")

            response = self.call_service(url, message)

            if response is None:
                logging.error("LLM call returned None, falling back to empty list")
                return []

            response_json = json.loads(response)

            if response_json.get('status') == 'success':
                content = response_json['data']['choices'][0]['message']['content'].strip()

                # Parse JSON array from response
                # Strip markdown code blocks if present
                if content.startswith("```json"):
                    content = content[7:]
                elif content.startswith("```"):
                    content = content[3:]
                if content.endswith("```"):
                    content = content[:-3]
                content = content.strip()

                ingredients_list = json.loads(content)

                if isinstance(ingredients_list, list):
                    # Validate that returned ingredients are in our list
                    valid_ingredients = [ing for ing in ingredients_list if ing in all_ingredients]
                    logging.info(f"LLM extracted ingredients: {valid_ingredients}")
                    return valid_ingredients
                else:
                    logging.info(f"LLM returned non-list: {content}")
                    return []
            else:
                error = response_json.get('error', 'Unknown error')
                logging.error(f"LLM call failed: {error}")
                return []

        except json.JSONDecodeError as e:
            logging.error(f"Failed to parse LLM response as JSON: {e}")
            return []
        except Exception as e:
            logging.error(f"Error in LLM ingredient extraction: {e}")
            import traceback
            logging.error(f"Traceback: {traceback.format_exc()}")
            return []

    def get_cumulative_ingredients(self, instructions: list, all_ingredients: list, up_to_step: int) -> list:
        """
        Get all ingredients used from step 1 up to and including the specified step.

        Args:
            instructions: List of all instruction strings
            all_ingredients: List of all available ingredients
            up_to_step: Step number (1-indexed) to accumulate ingredients up to

        Returns:
            List of unique ingredients used up to this step
        """
        cumulative = []
        seen = set()

        for step_idx in range(up_to_step):
            step_ingredients = self.extract_ingredients_for_step_with_llm(instructions[step_idx], all_ingredients)
            for ing in step_ingredients:
                if ing not in seen:
                    cumulative.append(ing)
                    seen.add(ing)

        return cumulative

    def build_consistent_prompt(
        self,
        dish_name: str,
        all_ingredients: list,
        all_instructions: list,
        step_num: int,
        current_instruction: str,
        ingredients_used_so_far: list
    ) -> str:
        """
        Build a detailed, consistent prompt for image generation.

        Shows ALL steps in the recipe context, highlights the CURRENT step,
        and only includes ingredients that have been used up to this step.

        Args:
            dish_name: Name of the dish
            all_ingredients: Complete list of all ingredients
            all_instructions: Complete list of all instructions
            step_num: Current step number (1-indexed)
            current_instruction: The instruction for the current step
            ingredients_used_so_far: Ingredients that have been used up to and including this step
        """
        # Format all steps with current step highlighted
        steps_context = []
        for i, instr in enumerate(all_instructions, 1):
            if i == step_num:
                steps_context.append(f">>> STEP {i} (CURRENT - GENERATE THIS): {instr}")
            elif i < step_num:
                steps_context.append(f"[COMPLETED] Step {i}: {instr}")
            else:
                steps_context.append(f"[UPCOMING] Step {i}: {instr}")

        all_steps_str = " | ".join(steps_context)

        # Only include ingredients used up to this step
        if ingredients_used_so_far:
            ingredients_in_image = ", ".join(ingredients_used_so_far)
        else:
            # If no specific ingredients detected, use generic description
            ingredients_in_image = "cooking preparation"

        # Get style description from properties
        style_description = self.properties.get("image.style_description")

        # Get prompt template from properties
        prompt_template = self.properties.get("image.prompt_template")

        # Use template from agent.json
        prompt = prompt_template.format(
            dish_name=dish_name,
            all_steps_str=all_steps_str,
            step_num=step_num,
            current_instruction=current_instruction,
            ingredients_in_image=ingredients_in_image,
            style_description=style_description
        )

        return prompt

    def generate_image_with_dalle(self, prompt: str) -> str:
        """
        Generate an image using DALLE via Blue's OpenAI service.

        Args:
            prompt: Text description of the image to generate

        Returns:
            URL of the generated image, or None if generation fails
        """
        try:
            logging.info(f"Generating image with DALLE: {prompt[:100]}...")

            model = self.properties.get("openai.image_model", "dall-e-3")

            # Build image generation parameters
            image_params = {
                "model": model,
                "prompt": prompt,
                "size": self.properties.get("openai.image_size", "1024x1024"),
                "n": self.properties.get("openai.image_n", 1)
            }

            # Add quality for dall-e-3
            if model == "dall-e-3":
                image_params["quality"] = self.properties.get("openai.image_quality", "standard")

            # Build message - call_service wraps in 'data', so we just add 'api' to params
            message = {
                "api": "ImageGeneration",
                **image_params
            }

            # Get service URL and call
            url = self.get_service_address(properties=self.properties)
            logging.info(f"Calling OpenAI service at: {url}")
            logging.info(f"Message: {message}")

            response = self.call_service(url, message)

            logging.info(f"Raw response from call_service: {response}")

            if response is None:
                logging.error("call_service returned None")
                return None

            response_json = json.loads(response)
            logging.info(f"OpenAI response status: {response_json.get('status')}")

            if response_json.get('status') == 'success':
                # Extract image URL from response
                data = response_json.get('data', {})
                if 'data' in data and len(data['data']) > 0:
                    image_url = data['data'][0].get('url')
                    if image_url:
                        logging.info(f"Image generated successfully: {image_url[:80]}...")
                        return image_url

                logging.error(f"No image URL in response: {response_json}")
                return None
            else:
                error = response_json.get('error', 'Unknown error')
                logging.error(f"OpenAI API call failed: {error}")
                return None

        except json.JSONDecodeError as e:
            logging.error(f"Failed to parse JSON from OpenAI response: {e}")
            return None
        except Exception as e:
            logging.error(f"Error generating image with DALLE: {e}")
            import traceback
            logging.error(f"Traceback: {traceback.format_exc()}")
            return None

    def display_step_image(self, image_url: str, worker, step_num: int, instruction: str):
        """Display a step image with its instruction using Markdown format."""
        markdown_content = f"""### Step {step_num}

**{instruction}**

<img src="{image_url}" alt="Step {step_num}" width="256" height="256">

---"""
        form_id = uuid_utils.create_uuid()
        form = {
            "form_id": form_id,
            "schema": {},
            "uischema": {
                "type": "Markdown",
                "scope": "#/properties/markdown",
                "props": {
                    "style": {
                        "maxHeight": "none",
                        "overflow": "visible"
                    },
                    "defaultExpanded": True
                }
            },
            "data": {"markdown": markdown_content}
        }
        worker.write_control(ControlCode.CREATE_FORM, form, output="DEFAULT", id=form_id)

    def display_recipe_header(self, recipe: dict, worker):
        """Display the recipe header with dish name, description, and ingredients."""
        ingredients_list = "\n".join([f"- {ing}" for ing in recipe["ingredients"]])

        markdown_content = f"""# 🍽️ {recipe["dish_name"]}

**{recipe["description"]}**

## Ingredients
{ingredients_list}

---

## Cooking Steps with Visual Guide"""
        form_id = uuid_utils.create_uuid()
        form = {
            "form_id": form_id,
            "schema": {},
            "uischema": {
                "type": "Markdown",
                "scope": "#/properties/markdown",
                "props": {
                    "style": {
                        "maxHeight": "none",
                        "overflow": "visible"
                    },
                    "defaultExpanded": True
                }
            },
            "data": {"markdown": markdown_content}
        }
        worker.write_control(ControlCode.CREATE_FORM, form, output="DEFAULT", id=form_id)

    def display_error(self, message: str, worker):
        """Display an error message."""
        markdown_content = f"""## ⚠️ Error

{message}"""
        form_id = uuid_utils.create_uuid()
        form = {
            "form_id": form_id,
            "schema": {},
            "uischema": {
                "type": "Markdown",
                "scope": "#/properties/markdown",
                "props": {
                    "style": {
                        "maxHeight": "none",
                        "overflow": "visible"
                    },
                    "defaultExpanded": True
                }
            },
            "data": {"markdown": markdown_content}
        }
        worker.write_control(ControlCode.CREATE_FORM, form, output="DEFAULT", id=form_id)

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        """
        Process recipe input and generate step-by-step images.

        Expects recipe text with dish name, ingredients, and instructions.
        Generates a consistent-style image for each cooking step."""
        if properties is None:
            properties = self.properties

        if message.isBOS():
            # Initialize stream state
            if worker:
                worker.set_data("stream_data", [])

        elif message.isData():
            # Accumulate recipe data
            data = message.getData()
            logging.info(f"Received input chunk: {str(data)[:100]}...")

            if worker:
                worker.append_data("stream_data", str(data))

        elif message.isEOS():
            # Process complete recipe
            stream_data = ""
            if worker:
                stream_data = "".join(worker.get_data("stream_data"))

            recipe_json = stream_data.strip()

            if not recipe_json:
                self.display_error("No recipe input provided.", worker)
                worker.write_eos(output="DEFAULT")
                return

            # Parse the recipe from JSON
            logging.info("Parsing recipe JSON...")
            recipe = self.parse_recipe(recipe_json)

            if not recipe["dish_name"]:
                self.display_error("Could not parse dish name from input.", worker)
                worker.write_eos(output="DEFAULT")
                return

            if not recipe["instructions"]:
                self.display_error("Could not parse instructions from input.", worker)
                worker.write_eos(output="DEFAULT")
                return

            logging.info(f"Parsed recipe: {recipe['dish_name']} with {len(recipe['instructions'])} steps")

            # Display recipe header
            self.display_recipe_header(recipe, worker)

            # Generate image for each step
            for step_num, instruction in enumerate(recipe["instructions"], 1):
                logging.info(f"Generating image for step {step_num}: {instruction}")

                # Get cumulative ingredients used up to this step
                ingredients_used = self.get_cumulative_ingredients(
                    recipe["instructions"],
                    recipe["ingredients"],
                    step_num
                )
                logging.info(f"Step {step_num} uses ingredients: {ingredients_used}")

                # Build consistent prompt with full recipe context
                prompt = self.build_consistent_prompt(
                    dish_name=recipe["dish_name"],
                    all_ingredients=recipe["ingredients"],
                    all_instructions=recipe["instructions"],
                    step_num=step_num,
                    current_instruction=instruction,
                    ingredients_used_so_far=ingredients_used
                )

                logging.info(f"Generated prompt: {prompt[:200]}...")

                # Generate image
                image_url = self.generate_image_with_dalle(prompt)

                if image_url:
                    self.display_step_image(image_url, worker, step_num, instruction)
                    logging.info(f"Step {step_num} image generated successfully")
                else:
                    # Show placeholder on failure
                    placeholder_url = f"https://via.placeholder.com/512x512/FF6B6B/FFFFFF?text=Step+{step_num}+Failed"
                    self.display_step_image(placeholder_url, worker, step_num, f"{instruction} (Image generation failed)")
                    logging.error(f"Failed to generate image for step {step_num}")

            # Display completion message
            completion_md = f"""
## ✅ Recipe Visualization Complete

Generated {len(recipe["instructions"])} step images for **{recipe["dish_name"]}**.

Enjoy cooking! 🧑‍🍳
"""
            form_id = uuid_utils.create_uuid()
            form = {
                "form_id": form_id,
                "schema": {},
                "uischema": {
                    "type": "Markdown",
                    "scope": "#/properties/markdown",
                    "props": {
                        "style": {
                            "maxHeight": "none",
                            "overflow": "visible"
                        },
                    "defaultExpanded": True
                    },
                },
                "data": {"markdown": completion_md}
            }
            worker.write_control(ControlCode.CREATE_FORM, form, output="DEFAULT", id=form_id)

            worker.write_eos(output="DEFAULT")
        return None


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--name', default="IMAGE_TEST", type=str)
    parser.add_argument('--session', type=str)
    parser.add_argument('--properties', type=str)
    parser.add_argument('--loglevel', default="INFO", type=str)
    parser.add_argument('--serve', type=str)
    parser.add_argument('--platform', type=str, default='default')
    parser.add_argument('--registry', type=str, default='default')

    args = parser.parse_args()

    # logging
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
            _class=ImageGeneratorAgent,
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
            a = ImageGeneratorAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = ImageGeneratorAgent(name=args.name, session=session, properties=properties)
        # wait for session
        if session:
            session.wait()
