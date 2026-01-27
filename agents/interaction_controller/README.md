# Interaction Controller

The Interaction Controller Agent is responsible for routing the user request to necessary agents to complete the exploration and visualization task. 

Interaction Controller supports
- Storing and managing conversations with user to better understand and contextualize user intent
- Generating a linear plan based on user intent and registry metadata 
- Managing execution flow and coordination between agents

## Usage 

1. You may utilize an automatic way to update the agent registry as below, or follow steps to [manually](#add-agent-manually-in-ui) add agent in UI.
```bash
cd agents/interaction_controller
blue registry agent update agent.json
```

2. Build `INTERACTION_CONTROLLER` agent

```bash
cd agents/interaction_controller
./docker_build_agent.sh
```

3. Deploy `INTERACTION_CONTROLLER` agent on UI.


Alternatively, you may define the agent manually in the UI
 
### Add Agent manually in UI
You may also add the agent manually in the UI
1. Create a `INTERACTION_CONTROLLER` agent with the following properties
 ```json
 {
    "plan_prompt": "You will be provided a USER utterance.\nBased on the USER utterance, create a detailed multi-step plan utilizing the following agents as needed:\n\n1. NL2SQL: The NL to SQL agent takes an instruction and optionally database or table information, converts the instruction into SQL queries, identifies relevant data sources if missing, executes the queries, and returns the results.\n2. DATA_EXPLORATION_AGENT: The Data Exploration agent is used to profile data and takes an instruction along with the database name and table name. It performs exploratory data analysis by generating statistical summaries such as distributions, missing values, and correlations, and highlights trends, anomalies, and key metrics.\n3. DATA_VISUALIZATION_AGENT: The Data Visualization agent takes an instruction along with tabular or summary data and generates Vega-Lite visualizations based on the input data.\n\nYour plan should also be based on the data registry provided above.\n\nNotes:\nThe NL2SQL agent should be used to query the database tables created or modified by the previous agents for the particular information requested by the user.\nThe instruction to NL2SQL should also be high level, no need to mention anything about tables or schema.\nThe instruction to the DATA_EXPLORATION_AGENT agent should include the name of the database as mentioned in the original user request. However, the instruction to DATA_EXPLORATION_AGENT should also be high level, no need to mention any specific instructions on what to do -- just the data is enough.\n\nYour plan should be in linear format, and use each agent only once at most.\nThe instructions to each agent should be related to the user query.\n\nResponse in a JSON format as follows:\n{\n \"plan\": [\n {\n \"agent\": \"AGENT_NAME\",\n \"instruction\": <valid input instruction to agent>\n },\n {\n ...\n },\n ...\n ]\n}\n${input}",
    "input_context_field": "content",
    "conversation_memory": true,
    "input_field": "messages",
    "service_url": "ws://blue_service_openai:8001",
    "input_json": "[{\"role\": \"user\"}]",
    "openai.max_tokens": 1024,
    "input_context": "$[0]",
    "openai.api": "ChatCompletion",
    "openai.presence_penalty": 0,
    "openai.frequency_penalty": 0,
    "openai.model": "gpt-4.1-mini-2025-04-14",
    "user_intent_for_data_visualization_prompt": "Based on the USER utterance, determine if the user explicitly states they want to visualize a database.\nIf so, return \"visualize\" else return \"no\".\nIf they mention they want to curate, gather, analyze or query -- return \"no\". Return \"visualize\" only when they explicitly state so.\n${input}",
    "openai.temperature": 0,
    "openai.top_p": 1,
    "user_context_prompt": "You will be provided a user conversation history. The last message is the current USER utterance.\nYour job is only to contextualize the current USER utterance based on the conversation history, without introducing any of the previous instructions.\nIf the current USER utterance depends on previous messages for context, rewrite it to be clear and unambiguous.\nEnsure you keep the latest intent and do not include the instructions of previous messages in the contextualized output.\nIf the current USER utterance is clear and unambiguous on its own, return it as is.\nKeep the tone of the original USER utterances.${input}",
    "user_intent_for_data_profiling_prompt": "Based on the USER utterance, determine if the user explicitly states they want to profile a database.\nIf so, return \"profile\" else return \"no\".\nIf they mention they want to curate, gather or query -- return \"no\". Return \"profile\" only when they explicitly state so.\n${input}",
    "summarize_instructions_prompt": "You will be provided an llm plan. Your job is to summarize the instructions for each step in the plan to be as concise as possible while retaining the original meaning.\nOnly use keywords. The summarized version should be no more than 3 or 4 words.\n\nResponse in a JSON format as follows:\n{\n \"plan\": [\n {\n \"agent\": \"AGENT_NAME as is\",\n \"instruction\": <instruction as is>, \n \"summarized_instruction\": <your summarized instruction>\n },\n {\n ...\n },\n ...\n ]\n}\n${input}"
}
```

`conversation_memory`: set to True, to store and manage entire conversation history with user. If to use only latest user utterance, set to False. 

`plan_prompt`: prompt used to generate linear plan. 

`summarize_instructions_prompt`: prompt used to simplify instructions for better visualization.

2. Add input `DEFAULT`, which **listens** to `USER`

3. Build `INTERACTION_CONTROLLER` agent

```bash
cd agents/interaction_controller
./docker_build_agent.sh
```

4. Deploy `INTERACTION_CONTROLLER` agent on UI.



