sample_user_input = "Chris earned $1000 in his job, and he spent $200 on a new phone. He also bought a new laptop for $800. Pat returned $100 to Chris for a previous loan. How much money does Chris have left?"
sample_plan_text = """{
    "nodes": [
        {
            "index": 0,
            "name": "Identify income",
            "instruction": "Identify the total income from Chris's job."
        },
        {
            "index": 1,
            "name": "Subtract phone cost",
            "instruction": "Subtract $200 from output of Agent 0."
        },
        {
            "index": 2,
            "name": "Subtract laptop cost",
            "instruction": "Subtract $800 from output of Agent 1."
        },
        {
            "index": 3,
            "name": "Add loan repayment",
            "instruction": "Add $100 to output of Agent 2."
        }
    ],
    "edges": [
        ["0", "1"],
        ["1", "2"],
        ["2", "3"]
    ]
}"""

sample_input2 = "Jannet has 20 eggs, half of them are brown and 1/4 of them are white, how many more brown eggs does Jannet has more than white eggs"
sample_plan_text2 = """{
    "nodes": [
        {
            "index": 0,
            "name": "Identify total egg count",
            "instruction": "Identify the total number of egges Jannet has."
        },
        {
            "index": 1,
            "name": "Calculate brown egg count",
            "instruction": "Divide the output of egg count of Agent_0 by 2"
        },
        {
            "index": 2,
            "name": "Calculate white egg count",
            "instruction": "Divide the output of egg count of Agent_0 by 4"
        },
        {
            "index": 3,
            "name": "Calculate difference between brown and white eggs",
            "instruction": "subtract the output of Agent 2 from the output of Agent_1"
        }
    ],
    "edges": [
        ["0", "1"],
        ["0", "2"],
        ["1", "3"],
        ["2", "3"]
    ]
}"""

DECOMPOSER_DEMONSTRATIONS = [
    {"input": sample_user_input, "output": sample_plan_text},
    {"input": sample_input2, "output": sample_plan_text2},
]
