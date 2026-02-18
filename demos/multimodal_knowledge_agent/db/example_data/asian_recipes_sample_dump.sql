--
-- PostgreSQL database dump
--

\restrict bY0flcFQ2ulomdj4Sh0L8G1g4jjvkygRRCtKdgYW6ewg3LPNGeMQnPaw0g3UIV6

-- Dumped from database version 14.20 (Homebrew)
-- Dumped by pg_dump version 14.20 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredients (
    ingredient_id integer NOT NULL,
    ingredient_name character varying(255) NOT NULL
);


ALTER TABLE public.ingredients OWNER TO postgres;

--
-- Name: nutrition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nutrition (
    recipe_id integer NOT NULL,
    calories double precision,
    total_fat_pdv double precision,
    sugar_pdv double precision,
    sodium_pdv double precision,
    protein_pdv double precision,
    saturated_fat_pdv double precision
);


ALTER TABLE public.nutrition OWNER TO postgres;

--
-- Name: recipe_ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe_ingredients (
    recipe_id integer,
    ingredient_id integer
);


ALTER TABLE public.recipe_ingredients OWNER TO postgres;

--
-- Name: recipe_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipe_tags (
    recipe_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.recipe_tags OWNER TO postgres;

--
-- Name: recipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipes (
    recipe_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    cook_time_min integer,
    ingredient_count integer,
    n_steps integer,
    review_count integer,
    average_rating double precision,
    instructions text
);


ALTER TABLE public.recipes OWNER TO postgres;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    tag_id integer NOT NULL,
    tag_name character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredients (ingredient_id, ingredient_name) FROM stdin;
1	bamboo shoots
2	basil
3	bean sprouts
4	bell peppers
5	bird's eye chili
6	broccoli
7	butter
8	cabbage
9	carrots
10	cashews
11	chashu pork
12	chicken
13	chicken breast
14	chicken broth
15	chicken thighs
16	chinese broccoli
17	chutney
18	cilantro
19	cooked rice
20	coriander
21	cream
22	cucumber
23	cumin
24	dark soy sauce
25	dashi stock
26	dipping sauce
27	doubanjiang
28	dried chili peppers
29	dumpling wrappers
30	egg
31	fenugreek
32	flour
33	garam masala
34	garlic
35	ginger
36	gochujang
37	green onions
38	ground beef
39	ground pork
40	heavy cream
41	ice water
42	jasmine rice
43	mayonnaise
44	milk
45	mirin
46	miso paste
47	mushrooms
48	nori
49	nori sheets
50	oil
51	onion
52	oyster sauce
53	paneer cheese
54	peanuts
55	peas
56	pork bone broth
57	potatoes
58	ramen noodles
59	rice
60	rice noodles
61	sake
62	scallions
63	sesame oil
64	sesame seeds
65	shrimp
66	sichuan peppercorns
67	silken tofu
68	snap peas
69	soft boiled egg
70	soy sauce
71	spinach
72	sriracha
73	star anise
74	steamed rice
75	sugar
76	sushi rice
77	sweet potato
78	tempura flour
79	thai basil
80	tofu
81	tomato
82	tomato puree
83	tomato sauce
84	tuna
85	vinegar
86	wakame seaweed
87	wide rice noodles
88	yeast
89	yogurt
90	zucchini
\.


--
-- Data for Name: nutrition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nutrition (recipe_id, calories, total_fat_pdv, sugar_pdv, sodium_pdv, protein_pdv, saturated_fat_pdv) FROM stdin;
1	450	15	8	35	60	5
11	480	22	6	38	45	5
12	80	4	2	25	8	1
15	620	40	8	35	45	20
17	580	20	10	30	35	6
19	320	12	6	28	15	2
20	380	10	4	20	20	2
23	420	25	5	20	18	12
25	450	8	2	45	35	2
27	350	15	2	25	18	5
28	500	18	20	40	35	5
31	280	8	2	15	8	4
34	550	20	8	45	25	4
35	420	12	2	30	20	2
36	380	20	4	15	5	2
39	250	12	3	10	4	1
43	380	22	3	40	20	6
44	800	45	5	60	35	20
47	680	45	10	35	40	22
\.


--
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_ingredients (recipe_id, ingredient_id) FROM stdin;
1	13
1	79
1	34
1	5
1	70
1	52
1	42
11	13
11	54
11	28
11	66
11	62
11	35
11	70
11	85
12	25
12	46
12	67
12	37
12	86
15	15
15	89
15	82
15	40
15	33
15	23
15	35
15	34
17	59
17	71
17	3
17	9
17	38
17	30
17	36
17	63
19	6
19	4
19	9
19	68
19	80
19	70
19	35
19	34
20	76
20	49
20	84
20	72
20	43
20	22
20	64
23	71
23	53
23	51
23	81
23	35
23	34
23	21
23	23
25	60
25	14
25	13
25	35
25	51
25	73
25	3
25	2
27	39
27	29
27	8
27	62
27	35
27	70
27	63
28	15
28	70
28	45
28	61
28	75
28	35
28	74
28	6
31	32
31	88
31	89
31	34
31	7
31	18
31	44
34	87
34	12
34	16
34	30
34	70
34	24
34	34
34	75
35	19
35	65
35	55
35	9
35	30
35	70
35	62
35	63
36	77
36	90
36	47
36	78
36	41
36	50
36	26
39	57
39	55
39	32
39	23
39	20
39	50
39	17
43	67
43	39
43	27
43	66
43	62
43	34
43	70
44	56
44	58
44	11
44	69
44	37
44	48
44	1
47	12
47	7
47	83
47	21
47	31
47	33
47	10
\.


--
-- Data for Name: recipe_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_tags (recipe_id, tag_id) FROM stdin;
1	2
1	10
1	30
1	15
11	6
11	10
11	30
11	31
12	17
12	29
12	34
12	14
15	16
15	10
15	30
15	8
17	19
17	10
17	4
17	14
19	6
19	33
19	25
19	14
20	17
20	20
20	26
20	30
23	16
23	34
23	10
23	14
25	35
25	29
25	10
25	13
27	6
27	1
27	9
27	24
28	17
28	10
28	11
28	18
31	16
31	5
31	27
31	3
34	32
34	10
34	23
34	31
35	6
35	10
35	25
35	26
36	17
36	1
36	12
36	34
39	16
39	28
39	1
39	33
43	6
43	10
43	30
43	7
44	17
44	29
44	22
44	10
47	16
47	10
47	8
47	21
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipes (recipe_id, name, description, cook_time_min, ingredient_count, n_steps, review_count, average_rating, instructions) FROM stdin;
1	Spicy Thai Basil Chicken	A quick and spicy Thai street food classic perfect for weeknight dinners.	25	7	6	2	5	['Mince garlic and chilies.', 'Slice chicken into bite-sized pieces.', 'Stir-fry chicken until browned.', 'Add sauces and stir-fry for another minute.', 'Toss in basil leaves until wilted.', 'Serve over hot jasmine rice.']
11	Kung Pao Chicken	A classic Sichuan dish with spicy chicken, crunchy peanuts, and chili peppers.	30	8	5	1	5	['Marinate chicken with soy sauce.', 'Fry peanuts and set aside.', 'Stir-fry chilies and peppercorns.', 'Add chicken and vegetables.', 'Toss with sauce and peanuts.']
12	Tofu Miso Soup	A comforting and traditional Japanese soup made with soybean paste and dashi.	15	5	5	0	0	['Bring dashi stock to a simmer.', 'Add tofu and wakame.', 'Dissolve miso paste in a ladle of broth.', 'Stir miso into soup (do not boil).', 'Garnish with green onions.']
15	Chicken Tikka Masala	A world-famous Indian curry featuring roasted chicken in a creamy tomato sauce.	60	8	5	1	5	['Marinate chicken in yogurt and spices.', 'Grill or bake chicken pieces.', 'Simmer tomato puree with cream and spices.', 'Add chicken to sauce and cook through.', 'Serve with naan or rice.']
17	Korean Bibimbap	A colorful mixed rice bowl topped with vegetables, meat, egg, and spicy sauce.	45	8	5	1	5	['Cook rice.', 'Sauté vegetables separately seasoned with sesame oil.', 'Cook beef with soy sauce.', 'Fried egg sunny side up.', 'Assemble bowl with rice, veggies, meat, egg, and gochujang.']
19	Vegetable Stir Fry	A quick and healthy mix of colorful vegetables and tofu in a savory sauce.	20	8	5	0	0	['Chop all vegetables.', 'Fry tofu until golden.', 'Stir-fry aromatics.', 'Add vegetables and cook until crisp-tender.', 'Toss with sauce and serve.']
20	Spicy Tuna Sushi Roll	Homemade sushi rolls filled with spicy tuna salad and crunch cucumber.	40	7	5	1	5	['Cook and season sushi rice.', 'Mix tuna with sriracha and mayo.', 'Spread rice on nori.', 'Add tuna and cucumber.', 'Roll tightly and slice.']
23	Palak Paneer	Soft cottage cheese cubes in a smooth, spiced spinach gravy.	40	8	5	1	4	['Blanch and puree spinach.', 'Fry paneer cubes until golden.', 'Sauté aromatics and spices.', 'Add spinach puree and simmer.', 'Stir in cream and paneer.']
25	Chicken Pho	A fragrant Vietnamese noodle soup with fresh herbs and light broth.	90	8	5	1	5	['Simmer broth with charred ginger, onion, and spices.', 'Cook noodles.', 'Poach chicken in broth and shred.', 'Assemble bowls with noodles and chicken.', 'Pour over hot broth and add herbs.']
27	Steamed Pork Dumplings	Juicy pork filling wrapped in soft dough, perfect for dim sum.	60	7	5	1	5	['Mix pork, veggies, and seasonings.', 'Place filling in wrappers.', 'Pleat and seal dumplings.', 'Steam for 10-12 minutes.', 'Serve with dipping sauce.']
28	Chicken Teriyaki	Sweet and savory glazed chicken served with steamed rice.	25	8	5	0	0	['Pan-fry chicken until crispy.', 'Mix soy sauce, mirin, sake, sugar.', 'Pour sauce over chicken.', 'Simmer until glaze thickens.', 'Serve with rice and broccoli.']
31	Garlic Naan Bread	Soft and bubbly flatbread topped with garlic butter and cilantro.	90	7	5	1	5	['Make dough and let rise.', 'Divide into balls.', 'Roll out flat.', 'Cook in a hot skillet.', 'Brush with garlic butter.']
34	Pad See Ew	Thai stir-fried noodles with soy sauce, meat, and vegetables.	20	8	5	0	0	['Cook noodles.', 'Stir-fry chicken and garlic.', 'Push aside and scramble egg.', 'Add noodles and broccoli.', 'Toss with sauces until caramelized.']
35	Shrimp Fried Rice	A quick and easy way to use leftover rice with fresh shrimp.	15	8	5	1	4	['Scramble eggs and remove.', 'Stir-fry shrimp and veggies.', 'Add cold rice.', 'Toss with soy sauce.', 'Mix in eggs and scallions.']
36	Vegetable Tempura	Light and crispy battered fried vegetables.	30	7	5	0	0	['Cut vegetables.', 'Mix flour with ice water.', 'Dip veggies in batter.', 'Deep fry until light and crispy.', 'Serve immediately.']
39	Vegetable Samosas	Crispy pastry pockets filled with spiced potatoes and peas.	60	7	5	1	5	['Make dough.', 'Cook spiced potato and pea filling.', 'Roll dough and fill cones.', 'Seal edges.', 'Deep fry until golden.']
43	Mapo Tofu	Spicy and numbing tofu dish with minced meat.	25	7	5	1	4	['Fry pork until crispy.', 'Add chili bean paste and aromatics.', 'Pour in stock and tofu.', 'Simmer gently.', 'Thicken sauce with cornstarch.']
44	Tonkotsu Ramen	Rich and creamy pork broth ramen with toppings.	120	7	5	0	0	['Boil broth for hours (or buy pre-made).', 'Cook noodles.', 'Assemble bowl with broth and noodles.', 'Top with pork, egg, and garnish.', 'Serve hot.']
47	Butter Chicken	Mild and buttery tomato curry beloved worldwide.	50	7	5	1	5	['Cook marinated chicken.', 'Simmer sauce with butter and spices.', 'Blend sauce for smoothness.', 'Add cream and chicken.', 'Simmer until thick.']
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (tag_id, tag_name) FROM stdin;
1	appetizer
2	asian
3	baking
4	bowl
5	bread
6	chinese
7	comfort-food
8	creamy
9	dim-sum
10	dinner
11	easy
12	fried
13	gluten-free
14	healthy
15	high-protein
16	indian
17	japanese
18	kids-friendly
19	korean
20	lunch
21	mild
22	noodle
23	noodles
24	pork
25	quick
26	seafood
27	side-dish
28	snack
29	soup
30	spicy
31	stir-fry
32	thai
33	vegan
34	vegetarian
35	vietnamese
\.


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (ingredient_id);


--
-- Name: nutrition nutrition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutrition
    ADD CONSTRAINT nutrition_pkey PRIMARY KEY (recipe_id);


--
-- Name: recipe_tags recipe_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_tags
    ADD CONSTRAINT recipe_tags_pkey PRIMARY KEY (recipe_id, tag_id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: average_rating; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX average_rating ON public.recipes USING btree (average_rating);


--
-- Name: ingredient_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ingredient_name ON public.ingredients USING btree (ingredient_name);


--
-- Name: nutrition nutrition_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutrition
    ADD CONSTRAINT nutrition_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: recipe_ingredients recipe_ingredients_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(ingredient_id);


--
-- Name: recipe_ingredients recipe_ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: recipe_tags recipe_tags_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_tags
    ADD CONSTRAINT recipe_tags_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: recipe_tags recipe_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipe_tags
    ADD CONSTRAINT recipe_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id);


--
-- PostgreSQL database dump complete
--

\unrestrict bY0flcFQ2ulomdj4Sh0L8G1g4jjvkygRRCtKdgYW6ewg3LPNGeMQnPaw0g3UIV6
