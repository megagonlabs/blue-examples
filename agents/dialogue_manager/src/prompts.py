USER_INTENT_PROMPT = """\
You will be provided a USER utterance. Your job is to decide the dialogue policy to take based on the input: either ask a clarifying question or plan.
You should ask a clarifying question if the user task is vague or needs more information. In that case, only return "Got it. Do you want to further clarify?".
Only if the user explicitly mentions or instucts to go ahead with plan generation, then simply return "plan"

${input}"""