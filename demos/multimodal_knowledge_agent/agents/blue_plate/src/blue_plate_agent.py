###### Parsers, Formats, Utils
import argparse
import logging
import json

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.agents.plan import AgenticPlan
from blue.session import Session
from blue.stream import ControlCode, Message

# set log level
logging.getLogger().setLevel(logging.INFO)
logging.basicConfig(format="%(asctime)s [%(levelname)s] [%(process)d:%(threadName)s:%(thread)d](%(filename)s:%(lineno)d) %(name)s -  %(message)s", level=logging.ERROR, datefmt="%Y-%m-%d %H:%M:%S")


############################
### Agent.BluePlateAgent
#

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

class BluePlateAgent(OpenAIAgent):

    def __init__(self, **kwargs):
        if 'name' not in kwargs:
            kwargs['name'] = "blue_plate"

        self.plan_started = False
        self.plan_finished = False
        self.conversation_history = []
        self.candidate_recipes = []
        self.ingredient_list = ""
        self.user_preferences = ""
        super().__init__(**kwargs)

    def _initialize_properties(self):
        """Initialize agent properties with defaults."""
        super()._initialize_properties()

    def _system_prompt(self, chosen_recipe):
        p = self.properties['system_prompt_base']
        if self.ingredient_list:
            p += f"\n{self.properties['system_prompt_ingredients']}{self.ingredient_list}\n"
        if self.candidate_recipes:
            p += f"\n{self.properties['system_prompt_recipes']}{self.candidate_recipes}\n"
        if self.user_preferences:
            p += f"{self.properties['system_prompt_preferences']}{self.user_preferences}\n"
        p += f"{self.properties['system_prompt_end']}{chosen_recipe}.\n"
        return p

    def execute_retrieval_plan(self, input_data, worker):
        agentic_plan = AgenticPlan(scope=worker.prefix)

        # Define inputs and agents
        agentic_plan.define_input(label="FIRST_USER_INPUT", value=input_data)
        agentic_plan.define_agent(name="INGREDIENT_EXTRACTOR", label="ingredient_extractor_agent", properties={})
        agentic_plan.define_agent(name="DISH_IDEATION", label="dish_ideation_agent", properties={})
        agentic_plan.define_agent(name="RECIPE_RETRIEVAL", label="retrieval_agent", properties={})

        # Connect inputs and agents
        agentic_plan.connect_input_to_agent(from_input="FIRST_USER_INPUT", to_agent="ingredient_extractor_agent", to_agent_input="DEFAULT")
        agentic_plan.connect_agent_to_agent(from_agent="ingredient_extractor_agent", to_agent=self.name, to_agent_input="INGREDIENTS")
        agentic_plan.connect_agent_to_agent(from_agent="ingredient_extractor_agent", to_agent="dish_ideation_agent", to_agent_input="DEFAULT")
        agentic_plan.connect_agent_to_agent(from_agent="dish_ideation_agent", to_agent="retrieval_agent", to_agent_input="DEFAULT")
        agentic_plan.connect_agent_to_agent(from_agent="retrieval_agent", to_agent=self.name, to_agent_input="RECIPES")

        agentic_plan.submit(worker)

    def execute_presenter_plan(self, recipe_data, worker):
        agentic_plan = AgenticPlan(scope=worker.prefix)

        agentic_plan.define_input(label="RECIPE_DATA", value=recipe_data)
        agentic_plan.define_input(label="PRESENTER_TRIGGER", value="Presenter Trigger")
        agentic_plan.define_agent(name="PRESENTER___BLUE_PLATE", label="presenter_form_agent", properties={"inputs": DISABLED_INPUTS_OVERRIDE})
        agentic_plan.define_agent(name="RECIPE_QUERY_EXECUTOR", label="query_executor", properties={"inputs": DISABLED_INPUTS_OVERRIDE})

        agentic_plan.connect_input_to_agent(from_input="PRESENTER_TRIGGER", to_agent="presenter_form_agent", to_agent_input="DEFAULT")
        agentic_plan.connect_input_to_agent(from_input="RECIPE_DATA", to_agent="query_executor", to_agent_input="RECIPES")
        agentic_plan.connect_agent_to_agent(from_agent="presenter_form_agent", to_agent="query_executor", to_agent_input="FILTERS")
        agentic_plan.connect_agent_to_agent(from_agent="presenter_form_agent", to_agent=self.name, to_agent_input="PREFERENCES")
        agentic_plan.connect_agent_to_agent(from_agent="query_executor", to_agent=self.name, to_agent_input="RESULT")

        agentic_plan.submit(worker)

    def generate_markdown(self, recipes, extracted_ingredients=None):
        """
        Convert a list of recipe dictionaries to markdown format.

        Args:
            recipes: List of recipe dicts or a single recipe dict
            extracted_ingredients: String or list of ingredients extracted from user input

        Returns:
            str: Markdown formatted string
        """
        # Handle single recipe or list of recipes
        if isinstance(recipes, dict):
            recipes = [recipes]

        markdown_parts = ["# Recipe Collection\n"]

        # Add extracted ingredients section if provided
        if extracted_ingredients:
            markdown_parts.append("## Your Ingredients\n")

            # Parse extracted_ingredients if it's a string
            if isinstance(extracted_ingredients, str):
                cleaned = extracted_ingredients.strip()

                # Remove markdown code block formatting (```python ... ``` or ``` ... ```)
                if cleaned.startswith("```"):
                    # Remove opening ``` with optional language identifier
                    first_newline = cleaned.find("\n")
                    if first_newline != -1:
                        cleaned = cleaned[first_newline + 1:]
                    else:
                        cleaned = cleaned[3:]
                    # Remove closing ```
                    if cleaned.endswith("```"):
                        cleaned = cleaned[:-3]
                    cleaned = cleaned.strip()

                # Remove common prefixes like "python " if present (without code block)
                if cleaned.lower().startswith("python "):
                    cleaned = cleaned[7:]

                # Try to parse as a list
                try:
                    import json
                    ingredients_list = json.loads(cleaned)
                except:
                    try:
                        import ast
                        ingredients_list = ast.literal_eval(cleaned)
                    except:
                        # Fallback: treat as comma-separated or single item
                        ingredients_list = [i.strip() for i in cleaned.split(",") if i.strip()]
            else:
                ingredients_list = extracted_ingredients

            # Display as bullet list
            for ingredient in ingredients_list:
                markdown_parts.append(f"- {ingredient.title()}")
            markdown_parts.append("")
            markdown_parts.append("---\n")

        for idx, recipe in enumerate(recipes, 1):
            # Recipe title
            dish_name = recipe.get('dish_name', 'Untitled Recipe').title()
            markdown_parts.append(f"## {idx}. {dish_name}\n")

            # Ingredients section
            ingredients = recipe.get('ingredients', [])
            if ingredients:
                markdown_parts.append("### Ingredients")
                for ingredient in ingredients:
                    markdown_parts.append(f"- {ingredient.title()}")
                markdown_parts.append("")

            # Missing ingredients section (if any)
            missing = recipe.get('missing_ingredients', [])
            if missing:
                markdown_parts.append("### Missing Ingredients")
                for ingredient in missing:
                    markdown_parts.append(f"- {ingredient.title()}")
                markdown_parts.append("")

            # Instructions section
            instructions = recipe.get('instructions', [])
            if instructions:
                # Handle instructions as string or list
                if isinstance(instructions, str):
                    # Try multiple parsing methods
                    try:
                        # First try: parse as JSON
                        instructions = json.loads(instructions)
                    except:
                        try:
                            # Second try: handle escaped quotes and use ast.literal_eval
                            import ast
                            cleaned = instructions.replace("\\'", "'")
                            instructions = ast.literal_eval(cleaned)
                        except:
                            # Last resort: treat as single instruction
                            instructions = [instructions]

                markdown_parts.append("### Instructions")
                for step_num, instruction in enumerate(instructions, 1):
                    # Capitalize first letter
                    instruction = instruction.strip()
                    if instruction:
                        instruction = instruction[0].upper() + instruction[1:]
                        markdown_parts.append(f"{step_num}. {instruction}")
                markdown_parts.append("")

            # Add separator between recipes (except for last one)
            if idx < len(recipes):
                markdown_parts.append("---\n")

        return "\n".join(markdown_parts)

    def render_markdown(self, markdown_text: str, worker) -> None:
        """Render markdown text on the GUI using form-based display.
        Creates a form structure with a Markdown element and sends it via
        control message to the output stream for beautiful rendering in the GUI.
        Args:
            markdown_text: The markdown content to render.
            worker: The worker instance for output.
        """
        # Build the form structure (same pattern as DocumenterAgent)
        if markdown_text.startswith("```markdown"):
            markdown_text = markdown_text[len("```markdown"):]
        if markdown_text.endswith("```\n"):
            markdown_text = markdown_text[:-len("```\n")]
        elif markdown_text.endswith("```"):
            markdown_text = markdown_text[:-len("```")]
        doc_ui = {
            "type": "VerticalLayout",
            "elements": [
                {
                    "type": "Markdown",
                    "scope": "#/properties/markdown",
                    "props": {"style": {}},
                }
            ],
        }

        doc_form = {
            "schema": {},
            "uischema": doc_ui,
            "data": {"markdown": markdown_text},
        }

        # Send to GUI via control message
        worker.write_control(ControlCode.CREATE_FORM, doc_form, output="DEFAULT")

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if input == "DEFAULT":
            if message.isData():
                if not self.plan_started:
                    self.plan_started = True
                    logging.info("Executing plan")
                    self.image_metadata = message.getData()
                    self.execute_retrieval_plan(self.image_metadata, worker)
                    return
                elif self.plan_finished:
                    user_message = message.getData()
                    self.conversation_history.append({
                        "role": "user",
                        "content": user_message
                    })
                    message_payload = self.create_message("", properties=properties)
                    message_payload['messages'] = self.conversation_history

                    url = self.get_service_address(properties=properties)
                    r = self.call_service(url, message_payload)
                    response = json.loads(r)
                    output = response['data']['choices'][0]['message']['content']

                    # Add assistant response to history
                    self.conversation_history.append({
                        "role": "assistant",
                        "content": output
                    })

                    return [output, Message.EOS]
                else:
                    return self.properties["user_message_while_processing"]
        if input == "INGREDIENTS":
            if message.isData():
                self.ingredient_list = message.getData()["ingredients"]
                logging.info(f"Ingredient list: {self.ingredient_list}")
                return
        if input == "RECIPES":
            if message.isData():
                self.candidate_recipes = message.getData()
                if isinstance(self.candidate_recipes, str):
                    self.candidate_recipes = json.loads(self.candidate_recipes)

                for result in self.candidate_recipes.get('results', []):
                    for recipe in result.get('recipes', []):
                        if 'recipe_id' in recipe:
                            try:
                                # Converts IDs to new format only if they were already ints
                                recipe['recipe_id'] = f"REC-{int(recipe['recipe_id']):03d}"
                            except:
                                pass

                logging.info(f"Candidate recipe list: {self.candidate_recipes}")

                self.recipe_id_to_recipe = {}
                for result in self.candidate_recipes['results']:
                    for recipe in result['recipes']:
                        self.recipe_id_to_recipe[str(recipe['recipe_id'])] = recipe
                logging.info(f"ID to recipe: {self.recipe_id_to_recipe}")

                self.execute_presenter_plan(self.candidate_recipes, worker)
                return
        if input == "PREFERENCES":
            if message.isData():
                self.user_preferences = message.getData()
                logging.info(f"User preferences: {self.user_preferences}")
                return
        if input == "RESULT":
            logging.info("IN RESULT")
            logging.info(message)
            if message.isData():
                self.plan_finished = True
                query_results = message.getData()
                if not query_results:
                    return

                chosen_recipes = []
                for r in query_results['result']:
                    r_id = f"REC-{int(r['recipe_id']):03d}"
                    if r_id in self.recipe_id_to_recipe:
                        recipe = self.recipe_id_to_recipe[r_id]
                        recipe['instructions'] = r['instructions']
                        chosen_recipes.append(recipe)
                # Sort recipes by number of missing ingredients (fewest first)
                chosen_recipes.sort(key=lambda recipe: len(recipe.get('missing_ingredients', [])))

                logging.info(f"Chosen recipes: {chosen_recipes}")
                if not chosen_recipes:
                    return self.properties["user_message_no_match"]

                recipe_markdown = self.generate_markdown(chosen_recipes, self.ingredient_list)
                self.render_markdown(recipe_markdown, worker)

                self.conversation_history = [{
                        "role": "system",
                        "content": self._system_prompt(recipe_markdown)
                    }]

                return self.properties["user_message_match_found"]

        return None

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--name', default="blue_plate", type=str)
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

        af = AgentFactory(_class=BluePlateAgent, _name=args.serve, _registry=args.registry, platform=platform, properties=properties)
        af.wait()
    else:
        a = None
        session = None
        if args.session:
            # join an existing session
            session = Session(cid=args.session)
            a = BluePlateAgent(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = BluePlateAgent(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()
