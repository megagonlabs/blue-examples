###### Parsers, Formats, Utils
import argparse
import logging
import json

###### Blue
from blue.agent import AgentFactory
from blue.agents.openai import OpenAIAgent
from blue.session import Session
from blue.stream import Message


DEFAULT_INGREDIENT_EXTRACTION_PROMPT = "Do your best to identify all of the visible ingredients in the provided image(s). Respond only with the list of ingredients. The response should be formatted as a Python list of strings."
DEFAULT_INGREDIENT_EXTRACTION_RESPONSE_FORMAT = {
    "type": "json_schema",
    "json_schema": {
        "name": "ingredient_extraction",
        "schema": {
            "type": "object",
            "properties": {
                "ingredients": {
                    "type": "array",
                    "items": {"type": "string"},
                    "description": "A list of ingredients extracted from the image",
                }
            },
            "required": ["ingredients"],
            "additionalProperties": False,
        },
        "strict": True,
    },
}


class IngredientExtractor(OpenAIAgent):
    """
    Agent that extracts ingredients from images using OpenAI's vision capabilities.

    Analyzes uploaded images (e.g., refrigerator or pantry photos) and returns
    a structured list of detected ingredients.

    Properties (in addition to OpenAIAgent properties):
    ----------
    | Name                      | Type   | Default                                         | Description                                                                 |
    |---------------------------|--------|-------------------------------------------------|-----------------------------------------------------------------------------|
    | `prompt`                  | `str`  | `DEFAULT_INGREDIENT_EXTRACTION_PROMPT`          | Instructions for the vision model explaining how to extract ingredients.    |
    | `openai.response_format`  | `dict` | `DEFAULT_INGREDIENT_EXTRACTION_RESPONSE_FORMAT` | JSON schema for structured output validation.                               |
    | `input_template`          | `None` | `null`                                          | Must be null to allow direct complex content (images) passing.              |
    | `service_url`             | `str`  | `ws://blue_service_openai:8001`                 | WebSocket URL for the OpenAI service.                                       |

    Inputs:
    - DEFAULT: Dictionary containing file metadata (file_id, filename, content_type) for an image.

    Outputs:
    - DEFAULT: JSON object containing a list of "ingredients".
    """

    def default_processor(self, message, input="DEFAULT", properties=None, worker=None):
        if input == "DEFAULT":
            if message.isData():
                file_metadata = message.getData()
                file_data_base64 = worker.get_session_data(file_metadata["file_id"])["file_data"]

                # images = properties['image_paths']
                content = [
                    {"type": "text", "text": properties.get("prompt", DEFAULT_INGREDIENT_EXTRACTION_PROMPT)},
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{file_data_base64}",
                        },
                    },
                ]

                # Set the properties for the API call
                ## See ServiceClient.create_message for how input message is created.
                ## When input_template is None, string substitution is skipped.
                ## content is assigned to `input_json`-`input_context`->`input_context_field`
                call_properties = properties.copy() if properties else {}
                if "input_template" not in call_properties:
                    call_properties["input_template"] = None

                # Set default response format if not provided
                if "openai.response_format" not in call_properties:
                    call_properties["openai.response_format"] = DEFAULT_INGREDIENT_EXTRACTION_RESPONSE_FORMAT

                output = self.execute_api_call(content, properties=call_properties)

                try:
                    output = json.loads(output)
                except Exception as e:
                    logging.warning(f"Failed to parse output as JSON: {e}")
                    output = {"ingredients": []}

                return [output, Message.EOS]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--name", default="INGREDIENT_EXTRACTOR", type=str)
    parser.add_argument("--session", type=str)
    parser.add_argument("--properties", type=str)
    parser.add_argument("--loglevel", default="INFO", type=str)
    parser.add_argument("--serve", type=str)
    parser.add_argument("--platform", type=str, default="default")
    parser.add_argument("--registry", type=str, default="default")

    args = parser.parse_args()

    # logging
    logging.getLogger().setLevel(logging.getLevelName(args.loglevel.upper()))

    # set properties
    properties = {}
    p = args.properties
    if p:
        # decode json
        properties = json.loads(p)

    if args.serve:
        platform = args.platform

        af = AgentFactory(
            _class=IngredientExtractor,
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
            a = IngredientExtractor(name=args.name, session=session, properties=properties)
        else:
            # create a new session
            session = Session()
            a = IngredientExtractor(name=args.name, session=session, properties=properties)

        # wait for session
        if session:
            session.wait()
