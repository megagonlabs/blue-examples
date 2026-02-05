import json
import argparse
import sys
import os


def mask_created_by(data):
    """Recursively set 'created_by' fields to None."""
    if isinstance(data, dict):
        if "created_by" in data:
            data["created_by"] = None
        for key, value in data.items():
            mask_created_by(value)
    elif isinstance(data, list):
        for item in data:
            mask_created_by(item)


def main():
    parser = argparse.ArgumentParser(description="Extract Blue Plate agent configurations.")
    parser.add_argument("-i", "--input", dest="input_path", required=True, help="Path to the input agents JSON file.")
    parser.add_argument(
        "-o", "--output", dest="output_path", default="agent.json", help="Path to the output JSON file."
    )

    args = parser.parse_args()

    if not os.path.exists(args.input_path):
        print(f"Error: Input file not found at {args.input_path}", file=sys.stderr)
        sys.exit(1)

    try:
        with open(args.input_path, "r") as f:
            data = json.load(f)
    except json.JSONDecodeError:
        print(f"Error: Failed to decode JSON from {args.input_path}", file=sys.stderr)
        sys.exit(1)

    filtered_data = []

    target_groups = {"blue_plate_multimodal_knowledge_agent", "reactive_blue_plate_multimodal_knowledge_agent"}

    print(f"Total items in input: {len(data)}")

    for item in data:
        # Special case for PRESENTER agent
        if item.get("name") == "PRESENTER":
            agents = item.get("contents", {}).get("agent", {})
            if "PRESENTER___BLUE_PLATE" in agents:
                target_agent = agents["PRESENTER___BLUE_PLATE"]
                item["contents"]["agent"] = {"PRESENTER___BLUE_PLATE": target_agent}
                mask_created_by(item)
                filtered_data.append(item)
                continue

        # Check for category
        properties = item.get("properties", {})
        # Handle cases where properties might be None (though unlikely in this schema)
        if properties is None:
            properties = {}

        categories = properties.get("categories", [])

        # categories might be None if explicitly set to null in JSON, so ensure it's a list
        if categories is None:
            categories = []

        is_blue_plate_agent = "EXAMPLE_BLUE_PLATE" in categories
        is_target_group = item.get("name") in target_groups

        if is_blue_plate_agent or is_target_group:
            mask_created_by(item)
            filtered_data.append(item)

    print(f"Extracted {len(filtered_data)} items.")

    # Ensure directory exists for output
    output_dir = os.path.dirname(os.path.abspath(args.output_path))
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir)

    with open(args.output_path, "w") as f:
        json.dump(filtered_data, f, indent=4)
    print(f"Wrote output to {args.output_path}")


if __name__ == "__main__":
    main()
