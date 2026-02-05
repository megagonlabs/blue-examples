# Recipes

This directory contains a small set of synthetic data samples for quick experimentation.

A larger recipe dataset is available at:
https://www.kaggle.com/datasets/shuyangli94/food-com-recipes-and-user-interactions

The dataset features over 180,000 recipes and 700,000 reviews, spanning 18 years of user interactions and uploads on Food.com (formerly GeniusKitchen). It was used in the following paper:

> Generating Personalized Recipes from Historical User Preferences
> Bodhisattwa Prasad Majumder*, Shuyang Li*, Jianmo Ni, Julian McAuley
> EMNLP, 2019
> https://www.aclweb.org/anthology/D19-1613/

We process the raw recipe data to create:

**a) `recipes_with_reviews.jsonl`**
Each row contains a recipe with: id, name, description, ingredients, instructions, cook time, nutrition info, reviews, tags, number of steps, ingredient count, and average rating.
This file is used for vector search based on recipe name and/or ingredients.

**b) Relational database tables**
Includes tables for recipes, ingredients, recipe_to_ingredients, tags, recipe_to_tags, and nutrition. The database supports precise structured queries over recipes retrieved from vector search. The `ddl.csv` provides schema information and indices.

For instructions on processing the full dataset, see [`../../data_prep/README.md`](../../data_prep/README.md).
