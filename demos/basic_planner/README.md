# Basic Planner

Basic Planner is an agent to demonstrate basic functioning of a plan. A plan is declarative specification of a workflow where inputs and outputs from various agents are connected to achieve an outcome. See [Plan](https://github.com/rit-git/blue/tree/dev/agents) in the development guide for more detailed description.

The basic planner simply creates a plan, comprised of:
* an input variable, `I`, with a value
* an output variable, `R`, to collect the result
and connects:
* I to `COUNTER` agent, `DEFAULT` input
* `COUNTER` agent, 'DEFAULT` output to `R`, as well as,
* `COUNTER` agent, 'DEFAULT` back to `BASIC_PLANNER` agent input `RESULT`,
  
Plan object is then written to the stream and with the help of the `COORDINATOR` agent it is executed.

The following animation displays a user entering some text to trigger the Basic Planner agent to kick off the plan, the counter agent responding.
When the debug mode is opened it shows more clearly what is happening. First, the input variable is written to a stream and then the plan is written, invoking the Counter agent, as part of the plan.

![Demo of Basic Planner agent](/docs/images/basic_planner.gif)

---

## Features

- **Plan:** Uses plan to define a workflow
- **Coordinator Agent:** Coordinates the execution of the plan issuing instructions to agents
  
---

## Input & Output

### Input

- **RESULT:** Captures result of the plan.

### Output

- **DEFAULT:** Plan written, tagged with `PLAN`

---

## Properties

- **Listener:**
  - `listens.DEFAULT`: Includes "USER" to listen to USER agent output, only to trigger plan execution.

### Configuration (UI)

None required

---

## Flow Diagram

Below is an overview of the process flow for the Counter agent:

```mermaid
graph LR;
    A[USER: Text] --> B[BASIC_PLANNER: Plan] --> C[COORDINATOR: Instructions]
    D[BASIC_PLANNER] --> I[I]
    E[Instruction] --> F[COUNTER] --> G[BASIC_PLANNER: Result]
    F[COUNTER] --> R[R]
```

---

## Code Overview

The `BASIC_PLANNER` agent is defined [here](https://github.com/rit-git/blue-examples/blob/dev/agents/basic_planer/src/basic_planner_agent.py)

- **Processing:**
  - Plan object created, and submitted
  - Result processed and displayed

---

## Try it out

To try out the agent, first add the agent to the agent registry and then follow the [quickstart guide](https://github.com/rit-git/blue/blob/dev/QUICK-START.md) to deploy the agent.

To add agent to the registry:
```
cd agents/basic_planner
blue registry agent update agent.json
```
and follow this steps interactively.

Then proceed to deploy the agent as described in the quickstart guide.


If the `Counter Example` (`COUNTER`) agent in your agent registry is listening to `USER` streams go ahead and remove it so you can see the Task Coordinator agent invoking it directly. 

Once deployed create a new session and add the `Planner Agent - Example` (`BASIC_PLANNER`), `Counter Agent - Example` (`COUNTER`), `Task Coordinator Agent` (`COORDINATOR`) agents to the session. 

In the UI, enter some text to trigger the `BASIC_PLANNER` agent.

| **User Input** | **Result** |
|--------------------------------|---------|
| 'go' | 8 |

