USER_INTENT_PROMPT = """\
You will be provided a USER utterance. Your job is to decide the dialogue policy to take based on the input: either ask a clarifying question or plan.
You should ask a clarifying question if the user task is vague or needs more information. In that case, only return "can you please clarify?".
If the user intent is now clear, then simply return "plan"

${input}"""