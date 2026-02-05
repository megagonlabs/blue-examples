# Blue Plate Agent

Blue Plate Agent interacts with the user and orchestrates multiple agents to generate diverse and appealing dish ideas based on a list of available ingredients.

Uses a fixed workflow to suggest recipes to the user, and answer follow up questions.


## Plan

User File Upload -> Image Extraction Agent -> Dish Ideation Agent -> Recipe Retrieval Agent 
User Preference Form Results + Recipe Retrieval Agent -> Recipe Query Executor -> Blue Plate Agent -> Display results to user

Blue Plate Agent also has several inputs to gather the outputs of each agent along the way, and store the intermediate results in memory for use in QA.

Once the user has uploaded the file and filled out the preference form, Blue Plate switched to QA mode. During this time, it responds to all user queries in natural language, using the context gathered during plan execution.
