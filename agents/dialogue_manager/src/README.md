# Dialogue Manager

The Dialogue Manager is responsible for handling interactions with the USER and coordinating different actions and responses based on the user input.

The current version of the Dialogue Manager supports:

1. **Conversation Memory**: Storing, managing and retrieving the conversation thread with USER in current session. 
2. **Intent Rewriting**: Rewriting the USER-ASSISTANT conversation to a concise, well-informed summary capturing the user's intent. 
3. Integration with the `Basic LLM Planner` to output a decomposed task plan, given the user input
4. **Re-plan**: allow user to update or further specify intents to re-plan

## Usage

1. Create and deploy `DIALOGUE_MANAGER___EXAMPLE` agent with the following configuration
 ```python
    {
    "intents": {
        "investigate": {
            "description": "The user is requesting job market statistics or insights that can be fulfilled by a single SQL query (e.g., 'What is the average salary for data scientists in New York?').",
            "plan": [
                [
                    "NL2SQL___DM",
                    "DEFAULT"
                ],
                [
                    "QUERYEXECUTOR",
                    "DEFAULT"
                ],
                [
                    "DIALOGUE_MANAGER___EXAMPLE",
                    "RESULT"
                ]
            ]
        },
        "job_search": {
            "description": "The user is searching for job postings that match specific criteria (e.g., 'Show me remote software engineer jobs with at least 5 years of experience.').",
            "plan": [
                [
                    "OPENAI___EXTRACTOR",
                    "DEFAULT"
                ],
                [
                    "NL2SQL___DM",
                    "DEFAULT"
                ],
                [
                    "QUERYEXECUTOR",
                    "DEFAULT"
                ],
                [
                    "DIALOGUE_MANAGER___EXAMPLE",
                    "RESULT"
                ]
            ]
        },
        "summarize": {
            "description": "The user wants a summary or aggregated insights over a group of job postings (e.g., 'Summarize the key skills required for product management roles in California.').",
            "plan": [
                [
                    "OPENAI___EXTRACTOR",
                    "DEFAULT"
                ],
                [
                    "NL2SQL___DM",
                    "DEFAULT"
                ],
                [
                    "QUERYEXECUTOR",
                    "DEFAULT"
                ],
                [
                    "OPENAI___QUERY_EXPLAINER",
                    "DEFAULT"
                ],
                [
                    "DIALOGUE_MANAGER___EXAMPLE",
                    "RESULT"
                ]
            ]
        },
        "default": {
            "description": "The user’s request does not fit into any of the above categories.",
            "plan": [
                [
                    "OPENAI___ROGUEAGENT",
                    "DEFAULT"
                ],
                [
                    "DIALOGUE_MANAGER___EXAMPLE",
                    "RESULT"
                ]
            ]
        }
    },
    "intent_classifier_agent": "OPENAI___INTENT_CLASSIFIER",
    "intent_rewriter_agent": "OPENAI___INTENT_REWRITER",
    "intent_action_agent": "OPENAI___INTENT_ACTION",
    "llm_planner": "BASIC_LLM_PLANNER___DM",
    "conversation_memory": true,
    "use_intent_rewrite": true,
    "round_limit": 3
}
```

`use_intent_rewrite`: set to True, to utilize intent rewriting

`conversation_memory`: set to True, to store and manage entire conversation history with user. If to use only latest user utterance, set to False. 

`round_limit`: specifies the maximum number of conversation rounds before which the system should begin generating the plan (re-planning is still allowed)

2. Deploy `OPENAI___INTENT_REWRITER`
```json
{
    "input_template": "Summarize the following USER-ASSISTANT conversation into a single, concise sentence describing the user's intended task. The summary should reflect the user's goal or intent, in an instruction style. Do not introduce new information. Only include what is stated or clearly implied. Respond only with JSON in the following format, nothing else. JSON response format: {\"rewrite\": \"<your_rewrite>\"}. Input: ${input}"
}
```
3. Deploy the [`BASIC_LLM_PLANNER___DM`](https://github.com/rit-git/blue-examples/tree/feature/basic-llm-planner/agents/basic_llm_planner/src) agent with the following additional properties:
```json
"executor.plan_return_to_agent": "DIALOGUE_MANAGER___EXAMPLE"
"executor.plan_return_to_agent_input":"FROM_PLANNER"
"plan_only_mode": true
```

- Set `plan_only_mode` to `false` to also perform execution of plan

- Add input `DEFAULT` which excludes `USER`

4. Deploy the `COORDINATOR`, `BLOCKING_OPENAI_AGENT`, `OPENAI_AGENT`

5. Start new session with `COORDINATOR`, `DIALOGUE_MANAGER___EXAMPLE`, `BASIC_LLM_PLANNER___DM`, `OPENAI___INTENT_REWRITER`, `OPENAI`.

