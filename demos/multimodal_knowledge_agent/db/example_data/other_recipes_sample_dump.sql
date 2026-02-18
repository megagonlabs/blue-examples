--
-- PostgreSQL database dump
--

\restrict DHacUcz0xf9mmS3hpmFcCyrnB29omagwRnguS0R4QSDmlvJ8rXIZSjRfSEd5mFI

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
1	all-purpose flour
2	almond milk
3	apple cider vinegar
4	arborio rice
5	avocado
6	avocados
7	bacon
8	baguette
9	baking powder
10	baking soda
11	bbq sauce
12	bechamel sauce
13	beef broth
14	beef chuck
15	beef sirloin
16	beer
17	bell pepper
18	bell peppers
19	black beans
20	blue cheese
21	blue cheese dressing
22	bread
23	breadcrumbs
24	brown sugar
25	burger bun
26	butter
27	buttermilk
28	canned tomatoes
29	caraway seeds
30	carrots
31	celery
32	cheddar cheese
33	cheese
34	cherry tomatoes
35	chia seeds
36	chicken breast
37	chicken broth
38	chicken wings
39	chickpeas
40	cilantro
41	cinnamon
42	cocoa powder
43	cod fillets
44	corn
45	corn salsa
46	cucumber
47	cumin
48	dijon mustard
49	egg
50	egg noodles
51	eggplant
52	eggs
53	elbow macaroni
54	enchilada sauce
55	feta block
56	feta cheese
57	flour
58	flour tortillas
59	fruit
60	garlic
61	garlic powder
62	grilled chicken
63	ground beef
64	gruyere cheese
65	guacamole
66	ham
67	hard boiled eggs
68	heavy cream
69	honey
70	hot sauce
71	jalapeno
72	kalamata olives
73	ketchup
74	lasagna noodles
75	lemon juice
76	lettuce
77	lime juice
78	linguine pasta
79	maple syrup
80	marinara sauce
81	milk
82	mixed berries
83	monterey jack cheese
84	mozzarella cheese
85	mushrooms
86	mussels
87	mustard
88	nutmeg
89	oil
90	olive oil
91	onion
92	oregano
93	paprika
94	parmesan cheese
95	parsley
96	peas
97	pepperoni slices
98	pie crust
99	pinch of salt
100	pita bread
101	pizza dough
102	pork ribs
103	potatoes
104	quinoa
105	red onion
106	red pepper flakes
107	rice
108	ricotta cheese
109	ripe avocado
110	ripe bananas
111	rolled oats
112	romaine lettuce
113	saffron
114	salsa
115	salt
116	shredded chicken
117	shrimp
118	sour cream
119	spinach
120	sugar
121	taco seasoning
122	taco shells
123	tahini
124	tartar sauce
125	thyme
126	tomato
127	tomato sauce
128	tortillas
129	vanilla
130	vanilla extract
131	vegetable broth
132	vinaigrette
133	vinegar
134	walnuts
135	white wine
136	yellow onions
137	yogurt
138	zucchini
\.


--
-- Data for Name: nutrition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nutrition (recipe_id, calories, total_fat_pdv, sugar_pdv, sodium_pdv, protein_pdv, saturated_fat_pdv) FROM stdin;
2	650	45	12	40	50	30
3	280	25	15	2	5	8
4	320	18	4	22	12	6
5	700	35	8	55	30	25
6	520	22	3	28	14	15
7	350	16	25	10	6	10
8	480	20	2	30	35	12
9	300	8	14	3	10	1
10	580	28	10	45	22	18
13	600	35	10	30	25	20
14	550	30	4	40	30	12
16	400	20	15	45	18	10
18	750	40	2	35	30	8
21	850	50	30	45	55	20
22	150	15	1	10	2	2
24	250	10	8	5	5	1
26	680	35	4	30	40	18
29	620	40	3	35	45	12
30	580	25	5	45	30	12
32	520	35	2	25	18	18
33	350	18	8	25	15	4
37	450	15	25	20	10	8
38	350	20	2	25	12	10
40	220	8	12	5	6	4
41	480	20	4	25	15	3
42	550	15	3	35	30	4
45	650	40	1	55	35	15
46	550	25	5	30	35	8
48	520	30	4	45	25	18
49	280	22	5	25	8	10
50	480	20	5	30	40	8
\.


--
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_ingredients (recipe_id, ingredient_id) FROM stdin;
2	63
2	25
2	76
2	126
2	32
2	91
2	73
2	87
3	109
3	42
3	79
3	130
3	2
3	99
4	104
4	46
4	34
4	72
4	56
4	90
4	75
4	105
5	101
5	127
5	84
5	97
5	92
5	90
6	4
6	85
6	131
6	135
6	91
6	26
6	94
6	125
7	110
7	1
7	120
7	26
7	52
7	134
7	10
7	41
8	117
8	78
8	26
8	60
8	75
8	95
8	106
8	135
9	111
9	35
9	2
9	137
9	69
9	82
10	74
10	80
10	138
10	18
10	119
10	108
10	84
10	49
13	53
13	32
13	81
13	26
13	57
13	23
13	93
14	63
14	122
14	76
14	32
14	126
14	121
14	118
16	136
16	13
16	8
16	64
16	26
16	125
16	135
18	43
18	103
18	57
18	16
18	9
18	89
18	124
21	102
21	11
21	24
21	93
21	61
21	3
22	6
22	77
22	40
22	91
22	71
22	126
22	115
24	51
24	138
24	18
24	126
24	91
24	60
24	125
24	90
26	15
26	50
26	85
26	91
26	118
26	13
26	87
26	26
29	112
29	36
29	7
29	67
29	5
29	20
29	126
29	132
30	128
30	116
30	54
30	33
30	19
30	44
30	91
32	98
32	52
32	68
32	7
32	64
32	91
32	88
33	52
33	28
33	17
33	91
33	60
33	47
33	93
33	22
37	57
37	27
37	52
37	120
37	9
37	26
37	79
38	58
38	32
38	83
38	26
38	114
38	118
40	57
40	81
40	52
40	26
40	120
40	129
40	59
41	39
41	95
41	60
41	47
41	100
41	123
41	46
42	107
42	113
42	117
42	86
42	18
42	96
42	37
45	38
45	70
45	26
45	133
45	31
45	21
46	107
46	19
46	62
46	45
46	65
46	76
46	33
48	22
48	66
48	64
48	12
48	26
48	48
49	46
49	126
49	72
49	105
49	55
49	92
49	90
50	14
50	91
50	93
50	30
50	103
50	13
50	29
\.


--
-- Data for Name: recipe_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipe_tags (recipe_id, tag_id) FROM stdin;
2	1
2	29
2	22
2	11
3	51
3	13
3	23
3	20
4	41
4	32
4	52
4	29
5	26
5	14
5	3
5	27
6	26
6	14
6	52
6	11
7	3
7	6
7	49
7	44
8	43
8	14
8	38
8	12
9	6
9	23
9	35
9	52
10	14
10	52
10	26
10	30
13	1
13	14
13	11
13	27
14	33
14	14
14	39
14	16
16	17
16	45
16	14
16	11
18	7
18	14
18	19
18	43
21	1
21	14
21	4
21	31
22	33
22	15
22	44
22	51
24	17
24	51
24	14
24	23
26	40
26	14
26	38
26	11
29	1
29	41
29	29
29	28
30	33
30	14
30	9
30	47
32	17
32	6
32	8
32	3
33	34
33	6
33	52
33	36
37	1
37	6
37	49
37	27
38	33
38	29
38	39
38	27
40	17
40	6
40	13
40	50
41	34
41	29
41	51
41	23
42	46
42	14
42	43
42	37
45	1
45	2
45	47
45	37
46	33
46	29
46	23
46	5
48	17
48	29
48	42
48	10
49	21
49	41
49	52
49	18
50	25
50	48
50	14
50	24
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipes (recipe_id, name, description, cook_time_min, ingredient_count, n_steps, review_count, average_rating, instructions) FROM stdin;
2	Classic Beef Burger	Juicy homemade beef burgers that taste better than takeout.	30	8	5	1	5	['Form beef into patties and season with salt and pepper.', 'Grill patties for 4 minutes per side.', 'Add cheese in the last minute of cooking.', 'Toast buns on the grill.', 'Assemble burger with vegetables and condiments.']
3	Vegan Avocado Chocolate Mousse	A rich and creamy chocolate dessert that is secretly healthy and plant-based.	10	6	4	1	3	['Scoop avocado flesh into a blender.', 'Add cocoa powder, maple syrup, vanilla, milk, and salt.', 'Blend until completely smooth and creamy.', 'Chill in the fridge for at least 30 minutes before serving.']
4	Mediterranean Quinoa Salad	Fresh and light salad packed with protein and vibrant veggies.	20	8	5	2	5	['Rinse and cook quinoa according to package instructions.', 'Chop cucumber, tomatoes, and onion.', 'Whisk olive oil and lemon juice together.', 'Combine cooled quinoa with vegetables and dressing.', 'Top with crumbled feta and olives.']
5	Homemade Pepperoni Pizza	Better than delivery, this classic pepperoni pizza has a crispy crust and gooey cheese.	45	6	5	0	0	['Preheat oven to 475°F (245°C).', 'Roll out the pizza dough on a floured surface.', 'Spread tomato sauce evenly over dough.', 'Sprinkle cheese and arrange pepperoni on top.', 'Bake for 12-15 minutes until crust is golden.']
6	Creamy Mushroom Risotto	Luxurious and creamy Italian rice dish with earthy mushroom flavors.	40	8	5	1	5	['Sauté onions and mushrooms in butter.', 'Add rice and toast for 2 minutes.', 'Pour in white wine and stir until absorbed.', 'Gradually add warm broth one ladle at a time, stirring constantly.', 'Stir in parmesan and thyme before serving.']
7	Banana Walnut Bread	Moist and flavorful banana bread with the perfect crunch from walnuts.	75	8	5	1	4	['Preheat oven to 350°F (175°C).', 'Mash bananas in a bowl.', 'Mix in melted butter, sugar, and egg.', 'Fold in dry ingredients and chopped walnuts.', 'Pour batter into a loaf pan and bake for 60 minutes.']
8	Garlic Butter Shrimp Scampi	Elegant and easy shrimp pasta dish ready in minutes.	20	8	5	1	5	['Cook pasta until al dente.', 'Sauté garlic and red pepper flakes in butter.', 'Add shrimp and cook until pink.', 'Deglaze pan with wine and lemon juice.', 'Toss pasta with the shrimp sauce and parsley.']
9	Overnight Oats with Berries	The perfect grab-and-go breakfast for busy mornings.	5	6	5	2	4	['Combine oats, chia seeds, milk, yogurt, and honey in a jar.', 'Stir well to combine.', 'Top with fresh berries.', 'Cover and refrigerate overnight (or at least 4 hours).', 'Enjoy cold the next morning.']
10	Roasted Vegetable Lasagna	Hearty vegetarian lasagna packed with roasted vegetables and cheesy goodness.	90	8	5	1	5	['Roast chopped zucchini and peppers in the oven.', 'Mix ricotta with egg and spinach.', 'Spread sauce in a baking dish.', 'Layer noodles, cheese mixture, roasted veggies, and sauce.', 'Repeat layers and top with mozzarella. Bake for 45 mins.']
13	Baked Mac and Cheese	Rich and creamy homemade macaroni and cheese with a crispy topping.	50	7	5	1	5	['Cook macaroni.', 'Make a roux with butter and flour, then whisk in milk.', 'Stir in cheese until melted.', 'Combine with pasta and top with breadcrumbs.', 'Bake until golden and bubbly.']
14	Classic Beef Tacos	Crunchy hard-shell tacos filled with seasoned beef and fresh toppings.	20	7	5	1	4	['Brown beef in a skillet.', 'Add seasoning and water, simmer.', 'Warm taco shells.', 'Fill shells with meat and toppings.', 'Serve immediately.']
16	Classic French Onion Soup	Deeply savory soup with sweet caramelized onions and a cheesy bread topping.	90	7	5	0	0	['Caramelize onions slowly in butter.', 'Deglaze with wine and add broth.', 'Simmer for 30 minutes.', 'Top with bread and cheese.', 'Broil until bubbly and brown.']
18	Fish and Chips	Traditional British dish of crispy battered fish served with chunky fries.	45	7	5	1	4	['Cut potatoes into chips and fry.', 'Make batter with flour and beer.', 'Dip fish in batter.', 'Deep fry fish until golden.', 'Serve with chips and tartar sauce.']
21	BBQ Pork Ribs	Tender, fall-off-the-bone pork ribs slathered in sticky barbecue sauce.	180	6	5	1	5	['Rub ribs with spice mixture.', 'Bake low and slow covered for 2.5 hours.', 'Brush with BBQ sauce.', 'Broil or grill to caramelize sauce.', 'Serve with coleslaw.']
22	Fresh Guacamole	Creamy and zesty avocado dip perfect for chips or tacos.	10	7	5	0	0	['Mash avocados.', 'Stir in lime juice immediately.', 'Mix in chopped vegetables and cilantro.', 'Season with salt to taste.', 'Serve with tortilla chips.']
24	Classic Ratatouille	A rustic French vegetable stew originating from Nice.	60	8	5	0	0	['Slice all vegetables thinly.', 'Layer vegetables in a baking dish.', 'Drizzle with oil and herbs.', 'Cover and bake until tender.', 'Serve hot or cold.']
26	Beef Stroganoff	Tender beef and mushrooms in a rich sour cream sauce.	30	8	5	1	4	['Sear beef strips quickly.', 'Sauté mushrooms and onions.', 'Make sauce with broth and sour cream.', 'Return beef to pan.', 'Serve over egg noodles.']
29	Classic Cobb Salad	A hearty American garden salad with rows of delicious toppings.	30	8	5	1	5	['Cook bacon and chicken.', 'Chop all ingredients.', 'Arrange in rows over lettuce.', 'Drizzle with vinaigrette.', 'Toss before eating.']
30	Chicken Enchiladas	Tortillas stuffed with chicken and beans, baked in a spicy red sauce.	45	7	5	0	0	['Mix chicken with beans and corn.', 'Fill tortillas and roll.', 'Place in baking dish.', 'Cover with sauce and cheese.', 'Bake until bubbly.']
32	Quiche Lorraine	A rich savory tart with a custard filling, bacon, and cheese.	60	7	5	0	0	['Blind bake the crust.', 'Fry bacon and onions.', 'Whisk eggs and cream.', 'Add filling to crust.', 'Bake until set.']
33	Shakshuka	Poached eggs in a spicy tomato and pepper sauce, served with bread.	25	8	5	1	5	['Sauté veggies and spices.', 'Add tomatoes and simmer.', 'Make wells in sauce.', 'Crack eggs into wells.', 'Cover and cook until eggs set.']
37	Buttermilk Pancakes	Fluffy and tangy pancakes perfect for a weekend breakfast.	20	7	5	1	5	['Mix dry ingredients.', 'Whisk wet ingredients.', 'Combine gently (do not overmix).', 'Cook on griddle until bubbly.', 'Serve with syrup.']
38	Cheese Quesadilla	Crispy tortillas filled with melted cheese.	10	6	5	0	0	['Butter one side of tortilla.', 'Place in pan, butter side down.', 'Top with cheese and fold.', 'Cook until golden and melty.', 'Cut into wedges.']
40	Sweet Crepes	Delicate and thin French pancakes, perfect with sweet fillings.	30	7	5	0	0	['Blend batter ingredients.', 'Let rest.', 'Pour thin layer into pan.', 'Cook briefly on both sides.', 'Fill with fruit or chocolate.']
41	Falafel Wrap	Crispy fried chickpea balls served in a soft pita with sauce.	45	7	5	1	5	['Blend soaked chickpeas with herbs.', 'Form into balls and fry.', 'Warm pita bread.', 'Fill with falafel and salad.', 'Drizzle with tahini.']
42	Seafood Paella	Iconic Spanish rice dish cooked with saffron and mixed seafood.	50	7	5	0	0	['Sauté veggies.', 'Add rice and saffron broth.', 'Simmer without stirring.', 'Top with seafood.', 'Cook until rice is tender and seafood is done.']
45	Buffalo Chicken Wings	Classic spicy wings perfect for game day.	45	6	4	1	5	['Bake or fry wings until crispy.', 'Melt butter and mix with hot sauce.', 'Toss wings in sauce.', 'Serve with celery and dip.']
46	Burrito Bowl	A deconstructed burrito without the tortilla.	25	7	5	0	0	['Cook rice with cilantro and lime.', 'Grill chicken.', 'Assemble bowls with rice base.', 'Top with beans, meat, and salsas.', 'Serve cold or warm.']
48	Croque Monsieur	The ultimate French grilled ham and cheese sandwich.	20	6	5	0	0	['Make bechamel sauce.', 'Assemble sandwich with ham and cheese.', 'Top with sauce and more cheese.', 'Broil until browned.', 'Serve hot.']
49	Greek Salad	Traditional peasant salad with fresh veggies and slab of feta.	15	7	5	1	4	['Chop vegetables into chunks.', 'Place slice of feta on top.', 'Sprinkle with oregano.', 'Drizzle generously with olive oil.', 'Serve immediately.']
50	Hungarian Goulash	A hearty beef and potato stew seasoned generously with paprika.	150	7	5	1	5	['Sauté onions and beef.', 'Add paprika and broth.', 'Simmer for 1.5 hours.', 'Add vegetables.', 'Cook until tender.']
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (tag_id, tag_name) FROM stdin;
1	american
2	appetizer
3	baking
4	bbq
5	bowl
6	breakfast
7	british
8	brunch
9	casserole
10	cheesy
11	comfort-food
12	date-night
13	dessert
14	dinner
15	dip
16	family-friendly
17	french
18	fresh
19	fried
20	gluten-free
21	greek
22	grilled
23	healthy
24	hearty
25	hungarian
26	italian
27	kids-friendly
28	low-carb
29	lunch
30	main-course
31	meat-lover
32	mediterranean
33	mexican
34	middle-eastern
35	no-cook
36	one-pan
37	party
38	pasta
39	quick
40	russian
41	salad
42	sandwich
43	seafood
44	snack
45	soup
46	spanish
47	spicy
48	stew
49	sweet
50	thin
51	vegan
52	vegetarian
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

\unrestrict DHacUcz0xf9mmS3hpmFcCyrnB29omagwRnguS0R4QSDmlvJ8rXIZSjRfSEd5mFI
