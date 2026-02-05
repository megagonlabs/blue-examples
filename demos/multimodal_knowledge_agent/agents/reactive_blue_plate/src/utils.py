"""Utility functions for reactive Blue Plate agent."""

from typing import Any
import json
import re

from blue.agent import Worker
from blue.stream import ControlCode


def add_user_message(conversation_history: list[dict[str, str]], content: str) -> None:
    """Add a user message to conversation history.

    Args:
        conversation_history: The conversation history list to append to.
        content: The message content.
    """
    conversation_history.append({"role": "user", "content": content})


def add_assistant_message(conversation_history: list[dict[str, str]], content: str) -> None:
    """Add an assistant message to conversation history.

    Args:
        conversation_history: The conversation history list to append to.
        content: The message content.
    """
    conversation_history.append({"role": "assistant", "content": content})


def add_action_to_history(
    conversation_history: list[dict[str, str]],
    action_name: str,
    arguments: dict[str, Any],
) -> None:
    """Add an action call to conversation history as an assistant message.

    Args:
        conversation_history: The conversation history list to append to.
        action_name: The name of the action/agent to call.
        arguments: The arguments for the action.
    """
    conversation_history.append(
        {
            "role": "assistant",
            "content": json.dumps({"name": action_name, "arguments": arguments}),
        }
    )


def build_action_schema_from_agent_definitions(
    agent_definitions: list[dict[str, Any]],
) -> dict[str, Any]:
    """Build an anyOf schema for actions from agent definitions.

    Transforms agent definitions into a structured schema where each agent becomes
    an option in an anyOf constraint, ensuring that both the action name and its
    arguments are properly typed and validated.

    Args:
        agent_definitions: List of agent definition dictionaries, each containing
            'name', 'description', and 'parameters' fields.

    Returns:
        Schema object with anyOf containing all agent action schemas.
    """
    anyof_options = []

    for agent_def in agent_definitions:
        agent_name = agent_def["name"]
        agent_description = agent_def["description"]
        agent_params = agent_def["parameters"]

        # Build the action schema for this specific agent
        # Each action requires both a name (enum-constrained) and typed arguments
        action_schema = {
            "type": "object",
            "description": agent_description,
            "properties": {
                "name": {
                    "type": "string",
                    "description": "Agent/action name",
                    "enum": [agent_name],
                },
                "arguments": agent_params,
            },
            "required": ["name", "arguments"],
            "additionalProperties": False,
        }

        anyof_options.append(action_schema)

    return {"anyOf": anyof_options}


def conversation_history_to_str(conversation_history: list[dict[str, str]]) -> str:
    """Convert conversation history list to a formatted string for logging.

    Args:
        conversation_history: List of conversation turns, each containing 'role' and 'content'.

    Returns:
        Formatted string representation of the conversation history.
    """
    msg_lines = []
    TURN_TEMPLATE = "[{role}]\n{content}\n"

    # Format each turn with role and content
    for turn in conversation_history:
        role = turn.get("role", "unknown")
        content = turn.get("content", "")
        msg_lines.append(TURN_TEMPLATE.format(role=role.upper(), content=content))

    return "\n".join(msg_lines)


def generate_markdown(recipes: dict[str, Any] | list[dict[str, Any]]) -> str:
    """Convert a list of recipe dictionaries to markdown format.

    Args:
        recipes: List of recipe dicts or a single recipe dict.

    Returns:
        Markdown formatted string.
    """
    # Handle single recipe or list of recipes
    if isinstance(recipes, dict):
        recipes = [recipes]

    markdown_parts = ["# Recipe Collection\n"]

    for idx, recipe in enumerate(recipes, 1):
        # Recipe title
        dish_name = recipe.get("dish_name", "Untitled Recipe").title()
        markdown_parts.append(f"## {idx}. {dish_name}\n")

        # Ingredients section
        ingredients = recipe.get("ingredients", [])
        if ingredients:
            markdown_parts.append("### Ingredients")
            for ingredient in ingredients:
                markdown_parts.append(f"- {ingredient.title()}")
            markdown_parts.append("")

        # Missing ingredients section (if any)
        missing = recipe.get("missing_ingredients", [])
        if missing:
            markdown_parts.append("### Missing Ingredients")
            for ingredient in missing:
                markdown_parts.append(f"- {ingredient.title()}")
            markdown_parts.append("")

        # Instructions section
        instructions = recipe.get("instructions", [])
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


def render_markdown(markdown_text: str, worker: Worker) -> None:
    """Render markdown text on the GUI using form-based display.

    Creates a form structure with a Markdown element and sends it via
    control message to the output stream for beautiful rendering in the GUI.

    Args:
        markdown_text: The markdown content to render.
        worker: The worker instance for output.
    """
    # Build the form structure (same pattern as DocumenterAgent)
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
