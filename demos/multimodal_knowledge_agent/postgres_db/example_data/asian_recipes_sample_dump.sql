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
-- Name: ingredients; Type: TABLE; Schema: public; Owner: nikita
--

CREATE TABLE public.ingredients (
    ingredient_id character varying(255) NOT NULL,
    ingredient_name character varying(255) NOT NULL
);


ALTER TABLE public.ingredients OWNER TO nikita;

--
-- Name: nutrition; Type: TABLE; Schema: public; Owner: nikita
--

CREATE TABLE public.nutrition (
    recipe_id character varying(255) NOT NULL,
    calories double precision,
    total_fat_pdv double precision,
    sugar_pdv double precision,
    sodium_pdv double precision,
    protein_pdv double precision,
    saturated_fat_pdv double precision
);


ALTER TABLE public.nutrition OWNER TO nikita;

--
-- Name: recipe_ingredients; Type: TABLE; Schema: public; Owner: nikita
--

CREATE TABLE public.recipe_ingredients (
    recipe_id character varying(255),
    ingredient_id character varying(255)
);


ALTER TABLE public.recipe_ingredients OWNER TO nikita;

--
-- Name: recipe_tags; Type: TABLE; Schema: public; Owner: nikita
--

CREATE TABLE public.recipe_tags (
    recipe_id character varying(255) NOT NULL,
    tag_id character varying(255) NOT NULL
);


ALTER TABLE public.recipe_tags OWNER TO nikita;

--
-- Name: recipes; Type: TABLE; Schema: public; Owner: nikita
--

CREATE TABLE public.recipes (
    recipe_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    cook_time_min integer,
    ingredient_count integer,
    n_steps integer,
    review_count integer,
    average_rating double precision,
    instructions text
);


ALTER TABLE public.recipes OWNER TO nikita;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: nikita
--

CREATE TABLE public.tags (
    tag_id character varying(255) NOT NULL,
    tag_name character varying(255) NOT NULL
);


ALTER TABLE public.tags OWNER TO nikita;

--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.ingredients (ingredient_id, ingredient_name) FROM stdin;
ING-1	bamboo shoots
ING-2	basil
ING-3	bean sprouts
ING-4	bell peppers
ING-5	bird's eye chili
ING-6	broccoli
ING-7	butter
ING-8	cabbage
ING-9	carrots
ING-10	cashews
ING-11	chashu pork
ING-12	chicken
ING-13	chicken breast
ING-14	chicken broth
ING-15	chicken thighs
ING-16	chinese broccoli
ING-17	chutney
ING-18	cilantro
ING-19	cooked rice
ING-20	coriander
ING-21	cream
ING-22	cucumber
ING-23	cumin
ING-24	dark soy sauce
ING-25	dashi stock
ING-26	dipping sauce
ING-27	doubanjiang
ING-28	dried chili peppers
ING-29	dumpling wrappers
ING-30	egg
ING-31	fenugreek
ING-32	flour
ING-33	garam masala
ING-34	garlic
ING-35	ginger
ING-36	gochujang
ING-37	green onions
ING-38	ground beef
ING-39	ground pork
ING-40	heavy cream
ING-41	ice water
ING-42	jasmine rice
ING-43	mayonnaise
ING-44	milk
ING-45	mirin
ING-46	miso paste
ING-47	mushrooms
ING-48	nori
ING-49	nori sheets
ING-50	oil
ING-51	onion
ING-52	oyster sauce
ING-53	paneer cheese
ING-54	peanuts
ING-55	peas
ING-56	pork bone broth
ING-57	potatoes
ING-58	ramen noodles
ING-59	rice
ING-60	rice noodles
ING-61	sake
ING-62	scallions
ING-63	sesame oil
ING-64	sesame seeds
ING-65	shrimp
ING-66	sichuan peppercorns
ING-67	silken tofu
ING-68	snap peas
ING-69	soft boiled egg
ING-70	soy sauce
ING-71	spinach
ING-72	sriracha
ING-73	star anise
ING-74	steamed rice
ING-75	sugar
ING-76	sushi rice
ING-77	sweet potato
ING-78	tempura flour
ING-79	thai basil
ING-80	tofu
ING-81	tomato
ING-82	tomato puree
ING-83	tomato sauce
ING-84	tuna
ING-85	vinegar
ING-86	wakame seaweed
ING-87	wide rice noodles
ING-88	yeast
ING-89	yogurt
ING-90	zucchini
\.


--
-- Data for Name: nutrition; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.nutrition (recipe_id, calories, total_fat_pdv, sugar_pdv, sodium_pdv, protein_pdv, saturated_fat_pdv) FROM stdin;
REC-001	450	15	8	35	60	5
REC-011	480	22	6	38	45	5
REC-012	80	4	2	25	8	1
REC-015	620	40	8	35	45	20
REC-017	580	20	10	30	35	6
REC-019	320	12	6	28	15	2
REC-020	380	10	4	20	20	2
REC-023	420	25	5	20	18	12
REC-025	450	8	2	45	35	2
REC-027	350	15	2	25	18	5
REC-028	500	18	20	40	35	5
REC-031	280	8	2	15	8	4
REC-034	550	20	8	45	25	4
REC-035	420	12	2	30	20	2
REC-036	380	20	4	15	5	2
REC-039	250	12	3	10	4	1
REC-043	380	22	3	40	20	6
REC-044	800	45	5	60	35	20
REC-047	680	45	10	35	40	22
\.


--
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.recipe_ingredients (recipe_id, ingredient_id) FROM stdin;
REC-001	ING-13
REC-001	ING-79
REC-001	ING-34
REC-001	ING-5
REC-001	ING-70
REC-001	ING-52
REC-001	ING-42
REC-011	ING-13
REC-011	ING-54
REC-011	ING-28
REC-011	ING-66
REC-011	ING-62
REC-011	ING-35
REC-011	ING-70
REC-011	ING-85
REC-012	ING-25
REC-012	ING-46
REC-012	ING-67
REC-012	ING-37
REC-012	ING-86
REC-015	ING-15
REC-015	ING-89
REC-015	ING-82
REC-015	ING-40
REC-015	ING-33
REC-015	ING-23
REC-015	ING-35
REC-015	ING-34
REC-017	ING-59
REC-017	ING-71
REC-017	ING-3
REC-017	ING-9
REC-017	ING-38
REC-017	ING-30
REC-017	ING-36
REC-017	ING-63
REC-019	ING-6
REC-019	ING-4
REC-019	ING-9
REC-019	ING-68
REC-019	ING-80
REC-019	ING-70
REC-019	ING-35
REC-019	ING-34
REC-020	ING-76
REC-020	ING-49
REC-020	ING-84
REC-020	ING-72
REC-020	ING-43
REC-020	ING-22
REC-020	ING-64
REC-023	ING-71
REC-023	ING-53
REC-023	ING-51
REC-023	ING-81
REC-023	ING-35
REC-023	ING-34
REC-023	ING-21
REC-023	ING-23
REC-025	ING-60
REC-025	ING-14
REC-025	ING-13
REC-025	ING-35
REC-025	ING-51
REC-025	ING-73
REC-025	ING-3
REC-025	ING-2
REC-027	ING-39
REC-027	ING-29
REC-027	ING-8
REC-027	ING-62
REC-027	ING-35
REC-027	ING-70
REC-027	ING-63
REC-028	ING-15
REC-028	ING-70
REC-028	ING-45
REC-028	ING-61
REC-028	ING-75
REC-028	ING-35
REC-028	ING-74
REC-028	ING-6
REC-031	ING-32
REC-031	ING-88
REC-031	ING-89
REC-031	ING-34
REC-031	ING-7
REC-031	ING-18
REC-031	ING-44
REC-034	ING-87
REC-034	ING-12
REC-034	ING-16
REC-034	ING-30
REC-034	ING-70
REC-034	ING-24
REC-034	ING-34
REC-034	ING-75
REC-035	ING-19
REC-035	ING-65
REC-035	ING-55
REC-035	ING-9
REC-035	ING-30
REC-035	ING-70
REC-035	ING-62
REC-035	ING-63
REC-036	ING-77
REC-036	ING-90
REC-036	ING-47
REC-036	ING-78
REC-036	ING-41
REC-036	ING-50
REC-036	ING-26
REC-039	ING-57
REC-039	ING-55
REC-039	ING-32
REC-039	ING-23
REC-039	ING-20
REC-039	ING-50
REC-039	ING-17
REC-043	ING-67
REC-043	ING-39
REC-043	ING-27
REC-043	ING-66
REC-043	ING-62
REC-043	ING-34
REC-043	ING-70
REC-044	ING-56
REC-044	ING-58
REC-044	ING-11
REC-044	ING-69
REC-044	ING-37
REC-044	ING-48
REC-044	ING-1
REC-047	ING-12
REC-047	ING-7
REC-047	ING-83
REC-047	ING-21
REC-047	ING-31
REC-047	ING-33
REC-047	ING-10
\.


--
-- Data for Name: recipe_tags; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.recipe_tags (recipe_id, tag_id) FROM stdin;
REC-001	TAG-2
REC-001	TAG-10
REC-001	TAG-30
REC-001	TAG-15
REC-011	TAG-6
REC-011	TAG-10
REC-011	TAG-30
REC-011	TAG-31
REC-012	TAG-17
REC-012	TAG-29
REC-012	TAG-34
REC-012	TAG-14
REC-015	TAG-16
REC-015	TAG-10
REC-015	TAG-30
REC-015	TAG-8
REC-017	TAG-19
REC-017	TAG-10
REC-017	TAG-4
REC-017	TAG-14
REC-019	TAG-6
REC-019	TAG-33
REC-019	TAG-25
REC-019	TAG-14
REC-020	TAG-17
REC-020	TAG-20
REC-020	TAG-26
REC-020	TAG-30
REC-023	TAG-16
REC-023	TAG-34
REC-023	TAG-10
REC-023	TAG-14
REC-025	TAG-35
REC-025	TAG-29
REC-025	TAG-10
REC-025	TAG-13
REC-027	TAG-6
REC-027	TAG-1
REC-027	TAG-9
REC-027	TAG-24
REC-028	TAG-17
REC-028	TAG-10
REC-028	TAG-11
REC-028	TAG-18
REC-031	TAG-16
REC-031	TAG-5
REC-031	TAG-27
REC-031	TAG-3
REC-034	TAG-32
REC-034	TAG-10
REC-034	TAG-23
REC-034	TAG-31
REC-035	TAG-6
REC-035	TAG-10
REC-035	TAG-25
REC-035	TAG-26
REC-036	TAG-17
REC-036	TAG-1
REC-036	TAG-12
REC-036	TAG-34
REC-039	TAG-16
REC-039	TAG-28
REC-039	TAG-1
REC-039	TAG-33
REC-043	TAG-6
REC-043	TAG-10
REC-043	TAG-30
REC-043	TAG-7
REC-044	TAG-17
REC-044	TAG-29
REC-044	TAG-22
REC-044	TAG-10
REC-047	TAG-16
REC-047	TAG-10
REC-047	TAG-8
REC-047	TAG-21
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.recipes (recipe_id, name, description, cook_time_min, ingredient_count, n_steps, review_count, average_rating, instructions) FROM stdin;
REC-001	Spicy Thai Basil Chicken	A quick and spicy Thai street food classic perfect for weeknight dinners.	25	7	6	2	5	['Mince garlic and chilies.', 'Slice chicken into bite-sized pieces.', 'Stir-fry chicken until browned.', 'Add sauces and stir-fry for another minute.', 'Toss in basil leaves until wilted.', 'Serve over hot jasmine rice.']
REC-011	Kung Pao Chicken	A classic Sichuan dish with spicy chicken, crunchy peanuts, and chili peppers.	30	8	5	1	5	['Marinate chicken with soy sauce.', 'Fry peanuts and set aside.', 'Stir-fry chilies and peppercorns.', 'Add chicken and vegetables.', 'Toss with sauce and peanuts.']
REC-012	Tofu Miso Soup	A comforting and traditional Japanese soup made with soybean paste and dashi.	15	5	5	0	0	['Bring dashi stock to a simmer.', 'Add tofu and wakame.', 'Dissolve miso paste in a ladle of broth.', 'Stir miso into soup (do not boil).', 'Garnish with green onions.']
REC-015	Chicken Tikka Masala	A world-famous Indian curry featuring roasted chicken in a creamy tomato sauce.	60	8	5	1	5	['Marinate chicken in yogurt and spices.', 'Grill or bake chicken pieces.', 'Simmer tomato puree with cream and spices.', 'Add chicken to sauce and cook through.', 'Serve with naan or rice.']
REC-017	Korean Bibimbap	A colorful mixed rice bowl topped with vegetables, meat, egg, and spicy sauce.	45	8	5	1	5	['Cook rice.', 'Sauté vegetables separately seasoned with sesame oil.', 'Cook beef with soy sauce.', 'Fried egg sunny side up.', 'Assemble bowl with rice, veggies, meat, egg, and gochujang.']
REC-019	Vegetable Stir Fry	A quick and healthy mix of colorful vegetables and tofu in a savory sauce.	20	8	5	0	0	['Chop all vegetables.', 'Fry tofu until golden.', 'Stir-fry aromatics.', 'Add vegetables and cook until crisp-tender.', 'Toss with sauce and serve.']
REC-020	Spicy Tuna Sushi Roll	Homemade sushi rolls filled with spicy tuna salad and crunch cucumber.	40	7	5	1	5	['Cook and season sushi rice.', 'Mix tuna with sriracha and mayo.', 'Spread rice on nori.', 'Add tuna and cucumber.', 'Roll tightly and slice.']
REC-023	Palak Paneer	Soft cottage cheese cubes in a smooth, spiced spinach gravy.	40	8	5	1	4	['Blanch and puree spinach.', 'Fry paneer cubes until golden.', 'Sauté aromatics and spices.', 'Add spinach puree and simmer.', 'Stir in cream and paneer.']
REC-025	Chicken Pho	A fragrant Vietnamese noodle soup with fresh herbs and light broth.	90	8	5	1	5	['Simmer broth with charred ginger, onion, and spices.', 'Cook noodles.', 'Poach chicken in broth and shred.', 'Assemble bowls with noodles and chicken.', 'Pour over hot broth and add herbs.']
REC-027	Steamed Pork Dumplings	Juicy pork filling wrapped in soft dough, perfect for dim sum.	60	7	5	1	5	['Mix pork, veggies, and seasonings.', 'Place filling in wrappers.', 'Pleat and seal dumplings.', 'Steam for 10-12 minutes.', 'Serve with dipping sauce.']
REC-028	Chicken Teriyaki	Sweet and savory glazed chicken served with steamed rice.	25	8	5	0	0	['Pan-fry chicken until crispy.', 'Mix soy sauce, mirin, sake, sugar.', 'Pour sauce over chicken.', 'Simmer until glaze thickens.', 'Serve with rice and broccoli.']
REC-031	Garlic Naan Bread	Soft and bubbly flatbread topped with garlic butter and cilantro.	90	7	5	1	5	['Make dough and let rise.', 'Divide into balls.', 'Roll out flat.', 'Cook in a hot skillet.', 'Brush with garlic butter.']
REC-034	Pad See Ew	Thai stir-fried noodles with soy sauce, meat, and vegetables.	20	8	5	0	0	['Cook noodles.', 'Stir-fry chicken and garlic.', 'Push aside and scramble egg.', 'Add noodles and broccoli.', 'Toss with sauces until caramelized.']
REC-035	Shrimp Fried Rice	A quick and easy way to use leftover rice with fresh shrimp.	15	8	5	1	4	['Scramble eggs and remove.', 'Stir-fry shrimp and veggies.', 'Add cold rice.', 'Toss with soy sauce.', 'Mix in eggs and scallions.']
REC-036	Vegetable Tempura	Light and crispy battered fried vegetables.	30	7	5	0	0	['Cut vegetables.', 'Mix flour with ice water.', 'Dip veggies in batter.', 'Deep fry until light and crispy.', 'Serve immediately.']
REC-039	Vegetable Samosas	Crispy pastry pockets filled with spiced potatoes and peas.	60	7	5	1	5	['Make dough.', 'Cook spiced potato and pea filling.', 'Roll dough and fill cones.', 'Seal edges.', 'Deep fry until golden.']
REC-043	Mapo Tofu	Spicy and numbing tofu dish with minced meat.	25	7	5	1	4	['Fry pork until crispy.', 'Add chili bean paste and aromatics.', 'Pour in stock and tofu.', 'Simmer gently.', 'Thicken sauce with cornstarch.']
REC-044	Tonkotsu Ramen	Rich and creamy pork broth ramen with toppings.	120	7	5	0	0	['Boil broth for hours (or buy pre-made).', 'Cook noodles.', 'Assemble bowl with broth and noodles.', 'Top with pork, egg, and garnish.', 'Serve hot.']
REC-047	Butter Chicken	Mild and buttery tomato curry beloved worldwide.	50	7	5	1	5	['Cook marinated chicken.', 'Simmer sauce with butter and spices.', 'Blend sauce for smoothness.', 'Add cream and chicken.', 'Simmer until thick.']
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.tags (tag_id, tag_name) FROM stdin;
TAG-1	appetizer
TAG-2	asian
TAG-3	baking
TAG-4	bowl
TAG-5	bread
TAG-6	chinese
TAG-7	comfort-food
TAG-8	creamy
TAG-9	dim-sum
TAG-10	dinner
TAG-11	easy
TAG-12	fried
TAG-13	gluten-free
TAG-14	healthy
TAG-15	high-protein
TAG-16	indian
TAG-17	japanese
TAG-18	kids-friendly
TAG-19	korean
TAG-20	lunch
TAG-21	mild
TAG-22	noodle
TAG-23	noodles
TAG-24	pork
TAG-25	quick
TAG-26	seafood
TAG-27	side-dish
TAG-28	snack
TAG-29	soup
TAG-30	spicy
TAG-31	stir-fry
TAG-32	thai
TAG-33	vegan
TAG-34	vegetarian
TAG-35	vietnamese
\.


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (ingredient_id);


--
-- Name: nutrition nutrition_pkey; Type: CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.nutrition
    ADD CONSTRAINT nutrition_pkey PRIMARY KEY (recipe_id);


--
-- Name: recipe_tags recipe_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.recipe_tags
    ADD CONSTRAINT recipe_tags_pkey PRIMARY KEY (recipe_id, tag_id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (recipe_id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tag_id);


--
-- Name: average_rating; Type: INDEX; Schema: public; Owner: nikita
--

CREATE INDEX average_rating ON public.recipes USING btree (average_rating);


--
-- Name: ingredient_name; Type: INDEX; Schema: public; Owner: nikita
--

CREATE INDEX ingredient_name ON public.ingredients USING btree (ingredient_name);


--
-- Name: nutrition nutrition_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.nutrition
    ADD CONSTRAINT nutrition_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: recipe_ingredients recipe_ingredients_ingredient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_ingredient_id_fkey FOREIGN KEY (ingredient_id) REFERENCES public.ingredients(ingredient_id);


--
-- Name: recipe_ingredients recipe_ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.recipe_ingredients
    ADD CONSTRAINT recipe_ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: recipe_tags recipe_tags_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.recipe_tags
    ADD CONSTRAINT recipe_tags_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(recipe_id);


--
-- Name: recipe_tags recipe_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: nikita
--

ALTER TABLE ONLY public.recipe_tags
    ADD CONSTRAINT recipe_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(tag_id);


--
-- PostgreSQL database dump complete
--

\unrestrict bY0flcFQ2ulomdj4Sh0L8G1g4jjvkygRRCtKdgYW6ewg3LPNGeMQnPaw0g3UIV6

