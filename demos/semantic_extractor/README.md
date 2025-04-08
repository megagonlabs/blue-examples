# Semantic Extractor Agent 

Semantic Extractor is an `OPENAI` agent designed to extract entities from input text. Entities can be specified as part of the agent properties (i.e. `entities`), along with a description. Given an input text, for example user input text, the agent prompts OPENAI with the specification of the entities to extract and the input text. Results are returned in JSON with matched values from text.



The following animation displays a user entering some text to trigger the Semantic Extractor agent to extract entities such as occupation sector, skills, and certifications.

![Demo of Semantic Extractor agent](/docs/images/semantic_extractor.gif)

---

## Features

- **OPENAI:** Uses OPENAI to extract entities
- **Entity Specification:** Uses entity names and descriptions, specified as agent property
  
---

## Input & Output

### Input

- **DEFAULT:** Input text to process

### Output

- **DEFAULT:** Extracted entities 

---

## Properties

- **entities:** Key-Value pairs representing entity name and description.

---

## Code Overview


The `OPENAI___SEMANTIC_EXTRACTOR` agent is a derivative agent of the `OPENAI` agent. You can find the code of `OPENAI` agent [here](https://github.com/rit-git/blue/blob/v0.9/lib/blue/agents/openai.py)

- **Processing:**
  - Prompt constructed using aget property `entites` and input text `input`
  - Result processed by `OPENAI` service and returned as `JSON`

---

## Try it out

To try out the agent, first follow the [quickstart guide](https://github.com/rit-git/blue/blob/v0.9/QUICK-START.md) to deploy the `OPENAI` agent. In addition the `OPENAI` service should be running as specified in the [installation guide](https://github.com/rit-git/blue/blob/v0.9/LOCAL-INSTALLATION.md#start-services)

Once deployed create a new session and add the `OPENAI Semantic Extractor Agent - Example` (`OPENAI___SEMANTIC_EXTRACTOR_EXAMPLE`) agent to the session. 

In the UI, enter some text.

| **User Input** | **Result** |
|--------------------------------|---------|
| Job Title: Child Care Centre Cook, Company: Company_881, Location: 308 Tanglin Road, 247974, Holland Road, Employment Type: Full Time, Position: Non-Executive, Salary: Undisclosed, Job Posting Date: 10 May 2019, Application Deadline: 09 Jun 2019, Description: We are seeking a dedicated and experienced Child Care Centre Cook to prepare nutritious meals for children. The role involves menu planning, food preparation, and ensuring food safety standards are met. Ideal candidates should have a passion for child care and cooking, with the ability to work in a team-oriented environment. | {"occupation sector":["child development"],"skill":["menu planning","food preparation","food safety","teamwork"],"certifications":[]} |
| Job Title: Child Care Teacher, Company: Company_1370, Location: TradeHub 21, 16 Boon Lay Way, 609965, Jurong, Employment Type: Full Time, Position: Executive, Salary: $2,000 - $2,400 Monthly, Job Posting Date: 28 May 2019, Application Deadline: 27 Jun 2019, Description: We are looking for a passionate Child Care Teacher to join our team. The role involves creating a safe, nurturing, and engaging environment for young children, planning and implementing age-appropriate activities, and supporting the development of social, cognitive, and emotional skills. Candidates should possess relevant qualifications and experience in early childhood education. | {"occupation sector":["education","child development"],"skill":["planning","implementing activities","supporting development"],"certifications":[]} |

