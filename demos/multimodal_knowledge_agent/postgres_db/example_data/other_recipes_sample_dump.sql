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
ING-1	all-purpose flour
ING-2	almond milk
ING-3	apple cider vinegar
ING-4	arborio rice
ING-5	avocado
ING-6	avocados
ING-7	bacon
ING-8	baguette
ING-9	baking powder
ING-10	baking soda
ING-11	bbq sauce
ING-12	bechamel sauce
ING-13	beef broth
ING-14	beef chuck
ING-15	beef sirloin
ING-16	beer
ING-17	bell pepper
ING-18	bell peppers
ING-19	black beans
ING-20	blue cheese
ING-21	blue cheese dressing
ING-22	bread
ING-23	breadcrumbs
ING-24	brown sugar
ING-25	burger bun
ING-26	butter
ING-27	buttermilk
ING-28	canned tomatoes
ING-29	caraway seeds
ING-30	carrots
ING-31	celery
ING-32	cheddar cheese
ING-33	cheese
ING-34	cherry tomatoes
ING-35	chia seeds
ING-36	chicken breast
ING-37	chicken broth
ING-38	chicken wings
ING-39	chickpeas
ING-40	cilantro
ING-41	cinnamon
ING-42	cocoa powder
ING-43	cod fillets
ING-44	corn
ING-45	corn salsa
ING-46	cucumber
ING-47	cumin
ING-48	dijon mustard
ING-49	egg
ING-50	egg noodles
ING-51	eggplant
ING-52	eggs
ING-53	elbow macaroni
ING-54	enchilada sauce
ING-55	feta block
ING-56	feta cheese
ING-57	flour
ING-58	flour tortillas
ING-59	fruit
ING-60	garlic
ING-61	garlic powder
ING-62	grilled chicken
ING-63	ground beef
ING-64	gruyere cheese
ING-65	guacamole
ING-66	ham
ING-67	hard boiled eggs
ING-68	heavy cream
ING-69	honey
ING-70	hot sauce
ING-71	jalapeno
ING-72	kalamata olives
ING-73	ketchup
ING-74	lasagna noodles
ING-75	lemon juice
ING-76	lettuce
ING-77	lime juice
ING-78	linguine pasta
ING-79	maple syrup
ING-80	marinara sauce
ING-81	milk
ING-82	mixed berries
ING-83	monterey jack cheese
ING-84	mozzarella cheese
ING-85	mushrooms
ING-86	mussels
ING-87	mustard
ING-88	nutmeg
ING-89	oil
ING-90	olive oil
ING-91	onion
ING-92	oregano
ING-93	paprika
ING-94	parmesan cheese
ING-95	parsley
ING-96	peas
ING-97	pepperoni slices
ING-98	pie crust
ING-99	pinch of salt
ING-100	pita bread
ING-101	pizza dough
ING-102	pork ribs
ING-103	potatoes
ING-104	quinoa
ING-105	red onion
ING-106	red pepper flakes
ING-107	rice
ING-108	ricotta cheese
ING-109	ripe avocado
ING-110	ripe bananas
ING-111	rolled oats
ING-112	romaine lettuce
ING-113	saffron
ING-114	salsa
ING-115	salt
ING-116	shredded chicken
ING-117	shrimp
ING-118	sour cream
ING-119	spinach
ING-120	sugar
ING-121	taco seasoning
ING-122	taco shells
ING-123	tahini
ING-124	tartar sauce
ING-125	thyme
ING-126	tomato
ING-127	tomato sauce
ING-128	tortillas
ING-129	vanilla
ING-130	vanilla extract
ING-131	vegetable broth
ING-132	vinaigrette
ING-133	vinegar
ING-134	walnuts
ING-135	white wine
ING-136	yellow onions
ING-137	yogurt
ING-138	zucchini
\.


--
-- Data for Name: nutrition; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.nutrition (recipe_id, calories, total_fat_pdv, sugar_pdv, sodium_pdv, protein_pdv, saturated_fat_pdv) FROM stdin;
REC-002	650	45	12	40	50	30
REC-003	280	25	15	2	5	8
REC-004	320	18	4	22	12	6
REC-005	700	35	8	55	30	25
REC-006	520	22	3	28	14	15
REC-007	350	16	25	10	6	10
REC-008	480	20	2	30	35	12
REC-009	300	8	14	3	10	1
REC-010	580	28	10	45	22	18
REC-013	600	35	10	30	25	20
REC-014	550	30	4	40	30	12
REC-016	400	20	15	45	18	10
REC-018	750	40	2	35	30	8
REC-021	850	50	30	45	55	20
REC-022	150	15	1	10	2	2
REC-024	250	10	8	5	5	1
REC-026	680	35	4	30	40	18
REC-029	620	40	3	35	45	12
REC-030	580	25	5	45	30	12
REC-032	520	35	2	25	18	18
REC-033	350	18	8	25	15	4
REC-037	450	15	25	20	10	8
REC-038	350	20	2	25	12	10
REC-040	220	8	12	5	6	4
REC-041	480	20	4	25	15	3
REC-042	550	15	3	35	30	4
REC-045	650	40	1	55	35	15
REC-046	550	25	5	30	35	8
REC-048	520	30	4	45	25	18
REC-049	280	22	5	25	8	10
REC-050	480	20	5	30	40	8
\.


--
-- Data for Name: recipe_ingredients; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.recipe_ingredients (recipe_id, ingredient_id) FROM stdin;
REC-002	ING-63
REC-002	ING-25
REC-002	ING-76
REC-002	ING-126
REC-002	ING-32
REC-002	ING-91
REC-002	ING-73
REC-002	ING-87
REC-003	ING-109
REC-003	ING-42
REC-003	ING-79
REC-003	ING-130
REC-003	ING-2
REC-003	ING-99
REC-004	ING-104
REC-004	ING-46
REC-004	ING-34
REC-004	ING-72
REC-004	ING-56
REC-004	ING-90
REC-004	ING-75
REC-004	ING-105
REC-005	ING-101
REC-005	ING-127
REC-005	ING-84
REC-005	ING-97
REC-005	ING-92
REC-005	ING-90
REC-006	ING-4
REC-006	ING-85
REC-006	ING-131
REC-006	ING-135
REC-006	ING-91
REC-006	ING-26
REC-006	ING-94
REC-006	ING-125
REC-007	ING-110
REC-007	ING-1
REC-007	ING-120
REC-007	ING-26
REC-007	ING-52
REC-007	ING-134
REC-007	ING-10
REC-007	ING-41
REC-008	ING-117
REC-008	ING-78
REC-008	ING-26
REC-008	ING-60
REC-008	ING-75
REC-008	ING-95
REC-008	ING-106
REC-008	ING-135
REC-009	ING-111
REC-009	ING-35
REC-009	ING-2
REC-009	ING-137
REC-009	ING-69
REC-009	ING-82
REC-010	ING-74
REC-010	ING-80
REC-010	ING-138
REC-010	ING-18
REC-010	ING-119
REC-010	ING-108
REC-010	ING-84
REC-010	ING-49
REC-013	ING-53
REC-013	ING-32
REC-013	ING-81
REC-013	ING-26
REC-013	ING-57
REC-013	ING-23
REC-013	ING-93
REC-014	ING-63
REC-014	ING-122
REC-014	ING-76
REC-014	ING-32
REC-014	ING-126
REC-014	ING-121
REC-014	ING-118
REC-016	ING-136
REC-016	ING-13
REC-016	ING-8
REC-016	ING-64
REC-016	ING-26
REC-016	ING-125
REC-016	ING-135
REC-018	ING-43
REC-018	ING-103
REC-018	ING-57
REC-018	ING-16
REC-018	ING-9
REC-018	ING-89
REC-018	ING-124
REC-021	ING-102
REC-021	ING-11
REC-021	ING-24
REC-021	ING-93
REC-021	ING-61
REC-021	ING-3
REC-022	ING-6
REC-022	ING-77
REC-022	ING-40
REC-022	ING-91
REC-022	ING-71
REC-022	ING-126
REC-022	ING-115
REC-024	ING-51
REC-024	ING-138
REC-024	ING-18
REC-024	ING-126
REC-024	ING-91
REC-024	ING-60
REC-024	ING-125
REC-024	ING-90
REC-026	ING-15
REC-026	ING-50
REC-026	ING-85
REC-026	ING-91
REC-026	ING-118
REC-026	ING-13
REC-026	ING-87
REC-026	ING-26
REC-029	ING-112
REC-029	ING-36
REC-029	ING-7
REC-029	ING-67
REC-029	ING-5
REC-029	ING-20
REC-029	ING-126
REC-029	ING-132
REC-030	ING-128
REC-030	ING-116
REC-030	ING-54
REC-030	ING-33
REC-030	ING-19
REC-030	ING-44
REC-030	ING-91
REC-032	ING-98
REC-032	ING-52
REC-032	ING-68
REC-032	ING-7
REC-032	ING-64
REC-032	ING-91
REC-032	ING-88
REC-033	ING-52
REC-033	ING-28
REC-033	ING-17
REC-033	ING-91
REC-033	ING-60
REC-033	ING-47
REC-033	ING-93
REC-033	ING-22
REC-037	ING-57
REC-037	ING-27
REC-037	ING-52
REC-037	ING-120
REC-037	ING-9
REC-037	ING-26
REC-037	ING-79
REC-038	ING-58
REC-038	ING-32
REC-038	ING-83
REC-038	ING-26
REC-038	ING-114
REC-038	ING-118
REC-040	ING-57
REC-040	ING-81
REC-040	ING-52
REC-040	ING-26
REC-040	ING-120
REC-040	ING-129
REC-040	ING-59
REC-041	ING-39
REC-041	ING-95
REC-041	ING-60
REC-041	ING-47
REC-041	ING-100
REC-041	ING-123
REC-041	ING-46
REC-042	ING-107
REC-042	ING-113
REC-042	ING-117
REC-042	ING-86
REC-042	ING-18
REC-042	ING-96
REC-042	ING-37
REC-045	ING-38
REC-045	ING-70
REC-045	ING-26
REC-045	ING-133
REC-045	ING-31
REC-045	ING-21
REC-046	ING-107
REC-046	ING-19
REC-046	ING-62
REC-046	ING-45
REC-046	ING-65
REC-046	ING-76
REC-046	ING-33
REC-048	ING-22
REC-048	ING-66
REC-048	ING-64
REC-048	ING-12
REC-048	ING-26
REC-048	ING-48
REC-049	ING-46
REC-049	ING-126
REC-049	ING-72
REC-049	ING-105
REC-049	ING-55
REC-049	ING-92
REC-049	ING-90
REC-050	ING-14
REC-050	ING-91
REC-050	ING-93
REC-050	ING-30
REC-050	ING-103
REC-050	ING-13
REC-050	ING-29
\.


--
-- Data for Name: recipe_tags; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.recipe_tags (recipe_id, tag_id) FROM stdin;
REC-002	TAG-1
REC-002	TAG-29
REC-002	TAG-22
REC-002	TAG-11
REC-003	TAG-51
REC-003	TAG-13
REC-003	TAG-23
REC-003	TAG-20
REC-004	TAG-41
REC-004	TAG-32
REC-004	TAG-52
REC-004	TAG-29
REC-005	TAG-26
REC-005	TAG-14
REC-005	TAG-3
REC-005	TAG-27
REC-006	TAG-26
REC-006	TAG-14
REC-006	TAG-52
REC-006	TAG-11
REC-007	TAG-3
REC-007	TAG-6
REC-007	TAG-49
REC-007	TAG-44
REC-008	TAG-43
REC-008	TAG-14
REC-008	TAG-38
REC-008	TAG-12
REC-009	TAG-6
REC-009	TAG-23
REC-009	TAG-35
REC-009	TAG-52
REC-010	TAG-14
REC-010	TAG-52
REC-010	TAG-26
REC-010	TAG-30
REC-013	TAG-1
REC-013	TAG-14
REC-013	TAG-11
REC-013	TAG-27
REC-014	TAG-33
REC-014	TAG-14
REC-014	TAG-39
REC-014	TAG-16
REC-016	TAG-17
REC-016	TAG-45
REC-016	TAG-14
REC-016	TAG-11
REC-018	TAG-7
REC-018	TAG-14
REC-018	TAG-19
REC-018	TAG-43
REC-021	TAG-1
REC-021	TAG-14
REC-021	TAG-4
REC-021	TAG-31
REC-022	TAG-33
REC-022	TAG-15
REC-022	TAG-44
REC-022	TAG-51
REC-024	TAG-17
REC-024	TAG-51
REC-024	TAG-14
REC-024	TAG-23
REC-026	TAG-40
REC-026	TAG-14
REC-026	TAG-38
REC-026	TAG-11
REC-029	TAG-1
REC-029	TAG-41
REC-029	TAG-29
REC-029	TAG-28
REC-030	TAG-33
REC-030	TAG-14
REC-030	TAG-9
REC-030	TAG-47
REC-032	TAG-17
REC-032	TAG-6
REC-032	TAG-8
REC-032	TAG-3
REC-033	TAG-34
REC-033	TAG-6
REC-033	TAG-52
REC-033	TAG-36
REC-037	TAG-1
REC-037	TAG-6
REC-037	TAG-49
REC-037	TAG-27
REC-038	TAG-33
REC-038	TAG-29
REC-038	TAG-39
REC-038	TAG-27
REC-040	TAG-17
REC-040	TAG-6
REC-040	TAG-13
REC-040	TAG-50
REC-041	TAG-34
REC-041	TAG-29
REC-041	TAG-51
REC-041	TAG-23
REC-042	TAG-46
REC-042	TAG-14
REC-042	TAG-43
REC-042	TAG-37
REC-045	TAG-1
REC-045	TAG-2
REC-045	TAG-47
REC-045	TAG-37
REC-046	TAG-33
REC-046	TAG-29
REC-046	TAG-23
REC-046	TAG-5
REC-048	TAG-17
REC-048	TAG-29
REC-048	TAG-42
REC-048	TAG-10
REC-049	TAG-21
REC-049	TAG-41
REC-049	TAG-52
REC-049	TAG-18
REC-050	TAG-25
REC-050	TAG-48
REC-050	TAG-14
REC-050	TAG-24
\.


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.recipes (recipe_id, name, description, cook_time_min, ingredient_count, n_steps, review_count, average_rating, instructions) FROM stdin;
REC-002	Classic Beef Burger	Juicy homemade beef burgers that taste better than takeout.	30	8	5	1	5	['Form beef into patties and season with salt and pepper.', 'Grill patties for 4 minutes per side.', 'Add cheese in the last minute of cooking.', 'Toast buns on the grill.', 'Assemble burger with vegetables and condiments.']
REC-003	Vegan Avocado Chocolate Mousse	A rich and creamy chocolate dessert that is secretly healthy and plant-based.	10	6	4	1	3	['Scoop avocado flesh into a blender.', 'Add cocoa powder, maple syrup, vanilla, milk, and salt.', 'Blend until completely smooth and creamy.', 'Chill in the fridge for at least 30 minutes before serving.']
REC-004	Mediterranean Quinoa Salad	Fresh and light salad packed with protein and vibrant veggies.	20	8	5	2	5	['Rinse and cook quinoa according to package instructions.', 'Chop cucumber, tomatoes, and onion.', 'Whisk olive oil and lemon juice together.', 'Combine cooled quinoa with vegetables and dressing.', 'Top with crumbled feta and olives.']
REC-005	Homemade Pepperoni Pizza	Better than delivery, this classic pepperoni pizza has a crispy crust and gooey cheese.	45	6	5	0	0	['Preheat oven to 475°F (245°C).', 'Roll out the pizza dough on a floured surface.', 'Spread tomato sauce evenly over dough.', 'Sprinkle cheese and arrange pepperoni on top.', 'Bake for 12-15 minutes until crust is golden.']
REC-006	Creamy Mushroom Risotto	Luxurious and creamy Italian rice dish with earthy mushroom flavors.	40	8	5	1	5	['Sauté onions and mushrooms in butter.', 'Add rice and toast for 2 minutes.', 'Pour in white wine and stir until absorbed.', 'Gradually add warm broth one ladle at a time, stirring constantly.', 'Stir in parmesan and thyme before serving.']
REC-007	Banana Walnut Bread	Moist and flavorful banana bread with the perfect crunch from walnuts.	75	8	5	1	4	['Preheat oven to 350°F (175°C).', 'Mash bananas in a bowl.', 'Mix in melted butter, sugar, and egg.', 'Fold in dry ingredients and chopped walnuts.', 'Pour batter into a loaf pan and bake for 60 minutes.']
REC-008	Garlic Butter Shrimp Scampi	Elegant and easy shrimp pasta dish ready in minutes.	20	8	5	1	5	['Cook pasta until al dente.', 'Sauté garlic and red pepper flakes in butter.', 'Add shrimp and cook until pink.', 'Deglaze pan with wine and lemon juice.', 'Toss pasta with the shrimp sauce and parsley.']
REC-009	Overnight Oats with Berries	The perfect grab-and-go breakfast for busy mornings.	5	6	5	2	4	['Combine oats, chia seeds, milk, yogurt, and honey in a jar.', 'Stir well to combine.', 'Top with fresh berries.', 'Cover and refrigerate overnight (or at least 4 hours).', 'Enjoy cold the next morning.']
REC-010	Roasted Vegetable Lasagna	Hearty vegetarian lasagna packed with roasted vegetables and cheesy goodness.	90	8	5	1	5	['Roast chopped zucchini and peppers in the oven.', 'Mix ricotta with egg and spinach.', 'Spread sauce in a baking dish.', 'Layer noodles, cheese mixture, roasted veggies, and sauce.', 'Repeat layers and top with mozzarella. Bake for 45 mins.']
REC-013	Baked Mac and Cheese	Rich and creamy homemade macaroni and cheese with a crispy topping.	50	7	5	1	5	['Cook macaroni.', 'Make a roux with butter and flour, then whisk in milk.', 'Stir in cheese until melted.', 'Combine with pasta and top with breadcrumbs.', 'Bake until golden and bubbly.']
REC-014	Classic Beef Tacos	Crunchy hard-shell tacos filled with seasoned beef and fresh toppings.	20	7	5	1	4	['Brown beef in a skillet.', 'Add seasoning and water, simmer.', 'Warm taco shells.', 'Fill shells with meat and toppings.', 'Serve immediately.']
REC-016	Classic French Onion Soup	Deeply savory soup with sweet caramelized onions and a cheesy bread topping.	90	7	5	0	0	['Caramelize onions slowly in butter.', 'Deglaze with wine and add broth.', 'Simmer for 30 minutes.', 'Top with bread and cheese.', 'Broil until bubbly and brown.']
REC-018	Fish and Chips	Traditional British dish of crispy battered fish served with chunky fries.	45	7	5	1	4	['Cut potatoes into chips and fry.', 'Make batter with flour and beer.', 'Dip fish in batter.', 'Deep fry fish until golden.', 'Serve with chips and tartar sauce.']
REC-021	BBQ Pork Ribs	Tender, fall-off-the-bone pork ribs slathered in sticky barbecue sauce.	180	6	5	1	5	['Rub ribs with spice mixture.', 'Bake low and slow covered for 2.5 hours.', 'Brush with BBQ sauce.', 'Broil or grill to caramelize sauce.', 'Serve with coleslaw.']
REC-022	Fresh Guacamole	Creamy and zesty avocado dip perfect for chips or tacos.	10	7	5	0	0	['Mash avocados.', 'Stir in lime juice immediately.', 'Mix in chopped vegetables and cilantro.', 'Season with salt to taste.', 'Serve with tortilla chips.']
REC-024	Classic Ratatouille	A rustic French vegetable stew originating from Nice.	60	8	5	0	0	['Slice all vegetables thinly.', 'Layer vegetables in a baking dish.', 'Drizzle with oil and herbs.', 'Cover and bake until tender.', 'Serve hot or cold.']
REC-026	Beef Stroganoff	Tender beef and mushrooms in a rich sour cream sauce.	30	8	5	1	4	['Sear beef strips quickly.', 'Sauté mushrooms and onions.', 'Make sauce with broth and sour cream.', 'Return beef to pan.', 'Serve over egg noodles.']
REC-029	Classic Cobb Salad	A hearty American garden salad with rows of delicious toppings.	30	8	5	1	5	['Cook bacon and chicken.', 'Chop all ingredients.', 'Arrange in rows over lettuce.', 'Drizzle with vinaigrette.', 'Toss before eating.']
REC-030	Chicken Enchiladas	Tortillas stuffed with chicken and beans, baked in a spicy red sauce.	45	7	5	0	0	['Mix chicken with beans and corn.', 'Fill tortillas and roll.', 'Place in baking dish.', 'Cover with sauce and cheese.', 'Bake until bubbly.']
REC-032	Quiche Lorraine	A rich savory tart with a custard filling, bacon, and cheese.	60	7	5	0	0	['Blind bake the crust.', 'Fry bacon and onions.', 'Whisk eggs and cream.', 'Add filling to crust.', 'Bake until set.']
REC-033	Shakshuka	Poached eggs in a spicy tomato and pepper sauce, served with bread.	25	8	5	1	5	['Sauté veggies and spices.', 'Add tomatoes and simmer.', 'Make wells in sauce.', 'Crack eggs into wells.', 'Cover and cook until eggs set.']
REC-037	Buttermilk Pancakes	Fluffy and tangy pancakes perfect for a weekend breakfast.	20	7	5	1	5	['Mix dry ingredients.', 'Whisk wet ingredients.', 'Combine gently (do not overmix).', 'Cook on griddle until bubbly.', 'Serve with syrup.']
REC-038	Cheese Quesadilla	Crispy tortillas filled with melted cheese.	10	6	5	0	0	['Butter one side of tortilla.', 'Place in pan, butter side down.', 'Top with cheese and fold.', 'Cook until golden and melty.', 'Cut into wedges.']
REC-040	Sweet Crepes	Delicate and thin French pancakes, perfect with sweet fillings.	30	7	5	0	0	['Blend batter ingredients.', 'Let rest.', 'Pour thin layer into pan.', 'Cook briefly on both sides.', 'Fill with fruit or chocolate.']
REC-041	Falafel Wrap	Crispy fried chickpea balls served in a soft pita with sauce.	45	7	5	1	5	['Blend soaked chickpeas with herbs.', 'Form into balls and fry.', 'Warm pita bread.', 'Fill with falafel and salad.', 'Drizzle with tahini.']
REC-042	Seafood Paella	Iconic Spanish rice dish cooked with saffron and mixed seafood.	50	7	5	0	0	['Sauté veggies.', 'Add rice and saffron broth.', 'Simmer without stirring.', 'Top with seafood.', 'Cook until rice is tender and seafood is done.']
REC-045	Buffalo Chicken Wings	Classic spicy wings perfect for game day.	45	6	4	1	5	['Bake or fry wings until crispy.', 'Melt butter and mix with hot sauce.', 'Toss wings in sauce.', 'Serve with celery and dip.']
REC-046	Burrito Bowl	A deconstructed burrito without the tortilla.	25	7	5	0	0	['Cook rice with cilantro and lime.', 'Grill chicken.', 'Assemble bowls with rice base.', 'Top with beans, meat, and salsas.', 'Serve cold or warm.']
REC-048	Croque Monsieur	The ultimate French grilled ham and cheese sandwich.	20	6	5	0	0	['Make bechamel sauce.', 'Assemble sandwich with ham and cheese.', 'Top with sauce and more cheese.', 'Broil until browned.', 'Serve hot.']
REC-049	Greek Salad	Traditional peasant salad with fresh veggies and slab of feta.	15	7	5	1	4	['Chop vegetables into chunks.', 'Place slice of feta on top.', 'Sprinkle with oregano.', 'Drizzle generously with olive oil.', 'Serve immediately.']
REC-050	Hungarian Goulash	A hearty beef and potato stew seasoned generously with paprika.	150	7	5	1	5	['Sauté onions and beef.', 'Add paprika and broth.', 'Simmer for 1.5 hours.', 'Add vegetables.', 'Cook until tender.']
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: nikita
--

COPY public.tags (tag_id, tag_name) FROM stdin;
TAG-1	american
TAG-2	appetizer
TAG-3	baking
TAG-4	bbq
TAG-5	bowl
TAG-6	breakfast
TAG-7	british
TAG-8	brunch
TAG-9	casserole
TAG-10	cheesy
TAG-11	comfort-food
TAG-12	date-night
TAG-13	dessert
TAG-14	dinner
TAG-15	dip
TAG-16	family-friendly
TAG-17	french
TAG-18	fresh
TAG-19	fried
TAG-20	gluten-free
TAG-21	greek
TAG-22	grilled
TAG-23	healthy
TAG-24	hearty
TAG-25	hungarian
TAG-26	italian
TAG-27	kids-friendly
TAG-28	low-carb
TAG-29	lunch
TAG-30	main-course
TAG-31	meat-lover
TAG-32	mediterranean
TAG-33	mexican
TAG-34	middle-eastern
TAG-35	no-cook
TAG-36	one-pan
TAG-37	party
TAG-38	pasta
TAG-39	quick
TAG-40	russian
TAG-41	salad
TAG-42	sandwich
TAG-43	seafood
TAG-44	snack
TAG-45	soup
TAG-46	spanish
TAG-47	spicy
TAG-48	stew
TAG-49	sweet
TAG-50	thin
TAG-51	vegan
TAG-52	vegetarian
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

\unrestrict DHacUcz0xf9mmS3hpmFcCyrnB29omagwRnguS0R4QSDmlvJ8rXIZSjRfSEd5mFI

