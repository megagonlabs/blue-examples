# Semantic Filter Agent

Semantic Filter is an `OPENAI` agent designed to filter text based on a user-defined natural language filter conditions. Filter conditions can be specified as part of the agent properties (i.e. `filter_conditions`), along with a description. Given an input text, for example user input text, the agent prompts OPENAI with the specification of the filter conditions to evaluate and the input text. Results are returned in JSON with each condition name and boolean value.



The following animation displays a user entering some text to trigger the Semantic Filter agent to examine filter conditions such as soft and technical skills.

![Demo of Semantic Filter agent](/docs/images/semantic_filter.gif)

---

## Features

- **OPENAI:** Uses OPENAI to filter conditions
- **Filter Specification:** Uses filte condition names and descriptions, specified as agent property
  
---

## Input & Output

### Input

- **DEFAULT:** Input text to process

### Output

- **DEFAULT:** Filter conditions and their values 

---

## Properties

- **filter_conditions:** Key-Value pairs representing filter condition name and description.

---

## Code Overview


The `OPENAI___SEMANTIC_FILTER` agent is a derivative agent of the `OPENAI` agent. You can find the code of `OPENAI` agent [here](https://github.com/megagonlabs/blue/blob/v0.9/lib/blue/agents/openai.py)

- **Processing:**
  - Prompt constructed using aget property `filter_conditions` and input text `input`
  - Result processed by `OPENAI` service and returned as `JSON`

---

## Try it out

To try out the agent, first follow the [quickstart guide](https://github.com/megagonlabs/blue/blob/v0.9/QUICK-START.md) to deploy the `OPENAI` agent. In addition the `OPENAI` service should be running as specified in the [installation guide](https://github.com/megagonlabs/blue/blob/v0.9/LOCAL-INSTALLATION.md#start-services)

Once deployed create a new session and add the `OPENAI Semantic Filter Agent - Example` (`OPENAI___SEMANTIC_FILTER_EXAMPLE`) agent to the session. 

In the UI, enter some text.

| **User Input** | **Result** |
|--------------------------------|---------|
| Job Title: Child Care Centre Cook, Company: Company_881, Location: 308 Tanglin Road, 247974, Holland Road, Employment Type: Full Time, Position: Non-Executive, Salary: Undisclosed, Job Posting Date: 10 May 2019, Application Deadline: 09 Jun 2019, Description: We are seeking a dedicated and experienced Child Care Centre Cook to prepare nutritious meals for children. The role involves menu planning, food preparation, and ensuring food safety standards are met. Ideal candidates should have a passion for child care and cooking, with the ability to work in a team-oriented environment. | {"filter_conditions":{"soft_skills":true,"technical_skills":false}} |
| Job Title: Child Care Teacher, Company: Company_1370, Location: TradeHub 21, 16 Boon Lay Way, 609965, Jurong, Employment Type: Full Time, Position: Executive, Salary: $2,000 - $2,400 Monthly, Job Posting Date: 28 May 2019, Application Deadline: 27 Jun 2019, Description: We are looking for a passionate Child Care Teacher to join our team. The role involves creating a safe, nurturing, and engaging environment for young children, planning and implementing age-appropriate activities, and supporting the development of social, cognitive, and emotional skills. Candidates should possess relevant qualifications and experience in early childhood education. | {"filter_conditions":{"soft skills":false,"technical skills":true}} |

