# Presenter

Presenter agents displays an interactive form to the user and outputs the data collected. Form is specified declaratively along with the schema of the underlying data collected. Presenter agent can  optionally be triggered through a set of keywords. The data collected is output as JSON following the data schema. Form specification uses a custom version on [JSON Forms](https://jsonforms.io/docs/).

See [Form Designer Tool](https://github.com/rit-git/blue/blob/v0.9/QUICK-START.md#form-designer) to learn more about how to design UIs.

The following animation displays a presenter agent showing a form to the user and output collected data.

![Demo of Documenter agent](/docs/images/presenter.gif)

---

## Features

- **UI Forms:** Allows users to render UI elements
  
---

## Input & Output

### Input

- **DEFAULT:** Triggers rendering of UI Form

### Output

- **FORM:** Form specification

---

## Properties
 
- `form`: form specification using JSON Forms
- `schema`: data specification using JSON Forms
- `triggers`: keywords to trigger execution (optional)
---

## Code Overview

The `PRESENTER` agent is defined [here](https://github.com/rit-git/blue/blob/v0.9/lib/blue/agents/presenter.py))

- **Processing:**
  - Create form
  - Process events from form, saving them to memory
  - On "DONE" show collected data
---

## Try it out

To try out the agent, first follow the [quickstart guide](https://github.com/rit-git/blue/blob/v0.9/QUICK-START.md) to deploy the `Presenter Agent` (`PRESENTER`).

Once deployed create a new session and add the above agent to the session. Note: For this example add `Presenter Agent - Example` (`PRESENTER___EXAMPLE`) instead of `Presenter Agent` (`PRESENTER`).

In the UI, enter some text.

| **User Input** | **Result** |
|--------------------------------|---------|
| 'hi' | form, JSON output |

