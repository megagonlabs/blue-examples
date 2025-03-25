# Natural Language to SQL to Natural Language


In this demo, we will show how to chain the `NL-to-SQL Interactive Agent` (`NL2SQL___INTERACTIVE`), with another agent, `OpenAI Query Explainer Agent` (`OPENAI___QUERY_EXPLAINER`) to achieve natural language query to SQL, to query results and then explain them back in natural language.

To do so, you won't even need to write any code. You will simply need to make sure that one agents output is listened by another agent. 

If you check the tags property of the `NL-to-SQL Interactive Agent` you will see that its `DEFAULT` output stream is tagged as `QUERY`:

![NL2SQL tag](/docs/images/nl2sql_tag.png)

and the `listens` property of the `OpenAI Query Explainer Agent` is configured such that its `DEFAULT` input stream is set to listen to streams tagged with `QUERY`, if not temporarily change it.

![Explainer_listens](/docs/images/explainer_listens.png)

That is all you need to chain agents.


The following animation shows the chaining of agents in action:

![Demo of NL2SQL to Explainer](/docs/images/nl2sql_explainer.gif)


---

## Try it out

To try out the agent, first follow the [quickstart guide](https://github.com/rit-git/blue/blob/v0.9/QUICK-START.md) to deploy `NL-to-SQL Agent` (`NL2SQL`) and `OpenAI Agent` (`OPENAI`) agents. Also, make sure that you are already running the `OPENAI` service.

Once deployed create a new session and add the `NL-to-SQL Interactive Agent` (`NL2SQL___INTERACTIVE`) and `OpenAI Query Explainer Agent` (`OPENAI___QUERY_EXPLAINER`)  agents to the session. 

In the UI, enter some query in natural language.

| **User Input** | **Result** |
|--------------------------------|---------|
| 'what is the most frequently advertised manager role in jurong?' | 'The results indicate that the most commonly advertised manager role in Jurong is "project manager," with a total of 40 advertisements for this position.' |

