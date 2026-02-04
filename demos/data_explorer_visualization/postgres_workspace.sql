--
-- PostgreSQL database dump
--

\restrict RJalJdvbYz0JFSaIwobVpyp0eF6wf4eS3YUOHE6GadzkciF3Bf5taa4IUmEjxKH

-- Dumped from database version 17.6 (Debian 17.6-1.pgdg13+1)
-- Dumped by pg_dump version 17.6 (Debian 17.6-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: ai_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_jobs (
    url text NOT NULL,
    company text NOT NULL,
    job_title text NOT NULL,
    location text NOT NULL,
    min_compensation_usd numeric,
    max_compensation_usd numeric
);


ALTER TABLE public.ai_jobs OWNER TO postgres;

--
-- Name: apartments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apartments (
    url text NOT NULL,
    title text NOT NULL,
    price numeric,
    bedrooms numeric(3,1),
    bathrooms numeric(3,1),
    square_feet integer,
    street_address text,
    in_unit_laundry text,
    has_pool boolean,
    has_hot_tub boolean,
    has_fitness_center boolean,
    has_parking boolean,
    has_ev_charging boolean,
    has_rooftop_deck boolean,
    has_clubhouse boolean,
    has_bbq_grills boolean,
    has_bike_storage boolean,
    has_business_center boolean,
    has_package_service boolean,
    has_on_site_laundry boolean,
    neighborhood text,
    is_pet_friendly boolean,
    has_elevator boolean,
    has_outdoor_space boolean,
    has_storage boolean,
    has_residents_lounge boolean,
    CONSTRAINT apartments_in_unit_laundry_check CHECK ((in_unit_laundry = ANY (ARRAY['yes'::text, 'no'::text, 'not mentioned'::text])))
);


ALTER TABLE public.apartments OWNER TO postgres;

--
-- Name: atlanta_apt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.atlanta_apt (
    url text NOT NULL,
    title text NOT NULL,
    price_min numeric,
    price_max numeric,
    bedrooms_min numeric,
    bedrooms_max numeric,
    bathrooms_min numeric,
    bathrooms_max numeric,
    square_feet_min integer,
    square_feet_max integer,
    street_address text,
    city text,
    neighborhood text,
    latitude numeric,
    longitude numeric,
    has_pool boolean,
    has_hot_tub boolean,
    has_fitness_center boolean,
    has_parking boolean,
    has_ev_charging boolean,
    has_rooftop_deck boolean,
    has_clubhouse boolean,
    has_bbq_grills boolean,
    has_bike_storage boolean,
    has_business_center boolean,
    has_package_service boolean,
    has_on_site_laundry boolean,
    is_pet_friendly boolean,
    has_elevator boolean,
    has_outdoor_space boolean,
    has_storage boolean,
    has_residents_lounge boolean,
    source_site text
);


ALTER TABLE public.atlanta_apt OWNER TO postgres;

--
-- Name: bay_area_apt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bay_area_apt (
    url text NOT NULL,
    title text,
    price_min numeric,
    price_max numeric,
    bedrooms_min numeric,
    bedrooms_max numeric,
    bathrooms_min numeric,
    bathrooms_max numeric,
    square_feet_min integer,
    square_feet_max integer,
    street_address text,
    city text,
    neighborhood text,
    latitude numeric,
    longitude numeric,
    has_pool boolean,
    has_hot_tub boolean,
    has_fitness_center boolean,
    has_parking boolean,
    has_ev_charging boolean,
    has_rooftop_deck boolean,
    has_clubhouse boolean,
    has_bbq_grills boolean,
    has_bike_storage boolean,
    has_business_center boolean,
    has_package_service boolean,
    has_on_site_laundry boolean,
    is_pet_friendly boolean,
    has_elevator boolean,
    has_outdoor_space boolean,
    has_storage boolean,
    has_residents_lounge boolean,
    source_site text
);


ALTER TABLE public.bay_area_apt OWNER TO postgres;

--
-- Name: bay_area_apt2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bay_area_apt2 (
    url text NOT NULL,
    title text NOT NULL,
    price_min numeric,
    price_max numeric,
    bedrooms_min numeric,
    bedrooms_max numeric,
    bathrooms_min numeric,
    bathrooms_max numeric,
    square_feet_min integer,
    square_feet_max integer,
    street_address text,
    city text NOT NULL,
    neighborhood text,
    latitude numeric,
    longitude numeric,
    has_pool boolean,
    has_hot_tub boolean,
    has_fitness_center boolean,
    has_parking boolean,
    has_ev_charging boolean,
    has_rooftop_deck boolean,
    has_clubhouse boolean,
    has_bbq_grills boolean,
    has_bike_storage boolean,
    has_business_center boolean,
    has_package_service boolean,
    has_on_site_laundry boolean,
    is_pet_friendly boolean,
    has_elevator boolean,
    has_outdoor_space boolean,
    has_storage boolean,
    has_residents_lounge boolean,
    source_site text NOT NULL
);


ALTER TABLE public.bay_area_apt2 OWNER TO postgres;

--
-- Name: bay_area_rental_listings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bay_area_rental_listings (
    url text NOT NULL,
    title text NOT NULL,
    city text NOT NULL,
    neighborhood text,
    latitude numeric NOT NULL,
    longitude numeric NOT NULL,
    rent_price_min numeric NOT NULL,
    rent_price_max numeric NOT NULL,
    bedrooms_min numeric NOT NULL,
    bedrooms_max numeric NOT NULL,
    bathrooms_min numeric,
    bathrooms_max numeric,
    has_pool boolean,
    has_hot_tub boolean,
    has_fitness_center boolean,
    has_parking boolean,
    has_ev_charging boolean,
    has_rooftop_deck boolean,
    has_clubhouse boolean,
    has_bbq_grills boolean,
    has_bike_storage boolean,
    has_business_center boolean,
    has_package_service boolean,
    has_on_site_laundry boolean,
    is_pet_friendly boolean,
    has_elevator boolean,
    has_outdoor_space boolean,
    has_storage boolean,
    has_residents_lounge boolean
);


ALTER TABLE public.bay_area_rental_listings OWNER TO postgres;

--
-- Name: blue_citations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blue_citations (
    cited_paper_title text NOT NULL,
    authors text,
    year integer,
    source_files text[]
);


ALTER TABLE public.blue_citations OWNER TO postgres;

--
-- Name: emnlp25_papers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.emnlp25_papers (
    paper_title text NOT NULL,
    authors text NOT NULL,
    topics text NOT NULL
);


ALTER TABLE public.emnlp25_papers OWNER TO postgres;

--
-- Name: internship_candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internship_candidates (
    author_name text NOT NULL,
    personal_website_url text,
    scholar_citations integer,
    acl_papers_since_2021 integer,
    emnlp_papers_since_2021 integer,
    naacl_papers_since_2021 integer
);


ALTER TABLE public.internship_candidates OWNER TO postgres;

--
-- Name: megagon_publications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.megagon_publications (
    publication_url text NOT NULL,
    title text NOT NULL,
    authors text,
    venue text,
    year integer,
    research_area text,
    external_link text,
    github_link text,
    abstract text,
    tags text
);


ALTER TABLE public.megagon_publications OWNER TO postgres;

--
-- Name: megagon_team_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.megagon_team_members (
    person_name text NOT NULL,
    profile_url text NOT NULL,
    job_title text NOT NULL,
    self_introduction text NOT NULL
);


ALTER TABLE public.megagon_team_members OWNER TO postgres;

--
-- Name: papers_from_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.papers_from_files (
    file_name text NOT NULL,
    paper_title text,
    authors text,
    organizations text,
    source_files text[]
);


ALTER TABLE public.papers_from_files OWNER TO postgres;

--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restaurants (
    url text NOT NULL,
    name text NOT NULL,
    street_address text,
    city text,
    neighborhood text,
    cuisine text,
    price_level text,
    rating numeric,
    review_count integer,
    phone_number text,
    website text,
    latitude numeric,
    longitude numeric,
    source_site text NOT NULL
);


ALTER TABLE public.restaurants OWNER TO postgres;

--
-- Name: text2sql_authors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.text2sql_authors (
    author_name text NOT NULL,
    paper_title text NOT NULL,
    personal_website_url text,
    is_phd_student boolean,
    acl_papers_since_2021 integer,
    scholar_citations integer,
    emnlp_papers_since_2021 integer,
    naacl_papers_since_2021 integer
);


ALTER TABLE public.text2sql_authors OWNER TO postgres;

--
-- Name: us_mass_shootings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.us_mass_shootings (
    incident_id integer NOT NULL,
    incident_date date NOT NULL,
    state text NOT NULL,
    city_or_county text NOT NULL,
    address text,
    victims_killed integer NOT NULL,
    victims_injured integer NOT NULL,
    suspects_killed integer NOT NULL,
    suspects_injured integer NOT NULL,
    suspects_arrested integer NOT NULL,
    incident_url text NOT NULL,
    source_url text
);


ALTER TABLE public.us_mass_shootings OWNER TO postgres;

--
-- Data for Name: ai_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_jobs (url, company, job_title, location, min_compensation_usd, max_compensation_usd) FROM stdin;
https://job-boards.greenhouse.io/deepmind/jobs/6789253	DeepMind	Research Scientist, Post-AGI Research	London, UK	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7411209	DeepMind	Research Scientist, Social Memory	Toronto, Canada	\N	\N
https://job-boards.greenhouse.io/anthropic/jobs/4799425008	Anthropic	Research Engineer / Research Scientist, Pre-training	Zürich, CH	\N	\N
https://job-boards.greenhouse.io/anthropic/jobs/4610158008	Anthropic	Research Engineer / Scientist, Alignment Science, London	London, UK	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7266721	DeepMind	Research Scientist, Gemini Information Tasks	New York City, New York, US	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7269779	DeepMind	Research Scientist	Mountain View, California, US	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7135585	DeepMind	Research Scientist, Reasoning & AGI, Google DeepMind	Singapore	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7408127	DeepMind	Research Scientist, Fusion	London, UK	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7334511	DeepMind	Research Scientist, Agentic Safety	Mountain View, California, US	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7411265	DeepMind	Research Engineer (or Scientist), Speech and Language	Mountain View, California, US	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7135034	DeepMind	Research Scientist, Multimodal Generative AI, Google DeepMind	Singapore	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7312594	DeepMind	Research Scientist, Generative Worlds	New York City, New York, US; San Francisco, California, US	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7089682	DeepMind	Research Scientist, Languages and Multimodality	Bangalore, India	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7142337	DeepMind	Research Scientist, AnthroKrishi	Bangalore, India	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/6890135	DeepMind	Research Scientist, Machine Learning Optimization	Bangalore, India	\N	\N
https://job-boards.greenhouse.io/deepmind/jobs/7102795	DeepMind	Research Scientist, Robotics	Mountain View, California, US	166000	244000
https://job-boards.greenhouse.io/anthropic/jobs/4520279008	Anthropic	[Expression of Interest] Research Scientist/Engineer, Alignment Finetuning	San Francisco, CA	315000	340000
https://job-boards.greenhouse.io/deepmind/jobs/7392933	DeepMind	Research Scientist, Tech Lead Manager, Model Threat Mitigation	Mountain View, California, US; New York City, New York, US; San Francisco, California, US	248000	349000
https://job-boards.greenhouse.io/deepmind/jobs/7392952	DeepMind	Research Scientist/Engineer, Security Classifier	Mountain View, California, US	166000	244000
https://job-boards.greenhouse.io/anthropic/jobs/4532887008	Anthropic	[Expression of Interest] Research Scientist/Engineer, Honesty	New York City, NY; San Francisco, CA	315000	340000
https://job-boards.greenhouse.io/anthropic/jobs/4631822008	Anthropic	Research Engineer / Scientist, Alignment Science	San Francisco, CA	315000	340000
https://job-boards.greenhouse.io/anthropic/jobs/4980427008	Anthropic	Research Scientist, Interpretability	San Francisco, CA	315000	560000
https://job-boards.greenhouse.io/deepmind/jobs/7392971	DeepMind	Research Scientist/Engineer, Model Threat Defense	Mountain View, California, US	166000	244000
https://job-boards.greenhouse.io/deepmind/jobs/7373829	DeepMind	Research Engineer/Scientist, AI Control	Mountain View, California, US	166000	244000
https://job-boards.greenhouse.io/anthropic/jobs/4924308008	Anthropic	Research Engineer / Research Scientist, Biology & Life Sciences	San Francisco, CA	315000	340000
https://job-boards.greenhouse.io/deepmind/jobs/7176150	DeepMind	Research Scientist, Model Collaborativity	Mountain View, California, US; New York City, New York, US; San Francisco, California, US; Seattle, Washington, US	166000	291000
https://job-boards.greenhouse.io/deepmind/jobs/7363231	DeepMind	Research Scientist, Socioaffective Agents	New York City, New York, US	166000	244000
https://job-boards.greenhouse.io/deepmind/jobs/7408812	DeepMind	Research Scientist, Information Quality	Mountain View, California, US; San Francisco, California, US	166000	244000
https://job-boards.greenhouse.io/deepmind/jobs/7392747	DeepMind	Research Scientist/Research Engineer, AI for Secure Code	Mountain View, California, US; New York City, New York, US; San Francisco, California, US	141000	291000
https://job-boards.greenhouse.io/anthropic/jobs/4951814008	Anthropic	Research Engineer / Research Scientist, Tokens	New York City, NY; New York City, NY | Seattle, WA; San Francisco, CA	340000	425000
\.


--
-- Data for Name: apartments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apartments (url, title, price, bedrooms, bathrooms, square_feet, street_address, in_unit_laundry, has_pool, has_hot_tub, has_fitness_center, has_parking, has_ev_charging, has_rooftop_deck, has_clubhouse, has_bbq_grills, has_bike_storage, has_business_center, has_package_service, has_on_site_laundry, neighborhood, is_pet_friendly, has_elevator, has_outdoor_space, has_storage, has_residents_lounge) FROM stdin;
https://www.padmapper.com/buildings/p14324/avalon-mountain-view-apartments-at-1600-villa-street-mountain-view-ca-94041	Avalon Mountain View	3315	1.0	\N	\N	1600 Villa St, Mountain View, CA 94041	yes	t	\N	t	\N	\N	\N	t	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p63415/the-camille-apartments-at-2645-california-street-mountain-view-ca-94040	The Camille Apartments	3695	2.0	\N	\N	2645 California Street, Mountain View, CA 94040	no	t	t	\N	t	\N	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/62708194/2-bedroom-2-bath-apartment-at-100-aspen-way-mountain-view-ca-94040	100 Aspen Way	6384	2.0	2.0	\N	100 Aspen Way #1313484P, Mountain View, CA 94040	yes	t	t	t	t	\N	\N	t	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p103602/the-camille-north-apartments-at-2685-california-street-mountain-view-ca-94040	The Camille North Apartments	2795	1.0	1.0	\N	2685 California St, Mountain View, CA 94040	no	t	t	\N	t	\N	\N	\N	t	\N	\N	t	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p103602/the-camille-north-apartments-at-26	The Camille North Apartments	2795	1.0	1.0	\N	2685 California St, Mountain View, CA 94040	no	t	t	\N	t	\N	\N	\N	t	\N	\N	t	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p16515/avalon-towers-on-the-peninsula-apartments-at-2400-west-el-camino-real-mountain-view-ca-94040	Avalon Towers On The Peninsula	3790	1.0	\N	\N	2400 West El Camino Real, Mountain View, CA 94040	yes	t	\N	t	\N	\N	t	t	t	t	\N	t	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p15695/eaves-mountain-view-at-middlefield-apartments-at-555-west-middlefield-road-mountain-view-ca-94043	Eaves Mountain View At Middlefield	2245	0.0	1.0	405	555 West Middlefield Rd, Mountain View, CA 94043	not mentioned	t	\N	t	\N	\N	t	t	t	\N	\N	t	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p14511/eaves-creekside-apartments-at-151-calderon-avenue-mountain-view-ca-94041	Eaves Creekside	2335	0.0	\N	\N	151 Calderon Ave, Mountain View, CA 94041	yes	t	\N	t	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/19817485p/2-bedroom-2-bath-apartment-at-99-east-middlefield-road-mountain-view-ca-94043	99 East Middlefield Road #15	3600	2.0	2.0	1083	99 East Middlefield Road #15, Mountain View, CA 94043	no	t	t	t	t	\N	\N	t	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p12999/reserve-at-mountain-view-apartments-at-870-east-el-camino-real-mountain-view-ca-94040	Reserve at Mountain View	2995	1.0	\N	\N	870 East El Camino Real, Mountain View, CA 94040	not mentioned	t	\N	t	\N	\N	\N	t	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p296814/arlo-mountain-view-apartments-at-1030-castro-street-mountain-view-ca-94040	Arlo Mountain View	3809	1.0	1.0	773	1030 Castro St, Mountain View, CA 94040	yes	\N	\N	t	t	\N	\N	t	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N
https://example.com/apartment_1	Sample Apartment #1	2236	3.0	2.0	968	8013 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	f	t	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_2	Sample Apartment #2	3079	2.0	2.5	1004	5201 Example Street, Mountain View, CA 94040	no	t	t	f	t	\N	f	f	f	t	f	f	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_3	Sample Apartment #3	4252	0.0	2.5	1426	9333 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	t	\N	f	t	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_4	Sample Apartment #4	2560	1.0	1.5	1046	3179 Example Street, Mountain View, CA 94040	yes	t	f	t	t	\N	f	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_5	Sample Apartment #5	3947	2.0	1.5	1059	6161 Example Street, Mountain View, CA 94040	no	t	f	t	f	\N	t	t	f	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_6	Sample Apartment #6	3274	3.0	\N	1131	9750 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	f	f	f	t	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_7	Sample Apartment #7	2498	0.0	1.0	368	3598 Example Street, Mountain View, CA 94040	yes	t	f	t	t	\N	f	f	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_8	Sample Apartment #8	2671	1.0	1.5	1091	1450 Example Street, Mountain View, CA 94040	yes	t	t	t	t	\N	f	t	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_9	Sample Apartment #9	3855	3.0	1.5	430	5647 Example Street, Mountain View, CA 94040	no	t	f	t	f	\N	f	f	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_10	Sample Apartment #10	3784	2.0	1.0	920	8883 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	t	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_11	Sample Apartment #11	4741	1.0	2.0	759	9753 Example Street, Mountain View, CA 94040	no	f	f	t	t	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_12	Sample Apartment #12	4183	0.0	\N	982	7439 Example Street, Mountain View, CA 94040	yes	f	f	f	f	\N	t	t	t	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_13	Sample Apartment #13	3950	2.0	\N	1100	2500 Example Street, Mountain View, CA 94040	no	t	f	f	t	\N	f	f	f	t	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_14	Sample Apartment #14	2643	0.0	2.5	550	5066 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	f	\N	f	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_15	Sample Apartment #15	3485	0.0	\N	1353	3625 Example Street, Mountain View, CA 94040	yes	f	t	f	t	\N	t	f	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_16	Sample Apartment #16	4125	3.0	1.5	616	4832 Example Street, Mountain View, CA 94040	yes	t	f	t	t	\N	f	f	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_17	Sample Apartment #17	4343	3.0	\N	1419	4853 Example Street, Mountain View, CA 94040	no	t	f	t	f	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_18	Sample Apartment #18	4641	0.0	2.0	1196	2465 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	f	\N	f	t	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_19	Sample Apartment #19	2710	1.0	2.5	857	6593 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	f	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_20	Sample Apartment #20	3312	3.0	1.5	1419	2275 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_21	Sample Apartment #21	2858	0.0	2.0	1195	6206 Example Street, Mountain View, CA 94040	no	t	f	t	f	\N	f	f	t	f	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_22	Sample Apartment #22	2576	0.0	\N	1511	774 Example Street, Mountain View, CA 94040	yes	f	f	t	t	\N	f	t	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_23	Sample Apartment #23	3444	3.0	1.0	952	9352 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	f	f	f	f	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_24	Sample Apartment #24	2008	1.0	2.0	1542	4767 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	f	\N	t	f	t	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_25	Sample Apartment #25	4125	1.0	1.5	965	5878 Example Street, Mountain View, CA 94040	yes	f	f	f	f	\N	f	f	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_26	Sample Apartment #26	2654	2.0	1.0	1312	8126 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	f	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_27	Sample Apartment #27	2797	2.0	2.0	865	3617 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	t	\N	f	f	f	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_28	Sample Apartment #28	2689	1.0	2.0	1496	2930 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	t	t	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_29	Sample Apartment #29	3090	1.0	1.0	629	5633 Example Street, Mountain View, CA 94040	no	f	t	f	t	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_30	Sample Apartment #30	3174	2.0	2.0	501	1452 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	f	f	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_31	Sample Apartment #31	2143	1.0	2.0	412	2046 Example Street, Mountain View, CA 94040	no	t	f	t	f	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_32	Sample Apartment #32	3640	1.0	2.5	1153	8585 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	t	t	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_33	Sample Apartment #33	4563	2.0	\N	457	5803 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	f	f	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_34	Sample Apartment #34	4304	1.0	2.0	1227	2473 Example Street, Mountain View, CA 94040	not mentioned	t	t	f	t	\N	f	f	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_35	Sample Apartment #35	4503	3.0	2.5	906	3603 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	f	\N	f	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_36	Sample Apartment #36	2960	2.0	2.0	1343	7185 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	t	t	t	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_37	Sample Apartment #37	4143	3.0	2.0	1195	3001 Example Street, Mountain View, CA 94040	yes	f	f	t	f	\N	f	t	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_38	Sample Apartment #38	3460	1.0	\N	1335	6376 Example Street, Mountain View, CA 94040	not mentioned	t	t	f	t	\N	f	t	t	f	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_39	Sample Apartment #39	2007	3.0	\N	366	2642 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	f	t	t	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_40	Sample Apartment #40	2006	0.0	2.5	1178	5068 Example Street, Mountain View, CA 94040	not mentioned	t	t	t	f	\N	f	f	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_41	Sample Apartment #41	2359	2.0	\N	356	3070 Example Street, Mountain View, CA 94040	not mentioned	t	t	f	f	\N	f	f	t	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_42	Sample Apartment #42	3572	0.0	\N	356	1256 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	t	\N	f	t	t	f	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_43	Sample Apartment #43	4228	1.0	2.5	653	9693 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	t	\N	f	t	t	f	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_44	Sample Apartment #44	3990	2.0	1.0	1520	9708 Example Street, Mountain View, CA 94040	yes	f	f	f	t	\N	f	t	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_45	Sample Apartment #45	2508	1.0	2.5	1160	3823 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	t	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_46	Sample Apartment #46	3374	3.0	2.5	1537	6244 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_47	Sample Apartment #47	4834	3.0	2.5	1115	5435 Example Street, Mountain View, CA 94040	not mentioned	f	f	f	f	\N	t	t	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_48	Sample Apartment #48	4567	1.0	1.5	681	2971 Example Street, Mountain View, CA 94040	yes	t	t	t	t	\N	f	t	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_49	Sample Apartment #49	3228	3.0	1.5	655	4042 Example Street, Mountain View, CA 94040	yes	f	f	f	t	\N	t	f	f	t	f	f	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_50	Sample Apartment #50	3366	1.0	2.0	1002	3819 Example Street, Mountain View, CA 94040	yes	f	t	f	f	\N	t	t	f	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_51	Sample Apartment #51	3471	0.0	1.0	1494	1677 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	f	t	t	f	f	f	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_52	Sample Apartment #52	2385	3.0	\N	798	3494 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	t	f	t	f	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_53	Sample Apartment #53	3093	1.0	2.0	1144	4958 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	f	\N	f	t	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_54	Sample Apartment #54	4235	2.0	2.5	771	2123 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	t	t	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_55	Sample Apartment #55	2873	0.0	\N	1242	6220 Example Street, Mountain View, CA 94040	yes	f	f	f	f	\N	f	f	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_56	Sample Apartment #56	3048	2.0	1.0	1538	4565 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	t	f	t	f	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_57	Sample Apartment #57	3244	1.0	\N	866	4245 Example Street, Mountain View, CA 94040	not mentioned	f	f	f	f	\N	f	f	f	t	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_58	Sample Apartment #58	2624	2.0	\N	1272	1208 Example Street, Mountain View, CA 94040	yes	f	f	t	f	\N	t	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_59	Sample Apartment #59	3979	0.0	1.0	652	1932 Example Street, Mountain View, CA 94040	not mentioned	f	f	f	t	\N	f	t	t	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_60	Sample Apartment #60	4410	2.0	1.5	877	829 Example Street, Mountain View, CA 94040	not mentioned	f	f	f	t	\N	f	f	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_61	Sample Apartment #61	3387	1.0	1.0	720	2446 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	t	\N	f	f	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_62	Sample Apartment #62	3900	0.0	1.0	538	4258 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	t	f	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_63	Sample Apartment #63	2421	2.0	2.0	1154	3238 Example Street, Mountain View, CA 94040	not mentioned	f	f	f	f	\N	t	f	t	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_64	Sample Apartment #64	4693	0.0	2.5	1338	387 Example Street, Mountain View, CA 94040	not mentioned	f	f	f	t	\N	f	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_65	Sample Apartment #65	3573	1.0	1.0	1169	4839 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	f	t	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_66	Sample Apartment #66	3989	0.0	2.0	504	6702 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	f	f	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_67	Sample Apartment #67	3613	0.0	1.5	386	1650 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	f	t	t	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_68	Sample Apartment #68	2718	3.0	2.0	694	9427 Example Street, Mountain View, CA 94040	no	t	t	f	t	\N	f	t	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_69	Sample Apartment #69	3952	0.0	\N	1082	9558 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	t	t	t	t	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_70	Sample Apartment #70	4202	0.0	\N	395	1401 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	f	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_71	Sample Apartment #71	2184	2.0	\N	1425	7029 Example Street, Mountain View, CA 94040	yes	f	f	f	t	\N	f	t	f	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_72	Sample Apartment #72	4208	0.0	1.5	1251	849 Example Street, Mountain View, CA 94040	yes	f	t	t	f	\N	f	f	t	f	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_73	Sample Apartment #73	3255	2.0	1.5	473	1512 Example Street, Mountain View, CA 94040	yes	t	f	t	t	\N	t	t	t	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_74	Sample Apartment #74	3452	3.0	2.0	557	4621 Example Street, Mountain View, CA 94040	no	t	f	t	t	\N	f	f	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_75	Sample Apartment #75	4662	0.0	1.5	451	2280 Example Street, Mountain View, CA 94040	no	f	f	f	t	\N	f	f	t	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_76	Sample Apartment #76	2063	0.0	\N	505	6770 Example Street, Mountain View, CA 94040	no	t	t	t	t	\N	t	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_77	Sample Apartment #77	3279	0.0	2.0	1288	118 Example Street, Mountain View, CA 94040	not mentioned	f	f	t	t	\N	f	t	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_78	Sample Apartment #78	3323	3.0	1.0	619	3752 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	t	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_79	Sample Apartment #79	3323	2.0	1.0	537	4813 Example Street, Mountain View, CA 94040	yes	f	f	f	f	\N	t	f	t	f	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_80	Sample Apartment #80	3737	0.0	1.5	682	6580 Example Street, Mountain View, CA 94040	yes	f	t	f	t	\N	f	t	f	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_81	Sample Apartment #81	4689	2.0	2.5	619	9265 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	f	\N	f	t	f	f	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_82	Sample Apartment #82	2264	2.0	\N	468	5873 Example Street, Mountain View, CA 94040	not mentioned	t	t	t	f	\N	f	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_83	Sample Apartment #83	3796	3.0	1.0	1023	5044 Example Street, Mountain View, CA 94040	yes	t	t	f	t	\N	f	f	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_84	Sample Apartment #84	3381	1.0	1.0	639	582 Example Street, Mountain View, CA 94040	no	f	f	f	t	\N	f	t	f	f	t	f	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_85	Sample Apartment #85	2909	1.0	1.5	359	8430 Example Street, Mountain View, CA 94040	yes	t	f	f	t	\N	f	f	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_86	Sample Apartment #86	2912	3.0	1.5	669	3354 Example Street, Mountain View, CA 94040	no	f	f	f	f	\N	f	f	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_87	Sample Apartment #87	3493	1.0	\N	1386	552 Example Street, Mountain View, CA 94040	no	f	t	f	t	\N	t	f	t	f	f	f	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_88	Sample Apartment #88	3700	0.0	\N	1454	2419 Example Street, Mountain View, CA 94040	yes	t	t	t	t	\N	f	t	t	f	t	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_89	Sample Apartment #89	2203	2.0	2.5	588	564 Example Street, Mountain View, CA 94040	yes	f	t	f	f	\N	f	t	f	t	t	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_90	Sample Apartment #90	2687	0.0	\N	775	1590 Example Street, Mountain View, CA 94040	yes	t	t	f	t	\N	f	t	f	t	f	f	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_91	Sample Apartment #91	4882	0.0	2.5	1116	57 Example Street, Mountain View, CA 94040	yes	t	f	t	f	\N	f	f	t	f	t	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_92	Sample Apartment #92	2149	0.0	2.5	1053	8068 Example Street, Mountain View, CA 94040	not mentioned	t	t	f	t	\N	t	f	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_93	Sample Apartment #93	2866	0.0	\N	789	181 Example Street, Mountain View, CA 94040	yes	f	f	t	t	\N	f	t	f	t	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_94	Sample Apartment #94	4221	2.0	1.0	1229	2063 Example Street, Mountain View, CA 94040	no	f	f	t	t	\N	f	t	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_95	Sample Apartment #95	4836	3.0	2.5	1131	6042 Example Street, Mountain View, CA 94040	not mentioned	t	f	t	t	\N	f	f	f	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_96	Sample Apartment #96	2810	3.0	1.5	824	6841 Example Street, Mountain View, CA 94040	yes	f	t	f	t	\N	f	t	t	t	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_97	Sample Apartment #97	3557	2.0	2.0	908	4928 Example Street, Mountain View, CA 94040	yes	f	t	t	t	\N	t	t	f	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_98	Sample Apartment #98	4721	2.0	\N	598	3037 Example Street, Mountain View, CA 94040	not mentioned	f	t	t	f	\N	f	f	t	f	f	t	f	\N	\N	\N	\N	\N	\N
https://example.com/apartment_99	Sample Apartment #99	3514	3.0	1.0	1293	9680 Example Street, Mountain View, CA 94040	no	f	f	t	t	\N	f	f	t	f	f	t	t	\N	\N	\N	\N	\N	\N
https://example.com/apartment_100	Sample Apartment #100	2559	3.0	1.5	941	6534 Example Street, Mountain View, CA 94040	yes	f	f	f	f	\N	f	f	f	t	f	t	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/62341405/2-bedroom-1-bath-apartment-at-234-escuela-avenue-mountain-view-ca-94040	234 Escuela Avenue #2019	3760	2.0	1.0	\N	234 Escuela Avenue #2019, Mountain View, CA	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/1600-villa-street-mountain-view-ca-94043	Avalon Mountain View 1600 Villa Street	2390	1.0	\N	\N	1600 Villa Street, Mountain View, CA	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/11557324p/1-bedroom-1-bath-apartment-at-280-easy-street-mountain-view-ca-94043	280 Easy Street #423	2500	1.0	1.0	\N	280 Easy Street #423, Mountain View, CA 94043	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/1724775/apartments-at-877-heatherstone-way-mountain-view-ca-94040	877 Heatherstone Way #443	2390	1.0	\N	\N	877 Heatherstone Way #443, Mountain View, CA 94040	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/26156963p/1-bedroom-1-bath-apartment-at-415-del-medio-avenue-mountain-view-ca-94040	415 Del Medio Avenue #08	2495	1.0	1.0	\N	415 Del Medio Avenue #08, Mountain View, CA 94040	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/1424199/anton-ladera-apartments-at-398-ortega-avenue-mountain-view-ca-94040	Anton Ladera 398 Ortega Avenue	2803	0.0	\N	\N	398 Ortega Avenue, Mountain View, CA 94040	yes	t	\N	t	t	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/3015789p/3-bedroom-2-bath-apartment-at-137-margo-dr-mountain-view-ca-94041	137 Margo Dr	4700	3.0	2.0	\N	137 Margo Dr, Mountain View, CA 94041	not mentioned	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/62493362/1-bedroom-1-bath-apartment-at-1941-california-street-mountain-view-ca-94040	1941 California Street #2032	2880	1.0	1.0	\N	1941 California Street #2032, Mountain View, CA 94040	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/16568508p/1-bedroom-1-bath-apartment-at-2700-del-medio-court-mountain-view-ca-94040	2700 Del Medio Court #109	2395	1.0	1.0	\N	2700 Del Medio Court #109, Mountain View, CA 94040	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p89627/regency-at-mountain-view-apartments-at-333-escuela-avenue-mountain-view-ca-94040	Regency at Mountain View 333 Escuela Avenue	3189	1.0	\N	\N	333 Escuela Avenue, Mountain View, CA 94040	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/15906865p/2-bedroom-1-bath-apartment-at-2700-del-medio-court-mountain-view-ca-94040	2700 Del Medio Court #211	3095	2.0	1.0	\N	2700 Del Medio Court #211, Mountain View, CA 94040	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p209871/el-portal-apartments-at-2065-california-st-mountain-view-ca-94040	El Portal Apartments 2065 California St	2800	1.0	\N	\N	2065 California St, Mountain View, CA 94040	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/59875793/3-bedroom-2-bath-apartment-at-821-altaire-walk-palo-alto-ca-94303	821 Altaire Walk #1549	5550	3.0	2.0	\N	821 Altaire Walk, Palo Alto, CA 94303	not mentioned	f	f	f	f	f	f	f	f	f	f	t	f	\N	t	f	f	f	f
https://www.padmapper.com/buildings/p15497/palo-alto-place-apartments-at-565-arastradero-road-palo-alto-ca-94306	Palo Alto Place 565 Arastradero Road	3275	0.0	\N	\N	565 Arastradero Road, Palo Alto, CA 94306	not mentioned	f	f	f	f	f	f	f	f	f	f	t	f	\N	\N	f	f	f	f
https://www.padmapper.com/buildings/1724355/apartments-at-837-cowper-street-palo-alto-ca-94301	837 Cowper Street	3890	1.0	\N	\N	837 Cowper Street, Palo Alto, CA 94301	not mentioned	f	f	f	f	f	f	f	f	f	f	f	t	University South	\N	t	t	\N	\N
https://www.padmapper.com/buildings/1775983/apartments-at-535-everett-avenue-palo-alto-ca-94301	535 Everett Avenue	3930	0.0	\N	\N	535 Everett Avenue, Palo Alto, CA 94301	not mentioned	t	f	f	f	f	f	f	f	f	f	f	t	Downtown North	\N	t	t	\N	\N
https://www.padmapper.com/buildings/1724755/apartments-at-501-forest-avenue-palo-alto-ca-94301	501 Forest Avenue	5430	1.0	\N	\N	501 Forest Avenue, Palo Alto, CA 94301	not mentioned	t	f	f	f	t	f	f	f	f	f	f	t	University South	\N	t	t	\N	t
https://www.padmapper.com/rentals/63135182/1-bedroom-1-bath-apartment-at-327-hawthorne-avenue-palo-alto-ca-94301	327 Hawthorne Avenue #2114 Downtown North	2350	1.0	1.0	\N	327 Hawthorne Avenue #2114, Palo Alto, CA 94301	not mentioned	f	f	f	f	f	f	f	f	f	f	t	f	Downtown North	\N	f	f	f	f
https://www.padmapper.com/rentals/58679823/1-bedroom-1-bath-apartment-at-580-channing-avenue-palo-alto-ca-94301	580 Channing Avenue #1647 University South	5020	1.0	1.0	\N	580 Channing Avenue #1647, Palo Alto, CA 94301	not mentioned	f	f	f	f	f	f	f	f	f	f	t	t	University South	\N	f	f	f	f
https://www.padmapper.com/rentals/58899251/2-bedroom-1-bath-apartment-at-596-channing-avenue-palo-alto-ca-94301	596 Channing Avenue #1649 University South	5550	2.0	1.0	\N	596 Channing Avenue #1649, Palo Alto, CA 94301	not mentioned	f	f	f	f	f	f	f	f	f	f	t	t	University South	\N	f	f	f	f
https://www.padmapper.com/buildings/1923034/apartments-at-345-sheridan-avenue-palo-alto-ca-94306	345 Sheridan Avenue	4370	1.0	\N	\N	345 Sheridan Avenue, Palo Alto, CA 94306	not mentioned	t	f	f	f	f	f	f	f	f	f	f	f	Evergreen Park	t	t	t	\N	\N
https://www.padmapper.com/rentals/27031488p/2-bedroom-2-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2995	2.0	2.0	\N	425 South Bernardo Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	Sunnyvale West	\N	t	\N	t	\N
https://www.padmapper.com/buildings/p108657/the-pointe-at-cupertino-apartments-at-19920-olivewood-street-cupertino-ca-95014	The Pointe at Cupertino	3889	\N	\N	\N	19920 Olivewood Street, Cupertino, CA 95014	not mentioned	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N
https://www.padmapper.com/buildings/p576308/apartments-at-1250-lakeside-drive-sunnyvale-ca-94085	1250 Lakeside	2799	\N	\N	\N	1250 Lakeside Drive, Sunnyvale, CA 94085	not mentioned	t	\N	t	\N	t	\N	\N	\N	\N	t	t	\N	\N	t	t	t	t	t
https://www.padmapper.com/buildings/p63419/village-square-townhouses-apartments-at-1674-hollenbeck-avenue-sunnyvale-ca-94087	Village Square Townhouses	3295	2.0	\N	\N	1674 Hollenbeck Avenue, Sunnyvale, CA 94087	yes	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	Sunnyvale West	t	\N	\N	\N	\N
https://www.padmapper.com/rentals/2374935p/4-bedroom-2-bath-apartment-at-1035-colony-hills-lane-cupertino-ca-95014	1035 Colony Hills Lane	5995	4.0	2.0	\N	1035 Colony Hills Lane, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/p108800/bristol-commons-apartments-at-732-east-evelyn-avenue-sunnyvale-ca-94086	Bristol Commons	2789	\N	\N	\N	732 East Evelyn Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	t	t
https://www.padmapper.com/buildings/p108797/the-montclaire-apartments-at-450-north-mathilda-avenue-sunnyvale-ca-94085	The Montclaire	2319	0.0	\N	\N	450 North Mathilda Avenue, Sunnyvale, CA 94085	not mentioned	t	\N	t	\N	t	\N	\N	\N	\N	\N	t	t	Lowlanders	t	t	t	\N	t
https://www.padmapper.com/buildings/p200337/sands-studio-apartments-at-874-borregas-avenue-sunnyvale-ca-94085	Sands Studio Apartments	1825	0.0	\N	\N	874 Borregas Avenue, Sunnyvale, CA 94085	yes	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	SNAIL	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p404212/lawrence-station-apartments-at-1271-lawrence-station-road-sunnyvale-ca-94089	Lawrence Station	2909	\N	\N	\N	1271 Lawrence Station Road, Sunnyvale, CA 94089	not mentioned	t	\N	t	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	t	t	t	t
https://www.padmapper.com/buildings/p801467/maxwell-sunnyvale-apartments-at-490-west-mckinley-avenue-sunnyvale-ca-94086	Maxwell Sunnyvale	3357	0.0	\N	\N	490 West Mckinley Avenue, Sunnyvale, CA 94086	not mentioned	\N	\N	t	\N	\N	\N	\N	\N	t	t	\N	\N	\N	t	\N	t	\N	t
https://www.padmapper.com/buildings/p108632/magnolia-square-apartments-at-107-south-mary-avenue-sunnyvale-ca-94086	Magnolia Square	2849	\N	\N	\N	107 South Mary Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	Sunnyvale West	t	\N	t	t	\N
https://www.padmapper.com/buildings/p108961/via-apartments-at-621-tasman-drive-sunnyvale-ca-94089	Via	2989	1.0	\N	\N	621 Tasman Drive, Sunnyvale, CA 94089	not mentioned	t	\N	t	\N	t	\N	\N	\N	\N	\N	t	t	\N	t	t	t	\N	t
https://www.padmapper.com/buildings/p1462914/apartments-at-1359-s-wolfe-rd-sunnyvale-ca-94087	1359 S. Wolfe Rd	4795	3.0	\N	\N	1359 S Wolfe Rd, Sunnyvale, CA 94087	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/buildings/p108774/summerhill-park-apartments-at-972-corte-madera-avenue-sunnyvale-ca-94085	Summerhill Park	3459	2.0	\N	\N	972 Corte Madera Avenue, Sunnyvale, CA 94085	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Sunnyvale West	t	\N	t	\N	t
https://www.padmapper.com/buildings/p12397/briarwood-apartments-at-180-pasito-terrace-sunnyvale-ca-94086	Briarwood	2739	\N	\N	\N	180 Pasito Terrace, Sunnyvale, CA 94086	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	Sunnyvale West	t	\N	t	\N	t
https://www.padmapper.com/buildings/p12908/the-arches-apartments-at-1235-wildwood-avenue-sunnyvale-ca-94089	The Arches	2630	\N	\N	\N	1235 Wildwood Avenue, Sunnyvale, CA 94089	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	t
https://www.padmapper.com/buildings/p17921/arbor-terrace-apartments-at-555-east-el-camino-real-sunnyvale-ca-94087	Arbor Terrace	2648	\N	\N	\N	555 East El Camino Real, Sunnyvale, CA 94087	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/p108998/riley-square-apartments-at-3707-poinciana-drive-sunnyvale-ca-95051	Riley Square	2679	\N	\N	\N	3707 Poinciana Drive, Sunnyvale, CA 95051	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Ponderosa Park	t	\N	t	t	t
https://www.padmapper.com/rentals/27166655p/studio-1-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2095	0.0	1.0	\N	425 South Bernardo Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	\N
https://www.padmapper.com/buildings/p20294/solstice-apartments-at-299-west-washington-avenue-sunnyvale-ca-94086	Solstice	3067	\N	\N	\N	299 West Washington Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	Heritage District	t	t	t	\N	t
https://www.padmapper.com/buildings/p113017/nineteen800-apartments-at-19700-vallco-parkway-cupertino-ca-95014	Nineteen800 Apartments	5254	\N	\N	\N	19700 Vallco Parkway, Cupertino, CA 95014	not mentioned	\N	\N	t	\N	\N	\N	\N	\N	\N	t	\N	\N	Vallco Park South	t	\N	t	\N	\N
https://www.padmapper.com/rentals/617007p/5-bedroom-3-bath-apartment-at-20421-via-palamos-cupertino-ca-95014	20421 Via Palamos	6000	5.0	3.0	\N	20421 Via Palamos, Cupertino, CA 95014	not mentioned	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/63075881/1-bedroom-1-bath-apartment-at-271-281-curtner-palo-alto-ca-94306	271-281 Curtner #279	2600	1.0	1.0	\N	271-281 Curtner, Palo Alto, CA 94306	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Ventura	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/62368050/2-bedroom-2-bath-apartment-at-20200-lucille-avenue-cupertino-ca-95014	20200 Lucille Avenue #1975	4690	2.0	2.0	\N	20200 Lucille Avenue #1975, Cupertino, CA 95014	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N
https://www.padmapper.com/rentals/27024385p/2-bedroom-2-bath-apartment-at-7375-rollingdell-drive-cupertino-ca-95014	7375 Rollingdell Drive #100	3295	2.0	2.0	\N	7375 Rollingdell Drive, Cupertino, CA 95014	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/27090658p/2-bedroom-2-bath-apartment-at-725-cowper-street-palo-alto-ca-94301	725 Cowper Street #45	2495	2.0	2.0	\N	725 Cowper Street, Palo Alto, CA 94301	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	University South	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/6895p/5-bedroom-4-bath-apartment-at-19973-pear-tree-court-cupertino-ca-95014	19973 Pear Tree Court	6495	5.0	4.0	\N	19973 Pear Tree Court, Cupertino, CA 95014	not mentioned	t	\N	\N	t	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/p120176/jabbok-cupertino-apartments-at-20652-park-circle-cupertino-ca-95014	Jabbok-Cupertino	3395	2.0	\N	\N	20652 Park Circle, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/rentals/27122445p/2-bedroom-1-bath-apartment-at-271-curtner-avenue-palo-alto-ca-94306	271 Curtner Avenue #271	4750	2.0	1.0	\N	271 Curtner Avenue, Palo Alto, CA 94306	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Ventura	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/61515294/1-bedroom-1-bath-apartment-at-2721-midtown-court-palo-alto-ca-94303	2721 Midtown Court #1868	3300	1.0	1.0	\N	2721 Midtown Court, Palo Alto, CA 94303	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Midtown	t	t	t	\N	\N
https://www.padmapper.com/rentals/58911792/4-bedroom-2-bath-apartment-at-10067-judy-avenue-cupertino-ca-95014	10067 Judy Avenue #1519	5390	4.0	2.0	\N	10067 Judy Avenue #1519, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Rancho Rinconada	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/p898251/apartments-at-19450-richwood-court-cupertino-ca-95014	19450 Richwood Court	3045	2.0	\N	\N	19450 Richwood Court, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/27003434p/1-bedroom-1-bath-apartment-at-737-sutter-avenue-palo-alto-ca-94303	737 Sutter Avenue #1	2995	1.0	1.0	\N	737 Sutter Avenue, Palo Alto, CA 94303	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Midtown	\N	\N	t	\N	\N
https://www.padmapper.com/rentals/62466799/2-bedroom-1-bath-apartment-at-10200-miller-avenue-cupertino-ca-95014	10200 Miller Avenue	7712	2.0	1.0	\N	10200 Miller Avenue, Cupertino, CA 95014	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/p108983/reed-square-apartments-at-1070-reed-avenue-sunnyvale-ca-94086	Reed Square	2819	\N	\N	\N	1070 Reed Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Ponderosa Park	t	\N	t	\N	\N
https://www.padmapper.com/rentals/27166661p/1-bedroom-1-bath-apartment-at-421-forest-avenue-palo-alto-ca-94301	421 Forest Avenue #425A	3950	1.0	1.0	\N	421 Forest Avenue, Palo Alto, CA 94301	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	University South	\N	\N	\N	\N	\N
https://www.padmapper.com/rentals/59875847/2-bedroom-2-bath-apartment-at-10161-danube-drive-cupertino-ca-95014	10161 Danube Drive #1652	4060	2.0	2.0	\N	10161 Danube Drive #1652, Cupertino, CA 95014	not mentioned	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/p16587/stanford-villa-apartments-at-3375-alma-street-palo-alto-ca-94306	Stanford Villa	3495	\N	\N	\N	3375 Alma Street, Palo Alto, CA 94306	not mentioned	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	St. Claire Gardens	\N	\N	t	t	\N
https://www.padmapper.com/rentals/27166660p/2-bedroom-1-bath-apartment-at-562-kendall-avenue-palo-alto-ca-94306	562 Kendall Avenue #17	3995	2.0	1.0	\N	562 Kendall Avenue, Palo Alto, CA 94306	yes	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Barron Park	\N	\N	\N	t	\N
https://www.padmapper.com/buildings/p56286/windsor-ridge-apartments-at-829-east-evelyn-avenue-sunnyvale-ca-94086	Windsor Ridge	2819	1.0	\N	\N	829 East Evelyn Avenue, Sunnyvale, CA 94086	not mentioned	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N
https://www.padmapper.com/buildings/1786199/apartments-at-715-everett-avenue-palo-alto-ca-94301	715 Everett Avenue	5890	\N	\N	\N	715 Everett Avenue, Palo Alto, CA 94301	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	Crescent Park	t	\N	\N	\N	\N
https://www.padmapper.com/rentals/26957794p/1-bedroom-1-bath-apartment-at-20365-silverado-avenue-cupertino-ca-95014	20365 Silverado Avenue #ADU	2380	1.0	1.0	\N	20365 Silverado Avenue #ADU, Cupertino, CA 95014	yes	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	t	\N	\N
https://www.padmapper.com/rentals/58444891/2-bedroom-2-bath-apartment-at-10065-judy-avenue-cupertino-ca-95014	10065 Judy Avenue #1570	3110	2.0	2.0	\N	10065 Judy Avenue #1570, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Rancho Rinconada	t	\N	\N	\N	\N
https://www.padmapper.com/rentals/62955644/1-bedroom-1-bath-apartment-at-19550-vallco-parkway-cupertino-ca-95014	19550 Vallco Parkway	7579	1.0	1.0	\N	19550 Vallco Parkway, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Vallco Park South	t	\N	\N	\N	\N
https://www.padmapper.com/rentals/58679238/3-bedroom-2-bath-apartment-at-18921-barnhart-avenue-cupertino-ca-95014	18921 Barnhart Avenue #1636	6040	3.0	2.0	\N	18921 Barnhart Avenue #1636, Cupertino, CA 95014	not mentioned	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	Rancho Rinconada	t	\N	\N	\N	\N
\.


--
-- Data for Name: atlanta_apt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.atlanta_apt (url, title, price_min, price_max, bedrooms_min, bedrooms_max, bathrooms_min, bathrooms_max, square_feet_min, square_feet_max, street_address, city, neighborhood, latitude, longitude, has_pool, has_hot_tub, has_fitness_center, has_parking, has_ev_charging, has_rooftop_deck, has_clubhouse, has_bbq_grills, has_bike_storage, has_business_center, has_package_service, has_on_site_laundry, is_pet_friendly, has_elevator, has_outdoor_space, has_storage, has_residents_lounge, source_site) FROM stdin;
https://www.padmapper.com/buildings/p529331/camden-buckhead-apartments-at-3300-roswell-road-atlanta-ga-30305	Camden Buckhead	1719	7329	1	3	1	3	\N	\N	3300 Roswell Road	Atlanta	South Tuxedo Park	\N	\N	t	\N	t	\N	t	t	\N	t	\N	t	t	t	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/1067214/apartments-at-holmes-street-northwest-atlanta-ga-30318	743 @ Howell Mills	1000	1400	0	2	1	1	\N	\N	Holmes Street Northwest	Atlanta	Berkeley Park	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	t	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p17837/skyhouse-buckhead-apartments-at-3390-stratford-road-northeast-atlanta-ga-30326	Skyhouse Buckhead	1323	4452	0	3	1	2	600	1200	3390 Stratford Road Northeast	Atlanta	North Buckhead	33.844	-84.366	t	\N	t	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p215642/apartments-at-841-memorial-drive-southeast-atlanta-ga-30316	841 Memorial	1289	4349	0	2	1	2	\N	\N	841 Memorial Drive Southeast	Atlanta	Reynoldstown	\N	\N	\N	\N	t	\N	t	t	\N	\N	\N	\N	t	\N	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p56357/apartments-at-900-peachtree-street-northeast-atlanta-ga-30309	900 Peachtree Lofts	1725	2795	0	3	1	2	\N	\N	900 Peachtree Street Northeast	Atlanta	Midtown	\N	\N	t	\N	t	t	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p47854/enso-apartments-at-880-glenwood-avenue-southeast-atlanta-ga-30316	Enso	1479	4864	1	2	1	2	\N	\N	880 Glenwood Avenue Southeast	Atlanta	Grant Park	\N	\N	t	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p20838/cascade-oaks-apartments-at-3820-old-cascade-road-southwest-atlanta-ga-30331	Cascade Oaks Apartments	1150	2200	1	3	1	1	\N	\N	3820 Old Cascade Road Southwest	Atlanta	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p425807/the-skylark-apartments-at-1099-boulevard-southeast-atlanta-ga-30312	The Skylark	997	4733	0	3	1	2	0	0	1099 Boulevard Southeast	Atlanta	Chosewood Park	\N	\N	t	\N	t	\N	\N	\N	t	\N	\N	t	t	\N	t	\N	\N	t	t	padmapper.com
https://www.padmapper.com/buildings/p556530/spectator-apartments-at-2395-herodian-way-southeast-atlanta-ga-30080	Spectator Apartments	1581	6606	1	3	1	1	\N	\N	2395 Herodian Way Southeast	Atlanta	\N	\N	\N	t	\N	t	t	\N	t	t	\N	\N	\N	\N	t	t	\N	\N	\N	t	padmapper.com
https://www.padmapper.com/buildings/p31576/camden-creekstone-apartments-at-1945-savoy-drive-atlanta-ga-30341	Camden Creekstone	1289	1779	1	2	1	1	\N	\N	1945 Savoy Drive	Atlanta	\N	\N	\N	t	t	t	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p883024/vibe-at-echo-street-west-apartments-at-750-echo-street-northwest-atlanta-ga-30318	Vibe at Echo Street West	1306	3310	0	2	1	2	\N	\N	750 Echo Street Northwest	Atlanta	English Avenue	\N	\N	t	\N	t	\N	\N	\N	t	\N	t	t	\N	t	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p893851/juniper-place-condominiums-apartments-at-146-7th-street-northeast-atlanta-ga-30308	Juniper Place Condominiums	1995	3395	2	3	1	1	\N	\N	146 7th Street Northeast	Atlanta	Midtown	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p989001/link-apartments-r-grant-park-at-730-glenwood-avenue-southeast-atlanta-ga-30312	Link Apartments® Grant Park	1440	4284	1	2	1	2	\N	\N	730 Glenwood Avenue Southeast	Atlanta	Grant Park	\N	\N	t	\N	t	t	t	t	\N	t	\N	\N	\N	t	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/p28159/parkway-vista-apartments-at-100-parkway-circle-south-atlanta-ga-30340	Parkway Vista	1000	2200	1	3	1	1	\N	\N	100 Parkway Circle South	Atlanta	\N	\N	\N	t	\N	t	t	\N	\N	t	\N	\N	t	t	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p142735/townhomes-at-pleasant-hill-apartments-at-2500-pleasant-hill-road-southwest-atlanta-ga-30349	Townhomes at Pleasant Hill	999	999	1	1	1	1	\N	\N	2500 Pleasant Hill Road Southwest	Atlanta	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p17303/the-reserve-at-the-ballpark-apartments-at-2875-crescent-parkway-southeast-atlanta-ga-30339	The Reserve at the Ballpark	1543	9143	0	3	2	2	\N	\N	2875 Crescent Parkway Southeast	Atlanta	\N	\N	\N	t	\N	t	\N	\N	\N	t	\N	\N	t	t	t	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p423514/the-cliftwood-apartments-at-185-cliftwood-drive-northeast-sandy-springs-ga-30328	The Cliftwood	1495	4503	0	3	\N	\N	\N	\N	185 Cliftwood Drive Northeast	Sandy Springs	Downtown Sandy Springs	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	t	t	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p25157/wynnwood-vinings-apartments-at-1900-tamarron-parkway-southeast-atlanta-ga-30339	Wynnwood Vinings	1100	1400	1	2	1	2	\N	\N	1900 Tamarron Parkway Southeast	Atlanta	\N	\N	\N	t	\N	t	\N	\N	\N	t	t	\N	t	t	t	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p47880/lenox-place-apartments-at-2572-lenox-road-northeast-north-atlanta-ga-30324	Lenox Place	1100	2050	1	3	\N	\N	\N	\N	2572 Lenox Road Northeast	North Atlanta	Pine Hills	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p146733/helios-apartments-at-2470-cheshire-bridge-road-atlanta-ga-30324	Helios	1450	3847	0	2	1	2	696	1213	2470 Cheshire Bridge Road	Atlanta	Lindridge - Martin Manor	\N	\N	t	\N	t	\N	\N	t	t	t	\N	t	t	\N	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p875128/allora-eastland-apartments-at-1296-moreland-avenue-southeast-atlanta-ga-30316	Allora Eastland	1510	2230	0	2	\N	\N	\N	\N	1296 Moreland Avenue Southeast	Atlanta	\N	\N	\N	\N	\N	t	\N	\N	\N	t	t	t	t	\N	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p915438/sentral-west-midtown-at-star-metals-apartments-at-1055-brady-avenue-northwest-atlanta-ga-30318	Sentral West Midtown at Star Metals	1311	10000	0	2	1	2	484	1392	1055 Brady Avenue Northwest	Atlanta	Home Park	\N	\N	t	\N	t	t	t	t	\N	t	\N	\N	\N	t	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p489037/rio-at-lenox-apartments-at-2716-buford-highway-northeast-north-atlanta-ga-30324	Rio At Lenox	1050	1800	0	2	\N	\N	\N	\N	2716 Buford Highway Northeast	North Atlanta	Pine Hills	\N	\N	t	\N	t	\N	t	t	\N	\N	\N	\N	t	t	t	\N	\N	\N	t	padmapper.com
https://www.padmapper.com/buildings/p1285764/apartments-at-925-canterbury-rd-ne-north-atlanta-ga-30324	925 Canterbury Rd Ne	1686	2224	1	2	\N	\N	\N	\N	925 Canterbury Rd Ne	North Atlanta	Pine Hills	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p26681/camden-buckhead-square-apartments-at-3097-maple-drive-northeast-atlanta-ga-30305	Camden Buckhead Square	1369	2059	0	2	\N	\N	\N	\N	3097 Maple Drive Northeast, Buckhead Village, North Atlanta, GA 30305	North Atlanta	Buckhead Village	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p121350/briarcliff-apartments-5-minutes-to-everything-emory-at-2194-briarcliff-road-northeast-atlanta-ga-30329	Briarcliff Apartments 5 Minutes To Everything Emory	1295	1295	2	2	\N	\N	\N	\N	2194 Briarcliff Road Northeast, Lindridge - Martin Manor, North Atlanta, GA 30329	North Atlanta	Lindridge - Martin Manor	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p274861/hampton-hall-apartments-at-2213-briarcliff-road-northeast-atlanta-ga-30329	Hampton Hall Apartments	895	1725	1	3	\N	\N	\N	\N	2213 Briarcliff Road Northeast, 30329, North Atlanta, GA 30329	North Atlanta	30329	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p303705/the-huntley-luxury-apartments-at-1000-park-avenue-atlanta-ga-30316	The Huntley Luxury Apartments	2075	26823	1	3	\N	\N	\N	\N	1000 Park Avenue, North Buckhead, North Atlanta, GA 30316	North Atlanta	North Buckhead	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	t	t	padmapper.com
https://www.padmapper.com/buildings/p869355/iris-o4w-apartments-at-652-angier-avenue-northeast-atlanta-ga-30308	Iris O4W	1890	3770	0	2	\N	\N	\N	\N	652 Angier Avenue Northeast, Atlanta, GA 30308	Atlanta	Old Fourth Ward	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	t	\N	\N	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p336/parc-at-perimeter-apartments-at-6210-peachtree-dunwoody-road-sandy-springs-ga-30328	Parc At Perimeter	1391	3421	1	3	\N	\N	\N	\N	6210 Peachtree Dunwoody Road	Sandy Springs	Perimeter Center	\N	\N	t	\N	t	\N	\N	t	\N	\N	t	t	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p478997/the-adair-apartments-at-415-morgan-falls-road-northeast-sandy-springs-ga-30350	The Adair	1594	4451	0	2	\N	\N	\N	\N	415 Morgan Falls Road Northeast	Sandy Springs	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	t	\N	\N	\N	t	t	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p426781/adley-city-springs-apartments-at-6075-roswell-road-sandy-springs-ga-30328	Adley City Springs	1140	1885	0	2	\N	\N	\N	\N	6075 Roswell Road	Sandy Springs	Downtown Sandy Springs	\N	\N	t	\N	t	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p241/waters-edge-apartments-at-8601-roberts-drive-sandy-springs-ga-30350	Waters Edge Apartments	1140	1885	1	3	\N	\N	\N	\N	8601 Roberts Drive	Sandy Springs	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	t	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
\.


--
-- Data for Name: bay_area_apt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bay_area_apt (url, title, price_min, price_max, bedrooms_min, bedrooms_max, bathrooms_min, bathrooms_max, square_feet_min, square_feet_max, street_address, city, neighborhood, latitude, longitude, has_pool, has_hot_tub, has_fitness_center, has_parking, has_ev_charging, has_rooftop_deck, has_clubhouse, has_bbq_grills, has_bike_storage, has_business_center, has_package_service, has_on_site_laundry, is_pet_friendly, has_elevator, has_outdoor_space, has_storage, has_residents_lounge, source_site) FROM stdin;
https://www.padmapper.com/rentals/62493362/1-bedroom-1-bath-apartment-at-1941-california-street-mountain-view-ca-94040	1941 California Street #2032	2880	2880	1	1	1	1	\N	\N	1941 California Street #2032	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/8928193p/3-bedroom-2-bath-apartment-at-14530-miranda-rd-los-altos-hills-ca-94022	14530 Miranda Rd	7995	7995	3	3	2	2	\N	\N	14530 Miranda Rd	Los Altos Hills	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27175637p/4-bedroom-2-bath-apartment-at-1310-garthwick-drive-los-altos-ca-94024	1310 Garthwick Drive	8000	8000	4	4	2	2	\N	\N	1310 Garthwick Drive	Los Altos	South Los Altos	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59875779/4-bedroom-2-bath-apartment-at-1324-sevier-avenue-menlo-park-ca-94025	1324 Sevier Avenue #1624	4710	4710	4	4	2	2	\N	\N	1324 Sevier Avenue #1624	Menlo Park	Belle Haven	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27031488p/2-bedroom-2-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2995	2995	0	0	1	1	\N	\N	425 South Bernardo Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	padmapper.com
https://www.padmapper.com/buildings/p14324/avalon-mountain-view-apartments-at-1600-villa-street-mountain-view-ca-94041	Avalon Mountain View	3245	4574	1	3	\N	\N	\N	\N	1600 Villa Street	Mountain View	Shoreline West	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/62877934/4-bedroom-2-bath-apartment-at-240-west-floresta-way-ladera-ca-94028	240 West Floresta Way	10500	10500	4	4	2	2	\N	\N	240 West Floresta Way	Ladera	Ladera	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p866290/apartments-at-1982-west-bayshore-road-east-palo-alto-ca-94303	1982 W Bayshore Rd	2000	2000	1	1	\N	\N	\N	\N	1982 West Bayshore Road	East Palo Alto	East Palo Alto	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	t	padmapper.com
https://www.padmapper.com/buildings/p123046/stanford-garden-apartments-at-1735-woodland-avenue-east-palo-alto-ca-94303	Stanford Garden Apartments	2145	2595	0	1	\N	\N	\N	\N	1735 Woodland Avenue	East Palo Alto	East Palo Alto	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59214592/4-bedroom-2-bath-apartment-at-312-haight-st-menlo-park-ca-94025	312 Haight St #1543	5020	5020	4	4	2	2	\N	\N	312 Haight St #1543	Menlo Park	The Willows	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58771219/3-bedroom-2-bath-apartment-at-615-gilbert-avenue-menlo-park-ca-94025	615 Gilbert Avenue #1527	\N	\N	3	3	2	2	\N	\N	615 Gilbert Avenue #1527	Menlo Park	South of Seminary - Vintage Oaks	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p35425/township-apartments-at-333-main-street-redwood-city-ca-94063	Township	3329	4239	1	2	\N	\N	\N	\N	333 Main Street	Redwood City	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	t	\N	\N	\N	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/243-acalanes-drive-sunnyvale-ca-94086	243 Acalanes Drive	3840	7600	0	2	\N	\N	\N	\N	243 Acalanes Drive	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	f	f	\N	\N	\N	t	\N	\N	t	f	f	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p22323/aviare-apartments-at-20415-via-paviso-cupertino-ca-95014	Aviare	5254	7444	1	2	\N	\N	\N	\N	\N	Cupertino	\N	\N	\N	t	\N	t	t	\N	t	\N	\N	\N	t	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27024385p/2-bedroom-2-bath-apartment-at-7375-rollingdell-drive-cupertino-ca-95014	7375 Rollingdell Drive #100	6000	6000	2	2	2	2	\N	\N	7375 Rollingdell Drive #100	Cupertino	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/617007p/5-bedroom-3-bath-apartment-at-20421-via-palamos-cupertino-ca-95014	20421 Via Palamos	3045	3045	5	5	3	3	\N	\N	20421 Via Palamos	Cupertino	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p898251/apartments-at-19450-richwood-court-cupertino-ca-95014	19450 Richwood Court	3045	3045	2	2	\N	\N	\N	\N	19450 Richwood Court	Cupertino	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1735641/apartments-at-555-east-evelyn-avenue-sunnyvale-ca-94041	555 East Evelyn Avenue	3170	3170	0	2	\N	\N	\N	\N	555 East Evelyn Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	t	t	\N	\N	\N	t	\N	\N	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p16515/avalon-towers-on-the-peninsula-apartments-at-2400-west-el-camino-real-mountain-view-ca-94040	Avalon Towers on the Peninsula	3735	7295	1	3	\N	\N	\N	\N	2400 West El Camino Real	Mountain View	\N	37.398889	-122.106944	t	\N	t	\N	\N	t	\N	\N	\N	\N	t	\N	\N	\N	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/58899251/2-bedroom-1-bath-apartment-at-596-channing-avenue-palo-alto-ca-94301	596 Channing Avenue #1649	7400	7400	2	2	1	1	\N	\N	596 Channing Avenue #1649	Palo Alto	University South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26963573p/2-bedroom-2-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2995	2995	2	2	2	2	\N	\N	425 South Bernardo Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/26498527p/studio-1-bath-apartment-at-2185-chuleta-court-los-altos-ca-94024	2185 Chuleta Court	2800	2800	0	0	1	1	\N	\N	2185 Chuleta Court	Los Altos	Woodland Acres - The Highlands	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p368951/huxley-apartments-at-1355-el-camino-real-redwood-city-ca-94063	Huxley	3010	6290	0	2	\N	\N	\N	\N	1355 El Camino Real	Redwood City	Staumbaugh-Heller	\N	\N	\N	\N	t	t	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	t	t	padmapper.com
https://www.padmapper.com/buildings/1424199/anton-ladera-apartments-at-398-ortega-avenue-mountain-view-ca-94040	Anton Ladera	2803	3125	0	0	\N	\N	\N	\N	398 Ortega Avenue	Mountain View	\N	\N	\N	t	\N	t	t	t	\N	\N	\N	\N	\N	t	t	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/p108657/the-pointe-at-cupertino-apartments-at-19920-olivewood-street-cupertino-ca-95014	The Pointe at Cupertino	3889	4277	2	3	\N	\N	\N	\N	19920 Olivewood Street	Cupertino	\N	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/rentals/26959371p/1-bedroom-1-bath-apartment-at-1-north-san-antonio-road-los-altos-ca-94022	1 North San Antonio Road	900	900	1	1	1	1	\N	\N	1 North San Antonio Road	Los Altos	North Los Altos	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p15497/palo-alto-place-apartments-at-565-arastradero-road-palo-alto-ca-94306	Palo Alto Place	3275	7500	0	3	\N	\N	\N	\N	565 Arastradero Road	Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p63419/village-square-townhouses-apartments-at-1674-hollenbeck-avenue-sunnyvale-ca-94087	Village Square Townhouses	3295	3595	2	2	\N	\N	\N	\N	1674 Hollenbeck Avenue	Sunnyvale	Sunnyvale West	37.3715	-122.0343	t	\N	f	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	t	f	t	padmapper.com
https://www.padmapper.com/buildings/p113017/nineteen800-apartments-at-19700-vallco-parkway-cupertino-ca-95014	Nineteen800 Apartments	3295	3295	2	3	\N	\N	\N	\N	\N	Cupertino	Vallco Park South	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/1724451/apartments-at-745-south-bernardo-avenue-sunnyvale-ca-94087	745 South Bernardo Avenue	3170	3170	1	1	\N	\N	\N	\N	745 South Bernardo Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p200337/sands-studio-apartments-at-874-borregas-avenue-sunnyvale-ca-94085	Sands Studio Apartments	1825	1975	0	0	\N	\N	\N	\N	874 Borregas Avenue	Sunnyvale	SNAIL	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p63415/the-camille-apartments-at-2645-california-street-mountain-view-ca-94040	The Camille Apartments	3695	3695	2	2	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/58679823/1-bedroom-1-bath-apartment-at-580-channing-avenue-palo-alto-ca-94301	580 Channing Avenue #1647	5020	5020	1	1	1	1	\N	\N	580 Channing Avenue #1647	Palo Alto	University South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/11557324p/1-bedroom-1-bath-apartment-at-280-easy-street-mountain-view-ca-94043	280 Easy Street #423	2500	2500	1	1	1	1	\N	\N	280 Easy Street #423	Mountain View	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/buildings/p12397/briarwood-apartments-at-180-pasito-terrace-sunnyvale-ca-94086	Briarwood	2739	3871	1	2	\N	\N	\N	\N	\N	Sunnyvale	Sunnyvale West	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/62955644/1-bedroom-1-bath-apartment-at-19550-vallco-parkway-cupertino-ca-95014	19550 Vallco Parkway	7579	7579	1	1	1	1	\N	\N	19550 Vallco Parkway	Cupertino	Vallco Park South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59875847/2-bedroom-2-bath-apartment-at-10161-danube-drive-cupertino-ca-95014	10161 Danube Drive #1652	4060	4060	2	2	2	2	\N	\N	10161 Danube Drive #1652	Cupertino	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26880179p/5-bedroom-2-bath-apartment-at-2229-pulgas-avenue-east-palo-alto-ca-94303	2229 Pulgas Avenue	2450	2450	5	5	2	2	\N	\N	2229 Pulgas Avenue	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	t	padmapper.com
https://www.padmapper.com/rentals/26998268p/1-bedroom-1-bath-apartment-at-2887-fordham-street-east-palo-alto-ca-94303	2887 Fordham Street	1600	1600	1	1	1	1	\N	\N	2887 Fordham Street	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/15906865p/2-bedroom-1-bath-apartment-at-2700-del-medio-court-mountain-view-ca-94040	2700 Del Medio Court #211	3095	3095	2	2	1	1	\N	\N	2700 Del Medio Court #211	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1775989/apartments-at-243-acalanes-drive-sunnyvale-ca-94086	243 Acalanes Drive	3840	7600	3	3	\N	\N	\N	\N	243 Acalanes Drive	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p14511/eaves-creekside-apartments-at-151-calderon-avenue-mountain-view-ca-94041	eaves Creekside	2215	3400	0	2	\N	\N	\N	\N	151 Calderon Avenue	Mountain View	Old Mountain View	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p328886/laurel-oaks-apts-apartments-at-1019-1019-and-1025-laurel-street-menlo-park-ca-94025	Laurel Oaks Apts	2395	3895	1	2	\N	\N	\N	\N	1019 1019 and 1025 Laurel Street	Menlo Park	\N	37.453	-122.181	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1726553/apartments-at-1545-san-antonio-street-menlo-park-ca-94025	1545 San Antonio Street	4140	5730	1	2	\N	\N	\N	\N	1545 San Antonio Street	Menlo Park	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p108797/the-montclaire-apartments-at-450-north-mathilda-avenue-sunnyvale-ca-94085	The Montclaire	2319	3319	0	2	\N	\N	\N	\N	450 North Mathilda Avenue	Sunnyvale	Lowlanders	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	t	t	t	t	t	t	padmapper.com
https://www.padmapper.com/rentals/63075881/1-bedroom-1-bath-apartment-at-271-281-curtner-palo-alto-ca-94306	271-281 Curtner #279	2495	2495	1	1	1	1	\N	\N	271-281 Curtner #279	Palo Alto	Ventura	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1786199/apartments-at-715-everett-avenue-palo-alto-ca-94301	715 Everett Avenue	5390	5390	1	3	\N	\N	\N	\N	715 Everett Avenue	Palo Alto	Crescent Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p103602/the-camille-north-apartments-at-2685-california-street-mountain-view-ca-94040	The Camille North Apartments	2795	3595	1	2	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58679426/1-bedroom-1-bath-apartment-at-820-kipling-street-palo-alto-ca-94301	820 Kipling Street #1637	4550	4550	1	1	1	1	\N	\N	820 Kipling Street #1637	Palo Alto	University South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p296814/arlo-mountain-view-apartments-at-1030-castro-street-mountain-view-ca-94040	ARLO Mountain View	3849	4767	1	2	\N	\N	\N	\N	\N	Mountain View	Cuesta Park	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/62466799/2-bedroom-1-bath-apartment-at-10200-miller-avenue-cupertino-ca-95014	10200 Miller Avenue	7712	7712	2	2	1	1	\N	\N	10200 Miller Avenue	Cupertino	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p404212/lawrence-station-apartments-at-1271-lawrence-station-road-sunnyvale-ca-94089	Lawrence Station	2909	4719	1	2	\N	\N	\N	\N	1271 Lawrence Station Road	Sunnyvale	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p69743/radius-apartments-at-620-veterans-boulevard-redwood-city-ca-94063	Radius	3219	5257	1	3	\N	\N	\N	\N	620 Veterans Boulevard	Redwood City	Centennial	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	t	padmapper.com
https://www.padmapper.com/rentals/27166661p/1-bedroom-1-bath-apartment-at-421-forest-avenue-palo-alto-ca-94301	421 Forest Avenue #425A	3760	3760	1	1	1	1	\N	\N	421 Forest Avenue #425A	Palo Alto	University South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58979527/3-bedroom-2-bath-apartment-at-1020-ticonderoga-drive-sunnyvale-ca-94087	1020 Ticonderoga Drive #1520	4270	4270	3	3	2	2	\N	\N	1020 Ticonderoga Drive #1520	Sunnyvale	Sunnyvale West	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1724668/apartments-at-743-roble-avenue-menlo-park-ca-94025	743 Roble Avenue	6420	6420	2	2	\N	\N	\N	\N	743 Roble Avenue	Menlo Park	Downtown Menlo Park	37.449	-122.181	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27166655p/studio-1-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2095	2095	0	0	1	1	\N	\N	\N	Sunnyvale	Sunnyvale West	37.36889	-122.03444	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/p1337452/apartments-at-1336-middlefield-road-redwood-city-ca-94063	1336 Middlefield Road	2410	2410	1	1	\N	\N	\N	\N	1336 Middlefield Road	Redwood City	Staumbaugh-Heller	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/16568508p/1-bedroom-1-bath-apartment-at-2700-del-medio-court-mountain-view-ca-94040	2700 Del Medio Court #109	2395	2395	1	1	1	1	\N	\N	2700 Del Medio Court #109	Mountain View	\N	\N	\N	t	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27073126p/2-bedroom-1-bath-apartment-at-367-azalia-drive-east-palo-alto-ca-94303	367 Azalia Drive	4250	4250	2	2	1	1	\N	\N	367 Azalia Drive	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58444891/2-bedroom-2-bath-apartment-at-10065-judy-avenue-cupertino-ca-95014	10065 Judy Avenue #1570	3110	3110	2	2	2	2	\N	\N	10065 Judy Avenue #1570	Cupertino	Rancho Rinconada	37.322998	-122.032182	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1765385/apartments-at-251-middlefield-road-palo-alto-ca-94301	251 Middlefield Road	3300	8280	2	2	\N	\N	\N	\N	251 Middlefield Road	Palo Alto	Crescent Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p89627/regency-at-mountain-view-apartments-at-333-escuela-avenue-mountain-view-ca-94040	Regency at Mountain View	3189	3289	1	1	\N	\N	\N	\N	\N	Mountain View	Shoreline West	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	t	padmapper.com
https://www.padmapper.com/rentals/26829239p/5-bedroom-5-bath-apartment-at-23171-mora-glen-dr-los-altos-ca-94024	23171 Mora Glen Dr	25000	25000	5	5	5	5	\N	\N	23171 Mora Glen Dr	Los Altos	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59875793/3-bedroom-2-bath-apartment-at-821-altaire-walk-palo-alto-ca-94303	821 Altaire Walk #1549	5550	5550	3	3	2	2	\N	\N	821 Altaire Walk #1549	Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p63413/noel-oaks-apartments-at-1010-noel-dr-menlo-park-ca-94025	Noel Oaks Apartments	3995	3995	2	2	\N	\N	\N	\N	1010 Noel Dr	Menlo Park	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/buildings/1775974/apartments-at-801-middlefield-road-palo-alto-ca-94301	801 Middlefield Road	5890	5890	2	2	\N	\N	\N	\N	801 Middlefield Road	Palo Alto	Crescent Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p108983/reed-square-apartments-at-1070-reed-avenue-sunnyvale-ca-94086	Reed Square	2819	3277	1	2	\N	\N	\N	\N	1070 Reed Avenue	Sunnyvale	Ponderosa Park	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p56286/windsor-ridge-apartments-at-829-east-evelyn-avenue-sunnyvale-ca-94086	Windsor Ridge	2819	3277	1	1	\N	\N	\N	\N	829 East Evelyn Avenue	Sunnyvale	\N	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/rentals/26957794p/1-bedroom-1-bath-apartment-at-20365-silverado-avenue-cupertino-ca-95014	20365 Silverado Avenue #ADU	2380	2380	1	1	1	1	\N	\N	20365 Silverado Avenue #ADU	Cupertino	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/62222495/2-bedroom-2-bath-apartment-at-151-south-bernardo-avenue-sunnyvale-ca-94086	151 South Bernardo Avenue #1992	3640	3640	2	2	2	2	\N	\N	151 South Bernardo Avenue #1992	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26959354p/1-bedroom-1-bath-apartment-at-1-east-bayshore-road-east-palo-alto-ca-94303	1 East Bayshore Road	1100	1100	1	1	1	1	\N	\N	1 East Bayshore Road	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26156963p/1-bedroom-1-bath-apartment-at-415-del-medio-avenue-mountain-view-ca-94040	415 Del Medio Avenue #08	2495	2495	1	1	1	1	\N	\N	415 Del Medio Avenue #08	Mountain View	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p12999/reserve-at-mountain-view-apartments-at-870-east-el-camino-real-mountain-view-ca-94040	Reserve at Mountain View	3005	3805	1	2	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58742458/4-bedroom-3-bath-apartment-at-532-hamilton-avenue-menlo-park-ca-94025	532 Hamilton Avenue #1542	5860	5860	4	4	3	3	\N	\N	532 Hamilton Avenue #1542	Menlo Park	Belle Haven	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1724529/apartments-at-20350-stevens-creek-boulevard-cupertino-ca-95014	20350 Stevens Creek Boulevard	2970	5120	1	2	\N	\N	\N	\N	20350 Stevens Creek Boulevard	Cupertino	\N	37.324399	-122.008711	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	\N	padmapper.com
https://www.padmapper.com/rentals/27090658p/2-bedroom-2-bath-apartment-at-725-cowper-street-palo-alto-ca-94301	725 Cowper Street #45	4750	4750	2	2	2	2	\N	\N	725 Cowper Street #45	Palo Alto	University South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p20294/solstice-apartments-at-299-west-washington-avenue-sunnyvale-ca-94086	Solstice	3067	3859	1	2	\N	\N	\N	\N	299 West Washington Avenue	Sunnyvale	Heritage District	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p201146/apartments-at-777-hamilton-avenue-menlo-park-ca-94025	777 Hamilton	3129	4377	1	2	\N	\N	\N	\N	777 Hamilton Avenue	Menlo Park	Belle Haven	\N	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/58911792/4-bedroom-2-bath-apartment-at-10067-judy-avenue-cupertino-ca-95014	10067 Judy Avenue #1519	5390	5390	4	4	2	2	\N	\N	10067 Judy Avenue #1519	Cupertino	Rancho Rinconada	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/62368050/2-bedroom-2-bath-apartment-at-20200-lucille-avenue-cupertino-ca-95014	20200 Lucille Avenue #1975	4690	4690	2	2	2	2	\N	\N	20200 Lucille Avenue #1975	Cupertino	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27018312p/3-bedroom-1-bath-apartment-at-463-larkspur-drive-east-palo-alto-ca-94303	463 Larkspur Drive #463	4300	4300	3	3	1	1	\N	\N	463 Larkspur Drive #463	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p209871/el-portal-apartments-at-2065-california-st-mountain-view-ca-94040	El Portal Apartments	2800	2800	1	1	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	t	padmapper.com
https://www.padmapper.com/rentals/59875873/2-bedroom-1-bath-apartment-at-926-webster-street-palo-alto-ca-94301	926 Webster Street #1651	4220	4220	2	2	1	1	\N	\N	926 Webster Street #1651	Palo Alto	University South	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p576308/apartments-at-1250-lakeside-drive-sunnyvale-ca-94085	1250 Lakeside	2799	4867	0	2	\N	\N	\N	\N	1250 Lakeside Drive	Sunnyvale	\N	37.37794	-122.00215	t	\N	\N	\N	t	\N	\N	\N	\N	t	t	t	t	t	t	t	t	padmapper.com
https://www.padmapper.com/rentals/58680015/3-bedroom-2-bath-apartment-at-1421-san-antonio-street-menlo-park-ca-94025	1421 San Antonio Street #1513	6560	6560	3	3	2	2	\N	\N	1421 San Antonio Street #1513	Menlo Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59875779/3-bedroom-2-bath-apartment-at-1421-san-antonio-street-menlo-park-ca-94025	1421 San Antonio Street #1513	6560	6560	3	3	2	2	\N	\N	1421 San Antonio Street #1513	Menlo Park	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1738756/apartments-at-2850-middlefield-road-palo-alto-ca-94306	2850 Middlefield Road	3950	3950	1	1	\N	\N	\N	\N	2850 Middlefield Road	Palo Alto	Midtown	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p195318/the-pines-apartments-at-3455-alameda-de-las-pulgas-menlo-park-ca-94025	The Pines	2595	2595	1	1	\N	\N	\N	\N	\N	Menlo Park	University Heights	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	t	t	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/3015789p/3-bedroom-2-bath-apartment-at-137-margo-dr-mountain-view-ca-94041	137 Margo Dr	4700	4700	3	3	2	2	\N	\N	137 Margo Dr	Mountain View	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/11741860p/1-bedroom-1-bath-apartment-at-670-live-oak-avenue-menlo-park-ca-94025	670 Live Oak Avenue #01	2295	2295	1	1	1	1	\N	\N	670 Live Oak Avenue #01	Menlo Park	Downtown Menlo Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p490777/apartments-at-585-cassia-street-redwood-city-ca-94063	585 Cassia Street	2595	2595	1	1	\N	\N	\N	\N	585 Cassia Street	Redwood City	Staumbaugh-Heller	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/63135182/1-bedroom-1-bath-apartment-at-327-hawthorne-avenue-palo-alto-ca-94301	327 Hawthorne Avenue #2114	3640	3730	1	1	1	1	\N	\N	327 Hawthorne Avenue #2114	Palo Alto	Downtown North	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/61515294/1-bedroom-1-bath-apartment-at-2721-midtown-court-palo-alto-ca-94303	2721 Midtown Court #1868	6080	6080	1	1	1	1	\N	\N	2721 Midtown Court #1868	Palo Alto	Midtown	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1937873/apartments-at-727-layne-court-palo-alto-ca-94306	747 Layne Court	2350	2350	1	2	\N	\N	\N	\N	747 Layne Court	Palo Alto	Midtown	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26978536p/4-bedroom-2-bath-apartment-at-667-university-avenue-los-altos-ca-94022	667 University Avenue	7800	7800	4	4	2	2	\N	\N	667 University Avenue	Los Altos	Old Los Altos	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p108774/summerhill-park-apartments-at-972-corte-madera-avenue-sunnyvale-ca-94085	Summerhill Park	3459	3607	2	2	\N	\N	\N	\N	\N	Sunnyvale	Sunnyvale West	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p108998/riley-square-apartments-at-3707-poinciana-drive-sunnyvale-ca-95051	Riley Square	2679	3107	1	2	\N	\N	\N	\N	\N	Sunnyvale	Ponderosa Park	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/rentals/63135093/2-bedroom-2-bath-apartment-at-3639-haven-avenue-menlo-park-ca-94025	3639 Haven Avenue	6408	6408	2	2	2	2	\N	\N	3639 Haven Avenue	Menlo Park	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/58442807/1-bedroom-1-bath-apartment-at-20488-stevens-creek-boulevard-cupertino-ca-95014	20488 Stevens Creek Boulevard #1569	3690	3690	1	1	1	1	\N	\N	20488 Stevens Creek Boulevard #1569	Cupertino	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/2374935p/4-bedroom-2-bath-apartment-at-1035-colony-hills-lane-cupertino-ca-95014	1035 Colony Hills Lane	5995	5995	4	4	2	2	\N	\N	1035 Colony Hills Lane	Cupertino	\N	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/rentals/6895p/5-bedroom-4-bath-apartment-at-19973-pear-tree-court-cupertino-ca-95014	19973 Pear Tree Court	6495	6495	5	5	4	4	\N	\N	19973 Pear Tree Court	Cupertino	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58679238/3-bedroom-2-bath-apartment-at-18921-barnhart-avenue-cupertino-ca-95014	18921 Barnhart Avenue #1636	6040	6040	3	3	2	2	\N	\N	18921 Barnhart Avenue #1636	Cupertino	Rancho Rinconada	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p108637/brookside-oaks-apartments-at-1651-belleville-way-los-altos-ca-94087	Brookside Oaks	2597	3057	0	1	\N	\N	\N	\N	1651 Belleville Way	Los Altos	South Los Altos	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27033457p/3-bedroom-1-bath-apartment-at-2887-fordham-street-east-palo-alto-ca-94303	2887 Fordham Street #MAIN	4300	4300	3	3	1	1	\N	\N	2887 Fordham Street #MAIN	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/21614207p/3-bedroom-1-bath-apartment-at-463-larkspur-drive-east-palo-alto-ca-94303	463 Larkspur Drive	4300	4300	3	3	1	1	\N	\N	463 Larkspur Drive	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/1724775/apartments-at-877-heatherstone-way-mountain-view-ca-94040	877 Heatherstone Way	2390	2390	1	1	\N	\N	\N	\N	877 Heatherstone Way	Mountain View	Cuernavaca	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/19817485p/2-bedroom-2-bath-apartment-at-99-east-middlefield-road-mountain-view-ca-94043	99 East Middlefield Road #15	3600	3600	2	2	2	2	\N	\N	99 East Middlefield Road #15	Mountain View	Slater	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p17921/arbor-terrace-apartments-at-555-east-el-camino-real-sunnyvale-ca-94087	Arbor Terrace	2648	3100	1	2	\N	\N	\N	\N	\N	Sunnyvale	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p120176/jabbok-cupertino-apartments-at-20652-park-circle-cupertino-ca-95014	Jabbok-Cupertino	3395	3395	2	2	\N	\N	\N	\N	20652 Park Circle	Cupertino	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p801467/maxwell-sunnyvale-apartments-at-490-west-mckinley-avenue-sunnyvale-ca-94086	Maxwell Sunnyvale	3357	4969	0	2	\N	\N	\N	\N	490 West Mckinley Avenue	Sunnyvale	Sunnyvale West	37.3717	-122.0341	\N	\N	t	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/buildings/p12908/the-arches-apartments-at-1235-wildwood-avenue-sunnyvale-ca-94089	The Arches	2630	3361	1	2	\N	\N	\N	\N	\N	Sunnyvale	\N	37.3715	-122.0343	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/1724719/apartments-at-3645-haven-avenue-menlo-park-ca-94025	3645 Haven Avenue	3270	4320	1	2	\N	\N	\N	\N	3645 Haven Avenue	Menlo Park	\N	37.4862215	-122.1827103	t	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1724568/apartments-at-350-sharon-park-drive-menlo-park-ca-94025	350 Sharon Park Drive	4220	7720	1	2	\N	\N	\N	\N	350 Sharon Park Drive	Menlo Park	Sharon Height	37.453	-122.182	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1972518/apartments-at-800-high-school-way-mountain-view-ca-94041	800 High School Way	3980	3980	1	1	\N	\N	\N	\N	800 High School Way	Mountain View	Old Mountain View	37.403	-122.086	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p16587/stanford-villa-apartments-at-3375-alma-street-palo-alto-ca-94306	Stanford Villa	2650	4265	0	2	\N	\N	\N	\N	\N	Palo Alto	St. Claire Gardens	37.4419	-122.1430	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/p108632/magnolia-square-apartments-at-107-south-mary-avenue-sunnyvale-ca-94086	Magnolia Square	2849	3639	1	2	\N	\N	\N	\N	107 South Mary Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/rentals/61515295/2-bedroom-1-bath-apartment-at-1230-mills-street-menlo-park-ca-94025	1230 Mills Street #1870	4470	4470	2	2	1	1	\N	\N	1230 Mills Street #1870	Menlo Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27003434p/1-bedroom-1-bath-apartment-at-737-sutter-avenue-palo-alto-ca-94303	737 Sutter Avenue #1	2995	2995	1	1	1	1	\N	\N	737 Sutter Avenue #1	Palo Alto	Midtown	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26959358p/2-bedroom-1-bath-apartment-at-1-east-bayshore-road-east-palo-alto-ca-94303	1 East Bayshore Road	1100	1100	2	2	1	1	\N	\N	1 East Bayshore Road	East Palo Alto	East Palo Alto	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58444876/3-bedroom-3-bath-apartment-at-5-heritage-pl-menlo-park-ca-94025	5 Heritage Pl #1528	6120	6120	3	3	3	3	\N	\N	5 Heritage Pl #1528	Menlo Park	\N	37.4678868	-122.1563944	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27166660p/2-bedroom-1-bath-apartment-at-562-kendall-avenue-palo-alto-ca-94306	562 Kendall Avenue #17	3995	3995	2	2	1	1	\N	\N	562 Kendall Avenue #17	Palo Alto	Barron Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/buildings/p15695/eaves-mountain-view-at-middlefield-apartments-at-555-west-middlefield-road-mountain-view-ca-94043	eaves Mountain View at Middlefield	2245	3930	0	2	\N	\N	\N	\N	555 West Middlefield Road	Mountain View	\N	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	t	t	\N	\N	t	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59875647/3-bedroom-2-bath-apartment-at-2315-eastridge-avenue-menlo-park-ca-94025	2315 Eastridge Avenue #1532	6060	6060	3	3	2	2	\N	\N	2315 Eastridge Avenue #1532	Menlo Park	Sharon Height	37.444	-122.168	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/1894447/apartments-at-838-roble-avenue-menlo-park-ca-94025	838 Roble Avenue	4710	4940	0	2	\N	\N	\N	\N	838 Roble Avenue	Menlo Park	Downtown Menlo Park	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26963574p/1-bedroom-1-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2395	2395	1	1	1	1	\N	\N	425 South Bernardo Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	padmapper.com
https://www.padmapper.com/buildings/p108961/via-apartments-at-621-tasman-drive-sunnyvale-ca-94089	Via	2989	3079	1	1	\N	\N	\N	\N	621 Tasman Drive	Sunnyvale	Sunnyvale West	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t	t	t	padmapper.com
https://www.padmapper.com/buildings/1731119/apartments-at-10870-north-stelling-road-cupertino-ca-95014	10870 North Stelling Road	3360	3870	1	2	\N	\N	\N	\N	10870 North Stelling Road	Cupertino	\N	37.32394	-122.02844	t	\N	\N	\N	t	\N	\N	\N	\N	t	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26963572p/1-bedroom-1-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	2395	2395	1	1	1	1	\N	\N	425 South Bernardo Avenue	Sunnyvale	Sunnyvale West	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/58680087/2-bedroom-1-bath-apartment-at-277-willow-road-menlo-park-ca-94025	277 Willow Road #1557	5110	5110	2	2	1	1	\N	\N	277 Willow Road #1557	Menlo Park	South of Seminary - Vintage Oaks	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/27122445p/2-bedroom-1-bath-apartment-at-271-curtner-avenue-palo-alto-ca-94306	271 Curtner Avenue #271	3495	3495	2	2	1	1	\N	\N	271 Curtner Avenue #271	Palo Alto	Ventura	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	padmapper.com
\.


--
-- Data for Name: bay_area_apt2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bay_area_apt2 (url, title, price_min, price_max, bedrooms_min, bedrooms_max, bathrooms_min, bathrooms_max, square_feet_min, square_feet_max, street_address, city, neighborhood, latitude, longitude, has_pool, has_hot_tub, has_fitness_center, has_parking, has_ev_charging, has_rooftop_deck, has_clubhouse, has_bbq_grills, has_bike_storage, has_business_center, has_package_service, has_on_site_laundry, is_pet_friendly, has_elevator, has_outdoor_space, has_storage, has_residents_lounge, source_site) FROM stdin;
https://www.padmapper.com/buildings/1724775/apartments-at-877-heatherstone-way-mountain-view-ca-94040	877 Heatherstone Way	2390	2390	1	1	\N	\N	\N	\N	877 Heatherstone Way	Mountain View	Cuernavaca	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/877-heatherstone-way-443	877 Heatherstone Way #443	2999	2999	1	1	\N	\N	\N	\N	877 Heatherstone Way	Mountain View	Cuernavaca	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/1724453/apartments-at-555-w-middlefield-rd-mountain-view-ca-94043	555 West Middlefield Rd. 555 W Middlefield Rd #5996A	2790	2790	0	0	\N	\N	\N	\N	555 W Middlefield Rd #5996A	Mountain View	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/26156963p/1-bedroom-1-bath-apartment-at-415-del-medio-ave-mountain-view-ca-94040	415 Del Medio Ave #08	2495	2495	1	1	1	1	610	610	415 Del Medio Ave #08	Mountain View	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	f	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/15029919p/studio-1-bath-apartment-at-2700-del-medio-ct-mountain-view-ca-94040	2700 Del Medio Ct #329	2195	2195	0	0	1	1	530	530	2700 Del Medio Ct #329	Mountain View	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	f	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/59875773/3-bedroom-2-bath-apartment-at-108-bryant-st-mountain-view-ca-94041	108 Bryant St #1653	5260	5260	3	3	2	3	1381	1381	108 Bryant St #1653	Mountain View	Old Mountain View	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/15906865p/2-bedroom-1-bath-apartment-at-2700-del-medio-ct-mountain-view-ca-94040	2700 Del Medio Ct #211	3095	3095	2	2	1	1	900	900	2700 Del Medio Ct #211	Mountain View	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	f	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/rentals/58679326/2-bedroom-1-bath-apartment-at-465-calderon-ave-mountain-view-ca-94041	465 Calderon Ave #1640	3760	3760	2	2	1	1	850	850	465 Calderon Ave #1640	Mountain View	Old Mountain View	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p16515/avalon-towers-on-the-peninsula-apartments-at-2400-w-el-camino-real-mountain-view-ca-94040	Avalon Towers on the Peninsula	3720	5080	1	3	\N	\N	\N	\N	2400 W El Camino Real	Mountain View	\N	\N	\N	t	\N	t	\N	\N	t	\N	\N	t	\N	t	t	f	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p15695/eaves-mountain-view-at-middlefield-apartments-at-555-w-middlefield-rd-mountain-view-ca-94043	eaves Mountain View at Middlefield	2457	3935	0	2	\N	\N	\N	\N	555 W Middlefield Rd	Mountain View	\N	\N	\N	t	\N	t	\N	\N	t	\N	\N	\N	\N	t	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/62493362/1-bedroom-1-bath-apartment-at-1941-california-st-mountain-view-ca-94040	1941 California St #2032	2870	2870	1	1	1	1	630	630	1941 California St #2032	Mountain View	\N	\N	\N	t	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p14324/avalon-mountain-view-apartments-at-1600-villa-st-mountain-view-ca-94041	Avalon Mountain View	3400	4495	1	3	1	2	\N	\N	1600 Villa St	Mountain View	Shoreline West	\N	\N	t	f	t	f	f	f	f	f	f	f	t	t	t	f	t	f	t	padmapper.com
https://www.padmapper.com/buildings/1443154/san-jose-mountain-view-apartments-at-190-e-el-camino-real-mountain-view-ca-94040	San Jose - Mountain View 190 E El Camino Real	2999	2999	0	0	\N	\N	\N	\N	190 E El Camino Real	Mountain View	Old Mountain View	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p14511/eaves-creekside-apartments-at-151-calderon-ave-mountain-view-ca-94041	eaves Creekside	2260	3545	0	2	\N	\N	\N	\N	151 Calderon Ave	Mountain View	Old Mountain View	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p296814/arlo-mountain-view-apartments-at-1030-castro-st-mountain-view-ca-94040	ARLO Mountain View	3349	4849	0	3	\N	\N	\N	\N	1030 Castro St	Mountain View	Cuesta Park	\N	\N	\N	\N	t	t	\N	\N	t	t	\N	t	\N	t	t	t	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p63415/the-camille-apartments-at-2645-california-st-mountain-view-ca-94040	The Camille Apartments	2895	3895	1	2	1	2	\N	\N	2645 California St	Mountain View	\N	\N	\N	t	t	\N	t	\N	\N	\N	\N	t	\N	\N	t	t	t	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/11557324p/1-bedroom-1-bath-apartment-at-280-easy-st-mountain-view-ca-94043	280 Easy St #423	2500	2500	1	1	1	1	711	711	280 Easy St #423	Mountain View	\N	\N	\N	f	f	f	t	f	f	f	f	f	f	f	t	f	f	t	t	f	padmapper.com
https://www.padmapper.com/buildings/p12999/reserve-at-mountain-view-apartments-at-870-e-el-camino-real-mountain-view-ca-94040	Reserve at Mountain View	3005	3735	1	2	1	2	\N	\N	870 E El Camino Real	Mountain View	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p103602/the-camille-north-apartments-at-2685-california-st-mountain-view-ca-94040	The Camille North Apartments	4095	4095	2	2	2	2	\N	\N	2685 California St	Mountain View	\N	\N	\N	t	\N	\N	t	\N	\N	\N	t	\N	\N	t	t	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p89627/regency-at-mountain-view-apartments-at-333-escuela-ave-mountain-view-ca-94040	Regency at Mountain View	3237	3307	1	3	\N	\N	\N	\N	333 Escuela Ave	Mountain View	Shoreline West	\N	\N	t	t	t	t	\N	\N	t	\N	t	\N	\N	t	t	t	\N	t	t	padmapper.com
https://www.padmapper.com/buildings/1724401/apartments-at-900-high-school-way-mountain-view-ca-94041	900 High School Way #170	5800	5800	2	2	2	2	\N	\N	900 High School Way #170	Mountain View	Old Mountain View	\N	\N	t	\N	\N	t	\N	\N	\N	t	\N	t	\N	t	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/rentals/62493362/1-bedroom-1-bath-apartment-at-1941-california-street-mountain-view-ca-94040	1941 California Street #2032	2880	2880	1	1	1	1	\N	\N	1941 California Street #2032	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p14324/avalon-mountain-view-apartments-at-1600-villa-street-mountain-view-ca-94041	Avalon Mountain View	3245	4574	1	3	\N	\N	\N	\N	1600 Villa Street	Mountain View	Shoreline West	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/p16515/avalon-towers-on-the-peninsula-apartments-at-2400-west-el-camino-real-mountain-view-ca-94040	Avalon Towers on the Peninsula	3735	7295	1	3	\N	\N	\N	\N	2400 West El Camino Real	Mountain View	\N	37.398889	-122.106944	t	\N	t	\N	\N	t	\N	\N	\N	\N	t	\N	\N	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/1424199/anton-ladera-apartments-at-398-ortega-avenue-mountain-view-ca-94040	Anton Ladera	2803	3125	0	0	\N	\N	\N	\N	398 Ortega Avenue	Mountain View	\N	\N	\N	t	\N	t	t	t	\N	\N	\N	\N	\N	t	t	t	\N	t	t	\N	padmapper.com
https://www.padmapper.com/buildings/p63415/the-camille-apartments-at-2645-california-street-mountain-view-ca-94040	The Camille Apartments	3695	3695	2	2	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/11557324p/1-bedroom-1-bath-apartment-at-280-easy-street-mountain-view-ca-94043	280 Easy Street #423	2500	2500	1	1	1	1	\N	\N	280 Easy Street #423	Mountain View	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/15906865p/2-bedroom-1-bath-apartment-at-2700-del-medio-court-mountain-view-ca-94040	2700 Del Medio Court #211	3095	3095	2	2	1	1	\N	\N	2700 Del Medio Court #211	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p14511/eaves-creekside-apartments-at-151-calderon-avenue-mountain-view-ca-94041	eaves Creekside	2215	3400	0	2	\N	\N	\N	\N	151 Calderon Avenue	Mountain View	Old Mountain View	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p103602/the-camille-north-apartments-at-2685-california-street-mountain-view-ca-94040	The Camille North Apartments	2795	3595	1	2	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p296814/arlo-mountain-view-apartments-at-1030-castro-street-mountain-view-ca-94040	ARLO Mountain View	3849	4767	1	2	\N	\N	\N	\N	\N	Mountain View	Cuesta Park	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	padmapper.com
https://www.padmapper.com/rentals/16568508p/1-bedroom-1-bath-apartment-at-2700-del-medio-court-mountain-view-ca-94040	2700 Del Medio Court #109	2395	2395	1	1	1	1	\N	\N	2700 Del Medio Court #109	Mountain View	\N	\N	\N	t	\N	f	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p89627/regency-at-mountain-view-apartments-at-333-escuela-avenue-mountain-view-ca-94040	Regency at Mountain View	3189	3289	1	1	\N	\N	\N	\N	\N	Mountain View	Shoreline West	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	t	t	padmapper.com
https://www.padmapper.com/rentals/26156963p/1-bedroom-1-bath-apartment-at-415-del-medio-avenue-mountain-view-ca-94040	415 Del Medio Avenue #08	2495	2495	1	1	1	1	\N	\N	415 Del Medio Avenue #08	Mountain View	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p12999/reserve-at-mountain-view-apartments-at-870-east-el-camino-real-mountain-view-ca-94040	Reserve at Mountain View	3005	3805	1	2	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p209871/el-portal-apartments-at-2065-california-st-mountain-view-ca-94040	El Portal Apartments	2800	2800	1	1	\N	\N	\N	\N	\N	Mountain View	\N	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	t	padmapper.com
https://www.padmapper.com/rentals/3015789p/3-bedroom-2-bath-apartment-at-137-margo-dr-mountain-view-ca-94041	137 Margo Dr	4700	4700	3	3	2	2	\N	\N	137 Margo Dr	Mountain View	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	\N	\N	t	\N	padmapper.com
https://www.padmapper.com/rentals/19817485p/2-bedroom-2-bath-apartment-at-99-east-middlefield-road-mountain-view-ca-94043	99 East Middlefield Road #15	3600	3600	2	2	2	2	\N	\N	99 East Middlefield Road #15	Mountain View	Slater	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	padmapper.com
https://www.padmapper.com/buildings/1972518/apartments-at-800-high-school-way-mountain-view-ca-94041	800 High School Way	3980	3980	1	1	\N	\N	\N	\N	800 High School Way	Mountain View	Old Mountain View	37.403	-122.086	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	\N	\N	padmapper.com
https://www.padmapper.com/buildings/p15695/eaves-mountain-view-at-middlefield-apartments-at-555-west-middlefield-road-mountain-view-ca-94043	eaves Mountain View at Middlefield	2245	3930	0	2	\N	\N	\N	\N	555 West Middlefield Road	Mountain View	\N	\N	\N	t	\N	t	\N	t	\N	\N	\N	\N	t	t	\N	\N	t	t	\N	\N	padmapper.com
\.


--
-- Data for Name: bay_area_rental_listings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bay_area_rental_listings (url, title, city, neighborhood, latitude, longitude, rent_price_min, rent_price_max, bedrooms_min, bedrooms_max, bathrooms_min, bathrooms_max, has_pool, has_hot_tub, has_fitness_center, has_parking, has_ev_charging, has_rooftop_deck, has_clubhouse, has_bbq_grills, has_bike_storage, has_business_center, has_package_service, has_on_site_laundry, is_pet_friendly, has_elevator, has_outdoor_space, has_storage, has_residents_lounge) FROM stdin;
https://www.padmapper.com/buildings/p16515/avalon-towers-on-the-peninsula-apartments-at-2400-west-el-camino-real-mountain-view-ca-94040	Avalon Towers on the Peninsula	Mountain View	\N	37.398889	-122.106944	3735	7295	1	3	\N	\N	t	\N	t	\N	\N	t	\N	\N	\N	\N	t	\N	\N	\N	t	\N	t
https://www.padmapper.com/buildings/p63419/village-square-townhouses-apartments-at-1674-hollenbeck-avenue-sunnyvale-ca-94087	Village Square Townhouses	Sunnyvale	Sunnyvale West	37.3715	-122.0343	3295	3595	2	2	\N	\N	t	\N	f	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	t	f	t
https://www.padmapper.com/buildings/p328886/laurel-oaks-apts-apartments-at-1019-1019-and-1025-laurel-street-menlo-park-ca-94025	Laurel Oaks Apts	Menlo Park	\N	37.453	-122.181	2395	3895	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/1724668/apartments-at-743-roble-avenue-menlo-park-ca-94025	743 Roble Avenue	Menlo Park	Downtown Menlo Park	37.449	-122.181	6420	6420	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/rentals/27166655p/studio-1-bath-apartment-at-425-south-bernardo-avenue-sunnyvale-ca-94086	425 South Bernardo Avenue	Sunnyvale	Sunnyvale West	37.36889	-122.03444	2095	2095	0	0	1	1	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	t	t	t	\N
https://www.padmapper.com/rentals/58444891/2-bedroom-2-bath-apartment-at-10065-judy-avenue-cupertino-ca-95014	10065 Judy Avenue #1570	Cupertino	Rancho Rinconada	37.322998	-122.032182	3110	3110	2	2	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/1724529/apartments-at-20350-stevens-creek-boulevard-cupertino-ca-95014	20350 Stevens Creek Boulevard	Cupertino	\N	37.324399	-122.008711	2970	5120	1	2	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	t	t	t	\N
https://www.padmapper.com/buildings/p576308/apartments-at-1250-lakeside-drive-sunnyvale-ca-94085	1250 Lakeside	Sunnyvale	\N	37.37794	-122.00215	2799	4867	0	2	\N	\N	t	\N	\N	\N	t	\N	\N	\N	\N	t	t	t	t	t	t	t	t
https://www.padmapper.com/buildings/p801467/maxwell-sunnyvale-apartments-at-490-west-mckinley-avenue-sunnyvale-ca-94086	Maxwell Sunnyvale	Sunnyvale	Sunnyvale West	37.3717	-122.0341	3357	4969	0	2	\N	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t	t	t
https://www.padmapper.com/buildings/p12908/the-arches-apartments-at-1235-wildwood-avenue-sunnyvale-ca-94089	The Arches	Sunnyvale	\N	37.3715	-122.0343	2630	3361	1	2	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	t	\N	t	\N	t
https://www.padmapper.com/buildings/1724719/apartments-at-3645-haven-avenue-menlo-park-ca-94025	3645 Haven Avenue	Menlo Park	\N	37.4862215	-122.1827103	3270	4320	1	2	\N	\N	t	\N	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	t	t	t	\N	\N
https://www.padmapper.com/buildings/1724568/apartments-at-350-sharon-park-drive-menlo-park-ca-94025	350 Sharon Park Drive	Menlo Park	Sharon Height	37.453	-122.182	4220	7720	1	2	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	t	\N	\N
https://www.padmapper.com/buildings/1972518/apartments-at-800-high-school-way-mountain-view-ca-94041	800 High School Way	Mountain View	Old Mountain View	37.403	-122.086	3980	3980	1	1	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	\N	t	\N	\N
https://www.padmapper.com/buildings/p16587/stanford-villa-apartments-at-3375-alma-street-palo-alto-ca-94306	Stanford Villa	Palo Alto	St. Claire Gardens	37.4419	-122.1430	2650	4265	0	2	\N	\N	t	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	t	t	\N
https://www.padmapper.com/rentals/58444876/3-bedroom-3-bath-apartment-at-5-heritage-pl-menlo-park-ca-94025	5 Heritage Pl #1528	Menlo Park	\N	37.4678868	-122.1563944	6120	6120	3	3	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N
https://www.padmapper.com/rentals/59875647/3-bedroom-2-bath-apartment-at-2315-eastridge-avenue-menlo-park-ca-94025	2315 Eastridge Avenue #1532	Menlo Park	Sharon Height	37.444	-122.168	6060	6060	3	3	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	\N
https://www.padmapper.com/buildings/1731119/apartments-at-10870-north-stelling-road-cupertino-ca-95014	10870 North Stelling Road	Cupertino	\N	37.32394	-122.02844	3360	3870	1	2	\N	\N	t	\N	\N	\N	t	\N	\N	\N	\N	t	\N	\N	t	\N	t	\N	\N
\.


--
-- Data for Name: blue_citations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blue_citations (cited_paper_title, authors, year, source_files) FROM stdin;
\.


--
-- Data for Name: emnlp25_papers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.emnlp25_papers (paper_title, authors, topics) FROM stdin;
ChartGaze: Enhancing Chart Understanding in LVLMs with Eye-Tracking Guided Attention Refinement	Ali Salamatian, Amirhossein Abaskohi, Wan-Cyuan Fan, Mir Rayat Imtiaz Hossain, Leonid Sigal, Giuseppe Carenini	multimodal, vision-language models, attention, eye-tracking, chart understanding
Toxicity Red-Teaming: Benchmarking LLM Safety in Singapore’s Low-Resource Languages	Yujia Hu, Ming Shan Hee, Preslav Nakov, Roy Ka-Wei Lee	large language models, safety, toxicity, low-resource languages, benchmarking
Gamma-Guard: Lightweight Residual Adapters for Robust Guardrails in Large Language Models	Lijia Lv, Yuanshu Zhao, Guan Wang, Xuehai Tang, Wen Jie, Jizhong Han, Songlin Hu	large language models, robustness, adapters, safety, guardrails
Skip-Thinking: Chunk-wise Chain-of-Thought Distillation Enable Smaller Language Models to Reason Better and Faster	Xiaoshu Chen, Sihang Zhou, KE LIANG, Xiaoyu Sun, Xinwang Liu	chain-of-thought, model distillation, reasoning, language models, efficiency
Improving Clustering with Positive Pairs Generated from LLM-Driven Labels	Xiaotong Zhang, Ying Li	clustering, large language models, data augmentation, positive pairs
LogiCoL: Logically-Informed Contrastive Learning for Set-based Dense Retrieval	Yanzhen Shen, Sihao Chen, Xueqiang Xu, Yunyi Zhang, Chaitanya Malaviya, Dan Roth	contrastive learning, dense retrieval, information retrieval, logic
ModalPrompt: Towards Efficient Multimodal Continual Instruction Tuning with Dual-Modality Guided Prompt	Fanhu Zeng, Fei Zhu, Haiyang Guo, Xu-Yao Zhang, Cheng-Lin Liu	multimodal, continual learning, instruction tuning, prompts
Can an Individual Manipulate the Collective Decisions of Multi-Agents?	Fengyuan Liu, Rui Zhao, Shuo Chen, Guohao Li, Philip Torr, Lei Han, Jindong Gu	multi-agent systems, decision making, manipulation, collective behavior
ICG: Improving Cover Image Generation via MLLM-based Prompting and Personalized Preference Alignment	Zhipeng Bian, Jieming Zhu, Qijiong Liu, Wang Lin, Guohao Cai, Zhaocheng Du, Jiacheng Sun, Zhou Zhao, Zhenhua Dong	multimodal, image generation, prompting, personalized preference
Dynamic Energy-Based Contrastive Learning with Multi-Stage Knowledge Verification for Event Causality Identification	Ya Su, Hu zhang, Yue Fan, Guangjun Zhang, YuJie Wang, Ru Li, Hongye Tan	contrastive learning, event causality, knowledge verification, energy-based models
A Symbolic Adversarial Learning Framework for Evolving Fake News Generation and Detection	Chong Tian, Qirong Ho, Xiuying Chen	fake news, adversarial learning, symbolic learning, generation, detection
Sticker-TTS: Learn to Utilize Historical Experience with a Sticker-driven Test-Time Scaling Framework	Jie Chen, Jinhao Jiang, Yingqian Min, Zican Dong, Shijie Wang, Xin Zhao, Ji-Rong Wen	text-to-speech, test-time scaling, historical experience, speech synthesis
RareSyn: Health Record Synthesis for Rare Disease Diagnosis	Huimin WANG, Yutian Zhao, Yefeng Zheng, Xian Wu	health records, data synthesis, rare diseases, medical diagnosis
From Long to Lean: Performance-aware and Adaptive Chain-of-Thought Compression via Multi-round Refinement	JianZhi Yan, Le Liu, Youcheng Pan, Shiwei Chen, Zike Yuan, Yang Xiang, Buzhou Tang	chain-of-thought, model compression, performance optimization, refinement
Facilitating Long Context Understanding via Supervised Chain-of-Thought Reasoning	Jingyang Lin, Andy Wong, Tian Xia, Shenghua He, Hui Wei, Mei Han, Jiebo Luo	long context understanding, chain-of-thought, reasoning, supervision
CMHG: A Dataset and Benchmark for Headline Generation of Minority Languages in China	Guixian Xu, Zeli Su, Ziyin Zhang, Jianing Liu, Xu Han, Ting Zhang, Yushuang Dong	datasets, headline generation, minority languages, Chinese languages, benchmarking
Understanding the Information Propagation Effects of Communication Topologies in LLM-based Multi-Agent Systems	Xu Shen, Yixin Liu, Yiwei Dai, Yili Wang, Rui Miao, Yue Tan, Shirui Pan, Xin Wang	multi-agent systems, large language models, communication, information propagation
Self-Augmented Preference Alignment for Sycophancy Reduction in LLMs	Chien Hung Chen, Hen-Hsen Huang, Hsin-Hsi Chen	large language models, preference alignment, sycophancy, model behavior
From Tens of Hours to Tens of Thousands: Scaling Back-Translation for Speech Recognition	Tianduo Wang, Lu Xu, Wei Lu, Shanbo Cheng	speech recognition, back-translation, data scaling
TP-RAG: Benchmarking Retrieval-Augmented Large Language Model Agents for Spatiotemporal-Aware Travel Planning	Hang Ni, Fan Liu, Xinyu Ma, Lixin Su, Shuaiqiang Wang, Dawei Yin, Hui Xiong, Hao Liu	large language models, retrieval-augmented models, travel planning, spatiotemporal reasoning, benchmarking
Towards Advanced Mathematical Reasoning for LLMs via First-Order Logic Theorem Proving	Chuxue Cao, Mengze Li, Juntao Dai, Jinluan Yang, Zijian Zhao, Shengyu Zhang, Weijie Shi, Chengzhong LIU, Sirui Han, Yike Guo	mathematical reasoning, large language models, theorem proving, logic
Recontextualizing Revitalization: A Mixed Media Approach to Reviving the Nüshu Language	Ivory Yang, Xiaobo Guo, Yuxin Wang, Hefan Zhang, Yaning Jia, William Dinauer, Soroush Vosoughi	language revitalization, mixed media, minority languages, cultural heritage
Boosting Data Utilization for Multilingual Dense Retrieval	Chao Huang, Fengran Mo, Yufeng Chen, Changhao Guan, Zhenrui Yue, Xinyu Wang, Jinan Xu, Kaiyu Huang	multilingual, dense retrieval, data utilization, information retrieval
CityEQA: A Hierarchical LLM Agent on Embodied Question Answering Benchmark in City Space	Yong Zhao, Kai Xu, Zhengqiu Zhu, Yue Hu, Zhiheng Zheng, Yingfeng Chen, Yatai Ji, Chen Gao, Yong Li, Jincai Huang	embodied question answering, hierarchical models, large language models, city environments
Mitigating Hallucinations in Vision-Language Models through Image-Guided Head Suppression	Sreetama Sarkar, Yue Che, Alex Gavin, Peter Anthony Beerel, Souvik Kundu	vision-language models, hallucination mitigation, image guidance, model robustness
Towards Automated Error Discovery: A Study in Conversational AI	Dominic Petrak, Thy Thy Tran, Iryna Gurevych	error discovery, conversational ai, automated evaluation
Break the Checkbox: Challenging Closed-Style Evaluations of Cultural Alignment in LLMs	Mohsinul Kabir, Ajwad Abrar, Sophia Ananiadou	cultural alignment, large language models, evaluation, bias
Biased Tales: Cultural and Topic Bias in Generating Children’s Stories	Donya Rooein, Vilém Zouhar, Debora Nozza, Dirk Hovy	bias, cultural bias, story generation, children, topic bias
Examining False Positives under Inference Scaling for Mathematical Reasoning	Yu Wang, Nan Yang, Liang Wang, Furu Wei, Fuli Feng	mathematical reasoning, inference scaling, false positives, large language models
QFrCoLA: a Quebec-French Corpus of Linguistic Acceptability Judgments	David Beauchemin, Richard Khoury	corpus, linguistic acceptability, quebec-french, dataset
JUDGEBERT: Assessing Legal Meaning Preservation Between Sentences	David Beauchemin, Michelle Albert-Rochette, Richard Khoury, Pierre-Luc Déziel	legal nlp, meaning preservation, sentence comparison, legal text
Large Language Models as Realistic Microservice Trace Generators	Donghyun Kim, Sriram Ravula, Taemin Ha, Alex Dimakis, Daehyeok Kim, Aditya Akella	large language models, microservices, trace generation, simulation
Fingerprinting LLMs through Survey Item Factor Correlation: A Case Study on Humor Style Questionnaire	Simon Münker	large language models, fingerprinting, humor style, survey analysis
“Feels Feminine to Me”: Understanding Perceived Gendered Style through Human Annotations	Hongyu Chen, Neele Falk, Michael Roth, Agnieszka Falenska	gender style, human annotations, social bias
Breaking Bad Tokens: Detoxification of LLMs Using Sparse Autoencoders	Chumeng Liang, Jiaxuan You	LLM detoxification, sparse autoencoders, token filtering
PanicToCalm: A Proactive Counseling Agent for Panic Attacks	Xuekang Wang, Shengyu Zhu, Xueqi Cheng	counseling agent, panic attacks, proactive agents
SSA-COMET: Do LLMs Outperform Learned Metrics in Evaluating MT for Under-Resourced African Languages?	Han Peng, Jinhao Jiang, Zican Dong, Xin Zhao, LEI FANG	machine translation, evaluation, under-resourced languages, African languages
TableRAG: A Retrieval Augmented Generation Framework for Heterogeneous Document Reasoning	Xiaohan Yu, Pu Jian, Chong Chen	retrieval augmented generation, document reasoning, heterogeneous documents
Process-Supervised Reinforcement Learning for Code Generation	Yufan Ye, Ting Zhang, Wenbin Jiang, Hua Huang	reinforcement learning, code generation, process supervision
PPTAgent: Generating and Evaluating Presentations Beyond Text-to-Slides	Hao Zheng, Xinyan Guan, Hao Kong, Wenkai Zhang, Jia Zheng, Weixiang Zhou, Hongyu Lin, Yaojie Lu, Xianpei Han, Le Sun	presentation generation, evaluation, text-to-slides
VRoPE: Rotary Position Embedding for Video Large Language Models	Zikang Liu, Longteng Guo, Yepeng Tang, Tongtian Yue, Junxian Cai, Kai Ma, Qingbin Liu, Xi Chen, Jing Liu	rotary position embedding, video, large language models
PropRAG: Guiding Retrieval with Beam Search over Proposition Paths	Takashi Wada, Yuki hirakawa, Ryotaro Shimizu, Takahiro Kawashima, Yuki Saito	retrieval, beam search, proposition paths
CoVoGER: A Multilingual Multitask Benchmark for Speech-to-text Generative Error Correction with Large Language Models	Pingzhi Li, Prateek Yadav, Jaehong Yoon, Jie Peng, Yi-Lin Sung, Mohit Bansal, Tianlong Chen	multilingual, speech-to-text, error correction, large language models
SPE Attention: Making Attention Equivariant to Semantic-Preserving Permutation for Code Processing	Runyu Peng, Yunhua Zhou, Kai Lv, Yang Gao, Qipeng Guo, Xipeng Qiu	attention mechanisms, code processing, semantic preservation
Probing for Arithmetic Errors in Language Models	Yucheng Sun, Alessandro Stolfo, Mrinmaya Sachan	language models, error analysis, arithmetic, probing
Variance Sensitivity Induces Attention Entropy Collapse and Instability in Transformers	Jonghyun Hong, Sungyoon Lee	transformers, attention, entropy, model stability
ComicScene154: A Scene Dataset for Comic Analysis	Sandro Paval, Pascal Meißner, Ivan P. Yamshchikov	dataset, comic analysis, scene understanding, multimodal
AraEval: An Arabic Multi-Task Evaluation Suite for Large Language Models	Alhanoof Althnian, Norah A. Alzahrani, Shaykhah Z. Alsubaie, Eman Albilali, Ahmed Abdelali, Nouf M. Alotaibi, M Saiful Bari, Yazeed Alnumay, Abdulhamed Alothaimen, Maryam Saif, Shahad D. Alzaidi, Faisal Abdulrahman Mirza, Yousef Almushayqih, Mohammed Al Saleem, Ghadah Alabduljabbar, Abdulmohsen Al-Thubaity, Areeb Alowisheq, Nora Al-Twairesh	evaluation, large language models, arabic, multitask
MoVa: Towards Generalizable Classification of Human Morals and Values	Ziyu Chen, Junfei Sun, Chenxi Li, Tuan Dung Nguyen, Jing Yao, Xiaoyuan Yi, Xing Xie, Chenhao Tan, Lexing Xie	classification, human morals, values, generalization
N-CORE: N-View Consistency Regularization for Disentangled Representation Learning in Nonverbal Vocalizations	Siddhant Bikram Shah, Kristina T. Johnson	representation learning, disentangled representation, nonverbal vocalizations, consistency regularization
A Knowledge-driven Adaptive Collaboration of LLMs for Enhancing Medical Decision-making	Xiao Wu, Ting-Zhu Huang, Liang-Jian Deng, Yanyuan Qiao, Imran Razzak, Yutong Xie	large language models, medical decision-making, adaptive collaboration, knowledge-driven
Benchmarking and Mitigating MCQA Selection Bias of Large Vision-Language Models	Md. Atabuzzaman, Ali Asgarov, Chris Thomas	benchmarking, vision-language models, multiple-choice question answering, bias mitigation
Mondrian: A Framework for Logical Abstract (Re)Structuring	Elizabeth Grace Orwig, Shinwoo Park, Hyundong Jin, Yo-Sub Han	logical reasoning, abstract structuring, framework
NormGenesis: Multicultural Dialogue Generation via Exemplar-Guided Social Norm Modeling and Violation Recovery	Minki Hong, Jangho Choi, Jihie Kim	dialogue generation, social norms, multicultural, exemplar-guided
Diverse, not Short: A Length-Controlled Data Selection Strategy for Improving Response Diversity of Language Models	Vijeta Deshpande, Debasmita Ghose, John D Patterson, Roger E. Beaty, Anna Rumshisky	data selection, response diversity, language models, length control
Orthogonal Finetuning Made Scalable	Zijian Ling, Han Zhang, Jiahao Cui, Zhequn Wu, Xu Sun, Guohao Li, Xiangjian He	finetuning, scalability, machine learning, model training
The Medium Is Not the Message: Deconfounding Document Embeddings via Linear Concept Erasure	Tu Nguyen, Kevin Du, Alexander Miserlis Hoyle, Ryan Cotterell	document embeddings, concept erasure, representation learning
Detecting LLM Hallucination Through Layer-wise Information Deficiency: Analysis of Ambiguous Prompts and Unanswerable Questions	Grgur Kovač, Jérémy Perez, Rémy Portelas, Peter Ford Dominey, Pierre-Yves Oudeyer	hallucination detection, large language models, ambiguous prompts, unanswerable questions
Train It and Forget It: Merge Lists are Unnecessary for BPE Inference in Language Models	Tomohiro Sawada, Kartik Goyal	language models, byte pair encoding, inference optimization
so much depends / upon / a whitespace: Why Whitespace Matters for Poets and LLMs	Sriharsh Bhyravajjula, Melanie Walsh, Anna Preus, Maria Antoniak	language models, whitespace, poetry, text representation
Retracing the Past: LLMs Emit Training Data When They Get Lost	Myeongseob Ko, Nikhil Reddy Billa, Adam Nguyen, Charles Fleming, Ming Jin, Ruoxi Jia	large language models, training data leakage, data privacy
Aligning Text/Speech Representations from Multimodal Models with MEG Brain Activity During Listening	Padakanti Srijith, Khushbu Pahwa, Radhika Mamidi, Bapi Raju Surampudi, Manish Gupta, SUBBA REDDY OOTA	multimodal models, speech representation, brain activity, alignment
TounsiBench: Benchmarking Large Language Models for Tunisian Arabic	Souha Ben Hassine, Asma Arrak, Marouene Addhoum, Steven R Wilson	benchmarking, large language models, tunisian arabic, evaluation
Towards Author-informed NLP: Mind the Social Bias	Inbar Cohen, Einat Minkov	social bias, authorship, natural language processing
Revisiting LLM Value Probing Strategies: Are They Robust and Expressive?	Siqi Shen, Mehar Singh, Lajanugen Logeswaran, Moontae Lee, Honglak Lee, Rada Mihalcea	large language models, value probing, robustness, interpretability
From Problem-Solving to Teaching Problem-Solving: Aligning LLMs with Pedagogy using Reinforcement Learning	David Dinucu-Jianu, Jakub Macina, Nico Daheim, Ido Hakimi, Iryna Gurevych, Mrinmaya Sachan	pedagogy, reinforcement learning, large language models, teaching, problem-solving
ToneCraft: Cantonese Lyrics Generation with Harmony of Tones and Pitches	Junyu Cheng, Chang Pan, Shuangyin Li	lyrics generation, cantonese, music, tone harmony
R2I-Bench: Benchmarking Reasoning-Driven Text-to-Image Generation	Dong Wang, Xinghang Li, Zhengshen Zhang, Jirong Liu, Xiao Ma, Hanbo Zhang, Tao Kong, Huaping Liu	text-to-image generation, benchmarking, reasoning, multimodal
How do autoregressive transformers solve full addition?	Shi-Yu Tian, Zhi Zhou, Kun-Yang Yu, Ming Yang, Lin-Han Jia, Lan-Zhe Guo, Yu-Feng Li	autoregressive transformers, arithmetic reasoning, addition task
Advancing Oversight Reasoning across Languages for Audit Sycophantic Behaviour via X-Agent	Zhuoyuan Mao, Mengjie Zhao, Qiyu Wu, Hiromi Wakaki, Yuki Mitsufuji	oversight reasoning, multilingual, audit behavior
Teaching Your Models to Understand Code via Focal Preference Alignment	Jie Wu, Haoling Li, Xin Zhang, Xiao Liu, Yangyu Huang, Jianwen Luo, Yizhen Zhang, Zuchao Li, Ruihang Chu, Yujiu Yang, Scarlett Li	code understanding, model training, preference alignment
G2: Guided Generation for Enhanced Output Diversity in LLMs	Zhiwen Ruan, Yixia Li, Yefeng Liu, Yun Chen, Weihua Luo, Peng Li, Yang Liu, Guanhua Chen	guided generation, output diversity, large language models
Warm Up Before You Train: Unlocking General Reasoning in Resource-Constrained Settings	Safal Shrestha, Minwu Kim, Aadim Nepal, Anubhav Shrestha, Keith W. Ross	general reasoning, resource-constrained training, model warm-up
VisCRA: A Visual Chain Reasoning Attack for Jailbreaking Multimodal Large Language Models	Xinkui Lin, yuhui zhang, Yongxiu Xu, Kun Huang, Hongzhang Mu, Yubin Wang, Gaopeng Gou, Li Qian, Li Peng, Wei Liu, Hongbo Xu	multimodal large language models, adversarial attack, visual reasoning
MOSAIC: Modeling Social AI for Content Dissemination and Regulation in Multi-Agent Simulations	Qihan Wang, Shidong Pan, Tal Linzen, Emily Black	social AI, content dissemination, multi-agent simulations
HD-PiSSA: High-Rank Distributed Orthogonal Adaptation	Gangwei Jiang, Yahui Liu, Zhaoyi Li, V. W., Fuzheng Zhang, Linqi Song, Ying Wei, Defu Lian	model adaptation, distributed learning, orthogonal adaptation
Learning Like Humans: Advancing LLM Reasoning Capabilities via Adaptive Difficulty Curriculum Learning and Expert-Guided Self-Reformulation	Haozhan Shen, Kangjia Zhao, Tiancheng Zhao, Ruochen Xu, Zilun Zhang, Mingwei Zhu, Jianwei Yin	large language models, reasoning, curriculum learning, self-reformulation
AbsVis – Benchmarking How Humans and Vision-Language Models “See” Abstract Concepts in Images	Tarun Tater, Diego Frassinelli, Sabine Schulte im Walde	vision-language models, benchmarking, abstract concepts, multimodal
Does Acceleration Cause Hidden Instability in Vision Language Models? Uncovering Instance-Level Divergence Through a Large-Scale Empirical Study	Yizheng Sun, Hao Li, Chang Xu, Hongpeng Zhou, Chenghua Lin, Riza Batista-Navarro, Jingyuan Sun	vision-language models, instability, empirical study, model analysis
How Do Social Bots Participate in Misinformation Spread? A Comprehensive Dataset and Analysis	Herun Wan, Minnan Luo, Zihan Ma, Guang Dai, Xiang Zhao	social bots, misinformation, dataset, analysis
TempParaphraser: “Heating Up” Text to Evade AI-Text Detection through Paraphrasing	Junjie Huang, Ruiquan Zhang, Jinsong Su, Yidong Chen	paraphrasing, text generation, AI-text detection, adversarial methods
When Big Models Train Small Ones: Label-Free Model Parity Alignment for Efficient Visual Question Answering using Small VLMs	Abhirama Subramanyam Penamakuri, Navlika Singh, Piyush Arora, Anand Mishra	visual question answering, model parity, efficient training, vision-language models
VEHME: A Vision-Language Model For Evaluating Handwritten Mathematics Expressions	Thu Phuong Nguyen, Duc M. Nguyen, Hyotaek Jeon, Hyunwook Lee, Hyunmin Song, Sungahn Ko, Taehwan Kim	vision-language models, handwritten mathematics, evaluation
Predicting Prosodic Boundaries for Children’s Texts	Mansi Dhamne, Sneha Raman, Preeti Rao	prosody prediction, children’s texts, speech processing
MemInsight: Autonomous Memory Augmentation for LLM Agents	Rana Salama, Jason Cai, Michelle Yuan, Anna Currey, MONICA SUNKARA, Yi Zhang, Yassine Benajiba	memory augmentation, large language models, autonomous agents
No Need for Explanations: LLMs can implicitly learn from mistakes in-context	Lisa Alazraki, Maximilian Mozes, Jon Ander Campos, Tan Yi-Chern, Marek Rei, Max Bartolo	large language models, in-context learning, error correction
Probability Distribution Collapse: A Critical Bottleneck to Compact Unsupervised Neural Grammar Induction	Jinwook Park, Kangil Kim	unsupervised learning, neural grammar induction, probability distribution collapse
Word Salad Chopper: Reasoning Models Waste A Ton Of Decoding Budget On Useless Repetitions, Self-Knowingly	Wenya Xie, Shaochen Zhong, Hoang Anh Duy Le, Zhaozhuo Xu, Jianwen Xie, Zirui Liu	reasoning models, decoding, repetition, efficiency
PRIME: Large Language Model Personalization with Cognitive Dual-Memory and Personalized Thought Process	Xinliang Frederick Zhang, Nicholas Beauchamp, Lu Wang	large language models, personalization, cognitive memory, thought process
Data Descriptions from Large Language Models with Influence Estimation	Chaeri Kim, Jaeyeon Bae, Taehwan Kim	data description, large language models, influence estimation
The Missing Parts: Augmenting Fact Verification with Half Truth Detection	Yixuan Tang, Jincheng Wang, Anthony Kum Hoe Tung	fact verification, half truth detection, augmentation
RAG+: Enhancing Retrieval-Augmented Generation with Application-Aware Reasoning	Mushtari Sadia, Zhenning Yang, Yunming Xiao, Ang Chen, Amrita Roy Chowdhury	retrieval-augmented generation, reasoning, natural language generation, applications
Text Detoxification: Data Efficiency, Semantic Preservation and Model Generalization	Hauke Licht, Rupak Sarkar, Patrick Y. Wu, Pranav Goel, Niklas Stoehr, Elliott Ash, Alexander Miserlis Hoyle	text detoxification, data efficiency, semantic preservation, model generalization
VideoPASTA: 7K Preference Pairs That Matter for Video-LLM Alignment	Tong Chen, Zimu Wang, Yiyi Miao, Haoran Luo, Sun Yuanfei, Wei Wang, Zhengyong Jiang, Procheta Sen, Jionglong Su	video, large language models, alignment, preference pairs
A Systematic Analysis of Base Model Choice for Reward Modeling	Kian Ahrabian, Pegah Jandaghi, Negar Mokhberian, Sai Praneeth Karimireddy, Jay Pujara	reward modeling, base models, analysis, reinforcement learning
CompKBQA: Component-wise Task Decomposition for Knowledge Base Question Answering	Yuhang Tian, Dandan Song, Zhijing Wu, Pan Yang, Changzhi Zhou, Jun Yang, Hao Wang, Huipeng Ma, Chenhao Li, Luan Zhang	knowledge base question answering, task decomposition, question answering
ProcWorld: Benchmarking Large Model Planning in Reachability-Constrained Environments	Ruifeng Ren, Zhicong Li, Yong Liu	large model planning, benchmarking, reachability constraints, environments
Following the Autoregressive Nature of LLM Embeddings via Compression and Alignment	Agam Goyal, Xianyang Zhan, Yilun Chen, Koustuv Saha, Eshwar Chandrasekharan	large language models, embeddings, autoregressive models, compression, alignment
Data to Defense: The Role of Curation in Aligning Large Language Models Against Safety Compromise	Wenyu Qiu, Yuxiong Wang, Jiajun Tan, Hanchao Hou, Qinda Liu, WEI YAO, Shiguang NI	data curation, large language models, safety, alignment
CAFE: Retrieval Head-based Coarse-to-Fine Information Seeking to Enhance Multi-Document QA Capability	Leonardo Ranaldi, Giulia Pucci	information retrieval, multi-document QA, coarse-to-fine
Vision-Free Retrieval: Rethinking Multimodal Search with Textual Scene Descriptions	Ioanna Ntinou, ALEXANDROS XENOS, Yassine Ouali, Adrian Bulat, Georgios Tzimiropoulos	multimodal search, retrieval, textual scene descriptions
Learning to See through Sound: From VggCaps to Multi2Cap for Richer Automated Audio Captioning	Sangyeon Cho, Mingi Kim, Jinkwon Hwang, Jaehoon Go, Minuk Ma, Sunjae Yoon, Junyeong Kim	audio captioning, automated captioning, sound processing
Advancing Fine-Grained Visual Understanding with Multi-Scale Alignment in Multi-Modal Models	Wei Wang, Zhaowei Li, Qi Xu, Linfeng Li, YiQing Cai, Botian Jiang, Hang Song, Xingcan Hu, Pengyu Wang, Li Xiao	visual understanding, multi-scale alignment, multi-modal models
Think, Verbalize, then Speak: Bridging Complex Thoughts and Comprehensible Speech	Sang Hoon Woo, Sehun Lee, Kang-wook Kim, Gunhee Kim	speech generation, complex thoughts, verbalization
Investigating Neurons and Heads in Transformer-based LLMs for Typographical Errors	Bingrui Sima, Linhua Cong, Wenxuan Wang, Kun He	transformers, large language models, typographical error correction, model analysis
Identification of Multiple Logical Interpretations in Counter-Arguments	Genglin Liu, Vivian T. Le, Salman Rahman, Elisa Kreiss, Marzyeh Ghassemi, Saadia Gabriel	logical interpretation, counter-arguments, argumentation
Audio-centric Video Understanding Benchmark without Text Shortcut	Chengyu Jiao, Shuhao Chen, Yu Zhang	video understanding, audio-centric, benchmark
Large Language Models Discriminate Against Speakers of German Dialects	Minh Duc Bui, Carolin Holtermann, Valentin Hofmann, Anne Lauscher, Katharina von der Wense	large language models, dialects, bias, fairness, language variation
A Middle Path for On-Premises LLM Deployment: Preserving Privacy Without Sacrificing Model Confidentiality	Hanbo Huang, Yihan Li, Bowen Jiang, Bo Jiang, Lin Liu, Zhuotao Liu, Ruoyu Sun, Shiyu Liang	large language models, deployment, privacy, model confidentiality
Are Stereotypes Leading LLMs’ Zero-Shot Stance Detection ?	Anthony Dubreuil, Antoine Gourru, Christine Largeron, Amine Trabelsi	stereotypes, zero-shot stance detection, large language models, bias
HookMoE: A learnable performance compensation strategy of Mixture-of-Experts for LLM inference acceleration	Cheng Longkai, Along He, Mulin Li, Xie xueshuo, Tao Li	mixture-of-experts, large language models, inference acceleration, model efficiency
Structure-Conditional Minimum Bayes Risk Decoding	Bryan Eikema, Anna Rutkiewicz, Mario Giulianelli	decoding, minimum bayes risk, structured prediction
SEMMA: A Semantic Aware Knowledge Graph Foundation Model	Arvindh Arun, Sumit Kumar, Mojtaba Nayyeri, Bo Xiong, Ponnurangam Kumaraguru, Antonio Vergari, Steffen Staab	knowledge graph, foundation models, semantic awareness
Can Large Language Models Outperform Non-Experts in Poetry Evaluation? A Comparative Study Using the Consensual Assessment Technique	Piotr Sawicki, Marek Grzes, Dan Brown, Fabricio Goes	poetry evaluation, large language models, comparative study
Language Models Identify Ambiguities and Exploit Loopholes	Jio Choi, Mohit Bansal, Elias Stengel-Eskin	large language models, ambiguity detection, loophole exploitation
Rapid Word Learning Through Meta In-Context Learning	Yu Wang, Shiwan Zhao, Zhihu Wang, Ming FAN, Yubo Zhang, Xicheng Zhang, Zhengfan Wang, Heyuan Huang, Ting Liu	word learning, meta learning, in-context learning, language modeling
Africa Health Check: Probing Cultural Bias in Medical LLMs	Zhenning Shi, Yijia Zhu, Yi Xie, Junhan Shi, Guorui Xie, Haotian Zhang, Yong Jiang, Congcong Miao, Qing Li	cultural bias, medical, large language models, fairness
MedFact: A Large-scale Chinese Dataset for Evidence-based Medical Fact-checking of LLM Responses	Kuang-Da Wang, Shuoyang Ding, Chao-Han Huck Yang, Ping-Chun Hsieh, Wen-Chih Peng, Vitaly Lavrukhin, Boris Ginsburg	medical, fact-checking, datasets, large language models, Chinese
Spectral Scaling Laws in Language Models: \\ emph{How Effectively Do Feed-Forward Networks Use Their Latent Space?}	Nandan Kumar Jha, Brandon Reagen	language models, feed-forward networks, latent space, model analysis
Certified Mitigation of Worst-Case LLM Copyright Infringement	Jingyu Zhang, Jiacan Yu, Marc Marone, Benjamin Van Durme, Daniel Khashabi	large language models, copyright infringement, mitigation, legal
Layer-wise Minimal Pair Probing Reveals Contextual Grammatical-Conceptual Hierarchy in Speech Representations	Linyang He, Qiaolin Wang, Xilin Jiang, Nima Mesgarani	speech representations, probing, grammatical hierarchy, conceptual hierarchy
STARQA: A Question Answering Dataset for Complex Analytical Reasoning over Structured Databases	Mounica Maddela, Lingjue Xie, Daniel Preotiuc-Pietro, Mausam	question answering, datasets, analytical reasoning, structured databases
Turning Logic Against Itself: Probing Model Defenses Through Contrastive Questions	Rachneet Singh Sachdeva, Rima Hazra, Iryna Gurevych	model defenses, contrastive questions, probing
Doc2Chart: Intent-Driven Zero-Shot Chart Generation from Documents	Akriti Jain, Pritika Ramu, Aparna Garimella, Apoorv Saxena	zero-shot learning, chart generation, document understanding
Making VLMs More Robot-Friendly: Self-Critical Distillation of Low-Level Procedural Reasoning	Yisong Miao, Min-Yen Kan	vision-language models, robotics, procedural reasoning, distillation
MathTutorBench: A Benchmark for Measuring Open-ended Pedagogical Capabilities of LLM Tutors	Jakub Macina, Nico Daheim, Ido Hakimi, Manu Kapur, Iryna Gurevych, Mrinmaya Sachan	benchmark, pedagogical capabilities, large language models, education
Translationese-index: Using Likelihood Ratios for Graded and Generalizable Measurement of Translationese	Yu Wang, Nan Yang, Liang Wang, Furu Wei, Fuli Feng	translationese, likelihood ratios, evaluation, machine translation
MAIN: Mutual Alignment Is Necessary for instruction tuning	WANG PEIXU, Chen Yu, Yu Ming, Cheng Xiang	instruction tuning, mutual alignment, large language models
CoPL: Collaborative Preference Learning for Personalizing LLMs	Jihyun Lee, Yejin Min, San Kim, Yejin Jeon, Sung Jun Yang, Hyounghun Kim, Gary Lee	preference learning, personalization, large language models
CCQA: Generating Question from Solution Can Improve Inference-Time Reasoning in SLMs	Jinyoung Kim, Ji Won Yoon	question generation, reasoning, language models
Towards Optimal Evaluation Efficiency for Large Language Models	Guohong Li, Deyi Xiong	evaluation efficiency, large language models
Thought calibration: Efficient and confident test-time scaling	Menghua Wu, Cai Zhou, Stephen Bates, Tommi Jaakkola	test-time scaling, model calibration, efficiency
SciNLP: A Domain-Specific Benchmark for Full-Text Scientific Entity and Relation Extraction in NLP		scientific entity extraction, relation extraction, domain-specific benchmark, NLP
RAV: Retrieval-Augmented Voting for Tactile Descriptions Without Training	Shuo Yan, Ziming Luo, Zimu Wang, Ruochen Li, Daoyang Li, Liqiang Jing, Kaiyu He, Peilin Wu, Juntong Ni, George Michalopoulos, Yue Zhang, Ziyang Zhang, Mian Zhang, Zhiyu Chen, Xinya Du	retrieval-augmented methods, tactile description, zero-shot learning
Legal Fact Prediction: The Missing Piece in Legal Judgment Prediction	Jinman Zhao, Xueyan Zhang, Jiaru Li, Jingcheng Niu, Yulan Hu, Erxue Min, Gerald Penn	legal fact prediction, legal judgment prediction, legal NLP
Firewall Routing: Blocking Leads to Better Hybrid Inference for LLMs	Yiding Wang, Fanxu Meng, Xuefeng Zhang, Fan Jiang, Pingzhi Tang, Muhan Zhang	hybrid inference, large language models, routing
Mining the Past with Dual Criteria: Integrating Three types of Historical Information for Context-aware Event Forecasting	Rong Ma, Lei Wang, Yating Yang, Bo Ma, Rui Dong, Fengyi Yang, Ahtamjan Ahmat, Kaiwen Lu, Xinyue Wang	event forecasting, historical information, context-aware, time series, prediction
Robust Native Language Identification through Agentic Decomposition	Ahmet Yavuz Uluslu, Tannon Kew, Tilia Ellendorff, Gerold Schneider, Rico Sennrich	native language identification, robustness, agentic decomposition
RALS: Resources and Baselines for Romanian Automatic Lexical Simplification	Fabian Anghel, Cristea Petru-Theodor, Claudiu Creanga, Sergiu Nisioi	lexical simplification, Romanian language, resources, baselines
Cross-Document Cross-Lingual NLI via RST-Enhanced Graph Fusion and Interpretability Prediction	Mengying Yuan, WenHao Wang, Zixuan Wang, Yujie Huang, Kangli Wei, Fei Li, Chong Teng, Donghong Ji	natural language inference, cross-lingual, graph fusion, interpretability
Extractive Fact Decomposition for Interpretable Natural Language Inference in one Forward Pass	Nicholas Popovic, Michael Färber	natural language inference, interpretability, fact decomposition
Threading the Needle: Reweaving Chain-of-Thought Reasoning to Explain Human Label Variation	Beiduo Chen, Yang Janet Liu, Anna Korhonen, Barbara Plank	chain-of-thought reasoning, human label variation, explainability
ImpliRet: Benchmarking the Implicit Fact Retrieval Challenge	Zeinab Sadat Taghavi, Ali Modarressi, Yunpu Ma, Hinrich Schuetze	benchmarking, fact retrieval, implicit knowledge
Graph-Based Multi-Trait Essay Scoring	Shengjie Li, Vincent Ng	essay scoring, graph-based methods, multi-trait scoring
ReflAct: World-Grounded Decision Making in LLM Agents via Goal-State Reflection	Jeonghye Kim, Sojeong Rhee, Minbeom Kim, Dohyung Kim, Sangmook Lee, Youngchul Sung, Kyomin Jung	large language models, decision making, goal reflection, agents
Idiosyncratic Versus Normative Modeling of Atypical Speech Recognition: Dysarthric Case Studies	Vishnu Raja, Adithya V Ganesan, Anand Syamkumar, Ritwik Banerjee, H. Schwartz	speech recognition, atypical speech, dysarthria, modeling
SYNC: A Synthetic Long-Context Understanding Benchmark for Controlled Comparisons of Model Capabilities	Shuyang Cao, Kaijian Zou, Lu Wang	benchmark, long-context understanding, model evaluation
Image Difference Captioning via Adversarial Preference Optimization	Zihan Huang, Junda Wu, Rohan Surana, Tong Yu, David Arbour, Ritwik Sinha, Julian McAuley	image captioning, adversarial optimization, computer vision
MicroEdit: Neuron-level Knowledge Disentanglement and Localization in Lifelong Model Editing	Shiqi Wang, Qi Wang, Runliang Niu, He Kong, Yi Chang	model editing, neuron-level, knowledge disentanglement, lifelong learning
How Persuasive Is Your Context?	Jacqueline Rowe, Mateusz Klimaszewski, Liane Guillou, Shannon Vallor, Alexandra Birch	persuasion, context analysis, natural language understanding
ToM-SSI: Evaluating Theory of Mind in Situated Social Interactions	Aly M. Kassem, Golnoosh Farnadi, Negar Rostamzadeh, Zhuan Shi	theory of mind, social interactions, evaluation, situated interactions
Translating Domain-Specific Terminology in Typologically-Diverse Languages: A Study in Tax and Financial Education	Arturo Oncevay, Elena Kochkina, Keshav Ramani, Toyin Aguda, Simerjot Kaur, Charese Smiley	translation, domain-specific terminology, multilingual, financial education, tax domain
A Simple Yet Effective Method for Non-Refusing Context Relevant Fine-grained Safety Steering in LLMs	Shaona Ghosh, Amrita Bhattacharjee, Yftah Ziser, Christopher Parisien	large language models, safety, fine-grained control, context relevance
Current Semantic-change Quantification Methods Struggle with Semantic Change Discovery in the Wild	Khonzoda Umarova, Lillian Lee, Laerdon Kim	semantic change, quantification methods, language change
Long Chain-of-Thought Fine-tuning via Understanding-to-Reasoning Transition	Chenxin An, Zhihui Xie, Xiaonan Li, Ming Zhong, Shansan Gong, Lei Li, Jun Zhang, Jingjing Xu, Lingpeng Kong	chain-of-thought, fine-tuning, reasoning, understanding
CHURRO: Making History Readable with an Open-Weight Large Vision-Language Model for High-Accuracy, Low-Cost Historical Text Recognition	Sina Semnani, Han Zhang, Xinyan He, Merve Tekgurler, Monica Lam	vision-language models, historical text recognition, accuracy, efficiency
NormXLogit: The Head-on-Top Never Lies	Sina Abbasi, Mohammad Reza Modarres, Mohammad Taher Pilehvar	logit models, neural networks, model analysis
Comparing Specialised Small and General Large Language Models on Text Classification: 100 Labelled Samples to Achieve Break-Even Performance	Branislav Pecher, Ivan Srba, Maria Bielikova	text classification, large language models, small models, performance comparison
Permutative Preference Alignment from Listwise Ranking of Human Judgments	Yang Zhao, Yixin Wang, Mingzhang Yin	preference alignment, human judgments, ranking
Can GRPO Boost Complex Multimodal Table Understanding?	Kaijie Chen, Zihao Lin, Zhiyang Xu, Ying Shen, Yuguang Yao, Joy Rimchala, Jiaxin Zhang, Lifu Huang	multimodal table understanding, complex data, GRPO method
DeepWell-Adol: A Scalable Expert-Based Dialogue Corpus for Adolescent Positive Mental Health and Wellbeing Promotion	Dingwei Chen, Ziqiang Liu, Feiteng Fang, Chak Tou Leong, Shiwen Ni, Ahmadreza Argha, Hamid Alinejad-Rokny, Min Yang, Chengming Li	dialogue corpus, mental health, adolescent wellbeing, expert-based
AI Chatbots as Professional Service Agents: Developing a Professional Identity	Chao Hao, Zezheng Wang, Yanhua Huang, Ruiwen Xu, Wenzhe Niu, Xin Liu, Zitong YU	AI chatbots, professional service agents, identity development
Transparent and Coherent Procedural Mistake Detection	Shane Storks, Itamar Bar-Yossef, Yayuan Li, Zheyuan Zhang, Jason J Corso, Joyce Chai	procedural mistake detection, error detection, transparency, coherence
Mixture-of-Clustered-Experts: Advancing Expert Specialization and Generalization in Instruction Tuning	Sugyeong Eo, Jung Jun Lee, Chanjun Park, Heuiseok Lim	expert specialization, instruction tuning, model generalization
Can LLMs Reason Abstractly Over Math Word Problems Without CoT? Disentangling Abstract Formulation From Arithmetic Computation	Ziling Cheng, Meng Cao, Leila Pishdad, Yanshuai Cao, Jackie CK Cheung	large language models, math word problems, abstract reasoning, arithmetic computation
HydraRAG: Structured Cross-Source Enhanced Large Language Model Reasoning	Xingyu Tan, Xiaoyang Wang, Qing Liu, Xiwei Xu, Xin Yuan, Liming Zhu, Wenjie Zhang	large language models, reasoning, cross-source enhancement
Static Word Embeddings for Sentence Semantic Representation	Jinlin Wang, Yulong Ji, Hongyu Yang	word embeddings, sentence representation, semantic representation
DAMON: A Dialogue-Aware MCTS Framework for Jailbreaking Large Language Models	Junkai Liu, Yujie Tong, Hui Huang, Bowen Zheng, Yiran HU, Peicheng Wu, Chuan Xiao, Makoto Onizuka, Muyun Yang, Shuyuan Zheng	dialogue systems, large language models, jailbreaking, monte carlo tree search
TurboRAG: Accelerating Retrieval-Augmented Generation with Precomputed KV Caches for Chunked Text	Yudong Yang, Jimin Zhuang, Guangzhi Sun, Changli Tang, Yixuan Li, Peihan Li, Yifan Jiang, Wei Li, Zejun MA, Chao Zhang	retrieval-augmented generation, caching, chunked text
RAGferee: Building Contextual Reward Models for Retrieval-Augmented Generation	Andrei Catalin Coman, Ionut Teodor Sorodoc, Leonardo F. R. Ribeiro, Bill Byrne, James Henderson, Adrià de Gispert	retrieval-augmented generation, reward models, contextual modeling
X-FLoRA: Cross-modal Federated Learning with Modality-expert LoRA for Medical VQA	Min Hyuk Kim, Changheon Kim, Seok Bong Yoo	federated learning, cross-modal, medical, visual question answering, LoRA
Multi-Modal Framing Analysis of News	Arnav Arora, Srishti Yadav, Maria Antoniak, Serge Belongie, Isabelle Augenstein	multi-modal, framing analysis, news, social media
MedLinkDE – MedDRA Entity Linking for German with Guided Chain of Thought Reasoning	Roman Christof, Farnaz Zeidi, Manuela Messelhäußer, Dirk Mentzer, Renate Koenig, Liam Childs, Alexander Mehler	entity linking, medical domain, German language, chain of thought reasoning
ProReason: Multi-Modal Proactive Reasoning with Decoupled Eyesight and Wisdom	Jingqi Zhou, Sheng Wang, Jingwei Dong, Kai Liu, Lei Li, Jiahui Gao, Jiyue Jiang, Lingpeng Kong, Chuan Wu	multi-modal reasoning, proactive reasoning, vision and language
The Transfer Neurons Hypothesis: An Underlying Mechanism for Language Latent Space Transitions in Multilingual LLMs	Hinata Tezuka, Naoya Inoue	multilingual large language models, latent space, language transitions
Enhancing Logical Reasoning in Language Models via Symbolically-Guided Monte Carlo Process Supervision	Xingwei Tan, Marco Valentino, Mahmud Elahi Akhter, Maria Liakata, Nikolaos Aletras	logical reasoning, language models, monte carlo supervision
LLM Response Lengths with Extreme Value Theory: Anchoring Effects and Hybrid Distributions	Liuxuan Jiao, Chen Gao, Yiqian Yang, Chenliang Zhou, YiXian Huang, Yong Li, Xinlei Chen	large language models, response length, statistical modeling, extreme value theory
Revealing and Mitigating the Challenge of Detecting Character Knowledge Errors in LLM Role-Playing	Wenyuan Zhang, Shuaiyi Nie, Jiawei Sheng, Zefeng Zhang, Xinghua Zhang, Yongquan He, Tingwen Liu	large language models, error detection, role-playing, character knowledge
Benchmarking LLMs on Semantic Overlap Summarization	John Salvador, Naman Bansal, Mousumi Akter, Souvika Sarkar, Anupam Das, Santu Karmaker	large language models, summarization, semantic overlap
CompassVerifier: A Unified and Robust Verifier for LLMs Evaluation and Outcome Reward	Shudong Liu, Hongwei Liu, Junnan Liu, Linchen Xiao, Songyang Gao, Chengqi Lyu, Yuzhe Gu, Wenwei Zhang, Derek F. Wong, Songyang Zhang, Kai Chen	large language models, evaluation, verification, outcome reward
NESTFUL: A Benchmark for Evaluating LLMs on Nested Sequences of API Calls	Kinjal Basu, Ibrahim Abdelaziz, Kiran Kate, Mayank Agarwal, Maxwell Crouse, Yara Rizk, Kelsey Bradford, Asim Munawar, Sadhana Kumaravel, Saurabh Goyal, Xin Wang, Luis A. Lastras, Pavan Kapanipathi	benchmark, large language models, nested sequences, API calls, evaluation
OpenNER 1.0: Standardized Open-Access Named Entity Recognition Datasets in 50+ Languages	Chester Palen-Michel, Maxwell Pickering, Maya Kruse, Jonne Sälevä, Constantine Lignos	named entity recognition, datasets, multilingual, open access
seqBench: A Tunable Benchmark to Quantify Sequential Reasoning Limits of LLMs	Mohammad Ramezanali, Mo Vazifeh, Paolo Santi	benchmark, sequential reasoning, large language models
Do Large Language Models Understand Word Senses?	Domenico Meconi, Simone Stirpe, Federico Martelli, Leonardo Lavalle, Roberto Navigli	large language models, word sense, understanding
Measuring scalar constructs in social science with LLMs	Yu Fan, Yang Tian, Shauli Ravfogel, Mrinmaya Sachan, Elliott Ash, Alexander Miserlis Hoyle	social science, scalar constructs, large language models, measurement
REVIVING YOUR MNEME: Predicting The Side Effects of LLM Unlearning and Fine-Tuning via Sparse Model Diffing	Orfeas Menis Mastromichalakis, Giorgos Filandrianos, Maria Symeonaki, Giorgos Stamou	large language models, unlearning, fine-tuning, model analysis
Is the Top Still Spinning? Evaluating Subjectivity in Narrative Understanding	Melanie Subbiah, Akankshya Mishra, Grace Kim, Liyan Tang, Greg Durrett, Kathleen McKeown	narrative understanding, subjectivity, evaluation
SensorLLM: Aligning Large Language Models with Motion Sensors for Human Activity Recognition	Zechen Li, Shohreh Deldari, Linyao Chen, Hao Xue, Flora D. Salim	large language models, motion sensors, human activity recognition, multimodal learning
MoMoE: Mixture of Moderation Experts Framework for AI-Assisted Online Governance	Xiaoqiang Kang, Shengen Wu, Zimu Wang, Yilin Liu, Xiaobo Jin, Kaizhu Huang, Wei Wang, Yutao Yue, Xiaowei Huang, Qiufeng Wang	online governance, moderation, mixture of experts, AI frameworks
Expanding before Inferring: Enhancing Factuality in Large Language Models through Premature Layers Interpolation	Fanyi Yang, Jianfeng Liu, Xin Zhang, Haoyu Liu, Xixin Cao, Yuefeng Zhan, Hao Sun, Weiwei Deng, Feng Sun, Qi Zhang	large language models, factuality, layer interpolation
Dynamic Collaboration of Multi-Language Models based on Minimal Complete Semantic Units	Youngbin Choi, Seunghyuk Cho, Minjong Lee, MoonJeong Park, Yesong Ko, Jungseul Ok, Dongwoo Kim	multi-language models, collaboration, semantic units
TVQACML: Benchmarking Text-Centric Visual Question Answering in Multilingual Chinese Minority Languages	shajiu, Mengxiao Zhu, Chong Feng, LAMA jIe	visual question answering, multilingual, chinese minority languages, benchmarking
Improve LLM-as-a-Judge Ability as a General Ability	Jiachen Yu, Shaoning Sun, Xiaohui Hu, Jiaxu Yan, Kaidong Yu, Xuelong Li	large language models, evaluation, general ability
MuCAL: Contrastive Alignment for Preference-Driven KG-to-Text Generation	Yifei Song, Claire Gardent	knowledge graph to text, contrastive alignment, preference-driven generation
QCRD: Quality-guided Contrastive Rationale Distillation for Large Language Models	Wei Wang, Zhaowei Li, Qi Xu, YiQing Cai, Hang Song, Qi Qi, Ran Zhou, Zhida Huang, Tao Wang, Li Xiao	contrastive rationale distillation, large language models, quality guidance
LMR-BENCH: Evaluating LLM Agent’s Ability on Reproducing Language Modeling Research	Kohei Tsuji, Tatsuya Hiraoka, Yuchang Cheng, Eiji Aramaki, Tomoya Iwakura	large language models, evaluation, language modeling research
Tiny Budgets, Big Gains: Parameter Placement Strategy in Parameter Super-Efficient Fine-Tuning	Zhengdong Yang, Zhen Wan, Sheng Li, Chao-Han Huck Yang, Chenhui Chu	parameter-efficient fine-tuning, model optimization
AlignX: Advancing Multilingual Large Language Models with Multilingual Representation Alignment	Peng Wang, biyu zhou, Xuehai Tang, Jizhong Han, Songlin Hu	multilingual large language models, representation alignment
RethinkMCTS: Refining Erroneous Thoughts in Monte Carlo Tree Search for Code Generation	Qingyao Li, Wei Xia, Xinyi Dai, Kounianhua Du, Weiwen Liu, Yasheng Wang, Ruiming Tang, Yong Yu, Weinan Zhang	code generation, monte carlo tree search, refinement, program synthesis
ConsistentChat: Building Skeleton-Guided Consistent Multi-Turn Dialogues for Large Language Models from Scratch	Jiawei Chen, Xinyan Guan, Qianhao Yuan, Mo guozhao, Weixiang Zhou, Yaojie Lu, Hongyu Lin, Ben He, Le Sun, Xianpei Han	dialogue systems, multi-turn dialogues, large language models, consistency
3R: Enhancing Sentence Representation Learning via Redundant Representation Reduction	Longxuan Ma, Xiao Wu, Yuxin Huang, Shengxiang Gao, Zhengtao Yu	sentence representation, representation learning, redundancy reduction
Label Set Optimization via Activation Distribution Kurtosis for Zero-Shot Classification with Generative Models	Yue Li, Zhixue Zhao, Carolina Scarton	zero-shot classification, generative models, label optimization
All Roads Lead to Rome: Graph-Based Confidence Estimation for Large Language Model Reasoning	Caiqi Zhang, Chang Shu, Ehsan Shareghi, Nigel Collier	confidence estimation, large language models, graph-based methods, reasoning
Text2Vis: A Challenging and Diverse Benchmark for Generating Multimodal Visualizations from Text	Mizanur Rahman, Md Tahmid Rahman Laskar, Shafiq Joty, Enamul Hoque	multimodal visualization, text-to-visual, benchmark
Beyond Human Labels: A Multi-Linguistic Auto-Generated Benchmark for Evaluating Large Language Models on Resume Parsing	Zijian Ling, Han Zhang, Jiahao Cui, Zhequn Wu, Xu Sun, Guohao Li, Xiangjian	resume parsing, large language models, multilingual, benchmarking
Benchmarking LLMs for Translating Classical Chinese Poetry: Evaluating Adequacy, Fluency, and Elegance	Andong Chen, Lianzhang Lou, Kehai Chen, Xuefeng Bai, Yang Xiang, Muyun Yang, Tiejun Zhao, Min Zhang	large language models, machine translation, classical chinese, poetry, evaluation
Breaking the Noise Barrier: LLM-Guided Semantic Filtering and Enhancement for Multi-Modal Entity Alignment	Chenglong Lu, Chenxiao Li, Jingwei Cheng, Yongquan Ji, Guoqing Chen, Fu Zhang	large language models, semantic filtering, multi-modal, entity alignment
EuroGEST: Investigating gender stereotypes in multilingual language models	Wentao Wang, Guangyuan Jiang, Tal Linzen, Brenden Lake	gender stereotypes, multilingual language models, bias, fairness
Reasoning under Uncertainty: Efficient LLM Inference via Unsupervised Confidence Dilution and Convergent Adaptive Sampling	Kiana Aghakasiri, Noopur Zambare, JoAnn Thai, Carrie Ye, Mayur Mehta, J Ross Mitchell, Mohamed Abdalla	uncertainty, inference, large language models, confidence estimation, sampling
Extending Automatic Machine Translation Evaluation to Book-Length Documents	Hazel Kim, Tom A. Lamb, Adel Bibi, Philip Torr, Yarin Gal	machine translation, evaluation, long documents
Trojsten Benchmark: Evaluating LLM Problem-Solving in Slovak STEM Competition Problems	Adam Zahradník, Marek Suppa	large language models, problem-solving, STEM, benchmarking
CourtReasoner: Can LLM Agents Reason Like Judges?	Simeng Han, Yoshiki Takashima, Shannon Zejiang Shen, Chen Liu, Yixin Liu, Roque K. Thuo, Sonia Knowlton, Ruzica Piskac, Scott J Shapiro, Arman Cohan	large language models, reasoning, legal domain, agents
Towards Robust Mathematical Reasoning	Thang Luong, Hoang H Nguyen, Dawsen Hwang, Golnaz Ghiasi, Yuri Chervonyi, Insuk Seo, Garrett Bingham, Jonathan Lee, Swaroop Mishra, Alex Zhai, Huiyi Hu, Henryk Michalewski, Jimin Kim, Jeonghyun Ahn, Junhwi Bae, Quoc V Le, Junehyuk Jung	mathematical reasoning, robustness, large language models
Efficient Real-time Refinement of Language Model Text Generation	Joonho Ko, Jinheon Baek, Sung Ju Hwang	language model, text generation, real-time refinement, efficiency
EduVidQA: Generating and Evaluating Long-form Answers to Student Questions based on Lecture Videos	Sourjyadip Ray, Shubham Sharma, Somak Aditya, Pawan Goyal	question answering, long-form answers, educational videos, evaluation
DrFrattn: Directly Learn Adaptive Policy from Attention for Simultaneous Machine Translation	Libo Zhao, Jing Li, Ziqian Zeng	machine translation, adaptive policy, attention mechanisms
Preemptive Detection and Correction of Misaligned Actions in LLM Agents	Haishuo Fang, Xiaodan Zhu, Iryna Gurevych	large language models, agent alignment, error detection, correction
Evaluating LLM-Generated Diagrams as Graphs	Jingcheng Deng, Zhongtao Jiang, Liang Pang, Zihao Wei, Liwei Chen, Kun Xu, Yang Song, Huawei Shen, Xueqi Cheng	diagram evaluation, large language models, graph representation
Speculative Safety-Aware Decoding	Xiaoqun Liu, Jiacheng Liang, Luoxi Tang, Muchao Ye, Weicheng Ma, Zhaohan Xi	safety-aware decoding, speculative decoding, language models
FaithUn: Toward Faithful Forgetting in Language Models by Investigating the Interconnectedness of Knowledge	Senyu Li, Jiayi Wang, Felermino D. M. A. Ali, Colin Cherry, Daniel Deutsch, Eleftheria Briakou, Rui Sousa-Silva, Henrique Lopes Cardoso, Pontus Stenetorp, David Ifeoluwa Adelani	language models, knowledge forgetting, faithfulness
Retrieval Enhanced Feedback via In-context Neural Error-book	Jongyeop Hyun, Bumsoo Kim	retrieval, feedback, neural networks, error correction
ToolSafety: A Comprehensive Dataset for Enhancing Safety in LLM-Based Agent Tool Invocations	Yuejin Xie, Youliang Yuan, Wenxuan Wang, Fan Mo, Jianmin Guo, Pinjia He	dataset, safety, large language models, agent tools
SHARP: Steering Hallucination in LVLMs via Representation Engineering	Junfei Wu, Yue Ding, Guofan Liu, Tianze Xia, Ziyue Huang, Dianbo Sui, Qiang Liu, Shu Wu, Liang Wang, Tieniu Tan	hallucination, large vision-language models, representation engineering
MAKAR: a Multi-Agent framework based Knowledge-Augmented Reasoning for Grounded Multimodal Named Entity Recognition	Aakanksha Naik, Shruti Singh, Nitzan Barzilay, Kyle Lo, Tom Hope, Luca Soldaini, Shannon Zejiang Shen, Doug Downey, Hannaneh Hajishirzi, Arman Cohan	multimodal named entity recognition, knowledge-augmented reasoning, multi-agent systems
Glider: Global and Local Instruction-Driven Expert Router	Jun Yan, Wenjie Jacky Mo, Xiang Ren, Robin Jia	instruction following, expert routing, language models
LyapLock: Bounded Knowledge Preservation in Sequential Large Language Model Editing	Wenzhi Wang, Paul Reisert, Shoichi Naito, Naoya Inoue, Machi Shimmei, Surawat Pothong, Jungmin Choi, Kentaro Inui	knowledge preservation, large language model editing, sequential editing
ZoomEye: Enhancing Multimodal LLMs with Human-Like Zooming Capabilities through Tree-Based Image Exploration	Songshuo Lu, Hua Wang, Yutian Rong, Zhi Chen, Yaohua Tang	multimodal large language models, image exploration, zooming capabilities
Uncovering Argumentative Flow: A Question-Focus Discourse Structuring Framework	Yini Wang, Xian Zhou, Shengan Zheng, Linpeng Huang, Zhunchen Luo, Wei Luo, Xiaoying Bai	discourse structuring, argumentation, question-focus, text analysis
Alignment with Fill-In-the-Middle for Enhancing Code Generation	Houxing Ren, Zimu Lu, Weikang Shi, Haotian Hou, Yunqiao Yang, Ke Wang, Aojun Zhou, Junting Pan, Mingjie Zhan, Hongsheng Li	code generation, alignment, fill-in-the-middle, program synthesis
QUIDS: Query Intent Description for Exploratory Search via Dual Space Modeling	Yumeng Wang, Xiuying Chen, Suzan Verberne	information retrieval, query intent, exploratory search, dual space modeling
Taking Notes Brings Focus? Towards Multi-Turn Multimodal Dialogue Learning	jiazheng liu, Sipeng Zheng, Börje F. Karlsson, Zongqing Lu	multimodal dialogue, multi-turn dialogue, note taking, focus
Spatial Layouts in News Homepages Capture Human Preferences	Alexander Spangher, Michael Vu, Arda Kaz, Naitian Zhou, Ben Welsh	spatial layouts, news homepages, human preferences, user modeling
DIWALI - Diversity and Inclusivity aWare cuLture specific Items for India: Dataset and Assessment of LLMs for Cultural Text Adaptation in Indian Context	Maharaj Brahma, Pramit Sahoo, Maunendra Sankar Desarkar	dataset, cultural adaptation, diversity, inclusivity, large language models, Indian context
Mechanisms vs. Outcomes: Probing for Syntax Fails to Explain Performance on Targeted Syntactic Evaluations	Ananth Agarwal, Jasper Jian, Christopher D Manning, Shikhar Murty	syntax, syntactic evaluation, performance analysis
EquiBench: Benchmarking Large Language Models’ Reasoning about Program Semantics via Equivalence Checking	Anjiang Wei, Jiannan Cao, Ran Li, Hongyu Chen, Yuhui Zhang, Ziheng Wang, Yuan Liu, Thiago S. F. X. Teixeira, Diyi Yang, Ke Wang, Alex Aiken	benchmark, program semantics, equivalence checking, large language models, reasoning
Personalized LLM Decoding via Contrasting Personal Preference	Hyungjune Bu, ChanJoo Jung, Minjae Kang, Jaehyung Kim	personalization, large language models, decoding, personal preference
SQUiD: Synthesizing Relational Databases from Unstructured Text	Wei Liu, Yancheng He, Yu Li, Hui Huang, Chengwei Hu, Jiaheng Liu, Shilong Li, Wenbo Su, Bo Zheng	relational databases, unstructured text, data synthesis, information extraction
Assumed Identities: Quantifying Gender Bias in Machine Translation of Gender-Ambiguous Occupational Terms	Charles Nimo, Shuheng Liu, Irfan Essa, Michael L. Best	gender bias, machine translation, occupational terms, fairness
Do LLMs Adhere to Label Definitions? Examining Their Receptivity to External Label Definitions	Yogesh Kulkarni, Pooyan Fazli	large language models, label definitions, evaluation
TLUE: A Tibetan Language Understanding Evaluation Benchmark	Fan Gao, Cheng Huang, Yutong Liu, Nyima Tashi, Xiangxiang Wang, Thupten Tsering, BAN Ma-bao, RENZENG Duojie, Gadeng Luosang, Rinchen Dongrub, Dorje Tashi, XiaoFengCD, Yongbin Yu, Hao Wang	language understanding, evaluation benchmark, tibetan language
Quantifying Logical Consistency in Transformers via Query-Key Alignment	Eduard Tulchinskii, Laida Kushnareva, Anastasia Voznyuk, Andrei Andriiainen, Irina Piontkovskaya, Evgeny Burnaev, Serguei Barannikov	transformers, logical consistency, query-key alignment, model evaluation
D-RAG: Differentiable Retrieval-Augmented Generation for Knowledge Graph Question Answering	Guangze Gao, Zixuan Li, Chunfeng Yuan, Jiawei Li, Wu Jianzhuo, Yuehao Zhang, Xiaolong Jin, Bing Li, Weiming Hu	knowledge graph, question answering, retrieval-augmented generation
Reward-Weighted Sampling: Enhancing Non-Autoregressive Characteristics in Masked Diffusion LLMs	Daehoon Gwak, Minseo Jung, Junwoo Park, Minho Park, ChaeHun Park, Junha Hyung, Jaegul Choo	non-autoregressive models, masked diffusion, large language models, sampling
ReDepress: A Cognitive Framework for Detecting Depression Relapse from Social Media	Aakash Kumar Agarwal, Saprativa Bhattacharjee, Mauli Rastogi, Jemima S. Jacob, Biplab Banerjee, Rashmi Gupta, Pushpak Bhattacharyya	depression detection, social media, cognitive framework, mental health
Gradient-Attention Guided Dual-Masking Synergetic Framework for Robust Text-based Person Retrieval	Tianlu Zheng, Yifan Zhang, Xiang An, Ziyong Feng, Kaicheng Yang, Qichuan Ding	person retrieval, text-based retrieval, attention mechanisms, robustness
Exploring the Limitations of Mamba in COPY and CoT Reasoning	Yikang Liu, Wanyang Zhang, Yiming Wang, Jialong Tang, Pei Zhang, Baosong Yang, Fei Huang, Rui Wang, Hai Hu	reasoning, chain-of-thought, copy task, model limitations
VCSearch: Bridging the Gap Between Well-Defined and Ill-Defined Problems in Mathematical Reasoning	Agam Goyal, Vedant Rathi, William Yeh, Yian Wang, Yuen Chen, Hari Sundaram	mathematical reasoning, problem solving, well-defined vs ill-defined problems
DeepResonance: Enhancing Multimodal Music Understanding via Music-centric Multi-way Instruction Tuning	Wenwen Li, Kangwei Shi, YidongChai	multimodal music understanding, instruction tuning, music-centric
MoLoRAG: Bootstrapping Document Understanding via Multi-modal Logic-aware Retrieval	Xixi Wu, Yanchao Tan, Nan Hou, Ruiyang Zhang, Hong Cheng	document understanding, multi-modal, retrieval, logic-aware
MMAPG: A Training-Free Framework for Multimodal Multi-hop Question Answering via Adaptive Planning Graphs	Yiheng Hu, Xiaoyang Wang, Qing Liu, Xiwei Xu, Qian Fu, Wenjie Zhang, Liming Zhu	multimodal question answering, multi-hop reasoning, planning graphs
SWAM: Adaptive Sliding Window and Memory-Augmented Attention Model for Rumor Detection	Mei Guo, Chen Chen, Chunyan Hou, Yike Wu, Xiaojie Yuan	rumor detection, sliding window, memory-augmented attention
Rethinking Backdoor Detection Evaluation for Language Models	William Wang, Jiawei Han	backdoor detection, language models, security
Multilingual Prompting for Improving LLM Generation Diversity	Xu Zhang, Xunjian Yin, Dinghao Jing, Huixuan Zhang, Xinyu Hu, Xiaojun Wan	multilingual prompting, large language models, generation diversity
What Makes a Good Reasoning Chain? Uncovering Structural Patterns in Long Chain-of-Thought Reasoning	Mengyu Bu, Shaolei Zhang, Zhongjun He, Hua Wu, Yang Feng	reasoning chains, chain-of-thought, structural patterns
NILE: Internal Consistency Alignment in Large Language Models	Minda Hu, Qiyuan Zhang, Yufei Wang, Bowei He, Hongru WANG, Jingyan Zhou, Liangyou Li, Yasheng Wang, Chen Ma, Irwin King	large language models, internal consistency, alignment
A Rigorous Evaluation of LLM Data Generation Strategies for Low-Resource Languages	Tatiana Anikina, Jan Cegin, Jakub Simko, Simon Ostermann	large language models, data generation, low-resource languages, evaluation
When Annotators Disagree, Topology Explains: Mapper, a Topological Tool for Exploring Text Embedding Geometry and Ambiguity	Nisrine Rair, Alban Goupil, Valeriu Vrabie, Emmanuel Chochoy	text embeddings, topology, ambiguity, analysis
MUZO: Leveraging Multiple Queries and Momentum for Zeroth-Order Fine-Tuning of Large Language Models	Yuezhang PENG, Yuxin Liu, Fei Wen, Xie Chen	large language models, fine-tuning, zeroth-order optimization
The Psychology of Falsehood: A Human-Centric Survey of Misinformation Detection	Arghodeep Nandi, Megha Sundriyal, Euna Mehnaz Khan, Jikai Sun, Emily K. Vraga, Jaideep Srivastava, Tanmoy Chakraborty	misinformation detection, survey, human-centric, psychology
AnchorAttention: Difference-Aware Sparse Attention with Stripe Granularity	Yu Zhang, Dong Guo, Fang Wu, Dian Ding, Yiming Zhang	attention mechanisms, sparse attention, difference-aware, transformers
Self-Critique and Refinement for Faithful Natural Language Explanations	Yingming Wang, Pepa Atanasova	natural language explanations, self-critique, refinement, faithfulness
Attacks by Content: Automated Fact-checking is an AI Security Issue	Michael Sejr Schlichtkrull	automated fact-checking, ai security, attacks
SEAL: Structure and Element Aware Learning Improves Long Structured Document Retrieval	Xinhao Huang, Zhibo Ren, Yipeng Yu, Ying Zhou, Zulong Chen, Zeyi Wen	document retrieval, long documents, structure-aware learning
Your Language Model Can Secretly Write Like Humans: Contrastive Paraphrase Attacks on LLM-Generated Text Detectors	Hao Fang, Jiawei Kong, Tianqu Zhuang, Yixiang Qiu, Kuofeng Gao, Bin Chen, Shu-Tao Xia, Yaowei Wang, Min Zhang	large language models, text detection, adversarial attacks, paraphrase attacks
Will It Still Be True Tomorrow? Multilingual Evergreen Question Classification to Improve Trustworthy QA	Sergey Pletenev, Maria Marina, Nikolay Ivanov, Daria Galimzianova, Nikita Krayko, Mikhail Salnikov, Vasily Konovalov, Alexander Panchenko, Viktor Moskvoretskii	question classification, multilingual, trustworthy qa
LiteASR: Efficient Automatic Speech Recognition with Low-Rank Approximation	Keisuke Kamahori, Jungo Kasai, Noriyuki Kojima, Baris Kasikci	automatic speech recognition, efficiency, low-rank approximation
Why Do Some Inputs Break Low-Bit LLM Quantization?	Ting-Yun Chang, Muru Zhang, Jesse Thomason, Robin Jia	large language models, quantization, low-bit, robustness
TokenSkip: Controllable Chain-of-Thought Compression in LLMs	Heming Xia, Chak Tou Leong, Wenjie Wang, Yongqi Li, Wenjie Li	large language models, chain-of-thought, compression, controllability
Are Generative Models Underconfident? Better Quality Estimation with Boosted Model Probability	Tu Anh Dinh, Jan Niehues	generative models, quality estimation, probability calibration
reWordBench: Benchmarking and Improving the Robustness of Reward Models with Transformed Inputs	Zhaofeng Wu, Michihiro Yasunaga, Andrew Cohen, Yoon Kim, Asli Celikyilmaz, Marjan Ghazvininejad	reward models, robustness, benchmarking, transformed inputs
AROMA: Autonomous Rank-one Matrix Adaptation	Hao Nan SHENG, Zhi-Yong Wang, Hing Cheung So, Mingrui Yang	matrix adaptation, autonomous methods, model optimization
Large Language Models Have Intrinsic Meta-Cognition, but Need a Good Lens	Ziyang Ma, Qingyue Yuan, Zhenglin Wang, Deyu Zhou	large language models, meta-cognition, model analysis
Anchoring-Guidance Fine-Tuning (AnGFT): Elevating Professional Response Quality in Role-Playing Conversational Agents	Qibin Li, Zhen Xu, Shengyuan Bai, Nianmin Yao, Kaili Sun, Ying Li, Baoxun Wang, Bowen Wu	fine-tuning, conversational agents, role-playing, response quality
WangchanThaiInstruct: An instruction-following Dataset for Culture-Aware, Multitask, and Multi-domain Evaluation in Thai	Peerat Limkonchotiwat, Pume Tuchinda, Lalita Lowphansirikul, Surapon Nonesung, Panuthep Tasawong, Alham Fikri Aji, Can Udomcharoenchaikit, Sarana Nutanong	instruction-following, dataset, culture-aware, multitask, multi-domain, thai language
MemeReaCon: Probing Contextual Meme Understanding in Large Vision-Language Models	Zhengyi Zhao, Shubo Zhang, Yuxi Zhang, Yanxi Zhao, Yifan Zhang, Zezhong WANG, Huimin WANG, Yutian Zhao, Bin Liang, Yefeng Zheng, Binyang Li, Kam-Fai Wong, Xian Wu	meme understanding, vision-language models, context, multimodal
RiTTA: Modeling Event Relations in Text-to-Audio Generation	Yuhang He, Yash Jain, Xubo Liu, Andrew Markham, Vibhav Vineet	event relations, text-to-audio generation, multimodal generation
A Comprehensive Literary Chinese Reading Comprehension Dataset with an Evidence Curation Based Solution	Dongning Rao, Rongchu Zhou, Peng Chen, Zhihua Jiang	reading comprehension, dataset, literary chinese, evidence curation
T$^2$: An Adaptive Test-Time Scaling Strategy for Contextual Question Answering	Zhengyi Zhao, Shubo Zhang, Zezhong WANG, Huimin WANG, Yutian Zhao, Bin Liang, Yefeng Zheng, Binyang Li, Kam-Fai Wong, Xian Wu	contextual question answering, test-time adaptation, scaling strategy
Stand on The Shoulders of Giants: Building JailExpert from Previous Attack Experience	Xi Wang, Songlei Jian, Shasha Li, Xiaopeng Li, Bin Ji, Ma Jun, Xiaodong Liu, Jing Wang, Jianfeng Zhang, Jie Yu, Feilong Bao, Wangbaosheng	security, adversarial attacks, expert systems
Debate-to-Detect: Reformulating Misinformation Detection as a Real-World Debate with Large Language Models	Chen Han, Wenzhen Zheng, Xijin Tang	misinformation detection, large language models, debate reformulation
DyePack: Provably Flagging Test Set Contamination in LLMs Using Backdoors	Yize Cheng, Wenxiao Wang, Mazda Moayeri, Soheil Feizi	test set contamination, large language models, backdoors, robustness
Complex Numerical Reasoning with Numerical Semantic Pre-training Framework	Jun Zhang, Haihong E, Tianyi Hu, Yifan Zhu, Meina Song, Haoran Luo	numerical reasoning, semantic pre-training, numerical semantics
ViLBench: A Suite for Vision-Language Process Reward Modeling	Haoqin Tu, Weitao Feng, Hardy Chen, Hui Liu, Xianfeng Tang, Cihang Xie	vision-language, reward modeling, benchmarking
Information Integration in Large Language Models is Gated by Linguistic Structural Markers	Wei Liu, Nai Ding	large language models, information integration, linguistic structure
Selective Preference Optimization via Token-Level Reward Function Estimation	Kailai Yang, Zhiwei Liu, Qianqian Xie, Jimin Huang, Erxue Min, Sophia Ananiadou	preference optimization, reward function, token-level, large language models
Personality Matters: User Traits Predict LLM Preferences in Multi-Turn Collaborative Tasks	Sarfaroz Yunusov, Kaige Chen, Kazi Nishat Anwar, Ali Emami	user traits, large language models, multi-turn tasks, preference prediction
MMLU-ProX: A Multilingual Benchmark for Advanced Large Language Model Evaluation	Weihao Xuan, Rui Yang, Heli Qi, Qingcheng Zeng, Yunze Xiao, Aosong Feng, Dairui Liu, Yun Xing, Junjue Wang, Fan Gao, Jinghui Lu, Yuang Jiang, Huitao Li, Xin Li, Kunyu Yu, Ruihai Dong, Shangding Gu, Yuekang Li, Xiaofei Xie, Felix Juefei-Xu, Foutse Khomh, Osamu Yoshie, Qingyu Chen, Douglas Teodoro, Nan Liu, Randy Goebel, Lei Ma, Edison Marrese-Taylor, Shijian Lu, Yusuke Iwasawa, Yutaka Matsuo, Irene Li	multilingual, benchmarking, large language models, evaluation
Utility-Focused LLM Annotation for Retrieval and Retrieval-Augmented Generation	Hengran Zhang, Minghao Tang, Keping Bi, Jiafeng Guo, Shihao Liu, Daiting Shi, Dawei Yin, Xueqi Cheng	large language models, annotation, retrieval, retrieval-augmented generation
Spontaneous Giving and Calculated Greed in Language Models	Yuxuan Li, Hirokazu Shirado	language models, behavior analysis
KG-RAG: Enhancing GUI Agent Decision-Making via Knowledge Graph-Driven Retrieval-Augmented Generation	Ziyi Guan, Jason Chun Lok Li, Zhijian Hou, Pingping Zhang, Donglai Xu, Yuzhi Zhao, Mengyang Wu, Jinpeng Chen, Thanh-Toan Nguyen, Pengfei Xian, Wenao MA, Shengchao Qin, Graziano Chesi, Ngai Wong	knowledge graphs, GUI agents, retrieval-augmented generation
HS-STaR: Hierarchical Sampling for Self-Taught Reasoners via Difficulty Estimation and Budget Reallocation	Feng Xiong, Hongling Xu, Yifei Wang, Runxi Cheng, Yong Wang, Xiangxiang Chu	hierarchical sampling, self-taught reasoners, difficulty estimation
UnCo: Uncertainty-Driven Collaborative Framework of Large and Small Models for Grounded Multimodal NER	Jielong Tang, Yang Yang, Jianxing Yu, Zhen-Xing Wang, Haoyuan Liang, Liang Yao, Jian Yin	uncertainty, collaborative models, multimodal NER, grounded NER
XAutoLM: Efficient Fine-Tuning of Language Models via Meta-Learning and AutoML	Ernesto Luis Estevanell Valladares, Suilan Estevez-Velarde, Yoan Gutierrez, Andrés Montoyo, Ruslan Mitkov	fine-tuning, language models, meta-learning, automl, efficiency
Layer-Aware Representation Filtering: Purifying Finetuning Data to Preserve LLM Safety Alignment	Hao Li, Lijun Li, Zhenghao Lu, Xianyi Wei, Rui Li, Jing Shao, Lei Sha	representation filtering, finetuning data, safety alignment, large language models
Beyond Pairwise: Global Zero-shot Temporal Graph Generation	Alon Eirew, Kfir Bar, Ido Dagan	zero-shot learning, temporal graph generation, graph neural networks
Seeing More, Saying More: Lightweight Language Experts are Dynamic Video Token Compressors	Xiangchen Wang, Jinrui Zhang, Teng Wang, Haigang Zhang, Feng Zheng	video token compression, lightweight models, dynamic models
CODI: Compressing Chain-of-Thought into Continuous Space via Self-Distillation	Zhenyi Shen, Hanqi Yan, Linhai Zhang, Zhanghao Hu, Yali Du, Yulan He	chain-of-thought, self-distillation, continuous space, model compression
Automating Steering for Safe Multimodal Large Language Models	Lyucheng Wu, Mengru Wang, Ziwen Xu, Tri Cao, Nay Oo, Bryan Hooi, Shumin Deng	multimodal large language models, safety, automation
Reimagining Safety Alignment with An Image	Yifan Xia, Guorui Chen, Wenqian Yu, Zhijiang Li, Philip Torr, Jindong Gu	safety alignment, image-based methods, large language models, multimodal models
XQuant: Achieving Ultra-Low Bit KV Cache Quantization with Cross-Layer Compression	Haoqi Yang, Yao Yao, Zuchao Li, Baoyuan Qi, Liu Guoming, hai zhao	model quantization, compression, efficiency, cache optimization
Not All Parameters Are Created Equal: Smart Isolation Boosts Fine-Tuning Performance	YaoWang, Di Liang, Minlong Peng	fine-tuning, parameter isolation, model performance
A Systematic Survey of Automatic Prompt Optimization Techniques	Kiran Ramnath, Kang Zhou, Sheng Guan, Soumya Smruti Mishra, Xuan Qi, Zhengyuan Shen, Shuai Wang, Sangmin Woo, Sullam Jeoung, Yawei Wang, Haozhu Wang, Han Ding, Yuzhe Lu, Zhichao Xu, Yun Zhou, Balasubramaniam Srinivasan, Qiaojing Yan, Yueyan Chen, Haibo Ding, Panpan Xu, Lin Lee Cheong	survey, prompt optimization, automatic techniques, large language models
A Multi-Agent Framework with Automated Decision Rule Optimization for Cross-Domain Misinformation Detection	Dongjun Jang, Youngchae Ahn, Hyopil Shin	multi-agent systems, decision rule optimization, misinformation detection, cross-domain
Dial-In LLM: Human-Aligned LLM-in-the-loop Intent Clustering for Customer Service Dialogues	Yanxu Ji, Jinzhong Ning, Yijia Zhang, Zhi Liu, Hongfei Lin	intent clustering, customer service, human-aligned models, large language models
ThoughtProbe: Classifier-Guided LLM Thought Space Exploration via Probing Representations	Yuanyuan He, Yongsen Pan, Wei Li, Jiali You, Jiawen Deng, Fuji Ren	classifier-guided exploration, thought space, large language models
Latent Inter-User Difference Modeling for LLM Personalization	Yilun Qiu, Tianhao Shi, Xiaoyan Zhao, Fengbin ZHU, Yang Zhang, Fuli Feng	large language models, personalization, user modeling
Shallow Focus, Deep Fixes: Enhancing Shallow Layers Vision Attention Sinks to Alleviate Hallucination in LVLMs	Xiaofeng Zhang, Yihao Quan, Chen Shen, Chaochen Gu, Xiaosong Yuan, Shaotian Yan, Jiawei Cao, Hao Cheng, Kaijie Wu, Jieping Ye	vision-language models, attention mechanisms, hallucination, model improvement
AdaptThink: Reasoning Models Can Learn When to Think	Jiajie Zhang, Nianyi Lin, Lei Hou, Ling Feng, Juanzi Li	reasoning models, learning to think, adaptive computation
Vision-and-Language Navigation with Analogical Textual Descriptions in LLMs	Yue Zhang, Tianyi Ma, Zun Wang, Yanyuan Qiao, Parisa Kordjamshidi	vision-and-language, navigation, large language models, multimodal
Controllable Memorization in LLMs via Weight Pruning	Chenjie Ni, Zhepeng Wang, Runxue Bao, Shangqian Gao, Yanfu Zhang	large language models, memorization, weight pruning, model compression
SeMob: Semantic Synthesis for Dynamic Urban Mobility Prediction	Runfei Chen, Shuyang Jiang, Wei Huang	semantic synthesis, urban mobility, prediction, dynamic systems
GUI-Bee: Align GUI Action Grounding to Novel Environments via Autonomous Exploration	Yue Fan, Handong Zhao, Ruiyi Zhang, Yu Shen, Xin Eric Wang, Gang Wu	gui action grounding, autonomous exploration, human-computer interaction
Measuring Bias or Measuring the Task: Understanding the Brittle Nature of LLM Gender Biases	Bufan Gao, Elisa Kreiss	large language models, bias, gender bias, evaluation
Middo: Model-Informed Dynamic Data Optimization for Enhanced LLM Fine-Tuning via Closed-Loop Learning	Zinan Tang, Xin Gao, Zhuoshi Pan, Qizhi Pei, Mengzhang Cai, Jiang Wu, Conghui He, Lijun Wu	large language models, fine-tuning, data optimization, closed-loop learning
EverTracer: Hunting Stolen Large Language Models via Stealthy and Robust Probabilistic Fingerprint	Zhenhua Xu, Meng Han, Wenpeng Xing	large language models, fingerprinting, security, robustness
Learning from Few Samples: A Novel Approach for High-Quality Malcode Generation	Haijian Ma, Daizong Liu, Xiaowen Cai, Yulai Xie, Pan Zhou	few-shot learning, code generation, malware generation
POSITION BIAS MITIGATES POSITION BIAS: Mitigate Position Bias Through Inter-Position Knowledge Distillation	Yifei Wang, Feng Xiong, Yong Wang, Linjing Li, Xiangxiang Chu, Daniel Dajun Zeng	position bias, knowledge distillation, bias mitigation
Beyond the Surface: Measuring Self-Preference in LLM Judgments	Zhi-Yuan Chen, Hao Wang, Xinyu Zhang, Enrui Hu, Yankai Lin	large language models, self-preference, evaluation
M-BRe: Discovering Training Samples for Relation Extraction from Unlabeled Texts with Large Language Models	Zexuan Li, Hongliang Dai, Piji Li	relation extraction, training sample discovery, unlabeled texts, large language models
ChatVLA: Unified Multimodal Understanding and Robot Control with Vision-Language-Action Model	Zhongyi Zhou, Yichen Zhu, Minjie Zhu, Junjie Wen, Ning Liu, Zhiyuan Xu, Weibin Meng, Ran Cheng, Yaxin Peng, Chaomin Shen, Feifei Feng	multimodal understanding, robot control, vision-language-action models
Text Meets Topology: Rethinking Out-of-distribution Detection in Text-Rich Networks	Danny Wang, Ruihong Qiu, Guangdong Bai, Zi Huang	out-of-distribution detection, text-rich networks, topology
GRPO-LEAD: A Difficulty-Aware Reinforcement Learning Approach for Concise Mathematical Reasoning in Language Models	Jixiao Zhang, Chunsheng Zuo	reinforcement learning, mathematical reasoning, difficulty-aware
Structuring Radiology Reports: Challenging LLMs with Lightweight Models	Johannes Moll, Louisa Fay, Asfandyar Azhar, Sophie Ostmeier, Sergios Gatidis, Tim C. Lueth, Curtis Langlotz, Jean-Benoit Delbrouck	radiology reports, large language models, lightweight models, medical domain
WebAgent-R1: Training Web Agents via End-to-End Multi-Turn Reinforcement Learning	Zhepei Wei, Wenlin Yao, Yao Liu, Weizhi Zhang, Qin Lu, Liang Qiu, Changlong Yu, Puyang Xu, Chao Zhang, Bing Yin, Hyokun Yun, Lihong Li	web agents, reinforcement learning, multi-turn dialogue, training
ToDi: Token-wise Distillation via Fine-Grained Divergence Control	Seongryong Jung, Suwan Yoon, DongGeon Kim, Hwanhee Lee	token-wise distillation, fine-grained divergence, model compression
SoundMind: RL-Incentivized Logic Reasoning for Audio-Language Models	Xingjian Diao, Chunhui Zhang, Keyi Kong, Weiyi Wu, Chiyu Ma, Zhongyu Ouyang, Peijun Qing, Soroush Vosoughi, Jiang Gui	logic reasoning, audio-language models, reinforcement learning
MAC-Tuning: LLM Multi-Compositional Problem Reasoning with Enhanced Knowledge Boundary Awareness	Junsheng Huang, Zhitao He, Yuchen Huang, Sandeep Polisetty, Qingyun Wang, Yi R. Fung	large language models, multi-compositional reasoning, knowledge boundary awareness
Plan Dynamically, Express Rhetorically: A Debate-Driven Rhetorical Framework for Argumentative Writing	Xueguan Zhao, Wenpeng Lu, Chaoqun Zheng, Weiyu Zhang, Jiasheng Si, Deyu Zhou	argumentative writing, rhetorical framework, debate, natural language generation
CROP: Contextual Region-Oriented Visual Token Pruning	Jiawei Guo, Feifei Zhai, Pu Jian, qianrun Wei, Yu Zhou	visual token pruning, contextual pruning, model efficiency, vision transformers
Enhancing LLM Text Detection with Retrieved Contexts and Logits Distribution Consistency	Zhaoheng Huang, Yutao Zhu, Ji-Rong Wen, Zhicheng Dou	text detection, large language models, context retrieval, logits distribution
Improving Low-Resource Sequence Labeling with Knowledge Fusion and Contextual Label Explanations	Jixiao Zhang, Chunsheng Zuo	sequence labeling, low-resource, knowledge fusion, contextual explanations
Detoxifying Large Language Models via the Diversity of Toxic Samples	Wang Cai, Hsiu-Yuan Huang, Zhixiang Wang, Yunfang Wu	large language models, detoxification, toxic samples diversity
ECC: An Emotion-Cause Conversation Dataset for Empathy Response	Xinyu Zhang, Lingling Zhang, Yanrui Wu, Muye Huang, Wenjun Wu, Bo Li, Shaowei Wang, Basura Fernando, Jun Liu	emotion-cause analysis, conversation datasets, empathy response
DSG-MCTS: A Dynamic Strategy-Guided Monte Carlo Tree Search for Diversified Reasoning in Large Language Models	Rui Ha, Chaozhuo Li, Rui Pu, Litian Zhang, Xi Zhang, Sen Su	large language models, reasoning, monte carlo tree search, dynamic strategy
Knowledge Editing through Chain-of-Thought	Changyue Wang, Weihang Su, Qingyao Ai, Yichen Tang, Yiqun LIU	knowledge editing, chain-of-thought, reasoning
From Scores to Steps: Diagnosing and Improving LLM Performance in Evidence-Based Medical Calculations	Benlu Wang, Iris Xia, Yifan Zhang, Junda Wang, Feiyun Ouyang, Shuo Han, hong yu, Zonghai Yao	large language models, medical calculations, evidence-based reasoning
NileChat: Towards Linguistically Diverse and Culturally Aware LLMs for Local Communities	Abdellah EL MEKKI, Houdaifa Atou, OMER NACAR, Shady Shehata, Muhammad Abdul-Mageed	large language models, linguistic diversity, cultural awareness, local communities
Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	Jie Shi, Xi Cao, Bo Xu, Jiaqing Liang, Yanghua Xiao, Jia Chen, Peng Wang, Wei Wang	text-to-sql, dialect adaptation, framework
FinMTEB: Finance Massive Text Embedding Benchmark	Yixuan Tang, Yi Yang	finance, text embedding, benchmark
Scaling Rich Style-Prompted Text-to-Speech Datasets	Anuj Diwan, Zhisheng Zheng, David Harwath, Eunsol Choi	text-to-speech, datasets, style prompting, speech synthesis
OBLIVIATE: Robust and Practical Machine Unlearning for Large Language Models	Xiaoyu Xu, Minxin Du, Qingqing Ye, Haibo Hu	machine unlearning, large language models, robustness
Eliciting Implicit Acoustic Styles from Open-domain Instructions to Facilitate Fine-grained Controllable Generation of Speech	Jianxing Yu, Gou Zihao, Chen Li, Zhisheng Wang, Peiji Yang, Wenqing Chen, Jian Yin	speech generation, acoustic styles, controllable generation, open-domain instructions
Exploring Changes in Nation Perception with Nationality-Assigned Personas in LLMs	Mahammed Kamruzzaman, Gene Louis Kim	large language models, personas, nation perception
Non-Existent Relationship: Fact-Aware Multi-Level Machine-Generated Text Detection	Yang Wu, Ruijia Wang, Jie Wu	machine-generated text detection, fact-awareness, multi-level detection
Calibrating Verbal Uncertainty as a Linear Feature to Reduce Hallucinations	Ziwei Ji, Lei Yu, Yeskendir Koishekenov, Yejin Bang, Anthony Hartshorn, Alan Schelten, Cheng Zhang, Pascale Fung, Nicola Cancedda	uncertainty calibration, hallucination reduction, verbal uncertainty
JUREX-4E: Juridical Expert-Annotated Four-Element Knowledge Base for Legal Reasoning	Huanghai Liu, Quzhe Huang, Qingjing Chen, Yiran HU, Jiayu Ma, Yun Liu, Weixing Shen, Yansong Feng	legal reasoning, knowledge base, expert annotation
CIE: Controlling Language Model Text Generations Using Continuous Signals	Vinay Samuel, Harshita Diddee, Yiming Zhang, Daphne Ippolito	language model control, text generation, continuous signals
CoEvo: Coevolution of LLM and Retrieval Model for Domain-Specific Information Retrieval	Ang Li, Yiquan Wu, Yinghao Hu, Lizhi Qing, Shihang Wang, Chengyuan Liu, Tao Wu, Adam Jatowt, Ming Cai, Fei Wu, Kun Kuang	large language models, retrieval, domain-specific, information retrieval
Conan-Embedding-v2: Training an LLM from Scratch for Text Embeddings	Shiyu Li, Yang Tang, Ruijie Liu, Shi-Zhe Chen, Xi Chen	large language models, training, text embeddings
MUCAR: Benchmarking Multilingual Cross-Modal Ambiguity Resolution for Multimodal Large Language Models	Xiaolong Wang, Zhaolu Kang, Wangyuxuan Zhai, Xinyue Lou, Yunghwei Lai, Ziyue Wang, Yawen Wang, Kaiyu Huang, Yile Wang, Peng Li, Yang Liu	benchmarking, multilingual, cross-modal, ambiguity resolution, multimodal, large language models
Mind the Gap: How BabyLMs Learn Filler-Gap Dependencies	Chi-Yun Chang, Xueyang Huang, Humaira Nasir, Shane Storks, Olawale Akingbade, Huteng Dai	language models, syntactic dependencies, learning, babyLMs
Paths Not Taken: Understanding and Mending the Multilingual Factual Recall Pipeline	Meng Lu, Ruochen Zhang, Carsten Eickhoff, Ellie Pavlick	multilingual, factual recall, pipeline, language models
BTC-SAM: Leveraging LLMs for Generation of Bias Test Cases for Sentiment Analysis Models	Zsolt T. Kardkovács, LYNDA DJENNANE, Anna Field, Boualem Benatallah, Yacine GACI, Fabio Casati, Walid Gaaloul	large language models, bias, test case generation, sentiment analysis
Tracing L1 Interference in English Learner Writing: A Longitudinal Corpus with Error Annotations	Poorvi Acharya, J. Elizabeth Liebl, Dhiman Goswami, Kai North, Marcos Zampieri, Antonios Anastasopoulos	language learning, corpus, error annotation, longitudinal study
Who is in the Spotlight: The Hidden Bias Undermining Multimodal Retrieval-Augmented Generation	Jiayu Yao, Shenghua Liu, Yiwei Wang, Lingrui Mei, Baolong Bi, Yuyao Ge, Zhecheng Li, Xueqi Cheng	bias, multimodal, retrieval-augmented generation, large language models
DCIS: Efficient Length Extrapolation of LLMs via Divide-and-Conquer Scaling Factor Search	Lei Yang, Shaoyang Xu, Jianxiang Peng, shaolin Zhu, Deyi Xiong	large language models, length extrapolation, scaling methods, efficiency
Let’s Play Across Cultures: A Large Multilingual, Multicultural Benchmark for Assessing Language Models’ Understanding of Sports	Punit kumar singh, Nishant Kumar, Akash Ghosh, Kunal Pasad, Khushi Soni, Manisha Jaishwal, Sriparna Saha, Syukron Abu Ishaq Alfarozi, Asres Temam Abagissa, Kitsuchart Pasupa, Jose G Moreno, Haiqin Yang	multilingual, multicultural, benchmarking, language models, sports understanding
Multilingual Federated Low-Rank Adaptation for Collaborative Content Anomaly Detection across Multilingual Social Media Participants	Jiaxin Li, Geng Zhao	multilingual, federated learning, low-rank adaptation, anomaly detection, social media
The Hidden Strength of Disagreement: Unraveling the Consensus-Diversity Tradeoff in Adaptive Multi-Agent Systems	Zengqing Wu, Takayuki Ito	multi-agent systems, consensus, diversity, adaptive systems
M3Retrieve: Benchmarking Multimodal Retrieval for Medicine	Arkadeep Acharya, Akash Ghosh, Pradeepika Verma, Kitsuchart Pasupa, Sriparna Saha, Dr Priti Singh	benchmarking, multimodal retrieval, medicine, healthcare
KLAAD: Refining Attention Mechanisms to Reduce Societal Bias in Generative Language Models	Seorin Kim, Dongyoung Lee, Jaejin Lee	attention mechanisms, societal bias, generative language models, fairness
Friend or Foe? A Computational Investigation of Semantic False Friends across Romance Languages	Ana Sabina Uban, Liviu P Dinu, Ioan-Bogdan Iordache, Simona Georgescu, Claudia Vlad	semantic analysis, false friends, romance languages, computational linguistics
Minimal, Local, and Robust: Embedding-Only Edits for Implicit Bias in T2I Models	Feng He, Chao Zhang, Zhixue Zhao	embedding edits, implicit bias, text-to-image models, robustness
Journalism-Guided Agentic In-context Learning for News Stance Detection	Dahyun Lee, Jonghyeon Choi, Jiyoung Han, Kunwoo Park	in-context learning, news stance detection, journalism, language models
Less Is MuRE: Revisiting Shallow Knowledge Graph Embeddings	Victor Charpenay, Steven Schockaert	knowledge graph embeddings, shallow embeddings, representation learning
Pierce the Mists, Greet the Sky: Decipher Knowledge Overshadowing via Knowledge Circuit Analysis	Haoming Huang, Yibo Yan, Jiahao Huo, Xin Zou, Xinfeng Li, Kun Wang, Xuming Hu	knowledge overshadowing, knowledge analysis, knowledge circuits
KRETA: A Benchmark for Korean Reading and Reasoning in Text-Rich VQA Attuned to Diverse Visual Contexts	Taebaek Hwang, Minseo Kim, Gisang Lee, Seonuk Kim, Hyunjun Eun	benchmarking, korean language, reading comprehension, visual question answering, multimodal
Jailbreak LLMs through Internal Stance Manipulation	Shuangjie Fu, Du Su, Beining Huang, Fei Sun, Jingang Wang, Wei Chen, Huawei Shen, Xueqi Cheng	large language models, security, stance manipulation, jailbreak
VersaTune: An Efficient Data Composition Framework for Training Multi-Capability LLMs	Keer Lu, Keshi Zhao, Zhuoran Zhang, Zheng Liang, Bin CUI, Tengjiao Wang, Wentao Zhang	large language models, training, data composition, multi-capability
Keep Security! Benchmarking Security Policy Preservation in Large Language Model Contexts Against Indirect Attacks in Question Answering	Hwan Chang, Yumin Kim, Yonghyun Jun, Hwanhee Lee	large language models, security, benchmarking, question answering
GraDaSE: Graph-Based Dataset Search with Examples	Jing He, Mingyang Lv, Qing Shi, Gong Cheng	dataset search, graph-based methods, examples
Addressing Tokenization Inconsistency in Steganography and Watermarking Based on Large Language Models	Ruiyi Yan	large language models, tokenization, steganography, watermarking
LLM Bias Detection and Mitigation through the Lens of Desired Distributions	Ingroj Shrestha, Padmini Srinivasan	large language models, bias detection, bias mitigation
CoBia: Constructed Conversations Can Trigger Otherwise Concealed Societal Biases in LLMs	Nafiseh Nikeghbal, Amir Hossein Kargaran, Jana Diesner	large language models, societal biases, constructed conversations
ty Alignment Collapse in Multimodal Large Reasoning Model	Xinyue Lou, You Li, Jinan Xu, Xiangyu Shi, Chi Chen, Kaiyu Huang	multimodal, large reasoning models, alignment
Judge and Improve: Towards a Better Reasoning of Knowledge Graphs with Large Language Models	Mo Zhiqiang, yanghua, Jiahui Li, Yuan Liu, Shawn Wong, Jianmin Huang	knowledge graphs, reasoning, large language models
From Personas to Talks: Revisiting the Impact of Personas on LLM-Synthesized Emotional Support Conversations	Shenghan Wu, Yimo Zhu, Wynne Hsu, Mong-Li Lee, Yang Deng	personas, emotional support, large language models, conversations
Tree-of-Quote Prompting Improves Factuality and Attribution in Multi-Hop and Medical Reasoning	Justin Xu, Yiming Li, Zizheng Zhang, Augustine Yui Hei Luk, Mayank Jobanputra, Samarth Oza, David W Eyre	prompting, factuality, multi-hop reasoning, medical reasoning
Noise, Adaptation, and Strategy: Assessing LLM Fidelity in Decision-Making	Yuanjun Feng, Vivek Choudhary, Yash Raj Shrestha	large language models, decision-making, model fidelity, adaptation
Self-Adjust Softmax	Chuanyang Zheng, Yihang Gao, Guoxuan Chen, Han Shi, Jing Xiong, Xiaozhe Ren, Chao Huang, Zhenguo Li, Yu Li	softmax, model optimization, neural networks
MLWQ: Efficient Small Language Model Deployment via Multi-Level Weight Quantization	Chun Hu, Junhui He, Shangyu Wu, YuxinHe, Chun Jason Xue, Qingan Li	small language models, deployment, weight quantization, efficiency
ViClaim: A Multilingual Multilabel Dataset for Automatic Claim Detection in Videos	Patrick Giedemann, Pius von Däniken, Jan Milan Deriu, Alvaro Rodrigo, Anselmo Peñas, Mark Cieliebak	claim detection, videos, multilingual, multilabel classification, datasets
RoT: Enhancing Table Reasoning with Iterative Row-Wise Traversals	Xuanliang Zhang, Dingzirui Wang, Keyan Xu, Qingfu Zhu, Wanxiang Che	table reasoning, iterative methods, row-wise traversal
TACO: Enhancing Multimodal In-context Learning via Task Mapping-Guided Sequence Configuration	Yanshu Li, Jianjiang Yang, Tian Yun, Pinyuan Feng, Jinfa Huang, Ruixiang Tang	multimodal in-context learning, task mapping, sequence configuration
EMNLP: Educator-role Moral and Normative Large Language Models Profiling	Yilin Jiang, Mingzi Zhang, Sheng Jin, Zengyi Yu, Xiangjie Kong, Binghao Tu	large language models, moral profiling, normative analysis
CodeArena: Evaluating and Aligning CodeLLMs on Human Preference	Jian Yang, Jiaxi Yang, Wei Zhang, JinKe, Yibo Miao, Lei Zhang, Liqun Yang, Zeyu Cui, Yichang Zhang, Zhoujun Li, Binyuan Hui, Junyang Lin	code language models, evaluation, human preference, alignment
Pre-training CLIP against Data Poisoning with Optimal Transport-based Matching and Alignment	Tong Zhang, Kuofeng Gao, Jiawang Bai, Leo Yu Zhang, Xin Yin, Zonghui Wang, Shouling Ji, Wenzhi CHEN	pre-training, CLIP, data poisoning, optimal transport, model robustness
Castle: Causal Cascade Updates in Relational Databases with Large Language Models	Yongye Su, Yucheng Zhang, Zeru Shi, Bruno Ribeiro, Elisa Bertino	large language models, relational databases, causal inference, data management
AQuilt: Weaving Logic and Self-Inspection into Low-Cost, High-Relevance Data Synthesis for Specialist LLMs	Shuting Wang, Jiejun Tan, Zhicheng Dou, Ji-Rong Wen	data synthesis, logic, self-inspection, specialist large language models
Superficial Self-Improved Reasoners Benefit from Model Merging	Mengze Hong, Wailing Ng, Chen Jason Zhang, Yuanfeng SONG, Di Jiang	reasoning, model merging, self-improvement
SciRIFF: A Resource to Enhance Language Model Instruction-Following over Scientific Literature	Zhibo Man, Yuanmeng Chen, Yujie Zhang, Jinan Xu	instruction-following, scientific literature, language models
CIFLEX: Contextual Instruction Flow for Sub-task Execution in Multi-Turn Interactions with a Single On-Device LLM	Juntae Lee, Jihwan Bang, Seunghan Yang, Simyung Chang	large language models, multi-turn interactions, sub-task execution, on-device models
SelfRACG: Enabling LLMs to Self-Express and Retrieve for Code Generation	Qian Dong, Jia Chen, Qingyao Ai, Hongning Wang, Haitao Li, YIWU, Yao Hu, Yiqun LIU, Shaoping Ma	large language models, code generation, self-expression, retrieval
Bridging External and Parametric Knowledge: Mitigating Hallucination of LLMs with Shared-Private Semantic Synergy in Dual-Stream Knowledge	Yi Sui, Chaozhuo Li, Chen Zhang, Dawei Song, Qiuchi Li	large language models, knowledge integration, hallucination mitigation
A Computational Simulation of Language Production in First Language Acquisition	Yuan Gao	language production, first language acquisition, computational simulation
Parallel Continuous Chain-of-Thought with Jacobi Iteration	Haoyi Wu, Zhihao Teng, Kewei Tu	chain-of-thought, reasoning, iterative methods
IPIGuard: A Novel Tool Dependency Graph-Based Defense Against Indirect Prompt Injection in LLM Agents	Hengyu An, Jinghuai Zhang, Tianyu Du, Chunyi Zhou, Qingming Li, Tao Lin, Shouling Ji	security, prompt injection, large language models, defense
MCIP: Protecting MCP Safety via Model Contextual Integrity Protocol	Huihao JING, Haoran Li, Wenbin Hu, Qi Hu, Xu Heli, Tianshu Chu, Peizhao Hu, Yangqiu Song	model safety, contextual integrity, protocol
Words Like Knives: Backstory-Personalized Modeling and Detection of Violent Communication	Jocelyn J Shen, Akhila Yerukola, Xuhui Zhou, Cynthia Breazeal, Maarten Sap, Hae Won Park	personalized modeling, violent communication, detection
Data Drives Unstable Hierarchical Generalization in LMs	Tian Qin, Naomi Saphra, David Alvarez-Melis	hierarchical generalization, language models, data influence
ReEvalMed: Rethinking Medical Report Evaluation by Aligning Metrics with Real-World Clinical Judgment	Ruochen Li, Jun Li, Bailiang Jian, Kun yuan, Youxiang Zhu	medical report evaluation, clinical judgment, metrics alignment
FlightGPT: Towards Generalizable and Interpretable UAV Vision-and-Language Navigation with Vision-Language Models	Hengxing Cai, Jinhan Dong, Jingjun Tan, Jingcheng Deng, Sihang Li, Zhifeng Gao, Haidong Wang, Zicheng Su, Agachai Sumalee, Renxin ZHONG	vision-language models, navigation, UAV, interpretable models
Route Sparse Autoencoder to Interpret Large Language Models	Wei Shi, Sihang Li, Tao Liang, Mingyang Wan, Guojun Ma, Xiang Wang, Xiangnan He	large language models, interpretability, autoencoder
Confidence-guided Refinement Reasoning for Zero-shot Question Answering	Youwon Jang, Woo Suk Choi, Minjoon Jung, Minsu Lee, Byoung-Tak Zhang	zero-shot question answering, reasoning, confidence-guided refinement
CondenseLM: LLMs-driven Text Dataset Condensation via Reward Matching	Cheng Shen, Yew-Soon Ong, Joey Tianyi Zhou	large language models, dataset condensation, reward matching
Thinking Out Loud: Do Reasoning Models Know When They’re Right?	Qingcheng Zeng, Weihao Xuan, Leyang Cui, Rob Voigt	reasoning models, model confidence, evaluation
Persuasion Dynamics in LLMs: Investigating Robustness and Adaptability in Knowledge and Safety with DuET-PD	Bryan Chen Zhengyu Tan, Daniel Wai Kit Chin, Zhengyuan Liu, Nancy F. Chen, Roy Ka-Wei Lee	large language models, robustness, safety, persuasion dynamics
CiteBART: Learning to Generate Citations for Local Citation Recommendation	Ege Yiğit Çelik, Selma Tekir	citation generation, recommendation, transformers
R-TOFU: Unlearning in Large Reasoning Models	Sangyeon Yoon, Wonje Jeung, Albert No	unlearning, large reasoning models
QuZO: Quantized Zeroth-Order Fine-Tuning for Large Language Models	Jiajun Zhou, Yifan Yang, Kai Zhen, Ziyue Liu, Yequan Zhao, Ershad Banijamali, Athanasios Mouchtaris, Ngai Wong, Zheng Zhang	quantized fine-tuning, large language models
Select-Then-Decompose: From Empirical Analysis to Adaptive Selection Strategy for Task Decomposition in Large Language Models	Shuodi Liu, Yingzhuo Liu, Zi Wang, yusheng wang, Huijia Wu, Liuyu Xiang, Zhaofeng He	task decomposition, large language models, adaptive selection
UnitCoder: Scalable Code Synthesis from Pre-training Corpora	Yichuan Ma, Yunfan Shao, Peiji Li, Demin Song, Qipeng Guo, Linyang Li, Xipeng Qiu, Kai Chen	code synthesis, pre-training, scalability
An Empirical Study of LLM Reasoning Ability Under Strict Output Length Constraint	Yi Sun, Han Wang, Jiaqiang Li, Jiacheng Liu, Xiangyu Li, Hao Wen, Huiwen Zheng, Yan Liang, Yuanchun Li, Yunxin Liu	large language models, reasoning, output length constraint, empirical study
Can LLMs Explain Themselves Counterfactually?	Zahra Dehghanighobadi, Asja Fischer, Muhammad Bilal Zafar	large language models, explainability, counterfactual reasoning
PoSum-Bench: Benchmarking Position Bias in LLM-based Conversational Summarization	XU SUN, Lionel Delphin-Poulat, Christèle Tarnec, Anastasia Shimorina	position bias, conversational summarization, large language models, benchmarking
Can Large Language Models Unlock Novel Scientific Research Ideas?	Sandeep Kumar, Tirthankar Ghosal, Vinayak Goyal, Asif Ekbal	large language models, scientific research, idea generation
MPRF: Interpretable Stance Detection through Multi-Path Reasoning Framework	ZhaoDan Zhang, Jin Zhang, Hui Xu, Jiafeng Guo, Xueqi Cheng	stance detection, interpretable models, multi-path reasoning
PAFT: Prompt-Agnostic Fine-Tuning	Chenxing Wei, Yao Shu, Mingwen Ou, Ying Tiffany He, Fei Yu	fine-tuning, prompt-agnostic methods
TracSum: A New Benchmark for Aspect-Based Summarization with Sentence-Level Traceability in Medical Domain	Bohao Chu, Meijie Li, Sameh Frihat, Chengyu Gu, Georg Lodde, Eli	aspect-based summarization, medical domain, sentence-level traceability, benchmarks
Can Large Language Models Win the International Mathematical Games?	Alessio Cocchieri, Luca Ragazzi, Giuseppe Tagliavini, Lorenzo Tordi, Antonella Carbonaro, Gianluca Moro	large language models, mathematical reasoning, games, evaluation
ICR: Iterative Clarification and Rewriting for Conversational Search	Zhiyu Cao, Peifeng Li, Qiaoming Zhu	conversational search, clarification, rewriting, information retrieval
RTQA : Recursive Thinking for Complex Temporal Knowledge Graph Question Answering with Large Language Models	Zhaoyan Gong, Juan Li, Zhiqiang Liu, Lei Liang, Huajun Chen, Wen Zhang	knowledge graph question answering, temporal reasoning, recursive thinking, large language models
AgentPro: Enhancing LLM Agents with Automated Process Supervision	Yuchen Deng, Shichen Fan, Naibo Wang, Xinkui Zhao, See-Kiong Ng	large language model agents, process supervision, automation
Merger-as-a-Stealer: Stealing Targeted PII from Aligned LLMs with Model Merging	Junxi Wu, Jinpeng Wang, Zheng Liu, Bin Chen, Dongjian Hu, Hao Wu, Shu-Tao Xia	privacy, personal information extraction, model merging, large language models
CARFT: Boosting LLM Reasoning via Contrastive Learning with Annotated Chain-of-Thought-based Reinforced Fine-Tuning	Xiangchi Yuan, Chunhui Zhang, Zheyuan Liu, Dachuan Shi, Leyan Pan, Soroush Vosoughi, Wenke Lee	contrastive learning, chain-of-thought, reasoning, large language models
SATER: A Self-Aware and Token-Efficient Approach to Routing and Cascading	Yuanzhe Shen, Yide Liu, Zisu Huang, Ruicheng Yin, Xiaoqing Zheng, Xuanjing Huang	large language models, efficiency, routing, cascading
Are Checklists Really Useful for Automatic Evaluation of Generative Tasks?	Momoka Furuhashi, Kouta Nakayama, Takashi Kodama, Saku Sugawara	automatic evaluation, generative tasks, checklists
Static or Dynamic: Towards Query-Adaptive Token Selection for Video Question Answering	Yumeng Shi, Quanyu Long, Wenya Wang	video question answering, token selection, adaptive methods
Deep Associations, High Creativity: A Simple yet Effective Metric for Evaluating Large Language Models	Ziliang Qiu, Renfen Hu	large language models, evaluation metrics, creativity
Long-Form Information Alignment Evaluation Beyond Atomic Facts	Danna Zheng, Mirella Lapata, Jeff Z. Pan	information alignment, long-form evaluation, factuality
EQA-RM: A Generative Embodied Reward Model with Test-time Scaling	Yuhang Chen, Zhen Tan, Tianlong Chen	embodied AI, reward models, generative models
Weight-Aware Activation Sparsity with Constrained Bayesian Optimization Scheduling for Large Language Models	Ming Wang, Miao Zhang, Xuebo Liu, Liqiang Nie	large language models, activation sparsity, bayesian optimization
Skeletons Matter: Dynamic Data Augmentation for Text-to-Query	Yuchen Ji, Bo Xu, Jie Shi, Jiaqing Liang, Deqing Yang, Yu Mao, Hai Chen, Yanghua Xiao	data augmentation, text-to-query, dynamic methods
Separate the Wheat from the Chaff: Winnowing Down Divergent Views in Retrieval Augmented Generation	Song Wang, Zihan Chen, Peng Wang, Zhepei Wei, Zhen Tan, Yu Meng, Cong Shen, Jundong Li	retrieval augmented generation, divergent views, information filtering
Agentic-R1: Distilled Dual-Strategy Reasoning	Weihua Du, Pranjal Aggarwal, Sean Welleck, Yiming Yang	reasoning, dual-strategy, distillation
Multimodal Language Models See Better When They Look Shallower	Haoran Chen, Junyan Lin, Xinghao Chen, Yue Fan, Jianfeng Dong, Xin Jin, Hui Su, Jinlan Fu, Xiaoyu Shen	multimodal language models, model architecture, vision-language
BTS: Harmonizing Specialized Experts into a Generalist LLM	Qizhen Zhang, Prajjwal Bhargava, Chloe Bi, Chris X. Cai, Jakob Nicolaus Foerster, Jeremy Fu, Punit Singh Koura, Ruan Silva, Sheng Shen, Emily Dinan, Suchin Gururangan, Mike Lewis	large language models, expert systems, generalist models
CTCC: A Robust and Stealthy Fingerprinting Framework for Large Language Models via Cross-Turn Contextual Correlation Backdoor	Zhenhua Xu, Xixiang Zhao, Xubin Yue, shengwei tian, Changting Lin, Meng Han	large language models, fingerprinting, security, backdoor attacks
Think Wider, Detect Sharper: Reinforced Reference Coverage for Document-Level Self-Contradiction Detection	Yuhao Chen, Yuanjie Lyu, Shuochen Liu, Chao Zhang, Junhui Lv, Tong Xu	document-level, self-contradiction detection, reinforcement learning
Enhancing Efficiency and Exploration in Reinforcement Learning for LLMs	Mengqi Liao, Xiangyu Xi, Chen Ruinian, Jia Leng, Yangen Hu, Ke Zeng, Shuai Liu, Huaiyu Wan	reinforcement learning, efficiency, large language models
Large Language Models for Automated Literature Review: An Evaluation of Reference Generation, Abstract Writing, and Review Composition	Xuemei Tang, Xufeng Duan, Zhenguang Cai	large language models, literature review, reference generation, abstract writing
Interpretability Analysis of Arithmetic In-Context Learning in Large Language Models	Gregory Polya	large language models, interpretability, in-context learning, arithmetic
SenDetEX: Sentence-Level AI-Generated Text Detection for Human-AI Hybrid Content via Style and Context Fusion	Lei Jiang, Desheng Wu, Xiaolong Zheng	ai-generated text detection, sentence-level, style fusion, context fusion
Add-One-In: Incremental Sample Selection for Large Language Models via a Choice-Based Greedy Paradigm	Zhuo Li, Yuhao Du, Xiaoqi Jiao, Steven Y. Guo, yuege feng, Xiang Wan, Anningzhe Gao, Jinpeng Hu	sample selection, large language models, incremental learning
APLOT: Robust Reward Modeling via Adaptive Preference Learning with Optimal Transport	Zhuo Li, yuege feng, Dandan Guo, Jinpeng Hu, Anningzhe Gao, Xiang Wan	reward modeling, preference learning, optimal transport
AesBiasBench: Evaluating Bias and Alignment in Multimodal Language Models for Personalized Image Aesthetic Assessment	Kun Li, Lai Man Po, Hongzheng Yang, XUYUAN XU, Kangcheng Liu, Yuzhi Zhao	bias evaluation, multimodal language models, image aesthetics, fairness, alignment
EcoTune: Token-Efficient Multi-Fidelity Hyperparameter Optimization for Large Language Model Inference	Yuebin XU, Zeyi Wen	hyperparameter optimization, large language models, inference efficiency, token efficiency
Same evaluation, more tokens: On the effect of input length for machine translation evaluation using Large Language Models	Tobias Domhan, Dawei Zhu	machine translation, evaluation, input length, large language models
Case-Based Decision-Theoretic Decoding with Quality Memories	Hiroyuki Deguchi, Masaaki Nagata	decision-theoretic decoding, case-based reasoning, memory
DeepResearcher: Scaling Deep Research via Reinforcement Learning in Real-world Environments	Yuxiang Zheng, Dayuan Fu, Xiangkun Hu, Xiaojie Cai, Lyumanshan Ye, Pengrui Lu, Pengfei Liu	reinforcement learning, deep research, real-world environments, scaling
T-MAD: Target-driven Multimodal Alignment for Stance Detection	ZhaoDan Zhang, Jin Zhang, Xueqi Cheng, Hui Xu	stance detection, multimodal alignment, target-driven methods
SportReason: Evaluating Retrieval-Augmented Reasoning across Tables and Text for Sports Question Answering	Kaiyue Feng, Siyue Zhang, Bingsen Chen, Yilun Zhao, Chen Zhao	retrieval-augmented reasoning, sports question answering, tables, text
Disambiguation in Conversational Question Answering in the Era of LLMs and Agents: A Survey	Mehrab Tanjim, Yeonjun In, Xiang Chen, Victor Bursztyn, Ryan A. Rossi, Sungchul Kim, Guang-Jie Ren, Vaishnavi Muppala, Shun Jiang, Yongsung Kim, Chanyoung Park	conversational question answering, large language models, agents, disambiguation, survey
UniversalCEFR: Enabling Open Multilingual Research on Language Proficiency Assessment	Joseph Marvin Imperial, Abdullah Barayan, Regina Stodden, Rodrigo Wilkens, Ricardo Muñoz Sánchez, GAO Lingyun, Melissa Torgbi, Dawn Knight, Gail Forey, Reka R. Jablonkai, Ekaterina Kochmar, Robert Joshua Reynolds, Eugénio Ribeiro, Horacio Saggion, Elena Volodina, Sowmya Vajjala, Thomas François, Fernando Alva-Manchego, Harish Tayyar Madabushi	language proficiency assessment, multilingual, language evaluation, CEFR
CAT: Causal Attention Tuning For Injecting Fine-grained Causal Knowledge into Large Language Models	Kairong Han, Wenshuo Zhao, Ziyu Zhao, Ye Jun Jian, Lujia Pan, Kun Kuang	causal attention, causal knowledge, large language models, model tuning
Rethinking Cross-Subject Data Splitting for Brain-to-Text Decoding	Peichao Lai, Jiaxin Gan, Feiyang Ye, Wentao Zhang, Fangcheng Fu, Yilei Wang, Bin CUI	brain-to-text decoding, data splitting, cross-subject analysis
Pragmatic Inference Chain (PIC) Improving LLMs’ Reasoning of Authentic Implicit Toxic Language	Lin Lu, Zhigang Zuo, Ziji Sheng, Pan Zhou	reasoning, implicit toxic language, large language models
QualBench: Benchmarking Chinese LLMs with Localized Professional Qualifications for Vertical Domain Evaluation	Wenqiao Zhu, Ji Liu, Rongjunchen Zhang, Haipang WU, Yulun Zhang	benchmarking, Chinese large language models, professional qualifications, domain evaluation
SATBench: Benchmarking LLMs’ Logical Reasoning via Automated Puzzle Generation from SAT Formulas	Anjiang Wei, Yuheng Wu, Yingjia Wan, Tarun Suresh, Huanmi Tan, Zhanke Zhou, Sanmi Koyejo, Ke Wang, Alex Aiken	benchmark, logical reasoning, large language models, SAT formulas
IG-Pruning: Input-Guided Block Pruning for Large Language Models	Kangyu Qiao, Shaolei Zhang, Yang Feng	large language models, model pruning, efficiency
Demystifying Synthetic Data in LLM Pre-training: A Systematic Study of Scaling Laws, Benefits, and Pitfalls	Feiyang Kang, Newsha Ardalani, Michael Kuchnik, Youssef Emad, Mostafa Elhoushi, Shubhabrata Sengupta, Shang-Wen Li, Ramya Raghavendra, Ruoxi Jia, Carole-Jean Wu	large language models, synthetic data, pretraining, scaling laws
LLMs cannot spot math errors, even when allowed to peek into the solution	KV Aditya Srivatsa, Kaushal Kumar Maurya, Ekaterina Kochmar	large language models, math error detection, reasoning
Context Reasoner: Incentivizing Reasoning Capability for Contextualized Privacy and Safety Compliance via Reinforcement Learning	Wenbin Hu, Haoran Li, Huihao JING, Qi Hu, Ziqian Zeng, Sirui Han, Xu Heli, Tianshu Chu, Peizhao Hu, Yangqiu Song	reasoning, privacy compliance, safety, reinforcement learning
Uncovering the Bigger Picture: Comprehensive Event Understanding Via Diverse News Retrieval	Yixuan Tang, Yuanyuan Shi, Yiqun Sun, Anthony Kum Hoe Tung	event understanding, news retrieval, comprehensive analysis
LoSiA: Efficient High-Rank Fine-Tuning via Subnet Localization and Optimization	Xujia Wang, Yunjia Qi, Bin Xu	fine-tuning, model optimization, subnet localization
CoCoA: Confidence- and Context-Aware Adaptive Decoding for Resolving Knowledge Conflicts in Large Language Models	Anant Khandelwal, Manish Gupta, Puneet Agrawal	large language models, decoding, knowledge conflicts, confidence, context awareness
DICE: Structured Reasoning in LLMs through SLM-Guided Chain-of-Thought Correction	Yiqi Li, Yusheng Liao, Zhe Chen, Yanfeng Wang, Yu Wang	large language models, structured reasoning, chain-of-thought
MovieCORE: COgnitive REasoning in Movies	Gueter Josmy Faure, Min-Hung Chen, Jia-Fong Yeh, Ying Cheng, Hung-Ting Su, Shang-Hong Lai, Winston H. Hsu	cognitive reasoning, movies, multimodal
Seeing is Believing, but How Much? A Comprehensive Analysis of Verbalized Calibration in Vision-Language Models	Weihao Xuan, Qingcheng Zeng, Heli Qi, Junjue Wang, Naoto Yokoya	vision-language models, calibration, evaluation
POINTS-Reader: Distillation-Free Adaptation of Vision-Language Models for Document Conversion	Yuan Liu, Zhongyin Zhao, Le Tian, Haicheng Wang, Xubing Ye, Yangxiu You, Zilin Yu, Chuhan Wu, Zhou Xiao, Yang Yu, Jie Zhou	vision-language models, model adaptation, document conversion
Culture Cartography: Mapping the Landscape of Cultural Knowledge	Caleb Ziems, William Barr Held, Jane Yu, Amir Goldberg, David Grusky, Diyi Yang	cultural knowledge, knowledge mapping, NLP
Chat-Driven Text Generation and Interaction for Person Retrieval	Zequn Xie, Chuxin Wang, Yeqiang Wang, Sihang Cai, Shulei Wang, Tao Jin	text generation, interaction, person retrieval
Cost-Optimal Grouped-Query Attention for Long-Context Modeling	Yingfa Chen, Yutong Wu, Chenyang Song, Zhen Leng Thai, Xingyu Shen, Xu Han, Zhiyuan Liu, Maosong Sun	attention mechanisms, long-context modeling
TombRaider: Entering the Vault of History to Jailbreak Large Language Models	Junchen Ding, Jiahao Zhang, Yi Liu, Ziqi Ding, Gelei Deng, Yuekang Li	jailbreaking, large language models, security
EMO: Embedding Model Distillation via Intra-Model Relation and Optimal Transport Alignments	Minh Phuc Truong, Hai An Vu, Tu Vu, Nguyen Thi Ngoc Diep, Linh Ngo Van, Thien Huu Nguyen, Trung Le	embedding distillation, model alignment, optimal transport, representation learning
PricingLogic: Evaluating LLMs Reasoning on Complex Tourism Pricing Tasks	Yunuo Liu, Dawei Zhu, Zena Al Khalili, Dai Cheng, Yanjun Chen, Dietrich Klakow, Wei Zhang, Xiaoyu Shen	large language models, reasoning, tourism pricing, complex tasks
PAKTON: A Multi-Agent Framework for Question Answering in Long Legal Agreements	Raptopoulos Petros, Giorgos Filandrianos, Maria Lymperaiou, Giorgos Stamou	multi-agent systems, question answering, legal domain, long documents
Mixture of Length and Pruning Experts for Knowledge Graphs Reasoning	Enjun Du, Siyi Liu, Yongqi Zhang	knowledge graphs, reasoning, mixture of experts, pruning
Emotion Transfer with Enhanced Prototype for Unseen Emotion Recognition in Conversation	Kun Peng, Cong Cao, Hao Peng, Guanlin Wu, Zhifeng Hao, Lei Jiang, Yanbing Liu, Philip S. Yu	emotion transfer, emotion recognition, conversation, prototypes
Training a Utility-based Retriever Through Shared Context Attribution for Retrieval-Augmented Language Models	Yilong Xu, Jinhua Gao, Xiaoming Yu, Yuanhai Xue, Baolong Bi, Huawei Shen, Xueqi Cheng	retrieval-augmented language models, utility-based retriever, shared context attribution
Bitune: Leveraging Bidirectional Attention to Improve Decoder-Only LLMs	Dawid Jan Kopiczko, Tijmen Blankevoort, Yuki M Asano	large language models, attention, decoder-only models, model improvement
Language models can learn implicit multi-hop reasoning, but only if they have lots of training data	Yuekun Yao, Yupei Du, Dawei Zhu, Michael Hahn, Alexander Koller	language models, multi-hop reasoning, training data, implicit learning
Similarity = Value? Consultation Value-Assessment and Alignment for Personalized Search	Weicong Qin, Yi Xu, Weijie Yu, Teng Shi, Chenglei Shen, Ming He, Jianping Fan, Xiao Zhang, Jun Xu	personalized search, value assessment, alignment, information retrieval
PORTS: Preference-Optimized Retrievers for Tool Selection with Large Language Models	Lorenzo Molfetta, Giacomo Frisoni, Nicolò Monaldini, Gianluca Moro	preference-optimized retrievers, tool selection, large language models
MoSEs: Uncertainty-Aware AI-Generated Text Detection via Mixture of Stylistics Experts with Conditional Thresholds	Xiaopeng Ke, Hexuan Deng, Xuebo Liu, Jun Rao, Zhenxi Song, Jun Yu, Min Zhang	AI-generated text detection, uncertainty, stylistic analysis
Diagram-Driven Course Questions Generation	Naen Xu, Jinghuai Zhang, Changjiang Li, Zhi Chen, Chunyi Zhou, Qingming Li, Tianyu Du, Shouling Ji	question generation, diagrams, educational technology
Calibrating LLM Confidence by Probing Perturbed Representation Stability	Reza Khanmohammadi, Erfan Miahi, Mehrsa Mardikoraem, Simerjot Kaur, Ivan Brugere, Charese Smiley, Kundan S Thind, Mohammad M. Ghassemi	large language models, confidence calibration, representation stability
Measuring the Effect of Disfluency in Multilingual Knowledge Probing Benchmarks	Kirill Semenov, Rico Sennrich	multilingual, knowledge probing, disfluency, evaluation
Can Vision-Language Models Solve Visual Math Equations?	Monjoy Narayan Choudhury, Junling Wang, Yifan Hou, Mrinmaya Sachan	vision-language models, visual math, multimodal reasoning
NeuroAda: Activating Each Neuron’s Potential for Parameter-Efficient Fine-Tuning	Zhi Zhang, Yixian Shen, Congfeng Cao, Ekaterina Shutova	parameter-efficient fine-tuning, neural networks, large language models
Towards General-Domain Word Sense Disambiguation: Distilling Large Language Model into Compact Disambiguator	Liqiang Ming, Sheng-hua Zhong, Yuncong Li	word sense disambiguation, model distillation, large language models
ProtoVQA: An Adaptable Prototypical Framework for Explainable Fine-Grained Visual Question Answering	Xingjian Diao, Weiyi Wu, Keyi Kong, Peijun Qing, Xinwen Xu, Ming Cheng, Soroush Vosoughi, Jiang Gui	visual question answering, explainability, prototypical networks
The LLM Already Knows: Estimating LLM-Perceived Question Difficulty via Hidden Representations	Yubo Zhu, Dongrui Liu, Zecheng Lin, Wei Tong, Sheng Zhong, Jing Shao	large language models, question difficulty estimation, hidden representations
CEMTM: Contextual Embedding-based Multimodal Topic Modeling	Amirhossein Abaskohi, Raymond Li, Chuyuan Li, Shafiq Joty, Giuseppe Carenini	multimodal topic modeling, contextual embeddings
D-CoDe: Scaling Image-Pretrained VLMs to Video via Dynamic Compression and Question Decomposition	Yiyang Huang, Yizhou Wang, Yun Fu	vision-language models, video, dynamic compression, question decomposition
Finding your MUSE: Mining Unexpected Solutions Engine	Nir Sweed, Hanit Hakim, Ben W	mining, solution discovery, unexpected solutions
Invisible Entropy: Towards Safe and Efficient Low-Entropy LLM Watermarking	Tianle Gu, Zongqi Wang, Kexin Huang, Yuanqi Yao, Xiangliang Zhang, Yujiu Yang, Xiuying Chen	large language models, watermarking, security, efficiency
R-Bind: Unified Enhancement of Attribute and Relation Binding in Text-to-Image Diffusion Models	Huixuan Zhang, Xiaojun Wan	text-to-image, diffusion models, attribute binding, relation binding
Realistic Training Data Generation and Rule Enhanced Decoding in LLM for NameGuess	Yikuan Xia, Jiazun Chen, Sujian Li, Jun Gao	large language models, training data generation, decoding, rule enhancement
DRISHTIKON: A Multimodal Multilingual Benchmark for Testing Language Models’ Understanding on Indian Culture	Arijit Maji, Raghvendra Kumar, Akash Ghosh, Anushka, Nemil Shah, Abhilekh Borah, Vanshika Shah, Nishant Mishra, Sriparna Saha	multimodal, multilingual, benchmarks, cultural knowledge, language models
MEBench: Benchmarking Large Language Models for Cross-Document Multi-Entity Question Answering	Teng LIN	benchmarking, large language models, question answering, cross-document
From Schema to State: Zero-Shot Scheme-Only Dialogue State Tracking via Diverse Synthetic Dialogue and Step-by-Step Distillation	Huan Xu, Zequn Li, Wen Tang, Jian Jun Zhang	dialogue state tracking, zero-shot learning, synthetic dialogue, distillation
Understanding the Modality Gap: An Empirical Study on the Speech-Text Alignment Mechanism of Large Speech Language Models	Bajian Xiang, Shuaijiang Zhao, Tingwei Guo, Wei zou	speech, text alignment, large language models, empirical study
Search-o1: Agentic Search-Enhanced Large Reasoning Models	Xiaoxi Li, Guanting Dong, Jiajie Jin, Yuyao Zhang, Yujia Zhou, Yutao Zhu, Zhicheng Dou	search, large reasoning models, agentic models
TRUST-VL: An Explainable News Assistant for General Multimodal Misinformation Detection	Zehong Yan, Peng Qi, Wynne Hsu, Mong-Li Lee	explainability, news assistant, multimodal misinformation detection
Enrich-on-Graph: Query-Graph Alignment for Complex Reasoning with LLM Enriching	Songze Li, Zhiqiang Liu, Zhengke Gui, Huajun Chen, Wen Zhang	query-graph alignment, complex reasoning, large language models
Investigating Value-Reasoning Reliability in Small Large Language Models	杜霞, Shuhan Sun, Pengyuan Liu, Dong Yu	small large language models, value reasoning, reliability
Cross-domain Rumor Detection via Test-Time Adaptation and Large Language Models	Yuxia Gong, Shuguo Hu, Huaiwen Zhang	rumor detection, cross-domain, test-time adaptation, large language models
AIR: Complex Instruction Generation via Automatic Iterative Refinement	Zeju Qiu, Weiyang Liu, Adrian Weller, Bernhard Schölkopf	instruction generation, iterative refinement, natural language generation
J$I^2$S: Joint Influence‑Aware Instruction Data Selection for Efficient Fine‑Tuning	Jingyu Wei, Bo Liu, Tianjiao Wan, Baoyun Peng, Xingkong Ma, Mengmeng Guo	instruction data selection, fine-tuning, efficiency, influence-aware
Theorem-Validated Reverse Chain-of-Thought Problem Generation for Geometric Reasoning	Deng Linger, Linghao Zhu, Yuliang Liu, Yu Wang, Qunyi Xie, Jingjing Wu, Gang Zhang, Yingying Zhu, Xiang Bai	chain-of-thought, problem generation, geometric reasoning
TCPO: Thought-Centric Preference Optimization for Effective Embodied Decision-making	Kechen Jiao, Zhirui Fang, Jiahao Liu, Bei Li, Qifan Wang, Xinyu Liu, Junhao Ruan, Zhongjian Qiao, Yifan Zhu, Yaxin Xu, Jingang Wang, Xiu Li	preference optimization, embodied decision-making, reinforcement learning, thought-centric methods
CR4-NarrEmote: An Open Vocabulary Dataset of Narrative Emotions Derived Using Citizen Science	Andrew Piper, Robert Budac	emotion recognition, narrative emotions, datasets, citizen science
AI Knows Where You Are: Exposure, Bias, and Inference in Multimodal Geolocation with KoreaGEO	Xiaonan Wang, Bo Shao, Hansaem Kim	multimodal geolocation, bias, exposure, inference, multimodal models
Not What the Doctor Ordered: Surveying LLM-based De-identification and Quantifying Clinical Information Loss	Jing Yu, Yibo Zhao, Jiapeng Zhu, Wenming Shao, Bo Pang, Zhao Zhang, Xiang Li	de-identification, clinical information, large language models, privacy
OmniEval: An Omnidirectional and Automatic RAG Evaluation Benchmark in Financial Domain	Hui Li, Ante Wang, Kunquan Li, Zhihao Wang, Liang Zhang, Delai Qiu, Qingsong Liu, Jinsong Su	evaluation benchmark, retrieval-augmented generation, financial domain
LLM-Driven Implicit Target Augmentation and Fine-Grained Contextual Modeling for Zero-Shot and Few-Shot Stance Detection	Ying Zhao, Yuanzhao Guo, XuemengWeng, Yuan Tian, Wei Wang, Yi Chang	stance detection, zero-shot learning, few-shot learning, contextual modeling, large language models
JOLT-SQL: Joint Loss Tuning of Text-to-SQL with Confusion-aware Noisy Schema Sampling	Zijian Wang, Chang Xu	text-to-SQL, loss tuning, schema sampling
Viability of Machine Translation for Healthcare in Low-Resourced Languages	Hellina Hailu Nigatu, Nikita Mehandru, Negasi Haile Abadi, Blen Gebremeskel, Ahmed Alaa, Monojit Choudhury	machine translation, healthcare, low-resourced languages
Probing Logical Reasoning of MLLMs in Scientific Diagrams	Yufei Wang, Adriana Kovashka	multimodal large language models, logical reasoning, scientific diagrams
Feature Extraction and Steering for Enhanced Chain-of-Thought Reasoning in Language Models	Zihao Li, Xu Wang, Yuzhe YANG, Ziyu Yao, Haoyi Xiong, Mengnan Du	chain-of-thought, feature extraction, reasoning, language models
Recursive Training Loops in LLMs: How training data properties modulate distribution shift in generated data?	Matteo Bortoletto, Constantin Ruhdorfer, Andreas Bulling	training loops, large language models, distribution shift, data properties
LinkAlign: Scalable Schema Linking for Real-World Large-Scale Multi-Database Text-to-SQL	Yihan Wang, Peiyu Liu, Xin Yang	text-to-SQL, schema linking, multi-database
VC4VG: Optimizing Video Captions for Text-to-Video Generation	Yang Du, Zhuoran Lin, Kaiqiang Song, Biao Wang, Zhicheng Zheng, Tiezheng Ge, Bo Zheng, Qin Jin	text-to-video generation, video captioning, optimization
Meta-Rewarding Language Models: Self-Improving Alignment with LLM-as-a-Meta-Judge	Tianhao Wu, Weizhe Yuan, Olga Golovneva, Jing Xu, Yuandong Tian, Jiantao Jiao, Jason E Weston, Sainbayar Sukhbaatar	large language models, alignment, self-improving
RedHerring Attack: Testing the Reliability of Attack Detection	Jonathan Rusert	attack detection, reliability testing
Beyond Checkmate: Exploring the Creative Choke Points for AI Generated Texts	Nafis Irtiza Tripto, Saranya Venkatraman, Mahjabin Nahar, Dongwon Lee	ai generated texts, creativity, choke points
Multilinguality Does not Make Sense: Investigating Factors Behind Zero-Shot Cross-Lingual Transfer in Sense-Aware Tasks	Roksana Goworek, Haim Dubossarsky	cross-lingual transfer, zero-shot learning, sense disambiguation, multilinguality
Statistical and Neural Methods for Hawaiian Orthography Modernization	Jaden Kapali, Keaton Williamson, Winston Wu	orthography modernization, statistical methods, neural methods, hawaiian language
Alignment-Augmented Speculative Decoding with Alignment Sampling and Conditional Verification	Jikai Wang, Zhenxu Tian, Juntao Li, Qingrong Xia, Xinyu Duan, Zhefeng Wang, Baoxing Huai, Min Zhang	large language models, decoding, alignment, verification
Why and How LLMs Benefit from Knowledge Introspection in Commonsense Reasoning	Chengfeng Zhao, Shizhu He, Shanshan Jiang, Bin Dong, Jun Zhao, Kang Liu	large language models, knowledge introspection, commonsense reasoning
Arena-lite: Efficient and Reliable Large Language Model Evaluation via Tournament-Based Direct Comparisons	Seonil Son, Ju-Min Oh, Heegon Jin, Cheolhun Jang, JEONGBEOM JEONG, KunTae Kim	large language models, evaluation, efficiency, tournament-based
VisualWebInstruct: Scaling up Multimodal Instruction Data through Web Search	Yiming Jia, Jiachen Li, Xiang Yue, Bo Li, Ping Nie, Kai Zou, Wenhu Chen	multimodal, instruction data, web search, data scaling
NL-Debugging: Exploiting Natural Language as an Intermediate Representation for Code Debugging	Weiming Zhang, Qingyao Li, Xinyi Dai, Jizheng Chen, Kounianhua Du, Weinan Zhang, Weiwen Liu, Yasheng Wang, Ruiming Tang, Yong Yu	code debugging, natural language, intermediate representation
Beyond Input Activations: Identifying Influential Latents by Gradient Sparse Autoencoders	Dong Shu, Xuansheng Wu, Haiyan Zhao, Mengnan Du, Ninghao Liu	autoencoders, latent variables, model interpretability
AssoCiAm: A Benchmark for Evaluating Association Thinking while Circumventing Ambiguity	Yifan Liu, Wenkuan Zhao, Shanshan Zhong, Jinghui Qin, Mingfu Liang, Zhongzhan Huang, Wushao Wen	benchmark, association thinking, evaluation, ambiguity
CLIP-MoE: Towards Building Mixture of Experts for CLIP with Diversified Multiplet Upcycling	Jihai Zhang, Xiaoye Qu, Tong Zhu, Yu Cheng	mixture of experts, CLIP, model efficiency
SEPS: A Separability Measure for Robust Unlearning in LLMs	Wonje Jeung, Sangyeon Yoon, Albert No	separability measure, unlearning, large language models
DA-Pred: Performance Prediction for Text Summarization under Domain-Shift and Instruct-Tuning	Anum Afzal, Florian Matthes, Alexander Fabbri	performance prediction, text summarization, domain shift, instruct tuning
UNCERTAINTY-LINE: Length-Invariant Estimation of Uncertainty for Large Language Models	Roman Vashurin, Maiya Goloburda, Preslav Nakov, Maxim Panov	uncertainty estimation, large language models, length-invariant methods
ConCISE: Confidence-guided Compression in Step-by-step Efficient Reasoning	Ziqing Qiao, Yongheng Deng, Jiali Zeng, Dong Wang, Lai Wei, Guanbo Wang, Fandong Meng, Jie Zhou, Ju Ren, Yaoxue Zhang	confidence-guided compression, efficient reasoning, step-by-step reasoning
MixLoRA-DSI: Dynamically Expandable Mixture-of-LoRA Experts for Rehearsal-Free Generative Retrieval over Dynamic Corpora	Tuan-Luc Huynh, Thuy-Trang Vu, Weiqing Wang, Trung Le, Dragan Gasevic, Yuan-Fang Li, Thanh-Toan Do	generative retrieval, mixture of experts, dynamic corpora, efficient retrieval
Analyzing the Effects of Supervised Fine-Tuning on Model Knowledge from Token and Parameter Levels	Junjie Ye, Yuming Yang, Yang Nan, Shuo Li, Qi Zhang, Tao Gui, Xuanjing Huang, Peng Wang, Zhongchao Shi, Jianping Fan	supervised fine-tuning, model knowledge, token level, parameter level, analysis
PBI-Attack: Prior-Guided Bimodal Interactive Black-Box Jailbreak Attack for Toxicity Maximization	Ruoxi Cheng, Yizhong Ding, Shuirong Cao, Ranjie Duan, Xiaoshuang Jia, Shaowei Yuan, Simeng Qin, Zhiqiang wang, Xiaojun Jia	black-box attack, toxicity maximization, bimodal interaction, security
Towards Controllable Speech Synthesis in the Era of Large Language Models: A Systematic Survey	Tianxin Xie, Yan Rong, Pengfei ZHANG, Wenwu Wang, Li Liu	speech synthesis, large language models, controllability, survey
Visual Contextual Attack: Jailbreaking MLLMs with Image-Driven Context Injection	Miao Ziqi, Yi Ding, Lijun Li, Jing Shao	multimodal large language models, adversarial attacks, image context, security
DINT Transformer	Yueyang Cang, Yuhang Liu, Xiaoteng Zhang, Erlu Zhao, Li Shi	transformers, model architecture, deep learning
Stop Looking for ``Important Tokens’’ in Multimodal Language Models: Duplication Matters More	Zichen Wen, Yifeng Gao, Shaobo Wang, Junyuan Zhang, Qintong Zhang, Weijia Li, Conghui He, Linfeng Zhang	multimodal language models, token duplication, model analysis
RCScore: Quantifying Response Consistency in Large Language Models	Congchi Yin, Qian Yu, Zhiwei Fang, Changping Peng, Piji Li	response consistency, large language models, evaluation metrics
Beyond Demonstrations: Dynamic Vector Construction from Latent Representations	Xi Chen, Shuo Wang	latent representations, vector construction, dynamic methods
VideoEraser: Concept Erasure in Text-to-Video Diffusion Models	Mengze Hong, Wailing Ng, Chen Jason Zhang, Di Jiang	concept erasure, text-to-video, diffusion models
DMDTEval: An Evaluation and Analysis of LLMs on Disambiguation in Multi-domain Translation	Jinwang Song, Hongying Zan, Kunli Zhang, Lingling Mu, Yingjie Han, Haobo Hua, Min Peng	evaluation, disambiguation, multi-domain translation, large language models
On the Role of Model Prior in Real-World Inductive Reasoning	Zhuo Liu, Ding Yu, Hangfeng He	inductive reasoning, model prior, real-world applications
AdamS: Momentum Itself Can Be A Normalizer for LLM Pretraining and Post-training	Huishuai Zhang, Bohan Wang, Luoxin Chen	large language models, pretraining, optimization, normalization
Identifying Unlearned Data in LLMs via Membership Inference Attacks	Advit Deepak, Megan Mou, Jing Huang, Diyi Yang	large language models, membership inference, privacy, security
Voice of a Continent: Mapping Africa’s Speech Technology Frontier	AbdelRahim A. Elmadany, Sang Yun Kwon, Hawau Olamid	speech technology, african languages, language technology mapping
OmniThink: Expanding Knowledge Boundaries in Machine Writing through Thinking	Zekun Xi, Wenbiao Yin, Jizhan Fang, Jialong Wu, Runnan Fang, Ningyu Zhang, Yong Jiang, Pengjun Xie, Fei Huang, Huajun Chen	machine writing, knowledge expansion, large language models
DatawiseAgent: A Notebook-Centric LLM Agent Framework for Adaptive and Robust Data Science Automation	Ziming You, Yumiao Zhang, Dexuan Xu, Yiwei Lou, Yandong Yan, Wei Wang, Huamin Zhang, Yu Huang	large language models, data science automation, agents
Group-Aware Reinforcement Learning for Output Diversity in Large Language Models	Seyedali Mohammadi, Bhaskara Hanuma Vedula, Hemank Lamba, Edward Raff, Ponnurangam Kumaraguru, Francis Ferraro, Manas Gaur	reinforcement learning, output diversity, large language models
Cognitive Linguistic Identity Fusion Score (CLIFS): A Scalable Cognition‑Informed Approach to Quantifying Identity Fusion from Text	Devin R. Wright, Jisun An, Yong-Yeol Ahn	cognitive linguistics, identity fusion, text analysis
Polysemantic Dropout: Conformal OOD Detection for Specialized LLMs	Ayush Gupta, Ramneet Kaur, Anirban Roy, Adam D. Cobb, Rama Chellappa, Susmit Jha	out-of-distribution detection, large language models, dropout
DischargeSim: A Simulation Benchmark for Educational Doctor–Patient Communication at Discharge	Zonghai Yao, Michael Sun, Won Seok Jang, SUNJAE KWON, Soie Kwon, hong yu	simulation benchmark, doctor-patient communication, education
Can LLMs be Good Graph Judge for Knowledge Graph Construction?	Haoyu Huang, Chong Chen, Zeang Sheng, Yang Li, Wentao Zhang	large language models, knowledge graph construction, graph evaluation
Retrieving Support to Rank Answers in Open-Domain Question Answering	Zeyu Zhang, Alessandro Moschitti, Thuy Vu	open-domain question answering, answer ranking, retrieval
Refusal-Aware Red Teaming: Exposing Inconsistency in Safety Evaluations	Yongkang Chen, Xiaohu Du, Xiaotian Zou, Chongyang Zhao, Huan Deng, Hu LI, Xiaohui Kuang	safety evaluation, red teaming, robustness
Molecular String Representation Preferences in Pretrained LLMs: A Comparative Study in Zero- & Few-Shot Molecular Property Prediction	George Arthur Baker, Mario Sanz-Guerrero, Katharina von der Wense	molecular property prediction, pretrained models, zero-shot learning, few-shot learning
SimulatorArena: Are User Simulators Reliable Proxies for Multi-Turn Evaluation of AI Assistants?	Yao Dou, Michel Galley, Baolin Peng, Chris Kedzie, Weixin Cai, Alan Ritter, Chris Quirk, Wei Xu, Jianfeng Gao	user simulators, multi-turn evaluation, AI assistants, dialogue systems
SilVar: Speech-Driven Multimodal Model for Reasoning Visual Question Answering and Object Localization	Tan-Hanh Pham, Le Hoang Nam, Phu-Vinh Nguyen, Chris Ngo, Truong-Son Hy	multimodal model, speech-driven, visual question answering, object localization
MultiMed-ST: Large-scale Many-to-many Multilingual Medical Speech Translation	Khai Le-Duc, Tuyen Tran, Bach Phan Tat, Nguyen Kim Hai Bui, Quan Dang Anh, Hung-Phong Tran, Thanh Thuy Nguyen, Ly Nguyen, Tuan Minh Phan, Thi Thu Phuong Tran, Chris Ngo, Khanh Xuan Nguyen, Thanh Nguyen-Tang	medical speech translation, multilingual, large-scale
Should I Share this Translation? Evaluating Quality Feedback for User Reliance on Machine Translation	Dayeon Ki, Kevin Duh, Marine Carpuat	machine translation, quality evaluation, user reliance
Towards Holistic Evaluation of Large Audio-Language Models: A Comprehensive Survey	Chih-Kai Yang, Neo S. Ho, Hung-yi Lee	audio language models, evaluation, survey
When Long Helps Short: How Context Length in Supervised Fine-tuning Affects Behavior of Large Language Models	Yingming Zheng, Hanqi Li, Lu Chen, Kai Yu	context length, supervised fine-tuning, large language models
Table-LLM-Specialist: Language Model Specialists for Tables using Iterative Fine-tuning	Junjie Xing, Yeye He, Mengyu Zhou, Haoyu Dong, Shi Han, Dongmei Zhang, Surajit Chaudhuri	language models, tables, fine-tuning, specialists
ComplexTempQA: A 100m Dataset for Complex Temporal Question Answering	Raphael Gruber, Abdelrahman Abdallah, Michael Färber, Adam Jatowt	question answering, temporal reasoning, datasets
HYDRA: A Multi-Head Encoder-only Architecture for Hierarchical Text Classification	Fabian Karl, Ansgar Scherp	hierarchical text classification, encoder architectures, multi-head attention
Token-Aware Editing of Internal Activations for Large Language Model Alignment	Tianbo Wang, Kewei Liao, Yuqing Ma, Chengzhao Yang, Zhange Zhang, Jiakai Wang, Xianglong Liu	model alignment, large language models, internal activations, token-aware editing
Context-Aware Hierarchical Taxonomy Generation for Scientific Papers via LLM-Guided Multi-Aspect Clustering	kun Zhu, Lizi Liao, Yuxuan Gu, Lei Huang, Xiaocheng Feng, Bing Qin	taxonomy generation, scientific papers, hierarchical clustering, large language models, multi-aspect clustering
CheckEval: A reliable LLM-as-a-Judge framework for evaluating text generation using checklists	Yukyung Lee, JoongHoon Kim, Jaehee Kim, Hyowon Cho, Jaewook Kang, Pilsung Kang, Najoung Kim	evaluation, text generation, large language models, checklist-based evaluation
Editing Across Languages: A Survey of Multilingual Knowledge Editing	Nadir Durrani, Basel Mousi, Fahim Dalvi	multilingual knowledge editing, survey, knowledge editing, multilingual NLP
VELA: An LLM-Hybrid-as-a-Judge Approach for Evaluating Long Image Captions	Kazuki Matsuda, Yuiga Wada, Shinnosuke Hirano, Seitaro Otsuki, Komei Sugiura	large language models, image captioning, evaluation
Multimodal Fine-grained Context Interaction Graph Modeling for Conversational Speech Synthesis	Zhenqi Jia, Rui Liu, Berrak Sisman, Haizhou Li	multimodal, context interaction, graph modeling, conversational speech synthesis
HVGuard: Utilizing Multimodal Large Language Models for Hateful Video Detection	yiheng jing, mingming zhang, Yong Zhuang, jiacheng guo, Juan Wang, Xiaoyang Xu, Wenzhe Yi, Keyan Guo, Hongxin Hu	multimodal, large language models, hateful content detection, video analysis
SimVBG: Simulating Individual Values by Backstory Generation	Bangde Du, Ziyi Ye, Zhijing Wu, Monika A. Jankowska, Shuqi Zhu, Qingyao Ai, Yujia Zhou, Yiqun LIU	simulation, value modeling, backstory generation, individual values
Direct Value Optimization: Improving Chain-of-Thought Reasoning in LLMs with Refined Values	Hongbo Zhang, Han Cui, Guangsheng Bao, Linyi Yang, Jun Wang, Yue Zhang	large language models, chain-of-thought reasoning, value optimization
GeoEdit: Geometric Knowledge Editing for Large Language Models	Yujie Feng, Li-Ming Zhan, ZEXIN LU, Yongxin Xu, Xu Chu, Yasha Wang, Jiannong Cao, Philip S. Yu, Xiao-Ming Wu	large language models, knowledge editing, geometric methods
Alignment Quality Index (AQI) : Beyond Refusals: AQI as an Intrinsic Alignment Diagnostic via Latent Geometry, Cluster Divergence, and Layer wise Pooled Representations	Abhilekh Borah, Chhavi Sharma, Danush Khanna, Utkarsh Bhatt, Gurpreet Singh, Hasnat Md Abdullah, Raghav Kaushik Ravi, Vinija Jain, Jyoti Patel, Shubham Singh, Vasu Sharma, Arpita Vats, Rahul Raja, Aman Chadha, Amitava Das	alignment, diagnostics, latent geometry, cluster divergence
Diagnosing Memorization in Chain-of-Thought Reasoning, One Token at a Time	Huihan Li, You Chen, Siyuan Wang, Yixin He, Ninareh Mehrabi, Rahul Gupta, Xiang Ren	memorization, chain-of-thought reasoning, token-level analysis
Exploring Large Language Models for Detecting Mental Disorders	Gleb Kuzmin, Petr Strepetov, Maksim Stankevich, Natalia Chudova, Artem Shelmanov, Ivan Smirnov	large language models, mental disorder detection, health
Reasoning Model Unlearning: Forgetting Traces, Not Just Answers, While Preserving Reasoning Skills	Changsheng Wang, Chongyu Fan, Yihua Zhang, Jinghan Jia, Dennis Wei, Parikshit Ram, Nathalie Baracaldo, Sijia Liu	model unlearning, reasoning, forgetting, knowledge retention
DASA-Trans-STM: Adaptive Efficient Transformer for Short Text Matching using Data Augmentation and Semantic Awareness	Jiguo Liu, Chao Liu, Meimei Li, Nan Li, Shihao Gao, Dali Zhu	transformers, short text matching, data augmentation, semantic awareness
Scalable Data Synthesis through Human-like Cognitive Imitation and Data Recombination	Zhongyi Ye, Weitai Zhang, Xinyuan Zhou, Yongxin Zhu, Ninghui Rao, Enhong Chen	data synthesis, cognitive imitation, data recombination, scalability
SLoW: Select Low-frequency Words! Automatic Dictionary Selection for Translation on Large Language Models	Hongyuan Lu, Zixuan Li, Zefan Zhang, Wai Lam	machine translation, dictionary selection, large language models
SEA: Supervised Embedding Alignment for Token-Level Visual-Textual Integration in MLLMs	Yuanyang Yin, Yaqi Zhao, Yajie Zhang, Yuanxing Zhang, Ke Lin, Jiahao Wang, Xin Tao, Pengfei Wan, Wentao Zhang, Feng Zhao	multimodal large language models, embedding alignment, visual-textual integration
SAKI-RAG: Mitigating Context Fragmentation in Long-Document RAG via Sentence-level Attention Knowledge Integration	Wenyu Tao, Xiaofen Xing, Zeliang Li, Xiangmin Xu	retrieval-augmented generation, long documents, attention mechanisms
A Good Plan is Hard to Find: Aligning Models with Preferences is Misaligned with What Helps Users	Nishant Balepur, Matthew Shu, Yoo Yeon Sung, Seraphina Goldfarb-Tarrant, Shi Feng, Fumeng Yang, Rachel Rudinger, Jordan Lee Boyd-Graber	model alignment, user preferences, human-computer interaction
EmoAgent: Assessing and Safeguarding Human-AI Interaction for Mental Health Safety	Jiahao Qiu, Yinghui He, Xinzhe Juan, Yimin Wang, Yuhan Liu, Zixin Yao, Yue Wu, xun jiang, Ling Yang, Mengdi Wang	human-ai interaction, mental health, safety, assessment
LIDDIA: Language-based Intelligent Drug Discovery Agent	Reza Averly, Frazier N. Baker, Xia Ning	language-based, drug discovery, intelligent agents
MusKGC: A Flexible Multi-source Knowledge Enhancement Framework for Open-World Knowledge Graph Completion	Xin Song, Liu Haiyan, Haiyang Wang, Ye Wang, Kai Chen, Bin Zhou	knowledge graph completion, knowledge enhancement, multi-source data
Train One Sparse Autoencoder Across Multiple Sparsity Budgets to Preserve Interpretability and Accuracy	Nikita Balagansky, Yaroslav Aksenov, Daniil Laptev, Vadim Kurochkin, Gleb Gerasimov, Nikita Koriagin, Daniil Gavrilov	autoencoders, sparsity, interpretability, accuracy
A Case Against Implicit Standards: Homophone Normalization in Machine Translation for Languages that use the Ge’ez Script.	Hellina Hailu Nigatu, Atnafu Lambebo Tonja, Henok Biadglign Ademtew, Hizkiel Mitiku Alemayehu, Negasi Haile Abadi, Tadesse Destaw Belay, Seid Muhie Yimam	machine translation, homophone normalization, ge’ez script
BRSpeech-DF: A Deep Fake Synthetic Speech Dataset for Portuguese Zero-Shot TTS	Alexandre Costa Ferro Filho, Rafaello Virgilli, Lucas Alcantara Souza, F S de Oliveira, Marcelo Henrique Lopes Ferreira, Daniel Tunnermann, Gustavo dos Reis Oliveira, Anderson Da Silva Soares, Arlindo Rodrigues Galvão Filho	speech synthesis, deep fake, synthetic speech, zero-shot, portuguese
ViDoRAG: Visual Document Retrieval-Augmented Generation via Dynamic Iterative Reasoning Agents	Qiuchen Wang, Ruixue Ding, Zehui Chen, Weiqi Wu, Shihang Wang, Pengjun Xie, Feng Zhao	visual document retrieval, retrieval-augmented generation, iterative reasoning, multimodal
FB-Bench: A Fine-Grained Multi-Task Benchmark for Evaluating LLMs’ Responsiveness to Human Feedback	Youquan Li, Miao Zheng, Fan Yang, Guosheng Dong, Bin CUI, Weipeng Chen, Zenan Zhou, Wentao Zhang	large language models, benchmarks, human feedback, evaluation
Does quantization affect models’ performance on long-context tasks?	Anmol Mekala, Anirudh Atmakuru, Yixiao Song, Marzena Karpinska, Mohit Iyyer	quantization, model performance, long-context tasks
OntologyRAG-Q: Resource Development and Benchmarking for Retrieval-Augmented Question Answering in Qur’anic Tafsir	Sadam Al-Azani, Maad Alowaifeer, Alhanoof Alhunief, Ahmed Abdelali	retrieval-augmented question answering, resource development, benchmarking, religious texts, qur’anic tafsir
Can Large Language Models Tackle Graph Partitioning?	Yiheng Wu, Ningchao Ge, Yanmin Li, Liwei Qian, Mengna Zhu, Haoyu Yang, Haiwen Chen, JibingWu	large language models, graph partitioning, graph algorithms
Chart2Code53: A Large-Scale Diverse and Complex Dataset for Enhancing Chart-to-Code Generation	Tianhao Niu, Yiming Cui, Baoxin Wang, Xiao Xu, Xin Yao, Qingfu Zhu, Dayong Wu, Shijin Wang, Wanxiang Che	datasets, chart-to-code generation, data complexity, code generation
Steering Language Models in Multi-Token Generation: A Case Study on Tense and Aspect	Alina Klerings, Jannik Brinkmann, Daniel Ruffinelli, Simone Paolo Ponzetto	language models, multi-token generation, tense, aspect
Beyond Seen Data: Improving KBQA Generalization Through Schema-Guided Logical Form Generation	Shengxiang Gao, Jey Han Lau, Jianzhong Qi	knowledge base question answering, generalization, logical form generation, schema-guided
Judging Quality Across Languages: A Multilingual Approach to Pretraining Data Filtering with Language Models	Mehdi Ali, Manuel Brack, Max Lübbering, Elias Wendt, Abbas Goher Khan, Richard Rutmann, Alex Jude, Maurice Kraus, Alexander Arno Weber, Felix Stollenwerk, David Kaczér, Florian Mai, Lucie Flek, Rafet Sifa, Nicolas Flores-Herr, Joachim Koehler, Patrick Schramowski, Michael Fromm, Kristian Kersting	multilingual, pretraining data filtering, language models, quality assessment
From A and B to A+B: Can Large Language Models Solve Compositional Math Problems?	Wei Yang, Jinwei Xiao, Hongming Zhang, Qingyang Zhang, Yanna Wang, bo xu	large language models, compositionality, math problems, problem solving
Jailbreak-Tuning: Models Efficiently Learn Jailbreak Susceptibility	Brendan Murphy, Dillon Bowen, Shahrad Mohammadzadeh, Tom Tseng, Julius Broomfield, Adam Gleave, Kellin Pelrine	model tuning, jailbreak susceptibility, large language models
A Generative Pre-Trained Language Model for Channel Prediction in Wireless Communications Systems	Bo Lin, Huanming Zhang, Yuhua Jiang, Yucong Wang, Tengyu Zhang, Shaoqiang Yan, Hongyao Li, Yihong Liu, Feifei Gao	generative language models, channel prediction, wireless communications
Demystifying optimized prompts in language models	Rimon Melamed, Lucas Hurley McCabe, H Howie Huang	language models, prompt optimization
SAND: Boosting LLM Agents with Self-Taught Action Deliberation	Yu Xia, Yiran Jenny Shen, Junda Wu, Tong Yu, Sungchul Kim, Ryan A. Rossi, Lina Yao, Julian McAuley	large language models, agents, self-taught learning, action deliberation
SHIFT: Selected Helpful Informative Frame for Video-guided Machine Translation	Boyu Guan, Chuang Han, Yining Zhang, Yupu Liang, Zhiyang Zhang, Yang Zhao, Chengqing Zong	video-guided machine translation, informative frame selection
Training LLMs to be Better Text Embedders through Bidirectional Reconstruction	Chang Su, Dengliang Shi, Siyuan Huang, Jintao Du, Changhua Meng, Yu Cheng, Weiqiang Wang, Zhouhan Lin	large language models, text embedding, representation learning, bidirectional models
Synergizing Multimodal Temporal Knowledge Graphs and Large Language Models for Social Relation Recognition	Haorui Wang, Zheng Wang, Yuxuan Zhang, Bo Wang, Bin Wu	multimodal, knowledge graphs, large language models, social relation recognition
MultiAgentESC: A LLM-based Multi-Agent Collaboration Framework for Emotional Support Conversation	YangyangXu, Jinpeng Hu, Zhuoer Zhao, Zhangling Duan, Xiao Sun, Xun Yang	large language models, multi-agent systems, emotional support, conversation
On Relation-Specific Neurons in Large Language Models	Yihong Liu, Runsheng Chen, Lea Hirlimann, Ahmad Dawar Hakimi, Mingyang Wang, Amir Hossein Kargaran, Sascha Rothe, François Yvon, Hinrich Schuetze	large language models, interpretability, neurons
LaMP-QA: A Benchmark for Personalized Long-form Question Answering	Alireza Salemi, Hamed Zamani	question answering, long-form QA, personalized QA, benchmark
AnyMAC: Cascading Flexible Multi-Agent Collaboration via Next-Agent Prediction	Song Wang, Zhen Tan, Zihan Chen, Shuang Zhou, Tianlong Chen, Jundong Li	multi-agent systems, collaboration, prediction
Modeling Bottom-up Information Quality during Language Processing	Cui Ding, Yanning Yin, Lena Ann Jäger, Ethan Wilcox	information quality, language processing, modeling
Learning Contextual Retrieval for Robust Conversational Search	Seunghan Yang, Juntae Lee, Jihwan Bang, Kyuhong Shim, Minsoo Kim, Simyung Chang	contextual retrieval, conversational search, robustness
Not Your Typical Government Tipline: LLM-Assisted Routing of Environmental Protection Agency Citizen Tips	Sharanya Majumder, Zehua Li, Derek Ouyang, Kit T Rodolfa, Elena Eneva, Julian Nyarko, Daniel E. Ho	large language models, routing, environmental protection, citizen tips
Benchmarking Large Language Models Under Data Contamination: A Survey from Static to Dynamic Evaluation	Simin Chen, Yiming Chen, Zexin Li, Yifan Jiang, Zhongwei Wan, Yixin He, Dezhi Ran, Tianle Gu, Haizhou Li, Tao Xie, Baishakhi Ray	large language models, benchmarking, data contamination, evaluation
SAEs Are Good for Steering – If You Select the Right Features	Dana Arad, Aaron Mueller, Yonatan Belinkov	self-aware systems, feature selection, steering
Primus: A Pioneering Collection of Open-Source Datasets for Cybersecurity LLM Training	Yao-Ching Yu, Tsun-Han Chiang, Cheng-Wei Tsai, Chien-Ming Huang, Wen-Kwang Tsao	datasets, cybersecurity, large language models, training data
Improving Multilingual Retrieval-Augmented Language Models through Dialectic Reasoning Argumentations	Leonardo Ranaldi, Federico Ranaldi, Fabio Massimo Zanzotto, Barry Haddow, Alexandra Birch	multilingual models, retrieval-augmented generation, reasoning, argumentation
M-LongDoc: A Benchmark For Multimodal Super-Long Document Understanding And A Retrieval-Aware Tuning Framework	Yew Ken Chia, Liying Cheng, Hou Pong Chan, Maojia Song, Chaoqun Liu, Mahani Aljunied, Soujanya Poria, Lidong Bing	multimodal, long document understanding, benchmarks, retrieval-aware tuning
SPECS: Specificity-Enhanced CLIP-Score for Long Image Caption Evaluation	Xiaofu Chen, Israfel Salazar, Yova Kementchedjhieva	image captioning, evaluation, clip-score, long captions
Automated Knowledge Graph Construction using Large Language Models and Sentence Complexity Modelling	Sydney Anuyah, Mehedi Mahmud Kaushik, Sri Rama Krishna Reddy Dwarampudi, Rakesh Shiradkar, Arjan Durresi, Sunandan Chakraborty	knowledge graph construction, large language models, sentence complexity, automated knowledge extraction
Improving Chemical Understanding of LLMs via SMILES Parsing	Yunhui Jang, Jaehyung Kim, Sungsoo Ahn	chemical understanding, large language models, SMILES parsing, cheminformatics
The State of Multilingual LLM Safety Research: From Measuring The Language Gap To Mitigating It	Zheng Xin Yong, Beyza Ermis, Marzieh Fadaee, Stephen Bach, Julia Kreutzer	multilingual large language models, safety, language gap, fairness, bias mitigation
The Staircase of Ethics: Probing LLM Value Priorities through Multi-Step Induction to Complex Moral Dilemmas	Ya Wu, Qiang Sheng, Danding Wang, Guang Yang, Yifan Sun, Zhengjia Wang, Yuyan Bu, Juan Cao	ethics, large language models, value priorities, moral dilemmas, multi-step induction
Certainty in Uncertainty: Reasoning over Uncertain Knowledge Graphs with Statistical Guarantees	Yuqicheng Zhu, Jingcheng Wu, Yizhen Wang, Hongkuan Zhou, Jiaoyan Chen, Evgeny Kharlamov, Steffen Staab	reasoning, knowledge graphs, uncertainty, statistical guarantees
Conditional [MASK] Discrete Diffusion Language Model	Hyukhun Koh, Minha Jhang, Dohyung Kim, Sangmook Lee, Kyomin Jung	discrete diffusion, language models, conditional modeling
Introducing Spotlight: A Novel Approach for Generating Captivating Key Information from Documents	Ankan Mullick, Sombit Bose, Rounak Saha, Ayan Kumar Bhowmick, Aditya Vempaty, Prasenjit Dey, Ravi Kokku, Pawan Goyal, Niloy Ganguly	information extraction, document understanding, key information generation
EvolveSearch: An Iterative Self-Evolving Search Agent	Ding-Chu Zhang, Yida Zhao, Jialong Wu, Liwen Zhang, Baixuan Li, Wenbiao Yin, Yong Jiang, Yu-Feng Li, Kewei Tu, Pengjun Xie, Fei Huang	search agents, iterative methods, self-evolving, reinforcement learning
How Is LLM Reasoning Distracted by Irrelevant Context? An Analysis Using a Controlled Benchmark	Minglai Yang, Ethan Huang, Liang Zhang, Mihai Surdeanu, William Yang Wang, Liangming Pan	large language models, reasoning, context sensitivity, benchmarking
MultiMatch: Multihead Consistency Regularization Matching for Semi-Supervised Text Classification	Iustin Sirbu, Robert-Adrian Popovici, Cornelia Caragea, Stefan Trausan-Matu, Traian Rebedea	semi-supervised learning, text classification, regularization
Whisper-UT: A Unified Translation Framework for Speech and Text	Cihan Xiao, Matthew Wiesner, Debashish Chakraborty, Reno Kriz, Keith Cunningham, Kenton Murray, Kevin Duh, Luis Tavarez-Arce, Paul McNamee, Sanjeev Khudanpur	translation, speech, text, unified framework
Two Heads Are Better Than One: Dual-Model Verbal Reflection at Inference-Time	Jiazheng Li, Yuxiang Zhou, Junru Lu, Gladys Tyen, Lin Gui, Cesare Aloisi, Yulan He	dual-model, verbal reflection, inference-time
Humanizing Machines: Rethinking LLM Anthropomorphism Through a Multi-Level Framework of Design	Yunze Xiao, Lynnette Hui Xian Ng, Jiarui Liu, Mona T. Diab	large language models, anthropomorphism, design framework
Chain-of-Talkers (CoTalk): Fast Human Annotation of Dense Image Captions	Yijun Shen, Delong Chen, Fan Liu, Xingyu Wang, Chuanyi Zhang, Liang Yao, Yuhui Zheng	image captioning, annotation, human annotation, dense captions
Pruning the Paradox: How CLIP’s Most Informative Heads Enhance Performance While Amplifying Bias	Avinash Madasu, Vasudev Lal, Phillip Howard	CLIP, model pruning, bias, performance, vision-language models
BeSimulator: A Large Language Model Powered Text-based Behavior Simulator	Jianan Wang, Bin Li, Jingtao Qi, xueying wang, Fu Li, Lihanxun	large language models, behavior simulation, text-based simulation
AdaRewriter: Unleashing the Power of Prompting-based Conversational Query Reformulation via Test-Time Adaptation	Yilong Lai, Jialong Wu, Zhenglin Wang, Deyu Zhou	conversational query reformulation, prompting, adaptation
ReAgent: Reversible Multi-Agent Reasoning for Knowledge-Enhanced Multi-Hop QA	Zhao Xinjie, Fan Gao, Xingyu Song, Yingjian Chen, Rui Yang, Yanran Fu, Yuyang Wang, Yusuke Iwasawa, Yutaka Matsuo, Irene Li	multi-agent reasoning, multi-hop question answering, knowledge-enhanced QA
Facilitating Cognitive Accessibility with LLMs: A Multi-Task Approach to Easy-to-Read Text Generation	François Ledoyen, Gaël Dias, Jeremie Pantin, Fabrice Maurel, Alexis Lechervy, Youssef Chahir	cognitive accessibility, large language models, text generation, multi-task learning
MoR: Better Handling Diverse Queries with a Mixture of Sparse, Dense, and Human Retrievers	Jushaan Singh Kalra, Xinran Zhao, To Eun Kim, Fengyu Cai, Fernando Diaz, Tongshuang Wu	information retrieval, diverse queries, sparse and dense retrievers
Evaluating Large Language Models for Detecting Antisemitism	Jay Patel, Hrudayangam Mehta, Jeremy Blackburn	large language models, hate speech detection, antisemitism
Learn and Unlearn: Addressing Misinformation in Multilingual LLMs	TaiMing Lu, Philipp Koehn	multilingual large language models, misinformation, learning
Doubling Your Data in Minutes: Ultra-fast Tabular Data Generation via LLM-Induced Dependency Graphs	Shuo Yang, Zheyu Zhang, Bardh Prenkaj, Gjergji Kasneci	data generation, tabular data, large language models
LLM-OREF: An Open Relation Extraction Framework Based on Large Language Models	Hongyao Tu, Liang Zhang, Yujie Lin, Xin Lin, Haibo Zhang, Long zhang, Jinsong Su	relation extraction, large language models, information extraction
Steering LLM Reasoning Through Bias-Only Adaptation	Viacheslav Sinii, Alexey Gorbatovski, Artem Cherepanov, Boris Shaposhnikov, Nikita Balagansky, Daniil Gavrilov	large language models, reasoning, bias adaptation
On LLM-Based Scientific Inductive Reasoning Beyond Equations	Brian S. Lin, Jiaxin Yuan, Zihan Zhou, Shouli Wang, Shuo Wang, Cunliang Kong, Qi Shi, Yuxuan Li, Liner Yang, Zhiyuan Liu, Maosong Sun	scientific reasoning, inductive reasoning, large language models
Slim-SC: Thought Pruning for Efficient Scaling with Self-Consistency	Colin Hong Fung Heng, Xu Guo, Anand Chaanan Singh, Esha Choukse, Dmitrii Ustiugov	efficient scaling, self-consistency, model pruning
Benchmark Profiling: Mechanistic Diagnosis of LLM Benchmarks	Dongjun Kim, Gyuho Shim, Yongchan Chun, Minhyuk Kim, Chanjun Park, Heuiseok Lim	benchmark profiling, large language models, mechanistic diagnosis, evaluation
Task-Aware Resolution Optimization for Visual Large Language Models	Weiqing Luo, Zhen Tan, Yifan Li, Xinyu Zhao, Kwonjoon Lee, Behzad Dariush, Tianlong Chen	visual large language models, resolution optimization, task-aware methods
Your RAG is Unfair: Exposing Fairness Vulnerabilities in Retrieval-Augmented Generation via Backdoor Attacks	Gaurav Bagwe, Saket Sanjeev Chaturvedi, Xiaolong Ma, Xiaoyong Yuan, Kuang-Ching Wang, Lan Emily Zhang	fairness, retrieval-augmented generation, backdoor attacks, security vulnerabilities
LLM-Independent Adaptive RAG: Let the Question Speak for Itself	Maria Marina, Nikolay Ivanov, Sergey Pletenev, Mikhail Salnikov, Daria Galimzianova, Nikita Krayko, Vasily Konovalov, Alexander Panchenko, Viktor Moskvoretskii	retrieval-augmented generation, large language models, question answering
Sheaf Discovery with Joint Computation Graph Pruning and Flexible Granularity	Jingcheng Niu, Lei Yu, Zining Zhu, Xi Chen, Gerald Penn	graph pruning, computation graphs, flexible granularity
WebEvolver: Enhancing Web Agent Self-Improvement with Co-evolving World Model	Tianqing Fang, Hongming Zhang, Zhisong Zhang, Kaixin Ma, Wenhao Yu, Haitao Mi, Dong Yu	web agents, self-improvement, world models, co-evolution
Merge then Realign: Simple and Effective Modality-Incremental Continual Learning for Multimodal LLMs	Dingkun Zhang, Shuhan Qi, Xinyu Xiao, Kehai Chen, Xuan Wang	continual learning, multimodal models, large language models, modality-incremental learning
CARE: A Disagreement Detection Framework with Concept Alignment and Reasoning Enhancement	Jiyuan Liu, Jielin Song, Yunhe Pang, Zhiyu Shen, Yanghui Rao	disagreement detection, concept alignment, reasoning enhancement
AIMMerging: Adaptive Iterative Model Merging Using Training Trajectories for Language Model Continual Learning	Yujie Feng, Jian Li, Xiaoyu DONG, Pengfei Xu, Xiaohui Zhou, Yujia Zhang, ZEXIN LU, Yasha Wang, Alan Zhao, Xu Chu, Xiao-Ming Wu	continual learning, language models, model merging, training trajectories
Learning from Diverse Reasoning Paths with Routing and Collaboration	Zhenyu Lei, Zhen Tan, Song Wang, Yaochen Zhu, Zihan Chen, Yushun Dong, Jundong Li	reasoning, collaboration, learning paths
Unleashing the Reasoning Potential of LLMs by Critique Fine-Tuning on One Problem	Yubo Wang, Ping Nie, Kai Zou, Lijun Wu, Wenhu Chen	large language models, reasoning, fine-tuning
FANS: Formal Answer Selection for LLM Natural Language Math Reasoning Using Lean4	Jiarui Yao, Ruida WANG, Tong Zhang	answer selection, large language models, math reasoning, formal methods
iKnow-audio: Integrating Knowledge Graphs with Audio-Language Models	Michel Olvera, Changhong Wang, Paraskevas Stamatiadis, Gaël Richard, Slim Essid	knowledge graphs, audio-language models, multimodal, integration
In-Context Learning Boosts Speech Recognition via Human-like Adaptation to Speakers and Language Varieties	Nathan Roll, Calbert Graham, Yuka Tatsumi, Kim Tien Nguyen, Meghan Sumner, Dan Jurafsky	speech recognition, in-context learning, adaptation, language varieties, speakers
COLA: Collaborative Multi-Agent Framework with Dynamic Task Scheduling for GUI Automation	Di Zhao, Longhui Ma, Siwei Wang, Miao Wang, Zhao Lv	multi-agent systems, task scheduling, GUI automation, collaboration
Recall with Reasoning: Chain-of-Thought Distillation for Mamba’s Long-Context Memory and Extrapolation	Jun-Yu Ma, Tianqing Fang, Zhisong Zhang, Hongming Zhang, Haitao Mi, Dong Yu	long-context memory, chain-of-thought, reasoning, distillation
Language-to-Space Programming for Training-Free 3D Visual Grounding	Boyu Mi, Hanqing Wang, Tai Wang, Yilun Chen, Jiangmiao Pang	3d visual grounding, programming, vision-language
End-to-End Learnable Psychiatric Scale Guided Risky Post Screening for Depression Detection on Social Media	Bichen Wang, Yuzhe Zi, Yixin Sun, Hao Yang, Yanyan Zhao, Bing Qin	depression detection, social media, psychiatric scale, classification
Superpose Task-specific Features for Model Merging	Haiquan Qiu, You Wu, Dong Li, Jianmin Guo, Quanming Yao	model merging, task-specific features
Leveraging Multilingual Training for Authorship Representation: Enhancing Generalization across Languages and Domains	Junghwan Kim, Haotian Zhang, David Jurgens	multilingual training, authorship representation, generalization, cross-lingual
ESGenius: Benchmarking LLMs on Environmental, Social, and Governance (ESG) and Sustainability Knowledge	Chaoyue He, Xin Zhou, Yi Wu, Xinjia Yu, yan zhang, Lei Zhang, Di Wang, Shengfei Lyu, Hong Xu, Wang Xiaoqiao, Wei Liu, Chunyan Miao	large language models, benchmarking, environmental, social, governance, sustainability
Power doesn’t reside in size: A Low Parameter Hybrid Language Model (HLM) for Sentiment Analysis in Code-mixed data	Pavan Sai Balaga, Nagasamudram Karthik, Challa Vishwanath, Raksha Sharma, Rudra Murthy, Ashish Mittal	hybrid language model, sentiment analysis, code-mixed data
Proactive Assistant Dialogue Generation from Streaming Egocentric Videos	Yichi Zhang, Xin Luna Dong, Zhaojiang Lin, Andrea Madotto, Anuj Kumar, Babak Damavandi, Joyce Chai, Seungwhan Moon	dialogue generation, egocentric videos, proactive assistants
Reshaping Representation Space to Balance the Safety and Over-rejection in Large Audio Language Models	Hao Yang, Lizhen Qu, Ehsan Shareghi, Gholamreza Haffari	audio language models, representation learning, safety, over-rejection
PRISM: Efficient Long-Range Reasoning With Short-Context LLMs	Dulhan Jayalath, James Bradley Wendt, Nicholas Monath, Sandeep Tata, Beliz Gunel	long-range reasoning, large language models, short context
Evaluating Language Translation Models by Playing Telephone	Syeda Jannatus Saba, Steven Skiena	language translation, model evaluation
Accelerate Parallelizable Reasoning via Parallel Decoding within One Sequence	Yijiong Yu, Ji Pei, Wei Wang, Ran Chen	reasoning, parallel decoding, efficiency
IndoSafety: Culturally Grounded Safety for LLMs in Indonesian Languages	Muhammad Falensi Azmi, Muhammad Dehan Al Kautsar, Alfan Farizki Wicaksono, Fajri Koto	language safety, cultural grounding, large language models, indonesian languages
CARD: Cross-modal Agent Framework for Generative and Editable Residential Design	Pengyu Zeng, Jun Yin, Miao Zhang, Yuqin Dai, Jizhizi Li, Shuai Lu	cross-modal, generative agents, editable design, residential design
AI Argues Differently: Distinct Argumentative and Linguistic Patterns of LLMs in Persuasive Contexts	Esra Dönmez, Maximilian Maurer, Gabriella Lapesa, Agnieszka Falenska	large language models, argumentation, linguistic patterns, persuasion
TreeReview: A Dynamic Tree of Questions Framework for Deep and Efficient LLM-based Scientific Peer Review	Yuan Chang, Ziyue Li, Hengyuan Zhang, Yuanbo Kong, Yanru Wu, Zhijiang Guo, Ngai Wong	peer review, large language models, question frameworks, scientific review
Boosting Multi-modal Keyphrase Prediction with Dynamic Chain-of-Thought in Vision-Language Models	Qihang Ma, Shengyu Li, Jie Tang, Dingkang Yang, Chenshaodong, Yingyi Zhang, ChaoFeng, Ran Jiao	multi-modal keyphrase prediction, chain-of-thought, vision-language models
Reason to Rote: Rethinking Memorization in Reasoning	Yupei Du, Philipp Mondorf, Silvia Casola, Yuekun Yao, Robert Litschko, Barbara Plank	reasoning, memorization, machine learning
We Need to Measure Data Diversity in NLP — Better and Broader	Dong Nguyen, Esther Ploeger	data diversity, NLP, evaluation
Moral Framing in Politics (MFiP): A new resource and models for moral framing	Ines Rehbein, Ines Reinig, Simone Paolo Ponzetto	moral framing, politics, resource creation, modeling
Sycophancy Mitigation Through Reinforcement Learning with Uncertainty-Aware Adaptive Reasoning Trajectories	Mohammad Beigi, Ying Shen, Parshin Shojaee, Qifan Wang, Zichao Wang, Chandan K. Reddy, Ming Jin, Lifu Huang	reinforcement learning, reasoning, uncertainty, adaptive methods, sycophancy mitigation
Answering Narrative-Driven Recommendation Queries via a Retrieve–Rank Paradigm and the OCG-Agent	Yunxiao Shi, Haoning Shang, Xing Zi, Wujiang Xu, Yue Feng, Min Xu	recommendation systems, narrative-driven queries, retrieve-rank methods
Investigating Pedagogical Teacher and Student LLM Agents: Genetic Adaptation Meets Retrieval-Augmented Generation Across Learning Styles	Debdeep Sanyal, Agniva Maiti, Umakanta Maharana, Dhruv Kumar, Ankur Mali, C. Lee Giles, Murari Mandal	large language models, pedagogical agents, retrieval-augmented generation, learning styles
NUTMEG: Separating Signal From Noise in Annotator Disagreement	Jonathan Ivey, Susan Gauch, David Jurgens	annotator disagreement, noise separation, data quality
LLMs as World Models: Data-Driven and Human-Centered Pre-Event Simulation for Disaster Impact Assessment	Lingyao Li, Dawei Li, Zhenhui Ou, Xiaoran Xu, Jingxiao Liu, Zihui Ma, Runlong Yu, Min Deng	large language models, world models, simulation, disaster impact assessment, human-centered
Surge: On the Potential of Large Language Models as General-Purpose Surrogate Code Executors	Bohan Lyu, Siqiao Huang, Zichen Liang, Qian Sun, Jiaming Zhang	large language models, code execution, surrogate models
DecoupleSearch: Decouple Planning and Search via Hierarchical Reward Modeling	Hao Sun, Zile Qiao, Bo Wang, Guoxin Chen, Yingyan Hou, Yong Jiang, Pengjun Xie, Fei Huang, Yan Zhang	planning, search, hierarchical reward modeling, reinforcement learning
CoLA: Compute-Efficient Pre-Training of LLMs via Low-Rank Activation	Ziyue Liu, Ruijie ZHANG, Zhengyang Wang, Zi Yang, Paul D. Hovland, Bogdan Nicolae, Franck Cappello, Zheng Zhang	large language models, pre-training, efficiency, low-rank activation
Too Consistent to Detect: A Study of Self-Consistent Errors in LLMs	Hexiang Tan, Fei Sun, Sha Liu, Du Su, Qi Cao, Xin Chen, Jingang Wang, Xunliang Cai, Yuanzhuo Wang, Huawei Shen, Xueqi Cheng	large language models, error analysis, self-consistency
F2TEval: Human-Aligned Multi-Dimensional Evaluation for Figure-to-Text Task	Tan Yue, Rui Mao, Zilong Song, Zonghai Hu, Dongyan Zhao	evaluation, figure-to-text, multimodal
ModRWKV: Transformer Multimodality in Linear Time	Jiale Kang, Ziyin Yue, Qingyu Yin, Rui Jiang, Weile Li, Zening Lu, Zhouran Ji	transformers, multimodality, efficiency
BacktrackAgent: Enhancing GUI Agent with Error Detection and Backtracking Mechanism	Qinzhuo Wu, Pengzhi Gao, Wei Liu, Jian Luan	GUI agents, error detection, backtracking
Think and Recall: Layer-Level Prompting for Lifelong Model Editing	Jinke Wang, Zenan Ying, Qi Liu, Wei Chen, Tong Xu, huijun hou, Zhi Zheng	model editing, lifelong learning, prompting
WISE: Weak-Supervision-Guided Step-by-Step Explanations for Multimodal LLMs in Image Classification	Yiwen Jiang, Deval Mehta, Siyuan Yan, Yaling Shen, Zimu Wang, Zongyuan Ge	weak supervision, multimodal, large language models, image classification, explainability
PPC-GPT: Federated Task-Specific Compression of Large Language Models via Pruning and Chain-of-Thought Distillation	Tao Fan, GuoqiangMa, Yuanfeng SONG, Lixin Fan, Qiang Yang	federated learning, model compression, large language models, pruning, chain-of-thought
FLRC: Fine-grained Low-Rank Compressor for Efficient LLM Inference	Yu-Chen Lu, Chong-Yan Chen, Chi-Chih Chang, Yu-Fang Hu, Kai-Chiang Wu	model compression, low-rank approximation, efficient inference, large language models
To Mask or to Mirror: Human-AI Alignment in Collective Reasoning	Crystal Qian, Aaron T Parisi, Clémentine Bouleau, Vivian Tsai, Maël Lebreton, Lucas Dixon	human-ai alignment, collective reasoning, masking
Code to Think, Think to Code: A Survey on Code-Enhanced Reasoning and Reasoning-Driven Code Intelligence in LLMs	Dayu Yang, Tianyang Liu, Daoan Zhang, Antoine Simoulin, Xiaoyi Liu, Yuwei Cao, Zhaopu Teng, Xin Qian, Grey Yang, Jiebo Luo, Julian McAuley	code intelligence, reasoning, large language models, surveys
SwarmAgentic: Towards Fully Automated Agentic System Generation via Swarm Intelligence	Yao Zhang, Chenyang Lin, Shijie Tang, Haokun Chen, Shijie Zhou, Yunpu Ma, Volker Tresp	agentic systems, swarm intelligence, automation
The Illusion of Progress: Re-evaluating Hallucination Detection in LLMs	Denis Janiak, Jakub Binkowski, Albert Sawczyn, Bogdan Gabrys, Ravid Shwartz-Ziv, Tomasz Jan Kajdanowicz	hallucination detection, large language models, evaluation
RecGPT: A Foundation Model for Sequential Recommendation	Yangqin Jiang, Xubin Ren, Lianghao Xia, Da Luo, Kangyi Lin, Chao Huang	foundation models, sequential recommendation
Layered Insights: Generalizable Analysis of Human Authorial Style by Leveraging All Transformer Layers	Milad Alshomary, Nikhil Reddy Varimalla, Vishal Anand, Smaranda Muresan, Kathleen McKeown	authorial style analysis, transformers, stylistic analysis
Towards Faithful Natural Language Explanations: A Study Using Activation Patching in Large Language Models	Yeo Wei Jie, Ranjan Satapathy, Erik Cambria	natural language explanations, activation patching, large language models
Predicate-Guided Generation for Mathematical Reasoning	Jiajun Chen, Yik-Cheung Tam	mathematical reasoning, generation, predicate-guided generation
Look Again, Think Slowly: Enhancing Visual Reflection in Vision-Language Models	Pu Jian, Junhong Wu, Wei Sun, Chen Wang, Shuo Ren, Jiajun Zhang	vision-language models, visual reflection, multimodal
LM-Searcher: Cross-domain Neural Architecture Search with LLMs via Unified Numerical Encoding	Yuxuan Hu, Jihao Liu, Ke Wang, Jinliang Zheng, Weikang Shi, Manyuan Zhang, Qi Dou, Rui Liu, Aojun Zhou, Hongsheng Li	neural architecture search, large language models, cross-domain, numerical encoding
Grouping Entities with Shared Properties using Multi-Facet Prompting and Property Embeddings	Amit Gajbhiye, Thomas Bailleux, Zied Bouraoui, Luis Espinosa-Anke, Steven Schockaert	entity grouping, multi-facet prompting, property embeddings, entity representation
A Necessary Step toward Faithfulness: Measuring and Improving Consistency in Free-Text Explanations	Lingjun Zhao, Hal Daumé III	faithfulness, consistency, free-text explanations, evaluation
Drift-Adapter: A Practical Approach to Near Zero-Downtime Embedding Model Upgrades in Vector Databases	Harshil Vejendla	embedding models, model upgrades, vector databases, efficiency
TurnBack: A Geospatial Route Cognition Benchmark for Large Language Models through Reverse Route	Hongyi Luo, Qing Cheng, Daniel Matos, Hari Krishna Gadi, Yanfeng Zhang, Lu Liu, Yongliang Wang, Niclas Zeller, Daniel Cremers, Liqiu Meng	geospatial, route cognition, large language models, benchmarking
Hierarchical Bracketing Encodings Work for Dependency Graphs	Ana Ezquerro, Carlos Gómez-Rodríguez, David Vilares	dependency graphs, hierarchical encoding, syntax
IIET: Efficient Numerical Transformer via Implicit Iterative Euler Method	Xinyu Liu, Bei Li, Jiahao Liu, Junhao Ruan, Kechen Jiao, Hongyin Tang, Jingang Wang, Tong Xiao, JingBo Zhu	transformers, numerical methods, efficiency
Calibrating Pseudo-Labeling with Class Distribution for Semi-supervised Text Classification	Nakyeong Yang, Minsung Kim, Seunghyun Yoon, Joongbo Shin, Kyomin Jung	semi-supervised learning, text classification, pseudo-labeling, class distribution
Graceful Forgetting in Generative Language Models	Chunyang Jiang, Chi-Min Chan, Yiyang Cai, Yulong Liu, Wei Xue, Yike Guo	generative language models, forgetting, model robustness
LightThinker: Thinking Step-by-Step Compression	Jintian Zhang, Yuqi Zhu, Mengshu Sun, Yujie Luo, Shuofei Qiao, Lun Du, Da Zheng, Huajun Chen, Ningyu Zhang	large language models, reasoning, step-by-step thinking, compression
RLAE: Reinforcement Learning-Assisted Ensemble for LLMs	Yuqian Fu, Yuanheng Zhu, Jiajun Chai, Guojun Yin, Wei Lin, Qichao Zhang, Dongbin Zhao	reinforcement learning, ensemble methods, large language models
MedHallu: A Comprehensive Benchmark for Detecting Medical Hallucinations in Large Language Models	Shrey Pandit, Jiawei Xu, Junyuan Hong, Zhangyang Wang, Tianlong Chen, Kaidi Xu, Ying Ding	benchmark, medical hallucinations, large language models, evaluation
BBScoreV2: Learning Time-Evolution and Latent Alignment from Stochastic Representation	Tianhao Zhang, Zhecheng Sheng, Zhexiao Lin, Chen Jiang, Dongyeop Kang	time-evolution, latent alignment, stochastic representation, learning
Few-Shot Learning Translation from New Languages	Carlos Mullov, Alexander Waibel	few-shot learning, translation, low-resource languages
ReMedy: Learning Machine Translation Evaluation from Human Preferences with Reward Modeling	Shaomu Tan, Christof Monz	machine translation, evaluation, reward modeling, human preferences
LegalSearchLM: Rethinking Legal Case Retrieval as Legal Elements Generation	Chaeeun Kim, Jinu Lee, Wonseok Hwang	legal, case retrieval, legal elements generation, information retrieval
Continuously Steering LLMs Sensitivity to Contextual Knowledge with Proxy Models	Yilin Wang, Heng Wang, Yuyang Bai, Minnan Luo	large language models, contextual knowledge, sensitivity, proxy models
The Sound of Syntax: Finetuning and Comprehensive Evaluation of Language Models for Speech Pathology	Fagun Patel, Duc Quang Nguyen, Sang T. Truong, Jody Vaynshtok, Sanmi Koyejo, Nick Haber	language models, speech pathology, fine-tuning, evaluation
Quantifying Language Disparities in Multilingual Large Language Models	Songbo Hu, Ivan Vulić, Anna Korhonen	multilingual models, language disparities, large language models
Task-aware Contrastive Mixture of Experts for Quadruple Extraction in Conversations with Code-like Replies and Non-opinion Detection	Chenyuan He, Yuxiang Jia, Fei Gao, Senbin Zhu, Hongde Liu, Hongying Zan, Min Peng	mixture of experts, quadruple extraction, conversation analysis
Crisp: Cognitive Restructuring of Negative Thoughts through Multi-turn Supportive Dialogues	Byeongho Yu, Changhun Lee, Jun-gyu Jin, Eunhyeok Park	dialogue systems, cognitive restructuring, mental health, multi-turn dialogues
FIRE: Flexible Integration of Data Quality Ratings for Effective Pretraining	Xu Liangyu, Xuemiao Zhang, Feiyu Duan, Sirui Wang, Rongxiang Weng, Jingang Wang, Xunliang Cai	pretraining, data quality, integration
Calibration Across Layers: Understanding Calibration Evolution in LLMs	Abhinav Joshi, Areeb Ahmad, Ashutosh Modi	calibration, large language models, model analysis
RETAIL: Towards Real-world Travel Planning for Large Language Models	Bin Deng, Yizhe Feng, Zeming Liu, Qing Wei, Xiangrong Zhu, Shuai Chen, Yuanfang Guo, Yunhong Wang	travel planning, large language models, real-world applications
Re-Align: Aligning Vision Language Models via Retrieval-Augmented Direct Preference Optimization	Shuo Xing, Peiran Li, Yuping Wang, Ruizheng Bai, Yueqi Wang, Chan-Wei Hu, Chengxuan Qian, Huaxiu Yao, Zhengzhong Tu	vision-language models, model alignment, retrieval augmentation, optimization
RuCCoD: Towards Automated ICD Coding in Russian	Alexandr Nesterov, Andrey Sakhovskiy, Ivan Sviridov, Airat Valiev, Vladimir Makharev, Petr Anokhin, Galina Zubkova, Elena Tutubalina	automated coding, icd coding, medical domain, russian language
Towards Transferable Personality Representation Learning based on Triplet Comparisons and Its Applications	Kai Tang, Rui Wang, Renyu Zhu, Minmin Lin, Xiao Ding, Tangjie Lv, Changjie Fan, Runze Wu, Haobo Wang	personality representation, transfer learning, triplet comparisons
Augmenting Multi-Agent Communication with State Delta Trajectory	Yichen Tang, Weihang Su, Yujia Zhou, Yiqun LIU, Min Zhang, Shaoping Ma, Qingyao Ai	multi-agent communication, state trajectory
SPaRC: A Spatial Pathfinding Reasoning Challenge	Lars Benedikt Kaesberg, Jan Philip Wahle, Terry Ruas, Bela Gipp	spatial reasoning, pathfinding, reasoning challenge
SlideCoder: Layout-aware RAG-enhanced Hierarchical Slide Generation from Design	Wenxin Tang, Jingyu Xiao, Wenxuan Jiang, Xi Xiao, Yuhang Wang, Xuxin Tang, Qing Li, Yuehe Ma, Junliang Liu, Shisong Tang, Michael R. Lyu	document generation, layout awareness, retrieval-augmented generation, hierarchical modeling
Can LLMs Help You at Work? A Sandbox for Evaluating LLM Agents in Enterprise Environments	Harsh Vishwakarma, Ankush Agarwal, Ojas Patil, Chaitanya Devaguptapu, Mahesh Chandran	large language models, evaluation, enterprise environments, agents
DrDiff: Dynamic Routing Diffusion with Hierarchical Attention for Breaking the Efficiency-Quality Trade-off	Jusheng Zhang, Yijia Fan, Kaitong Cai, Zimeng Huang, Xiaofei Sun, Jian Wang, Chengpei Tang, Keze Wang	diffusion models, hierarchical attention, efficiency-quality trade-off
Detecting Corpus-Level Knowledge Inconsistencies in Wikipedia with Large Language Models	Sina Semnani, Jirayu Burapacheep, Arpandeep Khatua, Thanawan Atchariyachanvanit, Zheng Wang, Monica Lam	knowledge inconsistencies, wikipedia, large language models, detection
RecBase: Generative Foundation Model Pretraining for Zero-Shot Recommendation	Sashuai Zhou, Weinan Gan, Qijiong Liu, Ke Lei, Jieming Zhu, Hai Huang, Yan Xia, Ruiming Tang, Zhenhua Dong, Zhou Zhao	foundation models, pretraining, zero-shot recommendation, generative models
What You Read Isn’t What You Hear: Linguistic Sensitivity in Deepfake Speech Detection	Binh Nguyen, Shuju Shi, Ryan Ofman, Thai Le	deepfake detection, speech detection, linguistic sensitivity, audio forensics
From Capabilities to Performance: Evaluating Key Functional Properties of LLM Architectures in Penetration Testing	Lanxiao Huang, Daksh Dave, Tyler Cody, Peter A. Beling, Ming Jin	large language models, architecture evaluation, penetration testing, security
Taming Text-to-Image Synthesis for Novices: User-centric Prompt Generation via Multi-turn Guidance	Yilun Liu, Minggui HE, Feiyu Yao, Yuhe Ji, Shimin Tao, Jingzhou DU, JustinLi, Jian Gao, Zhang Li, Hao Yang, Boxing Chen, Osamu Yoshie	text-to-image synthesis, prompt generation, user-centric, multi-turn guidance
A Fully Probabilistic Perspective on Large Language Model Unlearning: Evaluation and Optimization	Anda Cheng, Wei Huang, Yinggui Wang	large language models, unlearning, evaluation, optimization
Stronger Baselines for Retrieval-Augmented Generation with Long-Context Language Models	Stella Frank, Emily Allaway	retrieval-augmented generation, long-context language models
Syntax-Aware Retrieval Augmentation for Neural Symbolic Regression	Canmiao Zhou, Han Huang	neural symbolic regression, retrieval augmentation, syntax-aware methods
Beyond Task-Oriented and Chitchat Dialogues: Proactive and Transition-Aware Conversational Agents	Yejin Yoon, Yuri Son, Namyeong So, Minseo Kim, Minsoo Cho, Chanhee Park, Seungshin Lee, Taeuk Kim	conversational agents, dialogue systems, proactive dialogue, transition awareness
TTT-Bench: A Benchmark for Evaluating Reasoning Ability with Simple and Novel Tic-Tac-Toe-style Games	Prakamya Mishra, Jiang Liu, Jialian Wu, Xiaodong Yu, Zicheng Liu, Emad Barsoum	benchmark, reasoning, games, evaluation
MythTriage: Scalable Detection of Opioid Use Disorder Myths on a Video-Sharing Platform	Hayoung Jung, Shravika Mittal, Ananya Aatreya, Navreet Kaur, Munmun De Choudhury, Tanu Mitra	myth detection, opioid use disorder, video platform, scalable detection
Image Embedding Sampling Method for Diverse Captioning	Sania Waheed, Na Min An	image embedding, captioning, diversity
Measuring Risk of Bias in Biomedical Reports: The RoBBR Benchmark	Jianyou Wang, Weili Cao, Longtian Bao, Youze Zheng, Gil Pasternak, Kaicheng Wang, Xiaoyue Wang, Ramamohan Paturi, Leon Bergen	risk of bias, biomedical reports, benchmark, evaluation
SolEval: Benchmarking Large Language Models for Repository-level Solidity Smart Contract Generation	Zhiyuan Peng, Xin Yin, Rui Qian, Peiqin Lin, YongKang Liu, Hao Zhang, Chenhao Ying, Yuan Luo	large language models, code generation, smart contracts, benchmarking
ChartMind: A Comprehensive Benchmark for Complex Real-world Multimodal Chart Question Answering	Jingxuan Wei, Nan Xu, Junnan Zhu, haoyanni, Gaowei Wu, Qi Chen, Bihui Yu, Lei Wang	benchmarking, multimodal, chart question answering, complex data
Probing LLM World Models: Enhancing Guesstimation with Wisdom of Crowds Decoding	Yun-Shiuan Chuang, Sameer Narendran, Nikunj Harlalka, Alexander Cheung, Sizhe Gao, Siddharth Suresh, Junjie Hu, Timothy T. Rogers	large language models, world models, decoding, wisdom of crowds
ThinkSLM: Towards Reasoning in Small Language Models	Chan Young Park, Jillian Fisher, Marius Memmel, Dipika Khullar, Seoho Yun, Abhishek Gupta, Yejin Choi	small language models, reasoning
DSCD: Large Language Model Detoxification with Self-Constrained Decoding	Ming Dong, Jinkui Zhang, Bolong Zheng, Xinhui Tu, Po Hu, Tingting He	large language models, detoxification, decoding
Multimedia Event Extraction with LLM Knowledge Editing	Jiaao Yu, Yijing Lin, Zhipeng Gao, Xuesong Qiu, Lanlan Rui	event extraction, multimedia, knowledge editing, large language models
BannerAgency: Advertising Banner Design with Multimodal LLM Agents	Heng Wang, Yotaro Shimose, Shingo Takamatsu	advertising, banner design, multimodal, large language models
Tuning Less, Prompting More: In-Context Preference Learning Pipeline for Natural Language Transformation	Shuyun Yang, Yan Zhang, Zhengmao Ye, Lei Duan, Mingjie Tang	preference learning, prompting, natural language transformation
Logits-Based Finetuning	Jingyao Li, Senqiao Yang, Sitong Wu, Han Shi, Chuanyang Zheng, Hong Xu, Jiaya Jia	finetuning, logits, large language models
MIRROR: Multimodal Cognitive Reframing Therapy for Rolling with Resistance	Subin Kim, Hoonrae Kim, Jihyun Lee, Yejin Jeon, Gary Lee	multimodal, cognitive therapy, resistance, mental health
SinhalaMMLU: A Comprehensive Benchmark for Evaluating Multitask Language Understanding in Sinhala	Yifeng Ding, Hantian Ding, Shiqi Wang, Qing Sun, Varun Kumar, Zijian Wang	multitask language understanding, benchmarks, Sinhala language
FinTrust: A Comprehensive Benchmark of Trustworthiness Evaluation in Finance Domain	Tiansheng Hu, Tongyan Hu, Liuyang Bai, Yilun Zhao, Arman Cohan, Chen Zhao	trustworthiness evaluation, finance domain, benchmarking
CoBA: Counterbias Text Augmentation for Mitigating Various Spurious Correlations via Semantic Triples	Kyohoon Jin, Juhwan Choi, JungMin Yun, Junho Lee, Soojin Jang, YoungBin Kim	text augmentation, bias mitigation, semantic triples
Bit-Flip Error Resilience in LLMs: A Comprehensive Analysis and Defense Framework	Yuhang Chen, Zhen Tan, AJAY KUMAR JAISWAL, Huaizhi Qu, Xinyu Zhao, Qi Lin, Yu Cheng, Andrew Kwong, Zhichao Cao, Tianlong Chen	large language models, error resilience, defense framework
Ambiguity Awareness Optimization: Towards Semantic Disambiguation for Direct Preference Optimization	Jian Li, Shenglin Yin, Yujia Zhang, Alan Zhao, Xi Chen, Xiaohui Zhou, Pengfei Xu	semantic disambiguation, preference optimization, ambiguity awareness
VLASCD: A Visual Language Action Model for Simultaneous Chatting and Decision Making	Zuojin Tang, Bin Hu, Chenyang Zhao, De Ma, Gang Pan, Bin Liu	visual language models, multimodal, decision making, conversational agents
FaST: Feature-aware Sampling and Tuning for Personalized Preference Alignment with Limited Data	Thibaut Thonet, Germán Kruszewski, Jos Rozen, Pierre ERBACHER, Marc Dymetman	preference alignment, feature-aware sampling, tuning, personalization
Breaking Agents: Compromising Autonomous LLM Agents Through Malfunction Amplification	Boyang Zhang, Yicong Tan, Yun Shen, Ahmed Salem, Michael Backes, Savvas Zannettou, Yang Zhang	autonomous agents, large language models, security, malfunction
The Practical Impacts of Theoretical Constructs on Empathy Modeling	Allison Lahnala, Charles Welch, David Jurgens, Lucie Flek	empathy modeling, theoretical constructs, affective computing, model evaluation
To See a World in a Spark of Neuron: Disentangling Multi-Task Interference for Training-Free Model Merging	Zitao Fang, Guodong DU, Shuyang Yu, Yifei Guo, Yiwei Zhang, Yiyao Cao, Jing Li, Ho-Kin Tang, Sim Kuan Goh	multi-task learning, model merging, training-free methods, neural networks
AIP: Subverting Retrieval-Augmented Generation via Adversarial Instructional Prompt	Saket Sanjeev Chaturvedi, Gaurav Bagwe, Lan Emily Zhang, Xiaoyong Yuan	retrieval-augmented generation, adversarial attacks, prompts, robustness
DocReRank: Single-Page Hard Negative Query Generation for Training Multi-Modal RAG Rerankers	navve wasserman, Oliver Heinimann, Yuval Golbari, Tal Zimbalist, Eli Schwartz, michal Irani	multi-modal, retrieval-augmented generation, reranking, query generation
A Training-Free Length Extrapolation Approach for LLMs: Greedy Attention Logit Interpolation	Yan Li, Tianyi Zhang, Zechuan Li, Caren Han	large language models, length extrapolation, attention mechanisms
Language-Guided Temporal Token Pruning for Efficient VideoLLM Processing	Yogesh Kumar	video processing, large language models, token pruning, efficiency
Leveraging Semantic Triples for Private Document Generation with Local Differential Privacy Guarantees	Stephen Meisenbacher, Maulik Chevli, Florian Matthes	semantic triples, private document generation, differential privacy
Coarse-to-Fine Grounded Memory for LLM Agent Planning	Weiyi Yang, Richong Zhang, Junfan Chen, Jiawei Sheng	large language models, agent planning, memory, coarse-to-fine
Neural Topic Modeling via Contextual and Graph Information Fusion	Jiyuan Liu, Jiaxing Yan, Chunjiang Zhu, Xingyu Liu, Li Qing, Yanghui Rao	topic modeling, neural networks, graph information, contextual fusion
R-PRM: Reasoning-Driven Process Reward Modeling	Shuaijie She, Junxiao Liu, Yifeng Liu, Jiajun Chen, Xin Huang, Shujian Huang	reasoning, process modeling, reward modeling
Ask Patients with Patience: Enabling LLMs for Human-Centric Medical Dialogue with Grounded Reasoning	Jiayuan Zhu, Jiazhen Pan, Yuyuan Liu, Fenglin Liu, Junde Wu	large language models, medical dialogue, grounded reasoning, human-centric
Active Layer-Contrastive Decoding Reduces Hallucination in Large Language Model Generation	Hongxiang Zhang, Hao Chen, Muhao Chen, Tianyi Zhang	large language models, hallucination reduction, decoding
Date Fragments: A Hidden Bottleneck of Tokenization for Temporal Reasoning	Gagan Bhatia, Maxime Peyrard, Wei Zhao	tokenization, temporal reasoning, bottleneck
DIDS: Domain Impact-aware Data Sampling for Large Language Model Training	Weijie Shi, Jipeng Zhang, Yaguang Wu, Jingzhi Fang, Shibo Zhang, Yao Zhao, Hao Chen, Ruiyuan Zhang, Yue Cui, Jia Zhu, Sirui Han, Jiajie Xu, Xiaofang Zhou	large language models, data sampling, training, domain adaptation
RewardDS: Privacy-Preserving Fine-Tuning for Large Language Models via Reward Driven Data Synthesis	Jianwei Wang, Chengming Shi, Junyao Yang, Haoran Li, Qianli Ma, Huiping Zhuang, Cen Chen, Ziqian Zeng	privacy, fine-tuning, large language models, data synthesis, reward modeling
TS-CLIP: Time Series Understanding by CLIP	Ziwen Chen, Xiaoyuan Zhang, Ming Zhu	time series, CLIP, representation learning, vision-language models
pFedGPT: Hierarchically Optimizing LoRA Aggregation Weights for Personalized Federated GPT Models	Zhanming Shen, Tianqi Xu, Hao Wang, Jian Li, Miao Pan	federated learning, personalization, GPT models, LoRA, optimization
SmartBench: Is Your LLM Truly a Good Chinese Smartphone Assistant?	Xudong Lu, Haohao Gao, Renshou Wu, Shuai Ren, Xiaoxin Chen, Hongsheng Li, Fangyuan Li	large language models, evaluation, smartphone assistant, chinese language
KoBLEX: Open Legal Question Answering with Multi-hop Reasoning	Jihyung Lee, DaeHee Kim, Seonjeong Hwang, Hyounghun Kim, Gary Lee	legal question answering, multi-hop reasoning
FinRAGBench-V: A Benchmark for Multimodal RAG with Visual Citation in the Financial Domain	Zhao Suifeng, Zhuoran Jin, Sujian Li, Jun Gao	benchmark, multimodal retrieval-augmented generation, financial domain
The Impact of Language Mixing on Bilingual LLM Reasoning	Jinfeng Zhou, Yuxuan Chen, Jianing Yin, Yongkang Huang, Yihan Shi, Xikun Zhang, Libiao Peng, Rongsheng Zhang, Tangjie Lv, Zhipeng Hu, Hongning Wang, Minlie Huang	bilingual language models, language mixing, reasoning
IL-PCSR: Legal Corpus for Prior Case and Statute Retrieval	Shounak Paul, Dhananjay Ghumare, Pawan Goyal, Saptarshi Ghosh, Ashutosh Modi	legal, information retrieval, corpus
Efficient Beam Search for Large Language Models Using Trie-Based Decoding	Brian J Chan, Mao-xun Huang, Jui-Hung Cheng, Chao-Ting Chen, Hen-Hsen Huang	beam search, large language models, decoding, trie
Do You Know About My Nation? Investigating Multilingual Language Models’ Cultural Literacy Through Factual Knowledge	Eshaan Tanwar, Anwoy Chatterjee, Michael Saxon, Alon Albalak, William Yang Wang, Tanmoy Chakraborty	multilingual language models, cultural literacy, factual knowledge
Improving Cross Lingual Transfer by Pretraining with Active Forgetting	Divyanshu Aggarwal, Ashutosh Sathe, Sunayana Sitaram	cross-lingual transfer, pretraining, active forgetting
QSpec: Speculative Decoding with Complementary Quantization Schemes	Juntao Zhao, Wenhao Lu, Sheng Wang, Lingpeng Kong, Chuan Wu	speculative decoding, quantization, model efficiency, decoding techniques
Icon$^2$: Aligning Large Language Models Using Self-Synthetic Preference Data via Inherent Regulation	Qiyuan Chen, Hongsen Huang, Qian Shao, Jiahe Chen, Jintai Chen, Hongxia Xu, Renjie Hua, Ren Chuan, Jian Wu	large language models, alignment, preference data
Matter-of-Fact: A Benchmark for Verifying the Feasibility of Literature-Supported Claims in Materials Science	Peter Jansen, Samiah Hassan, Ruoyao Wang	benchmark, claim verification, materials science
Mitigating Biases in Language Models via Bias Unlearning	Dianqing Liu, Yi Liu, Guoqing Jin, Zhendong Mao	bias mitigation, language models, bias unlearning
Diffusion vs. Autoregressive Language Models: A Text Embedding Perspective	Siyue Zhang, Yilun Zhao, Liyuan Geng, Arman Cohan, Anh Tuan Luu, Chen Zhao	diffusion models, autoregressive models, text embeddings
Multi-Domain Explainability of Preferences	Nitay Calderon, Liat Ein-Dor, Roi Reichart	explainability, preferences, multi-domain
The discordance between embedded ethics and cultural inference in large language models	Aida Ramezani, Yang Xu	ethics, cultural inference, large language models, bias
Evaluating Taxonomy Free Character Role Labeling (TF-CRL) in News Stories using Large Language Models	David G Hobson, Derek Ruths, Andrew Piper	character role labeling, news stories, large language models, evaluation
SafeScientist: Enhancing AI Scientist Safety for Risk-Aware Scientific Discovery	Kunlun Zhu, Jiaxun Zhang, Ziheng Qi, Nuoxing Shang, Zijia Liu, Peixuan Han, Yue Su, Haofei Yu, Jiaxuan You	ai safety, scientific discovery, risk-aware learning
LLMs Behind the Scenes: Enabling Narrative Scene Illustration	Melissa Roemmele, John Joon Young Chung, Taewook Kim, Yuqian Sun, Alex Calderwood, Max Kreminski	large language models, narrative generation, scene illustration
Language Mixing in Reasoning Language Models: Patterns, Impact, and Internal Causes	Mingyang Wang, Lukas Lange, Heike Adel, Yunpu Ma, Jannik Strötgen, Hinrich Schuetze	language mixing, reasoning, language models
FoREST: Frame of Reference Evaluation in Spatial Reasoning Tasks	Tanawan Premsri, Parisa Kordjamshidi	spatial reasoning, evaluation, frame of reference
SpecVLM: Enhancing Speculative Decoding of Video LLMs via Verifier-Guided Token Pruning	Yicheng Ji, Jun Zhang, Heming Xia, Jinpeng Chen, Lidan Shou, Gang Chen, Huan Li	video large language models, speculative decoding, token pruning, multimodal models
PSET: a Phonetics-Semantics Evaluation Testbed	Gianluca Sperduti, Dong Nguyen	phonetics, semantics, evaluation, testbed
Avoidance Decoding for Diverse Multi-Branch Story Generation	Kyeongman Park, Nakyeong Yang, Kyomin Jung	story generation, decoding strategies, diversity
START: Self-taught Reasoner with Tools	Chengpeng Li, Mingfeng Xue, Zhenru Zhang, Jiaxi Yang, Beichen Zhang, Bowen Yu, Binyuan Hui, Junyang Lin, Xiang Wang, Dayiheng Liu	self-taught learning, reasoning, tool use, large language models
PRIM: Towards Practical In-Image Multilingual Machine Translation	Yanzhi Tian, Zeming Liu, Zhengyang Liu, Chong Feng, Xin Li, Heyan Huang, Yuhang Guo	multilingual machine translation, in-image translation, practical applications
PoseStitch-SLT: Linguistically Inspired Pose-Stitching for End-to-End Sign Language Translation	Abhinav Joshi, Vaibhav Sharma, Sanjeet Singh, Ashutosh Modi	sign language translation, pose-stitching, linguistics, end-to-end models
Why Stop at One Error? Benchmarking LLMs as Data Science Code Debuggers for Multi-Hop and Multi-Bug Errors	Zhiyu Yang, Shuo Wang, Yukun Yan, Yang Deng	large language models, code debugging, data science, multi-hop reasoning
Generator-Assistant Stepwise Rollback Framework for Large Language Model Agent	Xingzuo Li, Kehai Chen, Yunfei Long, Xuefeng Bai, Yong Xu, Min Zhang	large language models, agents, rollback framework
Mapping the Minds of LLMs: A Graph-Based Analysis of Reasoning LLMs	Zhen Xiong, Yujun Cai, Zhecheng Li, Yiwei Wang	large language models, reasoning, graph analysis
Answer Convergence as a Signal for Early Stopping in Reasoning	Xin Liu, Lu Wang	reasoning, early stopping, answer convergence
DynamicNER: A Dynamic, Multilingual, and Fine-Grained Dataset for LLM-based Named Entity Recognition	Hanjun Luo, Yingbin Jin, Yiran Wang, Xinfeng Li, Tong Shang, Xuecheng Liu, Ruizhe Chen, Kun Wang, Hanan Salam, Qingsong Wen, Zuozhu Liu	named entity recognition, multilingual, dataset, large language models
Database-Augmented Query Representation for Information Retrieval	Soyeong Jeong, Jinheon Baek, Sukmin Cho, Sung Ju Hwang, Jong C. Park	information retrieval, query representation, database augmentation
LVLMs are Bad at Overhearing Human Referential Communication	Zhengxiang Wang, Weiling Li, Panagiotis Kaliosis, Susan Brennan, Owen Rambow	large vision-language models, referential communication, human-computer interaction
VISaGE: Understanding Visual Generics and Exceptions	Yihao Li, Jiayi Xin, Miranda Muqing Miao, Qi Long, Lyle Ungar	visual understanding, generics, exceptions
Sparse Neurons Carry Strong Signals of Question Ambiguity in LLMs	Zhuoxuan Zhang, Jinhao Duan, Edward Kim, Kaidi Xu	large language models, neurons, question ambiguity, interpretability
MEPT: Mixture of Expert Prompt Tuning as a Manifold Mapper	Runjia Zeng, Guangyan Sun, Qifan Wang, Tong Geng, Sohail Dianat, Xiaotian Han, Raghuveer Rao, XUELING ZHANG, Cheng Han, Lifu Huang, Dongfang Liu	prompt tuning, mixture of experts, manifold learning
SQUAB: Evaluating LLM robustness to Ambiguous and Unanswerable Questions in Semantic Parsing	Simone Papicchio, Luca Cagliero, Paolo Papotti	large language models, robustness, ambiguous questions, unanswerable questions, semantic parsing
Exploring Response Uncertainty in MLLMs: An Empirical Evaluation under Misleading Scenarios	Yunkai Dang, Mengxi Gao, Yibo Yan, Xin Zou, Yanggan Gu, Jungang Li, Jingyu Wang, Peijie Jiang, Aiwei Liu, Jia Liu, Xuming Hu	multimodal large language models, response uncertainty, empirical evaluation, misleading scenarios
UniDebugger: Hierarchical Multi-Agent Framework for Unified Software Debugging	Cheryl Lee, Chunqiu Steven Xia, Longji Yang, Jen-tse Huang, Zhouruixing Zhu, LINGMING ZHANG, Michael R. Lyu	software debugging, multi-agent systems, hierarchical frameworks
Model Unlearning via Sparse Autoencoder Subspace Guided Projections	Xu Wang, Zihao Li, Benyou Wang, Yan Hu, Difan Zou	model unlearning, autoencoders, projections
CRITICTOOL: Evaluating Self-Critique Capabilities of Large Language Models in Tool-Calling Error Scenarios	Shiting Huang, Zhen Fang, Zehui Chen, Siyu Yuan, Junjie Ye, Yu Zeng, Lin Chen, Qi Mao, Feng Zhao	large language models, self-critique, error analysis
RAG-Instruct: Boosting LLMs with Diverse Retrieval-Augmented Instructions	Wanlong Liu, Junying Chen, Ke Ji, Li Zhou, Wenyu Chen, Benyou Wang	large language models, retrieval-augmented generation, instructions
From Reasoning to Answer: Empirical, Attention-Based and Mechanistic Insights into Distilled DeepSeek R1 Models	Jue Zhang, Qingwei Lin, Saravan Rajmohan, Dongmei Zhang	reasoning, attention, model analysis
Exploring the Impact of Personality Traits on LLM Toxicity and Bias	Shuo Wang, Renhao Li, Xi Chen, Yulin Yuan, Min Yang, Derek F. Wong	personality traits, toxicity, bias, large language models
SPIRIT: Patching Speech Language Models against Jailbreak Attacks	Amirbek Djanibekov, Nurdaulet Mukhituly, Kentaro Inui, Hanan Aldarmaki, Nils Lukas	speech language models, security, jailbreak attacks, robustness
SSA: Semantic Contamination of LLM-Driven Fake News Detection	Cheng Xu, Nan Yan, Shuhao Guan, Yuke Mei, Tahar Kechadi	fake news detection, semantic contamination, large language models
Unraveling Interwoven Roles of Large Language Models in Authorship Privacy: Obfuscation, Mimicking, and Verification	Tuc Nguyen, Yifan Hu, Thai Le	authorship privacy, large language models, obfuscation, verification
Integral Transformer: Denoising Attention, Not Too Much Not Too Little	Ivan Kobyzev, Abbas Ghaddar, Dingtao Hu, Boxing Chen	transformers, attention mechanisms, denoising
M-ABSA: A Multilingual Dataset for Aspect-Based Sentiment Analysis	ChengYan Wu, Bolei Ma, Yihong Liu, Zheyu Zhang, Ningyuan Deng, Yanshu Li, Baolan Chen, Yi Zhang, Yun Xue, Barbara Plank	multilingual datasets, aspect-based sentiment analysis, sentiment analysis
SurveyGen: Quality-Aware Scientific Survey Generation with Large Language Models	Tong Bao, Mir Tafseer Nayeem, Davood Rafiei, Chengzhi Zhang	scientific survey generation, large language models, quality awareness
ExeCoder: Empowering Large Language Models with Executability Representation for Code Translation	Minghua He, Yue Chen, Fangkai Yang, Pu Zhao, Wenjie Yin, Yu Kang, Qingwei Lin, Saravan Rajmohan, Dongmei Zhang	large language models, code translation, executability, program synthesis
Formalizing Style in Personal Narratives	Gustave Cortal, Alain Finkel	style, personal narratives, text analysis, stylistics
Genre Matters: How Text Types Interact with Decoding Strategies and Lexical Predictors in Shaping Reading Behavior	Lena Sophia Bolliger, Lena Ann Jäger	reading behavior, text types, decoding strategies, lexical predictors
Discursive Circuits: How Do Language Models Understand Discourse Relations?	Alex Laitenberger, Christopher D Manning, Nelson F. Liu	discourse relations, language models, discourse understanding
AskToAct: Enhancing LLMs Tool Use via Self-Correcting Clarification	Xuan Zhang, Yongliang Shen, Zhe Zheng, Linjuan Wu, Wenqi Zhang, Yuchen Yan, Qiuying Peng, Jun Wang, Weiming Lu	large language models, tool use, self-correction, clarification
MuTIS: Enhancing Reasoning Efficiency through Multi Turn Intervention Sampling in Reinforcement Learning	Wenshuo Zhao, Haoxing Zhai, Xinyu Qiu, Zhenting Qi, Shuhe Li, Linchao Zhu	reinforcement learning, reasoning efficiency, multi-turn intervention sampling
Few-Shot Open-Set Classification via Reasoning-Aware Decomposition	Avyav Kumar Singh, Helen Yannakoudakis	few-shot learning, open-set classification, reasoning-aware methods
Controlled Generation for Private Synthetic Text	Marc Felix Brinner, Sina Zarrieß	controlled generation, synthetic text, privacy
Structured Preference Optimization for Vision-Language Long-Horizon Task Planning	Xiwen Liang, Min Lin, Weiqi Ruan, Rongtao Xu, Yuecheng Liu, Jiaqi Chen, Bingqian Lin, Yuzheng Zhuang, Xiaodan Liang	vision-language models, task planning, long-horizon planning, optimization
Extracting and Combining Abilities For Building Multi-lingual Ability-enhanced Large Language Models	Zhipeng Chen, Kun Zhou, Liang Song, Xin Zhao, Bingning Wang, Weipeng Chen, Ji-Rong Wen	large language models, multilingual, ability enhancement
ViPE: Visual Perception in Parameter Space for Efficient Video-Language Understanding	Shichen Lu, Tongtian Yue, Longteng Guo, Handong Li, Xingjian He, Si Liu, Jing Liu	video-language understanding, visual perception, efficiency
Linear-Time Demonstration Selection for In-Context Learning via Gradient Estimation	Ziniu Zhang, Zhenshuo Zhang, Dongyue Li, Lu Wang, Jennifer Dy, Hongyang R. Zhang	in-context learning, demonstration selection, gradient estimation, efficiency
Visual-Aware Speech Recognition for Noisy Scenarios	Balaji Darur, Karan Singla	speech recognition, noisy environments, multimodal
TORSO: Template-Oriented Reasoning Towards General Tasks	Minhyuk Kim, Seungyoon Lee, Heuiseok Lim	template-oriented reasoning, general tasks, reasoning
SliceMoE: Routing Embedding Slices Instead of Tokens for Fine-Grained and Balanced Transformer Scaling	Harshil Vejendla	transformers, mixture of experts, model scaling, embeddings
Enhancing Chain-of-Thought Reasoning via Neuron Activation Differential Analysis	Yiru Tang, Kun Zhou, Yingqian Min, Jing Sha, Zhichao Sheng, Shijin Wang, Xin Zhao	chain-of-thought reasoning, neuron analysis, interpretability
KG-CQR: Leveraging Structured Relation Representations in Knowledge Graphs for Contextual Query Retrieval	Chi Minh Bui, Ngoc Mai Thieu, Vinh Van Nguyen, Jason J. Jung, Khac-Hoai Nam Bui	knowledge graphs, query retrieval, structured relations
VisBias: Measuring Explicit and Implicit Social Biases in Vision Language Models	Jen-tse Huang, Jiantong Qin, Jianping Zhang, Youliang Yuan, Wenxuan Wang, Jieyu Zhao	social bias, vision language models, bias measurement
Unilaw-R1: A Large Language Model for Legal Reasoning with Reinforcement Learning and Iterative Inference	Hua Cai, Shuang Zhao, liang zhang, Xuli Shen, Qing Xu, Weilin Shen, ZihaoWen, Tianke Ban	large language models, legal reasoning, reinforcement learning, iterative inference
Understanding the Thinking Process of Reasoning Models: A Perspective from Schoenfeld’s Episode Theory	Nan Zhang, Ming Li, Chenrui Fan, Hong Jiao, Yanbin Fu, Sydney Peters, Qingshu Xu, Robert Lissitz, Tianyi Zhou	reasoning models, thinking process, episode theory
Combining Constrained and Unconstrained Decoding via Boosting: BoostCD and Its Application to Information Extraction	Marija Sakota, Robert West	decoding, boosting, information extraction
Exploring Quality and Diversity in Synthetic Data Generation for Argument Mining	Jianzhu Bao, Yuqi Huang, Yang Sun, Wenya Wang, Yice Zhang, Bojun Jin, Ruifeng Xu	synthetic data, argument mining, data quality, data diversity
A Text-Based Recommender System that Leverages Explicit Affective State Preferences	Wentao Zhang, Woojeong Kim, Yuntian Deng	recommender systems, affective state preferences, text-based
UNComp: Can Matrix Entropy Uncover Sparsity? — A Compressor Design from an Uncertainty-Aware Perspective	Jing Xiong, Jianghan Shen, Fanghua Ye, Chaofan Tao, Zhongwei Wan, Jianqiao Lu, Xun Wu, Chuanyang Zheng, Zhijiang Guo, Min Yang, Lingpeng Kong, Ngai Wong	matrix entropy, sparsity, compression, uncertainty-aware methods
Model-Based Ranking of Source Languages for Zero-Shot Cross-Lingual Transfer	Oron Anschel, Alon Shoshan, Adam Botach, Shunit Haviv Hakimi, Asaf Gendler, Emanuel Ben Baruch, Nadav Bhonker, Igor Kviatkovsky, Manoj Aggarwal, Gerard Medioni	cross-lingual transfer, zero-shot learning, language ranking
How Sememic Components Can Benefit Link Prediction for Lexico-Semantic Knowledge Graphs?	Hansi Wang, Yue Wang, Qiliang Liang, Yang Liu	link prediction, knowledge graphs, lexico-semantic
STARE at the Structure: Steering ICL Exemplar Selection with Structural Alignment	Jiaqian Li, Qisheng Hu, Jing Li, Wenya Wang	in-context learning, exemplar selection, structural alignment
Reward Model Perspectives: Whose Opinions Do Reward Models Reward?	Elle	reward models, evaluation, bias
CHENGYU-BENCH: Benchmarking Large Language Models for Chinese Idiom Understanding and Use	Yicheng Fu, Zhemin Huang, Liuxin Yang, Yumeng Lu, Zhongdongming Dai	benchmarking, large language models, chinese idioms, language understanding
REARANK: Reasoning Re-ranking Agent via Reinforcement Learning	Le Zhang, Bo Wang, Xipeng Qiu, Siva Reddy, Aishwarya Agrawal	reasoning, re-ranking, reinforcement learning
User Feedback in Human-LLM Dialogues: A Lens to Understand Users But Noisy as a Learning Signal	Yuhan Liu, Michael JQ Zhang, Eunsol Choi	human-llm interaction, user feedback, learning signals
Batched Self-Consistency Improves LLM Relevance Assessment and Ranking	Justin Chen, Archiki Prasad, Swarnadeep Saha, Elias Stengel-Eskin, Mohit Bansal	self-consistency, large language models, relevance assessment, ranking
InfoGain-RAG: Boosting Retrieval-Augmented Generation through Document Information Gain-based Reranking and Filtering	Zihan Wang, Zihan Liang, Zhou Shao, Yufei Ma, Huangyu Dai, Ben Chen, MaoLingtao, Chenyi Lei, Yuqing DING, Han Li	retrieval-augmented generation, reranking, information gain, document retrieval
Enhancing Reasoning Abilities of Small LLMs with Cognitive Alignment	Wenrui Cai, Chengyu Wang, Junbing Yan, Jun Huang, Xiangzhong Fang	small large language models, reasoning, cognitive alignment
DEBATE, TRAIN, EVOLVE: Self‑Evolution of Language Model Reasoning	YONGJIAN CHEN, Antonio Toral	language model reasoning, self-evolution
Knowledge-Aware Co-Reasoning for Multidisciplinary Collaboration	xurui li, wanghaijiao, Kaisong Song, Rui Zhu, Haixu Tang	knowledge-aware systems, co-reasoning, multidisciplinary collaboration
DiplomacyAgent: Do LLMs Balance Interests and Ethical Principles in International Events?	Jianxiang Peng, Ling Shi, Xinwei Wu, Hanwen Zhang, Fujiang Liu, Haocheng Lyu, Deyi Xiong	large language models, ethics, international events, interest balancing
iTool: Reinforced Fine-Tuning with Dynamic Deficiency Calibration for Advanced Tool Use	Yirong Zeng, Xiao Ding, Yuxian Wang, Weiwen Liu, Yutai Hou, Wu Ning, Xu Huang, Duyu Tang, Dandan Tu, Bing Qin, Ting Liu	reinforcement learning, fine-tuning, tool use, dynamic calibration
V-SEAM: Visual Semantic Editing and Attention Modulating for Causal Interpretability of Vision-Language Models	Qidong Wang, Junjie Hu, Ming Jiang	vision-language models, interpretability, attention, causal analysis
Evaluating the Effectiveness and Scalability of LLM-Based Data Augmentation for Retrieval	Pranjal A Chitale, Bishal Santra, Yashoteja Prabhu, Amit Sharma	large language models, data augmentation, retrieval, evaluation
BANMIME : Misogyny Detection with Metaphor Explanation on Bangla Memes	Md Ayon Mia, Akm Moshiur Rahman Mazumder, Khadiza Sultana Sayma, Md Fahim, Md Tahmid Hasan Fuad, MUHAMMAD IBRAHIM KHAN, AKMMAHBUBUR RAHMAN	misogyny detection, metaphor explanation, memes, bangla language
VeriFact: Enhancing Long-Form Factuality Evaluation with Refined Fact Extraction and Reference Facts	Xin Liu, Lechen Zhang, Sheza Munir, Yiyang Gu, Lu Wa	factuality evaluation, long-form text, fact extraction
Med-PRM: Medical Reasoning Models with Stepwise, Guideline-verified Process Rewards	Jaehoon Yun, Jiwoong Sohn, Jungwoo Park, Hyunjae Kim, Xiangru Tang, Daniel Shao, Yong Hoe Koo, Ko Minhyeok, Qingyu Chen, Mark Gerstein, Michael Moor, Jaewoo Kang	medical reasoning, process rewards, guideline verification, healthcare
The Enemy from Within: A Study of Political Delegitimization Discourse in Israeli Political Speech	Naama Rivlin-Angert, Guy Mor-Lan	political discourse, delegitimization, speech analysis
Implicit Values Embedded in How Humans and LLMs Complete Subjective Everyday Tasks	Arjun Arunasalam, Madison Pickering, Z. Berkay Celik, Blase Ur	subjective tasks, human-computer interaction, large language models, values
Do Large Language Models excel in Complex Logical Reasoning with Formal Language?	Jin Jiang, Jianing Wang, Yuchen Yan, Yang Liu, Jianhua Zhu, Mengdi Zhang, Liangcai Gao	large language models, logical reasoning, formal language
ESC-Judge: A Framework for Comparing Emotional Support Conversational Agents	Navid Madani	conversational agents, emotional support, evaluation frameworks
MULTIGUARD: An Efficient Approach for AI Safety Moderation Across Languages and Modalities	Sahil Verma, Keegan Hines, Jeff Bilmes, Charlotte Siska, Luke Zettlemoyer, Hila Gonen, Chandan Singh	AI safety, moderation, multilingual, multimodal
When Truthful Representations Flip Under Deceptive Instructions?	Xianxuan Long, Yao Fu, Runchao Li, Mu Sheng, Haotian Yu, Xiaotian Han, Pan Li	truthfulness, deceptive instructions, representation learning
Reliable Evaluation and Benchmarks for Statement Autoformalization	Auguste Poiroux, Gail Weiss, Viktor Kunčak, Antoine Bosselut	evaluation, benchmarks, statement autoformalization
Language Models as Continuous Self-Evolving Data Engineers	Peidong Wang, Ming Wang, Zhiming Ma, Xiaocui Yang, Shi Feng, Daling Wang, Yifei Zhang, Kaisong Song	language models, self-evolving, data engineering
UI-Hawk: Unleashing the Screen Stream Understanding for Mobile GUI Agents	Jiwen Zhang, Ya-Qi Yu, Minghui Liao, WenTao Li, Jihao Wu, zhongyu wei	screen stream understanding, mobile GUI agents
ConvSearch-R1: Enhancing Query Reformulation for Conversational Search with Reasoning via Reinforcement Learning	Changtai Zhu, Siyin Wang, Ruijun Feng, Kai Song, Xipeng Qiu	conversational search, query reformulation, reinforcement learning
iVISPAR — An Interactive Visual-Spatial Reasoning Benchmark for VLMs	Julius Mayer, Mohamad Ballout, Serwan Jassim, Farbod Nosrat Nezami, Elia Bruni	visual-spatial reasoning, vision-language models, benchmark
Spec-VLA: Speculative Decoding for Vision-Language-Action Models with Relaxed Acceptance	Songsheng Wang, Rucheng Yu, Zhihang Yuan, Chao Yu, Feng Gao, Yu Wang, Derek F. Wong	vision-language-action models, speculative decoding
PruneCD: Contrasting Pruned Self Model to Improve Decoding Factuality	Abteen Ebrahimi, Adam Wiemerslage, Katharina von der Wense	model pruning, decoding, factuality, language models
Improving Informally Romanized Language Identification	Adrian Benton, Alexander Gutkin, Christo Kirov, Brian Roark	language identification, romanized text, informal language
Large Language Models Do Multi-Label Classification Differently	Marcus Ma, Georgios Chochlakis, Niyantha Maruthu Pandiyan, Jesse Thomason, Shrikanth Narayanan	large language models, multi-label classification
COCO-Tree: Compositional Hierarchical Concept Trees for Enhanced Reasoning in Vision-Language Models	Sanchit Sinha, Guangzhi Xiong, Aidong Zhang	vision-language models, compositionality, hierarchical reasoning
LEO-MINI: An Efficient Multimodal Large Language Model using Conditional Token Reduction and Mixture of Multi-Modal Experts	Yimu Wang, Mozhgan Nasr Azadani, Sean Sedwards, Krzysztof Czarnecki	multimodal large language models, efficiency, token reduction, mixture of experts
Teach Small Models to Reason by Curriculum Distillation	Wangyi Jiang, Yaojie Lu, Hongyu Lin, Xianpei Han, Le Sun	small models, reasoning, curriculum learning, distillation
RTE-GMoE: A Model-agnostic Approach for Relation Triplet Extraction via Graph-based Mixture-of-Expert Mutual Learning	Aziguli Wulamu, Kaiyuan Gong, Lyu Zhengyu, Yu Han, Zhihong Zhu, Bowen Xing	relation extraction, graph neural networks, mixture of experts
A Probabilistic Inference Scaling Theory for LLM Self-Correction	Zhe Yang, Yichang Zhang, Yudong Wang, Ziyao Xu, Junyang Lin, Zhifang Sui	probabilistic inference, large language models, self-correction, scaling theory
Unmasking Deceptive Visuals: Benchmarking Multimodal Large Language Models on Misleading Chart Question Answering	Zixin CHEN, Sicheng Song, KaShun SHUM, Yanna Lin, Rui SHENG, Weiqi Wang, Huamin Qu	multimodal large language models, deceptive visuals, chart question answering, benchmarking
Compositional Generalisation for Explainable Hate Speech Detection	Agostina Calabrese, Tom Sherborne, Björn Ross, Mirella Lapata	hate speech detection, explainability, compositional generalisation
LORAXBENCH: A Multitask, Multilingual Benchmark Suite for 20 Indonesian Languages	Alham Fikri Aji, Trevor Cohn	benchmark, multilingual, indonesian languages, multitask learning
CLLMate: A Multimodal Benchmark for Weather and Climate Events Forecasting	Haobo Li, Zhaowei Wang, Jiachen Wang, Yueya WANG, Alexis Kai Hon Lau, Huamin Qu	multimodal, benchmark, weather forecasting, climate events
EasyRec: Simple yet Effective Language Models for Recommendation	Xubin Ren, Chao Huang	language models, recommendation systems, simplicity, effectiveness
Retrieval-augmented GUI Agents with Generative Guidelines	Ran Xu, Kaixin Ma, Wenhao Yu, Hongming Zhang, Joyce C. Ho, Carl Yang, Dong Yu	retrieval-augmented agents, gui agents, generative guidelines
TurBLiMP: A Turkish Benchmark of Linguistic Minimal Pairs	Ezgi Başar, Francesca Padovani, Jaap Jumelet, Arianna Bisazza	benchmark, linguistic minimal pairs, turkish, evaluation
SAMULE: Self-Learning Agents Enhanced by Multi-level Reflection	Yubin Ge, Salvatore Romeo, Jason Cai, MONICA SUNKARA, Yi Zhang	self-learning agents, multi-level reflection, reinforcement learning
Dynamic Retriever for In-Context Knowledge Editing via Policy Optimization	Mahmud Wasif Nafee, Maiqi JIANG, Haipeng Chen, Yanfu Zhang	knowledge editing, in-context learning, policy optimization, retrieval
Backdoor Attacks	Gaurav Bagwe, Saket Sanjeev Chaturvedi, Xiaolong Ma, Xiaoyong Yuan, Kuang-Ching Wang, Lan Emily Zhang	security, adversarial attacks, machine learning
Neuron-Level Differentiation of Memorization and Generalization in Large Language Models	Ko-Wei Huang, Yi-Fu Fu, Ching-Yu Tsai, Yu-Chieh Tu, TZU-LING CHENG, Cheng-Yu Lin, Yi-Ting Yang, Heng-Yi Liu, Keng-Te Liao, Da-Cheng Juan, Shou-De Lin	large language models, memorization, generalization, neuron analysis
Comparing human and LLM politeness strategies in free production	Haoran Zhao, Robert D. Hawkins	politeness, language models, human-computer interaction
Evaluating Behavioral Alignment in Conflict Dialogue: A Multi-Dimensional Comparison of LLM Agents and Humans	Deuksin Kwon, Kaleen Shrestha, Bin Han, Gale Lucas	behavioral alignment, dialogue systems, large language models
SemCSE: Semantic Contrastive Sentence Embeddings Using LLM-Generated Summaries For Scientific Abstracts	Anton Korikov, Pan Du, Scott Sanner, Navid Rekabsaz	semantic embeddings, contrastive learning, sentence embeddings, scientific abstracts
AI Sees Your Location—But With A Bias Toward The Wealthy World	Jingyuan Huang, Jen-tse Huang, Ziyi Liu, Xiaoyuan Liu, Wenxuan Wang, Jieyu Zhao	location bias, social bias, large language models
Ensembling Prompting Strategies for Zero-Shot Hierarchical Text Classification with Large Language Models	Mingxuan Xia, Zhijie Jiang, Haobo Wang, Junbo Zhao, Tianlei Hu, Gang Chen	prompting strategies, zero-shot learning, hierarchical text classification, large language models
STEER-BENCH: A Benchmark for Evaluating the Steerability of Large Language Models	Kai Chen, Zihao He, Taiwei Shi, Kristina Lerman	benchmark, steerability, large language models
How to Make Large Language Models Generate 100% Valid Molecules?	Wen Tao, Jing Tang, Alvin Chan, Bryan Hooi, Baolong Bi, Nanyun Peng, Yuansheng Liu, Yiwei Wang	large language models, molecule generation, validity
Pre-trained Language Models Learn Remarkably Accurate Representations of Numbers	Marek Kadlčík, Michal Štefánik, Timothee Mickus, Josef Kuchař, Michal Spiegel	pre-trained language models, numerical representation
HydraOpt: Navigating the Efficiency-Performance Trade-off of Adapter Merging	Taha Ceritli, Ondrej Bohdal, Mete Ozay, Jijoong Moon, Kyenghun Lee, Hyeonmok Ko, Umberto Michieli	adapter merging, efficiency, performance trade-off
Embedding Domain Knowledge for Large Language Models via Reinforcement Learning from Augmented Generation	Chaojun Nie, Jun Zhou, Guanxiang Wang, Shisong Wu, Zichen Wang	large language models, domain knowledge, reinforcement learning
3DS: Medical Domain Adaptation of LLMs via Decomposed Difficulty-based Data Selection	Hongxin Ding, Yue Fang, Runchuan Zhu, Xinke Jiang, Jinyang Zhang, Yongxin Xu, Weibin Liao, Xu Chu, Junfeng Zhao, Yasha Wang	large language models, medical domain, domain adaptation, data selection
CBP-Tuning: Efficient Local Customization for Black-box Large Language Models	Jiaxuan Zhao, Naibin Gu, Yuchen Feng, Xiyu Liu, Peng Fu, Zheng Lin, Weiping Wang	large language models, model tuning, customization
Child-Directed Language Does Not Consistently Boost Syntax Learning in Language Models	Francesca Padovani, Jaap Jumelet, Yevgen Matusevych, Arianna Bisazza	language models, syntax learning, child-directed language
Planning-Aware Code Infilling via Horizon-Length Prediction	Tamás Ficsor, Gábor Berend	code infilling, horizon-length prediction, planning-aware models
SWAN: An Efficient and Scalable Approach for Long-Context Language Modeling	Krishna C Puvvada, Faisal Ladhak, Santiago Akle Serano, Cheng-Ping Hsieh, Shantanu Acharya, Somshubra Majumdar, Fei Jia, Samuel Kriman, Simeng Sun, Dima Rekesh, Boris Ginsburg	long-context language modeling, efficiency, scalability
Efficient Model Development through Fine-tuning Transfer	Pin-Jie Lin, Rishab Balasubramanian, Fengyuan Liu, Nikhil Kandpal, Tu Vu	model development, fine-tuning, transfer learning, efficiency
From Generation to Judgment: Opportunities and Challenges of LLM-as-a-judge	Dawei Li, Bohan Jiang, Liangjie Huang, Alimohammad Beigi, Chengshuai Zhao, Zhen Tan, Amrita Bhattacharjee, Yuxuan Jiang, Canyu Chen, Tianhao Wu, Kai Shu, Lu Cheng, huan liu	large language models, judgment, generation, challenges
TableEval: A Real-World Benchmark for Complex, Multilingual, and Multi-Structured Table Question Answering	Junnan Zhu, Jingyi Wang, Bohan Yu, Xiaoyu Wu, Junbo Li, Lei Wang, Nan Xu	table question answering, multilingual, benchmarking, complex data, structured data
Context-Aware Membership Inference Attacks against Pre-trained Large Language Models	Hongyan Chang, Ali Shahin Shamsabadi, Kleomenis Katevas, Hamed Haddadi, Reza Shokri	membership inference attacks, privacy, large language models, security
NOVER: Incentive Training for Language Models via Verifier-Free Reinforcement Learning	Wei Liu, Siya Qi, Xinyu Wang, Chen Qian, Yali Du, Yulan He	language models, reinforcement learning, incentive training
SURE: Safety Understanding and Reasoning Enhancement for Multimodal Large Language Models	Yuxin Gou, Xiaoning Dong, Qin Li, Shishen Gu, Richang Hong, Wenbo Hu	safety, reasoning, multimodal large language models
The Impact of Negated Text on Hallucination with Large Language Models	Jaehyung Seo, Hyeonseok Moon, Heuiseok Lim	large language models, hallucination, negation, text analysis
DisLoRA: Task-specific Low-Rank Adaptation via Orthogonal Basis from Singular Value Decomposition	She Yifei, Xinhao Wei, Yulong Wang	low-rank adaptation, singular value decomposition, task-specific adaptation
Towards AI-Assisted Psychotherapy: Emotion-Guided Generative Interventions	Zihao Zhao, Anjalie Field	ai-assisted psychotherapy, emotion-guided generation, generative interventions
Dovetail: A CPU/GPU Heterogeneous Speculative Decoding for LLM inference	Libo Zhang, Zhaoning Zhang, xubaizhou, Rui Li, Zhiliang Tian, Songzhu Mei, Dongsheng Li	large language models, inference, hardware acceleration, cpu, gpu
Multi-perspective Analysis of Large Language Model Domain Specialization: An Experiment in Accounting Audit Procedures Generation	Yusuke Noro	large language models, domain specialization, accounting, audit procedures
ToM: Leveraging Tree-oriented MapReduce for Long-Context Reasoning in Large Language Models	Jiani Guo, Zuchao Li, Jie Wu, Qianren Wang, Yun Li, Lefei Zhang, hai zhao, Yujiu Yang	large language models, long-context reasoning, mapreduce
Speech Vecalign: an Embedding-based Method for Aligning Parallel Speech Documents	Chutong Meng, Philipp Koehn	speech processing, alignment, embeddings, parallel data
Representation Potentials of Foundation Models for Multimodal Alignment: A Survey	Jianglin Lu, Hailing Wang, Yi Xu, Yizhou Wang, Kuo Yang, Yun Fu	foundation models, multimodal alignment, survey
WildScore: Benchmarking MLLMs in-the-Wild Symbolic Music Reasoning	Gagan Mundada, Yash Vishe, Amit Namburi, Xin Xu, Zachary Novack, Julian McAuley, Junda Wu	benchmarking, multimodal large language models, symbolic music reasoning
ReSo: A Reward-driven Self-organizing LLM-based Multi-Agent System for Reasoning Tasks	Heng Zhou, Hejia Geng, Xiangyuan Xue, Li Kang, Yiran Qin, Zhiyong Wang, Zhenfei Yin, LEI BAI	large language models, multi-agent systems, reasoning, reinforcement learning
PakBBQ: A Culturally Adapted Bias Benchmark for QA	Abdullah Hashmat, Muhammad Arham Mirza, Agha Ali Raza	bias, question answering, cultural adaptation, benchmarks
Can LLMs simulate the same correct solutions to free-response math problems as real students?	Yuya Asano, Diane Litman, Erin Walker	large language models, math problem solving, education
RECALL: REpresentation-aligned Catastrophic-forgetting ALLeviation via Hierarchical Model Merging	Bowen Wang, Haiyuan Wan, 石力文, Chen Yang, Peng He, Yue MA, Haochen Han, Wenhao Li, Tiao Tan, Yongjian Li, Fangming Liu, Gong Yifan, Sheng Zhang	catastrophic forgetting, model merging, representation learning
Less Is More? Examining Fairness in Pruned Large Language Models for Summarising Opinions	Nannan Huang, Haytham M. Fayek, Xiuzhen Zhang	fairness, pruned large language models, summarization, opinion summarization
Evaluating and Aligning Human Economic Risk Preferences in LLMs	Jiaxin Liu, Yixuan Tang, Yi Yang, KAR YAN TAM	large language models, economic risk preferences, evaluation, alignment
MultiLogicNMR(er): A Benchmark and Neural-Symbolic Framework for Non-monotonic Reasoning with Multiple Extensions	Yeliang Xiu, Yongmei Liu	benchmark, neural-symbolic framework, non-monotonic reasoning
Dynamic Jointly Batch Selection for Data Efficient Machine Translation Fine-Tuning	Mohammad Amin Ghanizadeh, Mohammad Javad Dousti	machine translation, fine-tuning, data efficiency
Are LLMs Better than Reported? Detecting Label Errors and Mitigating Their Effect on Model Performance	Omer Nahum, Nitay Calderon, Orgad Keller, Idan Szpektor, Roi Reichart	large language models, label errors, model performance
Parrot: A Training Pipeline Enhances Both Program CoT and Natural Language CoT for Reasoning	Senjie Jin, Lu Chen, Zhiheng Xi, Yuhui Wang, Sirui Song, Yuhao Zhou, Xinbo Zhang, peng sun, Hong Lu, Tao Gui, Qi Zhang, Xuanjing Huang	chain-of-thought, reasoning, training pipeline
Mitigating Hallucinations in Large Vision-Language Models via Entity-Centric Multimodal Preference Optimization	Jiulong Wu, Zhengliang Shi, Shuaiqiang Wang, Jizhou Huang, Dawei Yin, Lingyong Yan, Min Cao, Min Zhang	vision-language models, hallucination mitigation, multimodal optimization
InfiniBench: A Benchmark for Large Multi-Modal Models in Long-Form Movies and TV Shows	Kirolos Ataallah, Eslam Mohamed BAKR, Mahmoud Ahmed, Chenhui Gou, Khushbu Pahwa, Jian Ding, Mohamed Elhoseiny	multi-modal models, benchmarking, long-form video, movies, tv shows
Humans Hallucinate Too: Language Models Identify and Correct Subjective Annotation Errors With Label-in-a-Haystack Prompts	Georgios Chochlakis, Peter Wu, Tikka Arjun Singh Bedi, Marcus Ma, Kristina Lerman, Shrikanth Narayanan	large language models, hallucination detection, annotation errors
From Chat Logs to Collective Insights: Aggregative Question Answering	Gaurav Srivastava, Zhenyu Bi, Meng Lu, Xuan Wang	question answering, chat logs, aggregative insights
OMS: On-the-fly, Multi-Objective, Self-Reflective Ad Keyword Generation via LLM Agent	Bowen Chen, Zhao Wang, Shingo Takamatsu	ad keyword generation, multi-objective optimization, large language models
FilBench: Can LLMs Understand and Generate Filipino?	Lester James Validad Miranda, Elyanah Aco, Conner G. Manuel, Jan Christian Blaise Cruz, Joseph Marvin Imperial	large language models, language understanding, language generation, filipino language
Read to Hear: A Zero-Shot Pronunciation Assessment Using Textual Descriptions and LLMs	Yu-Wen Chen, Melody Ma, Julia Hirschberg	pronunciation assessment, zero-shot learning, large language models
From Shortcuts to Balance: Attribution Analysis of Speech-Text Feature Utilization in Distinguishing Original from Machine-Translated Texts	Kilichbek Haydarov, Youssef Mohamed, Emilio Goldenhersch, Paul OCallaghan, Li-jia Li, Mohamed Elhoseiny	attribution analysis, speech-text features, machine translation, original vs translated texts
Confounding Factors in Relating Model Performance to Morphology	Wessel Poelman, Thomas Bauwens, Miryam de Lhoneux	model performance, morphology, linguistic analysis, evaluation
GATEAU: Selecting Influential Samples for Long Context Alignment	Shuzheng Si, Haozhe Zhao, Gang Chen, Yunshui Li, Kangyang Luo, Chuancheng Lv, Kaikai An, Fanchao Qi, Baobao Chang, Maosong Sun	long context alignment, sample selection, data efficiency
Multilingual Dialogue Generation and Localization with Dialogue Act Scripting	Geyang Guo, Tarek Naous, Hiromi Wakaki, Yukiko Nishimura, Yuki Mitsufuji, Alan Ritter, Wei Xu	multilingual dialogue generation, dialogue act scripting, localization
Astra: Efficient Transformer Architecture and Contrastive Dynamics Learning for Embodied Instruction Following	Yueen Ma, DaFeng Chi, Shiguang Wu, Yuecheng Liu, Yuzheng Zhuang, Irwin King	transformers, efficient architecture, contrastive learning, embodied instruction following
Textual Aesthetics in Large Language Models	Lingjie Jiang, Shaohan Huang, Xun Wu, Furu Wei	large language models, textual aesthetics, language generation
Transplant Then Regenerate: A New Paradigm for Text Data Augmentation	Guangzhan Wang, Hongyu Zhang, Beijun Shen, Xiaodong Gu	text data augmentation, data generation, regeneration
SAFE: Schema-Driven Approximate Distance Join for Efficient Knowledge Graph Querying	Sangoh Lee, Sungho Park, Wook-Shin Han	knowledge graphs, querying, schema, efficiency
DocAgent: An Agentic Framework for Multi-Modal Long-Context Document Understanding	Li Sun, Liu He, Shuyue Jia, Yangfan He, Chenyu You	multi-modal, long-context, document understanding, agents
Alignment for Efficient Tool Calling of Large Language Models	Hongshen Xu, Zihan Wang, Zichen Zhu, Lei Pan, Xingyu Chen, Shuai Fan, Lu Chen, Kai Yu	large language models, tool calling, efficiency
Not-Just-Scaling Laws: Towards a Better Understanding of the Downstream Impact of Language Model Design Decisions	Emmy Liu, Amanda Bertsch, Lintang Sutawika, Lindia Tjuatja, Patrick Fernandes, Lara Marinov, Michael Chen, Shreya Singhal, Carolin Lawrence, Aditi Raghunathan, Kiril Gashteovski, Graham Neubig	language models, model design, downstream tasks, scaling laws
Attention Eclipse: Manipulating Attention to Bypass LLM Safety-Alignment	Pedram Zaree, Md Abdullah Al Mamun, Quazi Mishkatul Alam, Yue Dong, Ihsen Alouani, Nael Abu-Ghazaleh	attention mechanisms, safety alignment, large language models, adversarial manipulation
Let’s Reason Formally: Natural-Formal Hybrid Reasoning Enhances LLM’s Math Capability	Ruida WANG, Yuxin Li, Yi R. Fung, Tong Zhang	formal reasoning, hybrid reasoning, math capability, large language models
ConstraintLLM: A Neuro-Symbolic Framework for Industrial-Level Constraint Programming	Weichun Shi, Minghao Liu, Wanting Zhang, Langchen Shi, Fuqi Jia, Feifei Ma, Jian Zhang	neuro-symbolic methods, constraint programming, industrial applications
Out of Sight, Not Out of Context? Egocentric Spatial Reasoning in VLMs Across Disjoint Frames	Sahithya Ravi, Gabriel Herbert Sarch, Vibhav Vineet, Andrew D Wilson, Balasaravanan Thoravi Kumaravel	vision-language models, spatial reasoning, egocentric vision
SABER: Uncovering Vulnerabilities in Safety Alignment via Cross-Layer Residual Connection	Maithili Joshi, Palash Nandi, Tanmoy Chakraborty	safety alignment, vulnerabilities, neural networks
From Surveys to Narratives: Rethinking Cultural Value Adaptation in LLMs	Muhammad Farid Adilazuarda, Chen Cecilia Liu, Iryna Gurevych, Alham Fikri Aji	cultural value adaptation, large language models, narratives
Improbable Bigrams Expose Vulnerabilities of Incomplete Tokens in Byte-Level Tokenizers	Eugene Jang, Kimin Lee, Jin-Woo Chung, Keuntae Park, Seungwon Shin	byte-level tokenizers, token vulnerabilities, bigrams
Models Are Not Private Thinkers	Tommaso Green, Martin Gubri, Haritz Puerto, Sangdoo Yun, Seong Joon Oh	privacy, model analysis
Enhancing Large Vision-Language Models with Ultra-Detailed Image Caption Generation	Yu Zeng, Yukun Qi, Yiming Zhao, Xikun Bao, Lin Chen, Zehui Chen, Shiting Huang, Jie Zhao, Feng Zhao	vision-language models, image captioning, detail enhancement
Principled Personas: Defining and Measuring the Intended Effects of Persona Prompting on Task Performance	Pedro Henrique Luz de Araujo, Paul Röttger, Dirk Hovy, Benjamin Roth	persona prompting, task performance, evaluation
Conflict-Aware Soft Prompting for Retrieval-Augmented Generation	Eunseong Choi, June Park, Hyeri Lee, Jongwuk Lee	soft prompting, retrieval-augmented generation, conflict awareness
Mind the Gap: A Closer Look at Tokenization for Multiple-Choice Question Answering with LLMs	Mario Sanz-Guerrero, Minh Duc Bui, Katharina von der Wense	tokenization, multiple-choice question answering, large language models
Looking Beyond Text: Reducing Language Bias in Large Vision-Language Models via Multimodal Dual-Attention and Soft-Image Guidance	Haozhe Zhao, Shuzheng Si, Liang Chen, Yichi Zhang, Maosong Sun, Baobao Chang, Minjia Zhang	vision-language models, language bias, multimodal attention
VERITAS: Leveraging Vision Priors and Expert Fusion to Improve Multimodal Data	Tingqiao Xu, Ziru Zeng, Jiayu Chen	vision priors, expert fusion, multimodal data
MaZO: Masked Zeroth-Order Optimization for Multi-Task Fine-Tuning of Large Language Models	Zhen Zhang, Yifan Yang, Kai Zhen, Nathan Susanj, Athanasios Mouchtaris, Siegfried Kunzmann, Zheng Zhang	optimization, multi-task learning, large language models
Can LLMs be Literary Companions?: Analysing LLMs on Bengali Figures of Speech Identification	Sourav Das, Kripabandhu Ghosh	figures of speech, language models, Bengali language, literary analysis
Small Models, Big Results: Achieving Superior Intent Extraction through Decomposition	Danielle Cohen, Yoni Halpern, Anatoly Efros, Noam Kahlon, Joel Oren, Omri Berkovitch, Sapir Caduri, Ido Dagan	intent extraction, model efficiency, decomposition
Constrained Non-negative Matrix Factorization for Guided Topic Modeling of Minority Topics	Seyedeh Fatemeh Ebrahimi, Jaakko Peltonen	topic modeling, matrix factorization, minority topics
VoiceCraft-X: Unifying Multilingual, Voice-Cloning Speech Synthesis and Speech Editing	Zhisheng Zheng, Puyuan Peng, Anuj Diwan, Cong Phuoc Huynh, Xiaohang Sun, Zhu Liu, Vimal Bhat, David Harwath	multilingual speech synthesis, voice cloning, speech editing
What Do Indonesians Really Need from Language Technology? A Nationwide Survey	Muhammad Dehan Al Kautsar, Lucky Susanto, Derry Tanti Wijaya, Fajri Koto	language technology, survey, user needs, Indonesian language, language resources
From Unaligned to Aligned: Scaling Multilingual LLMs with Multi-Way Parallel Corpora	Yingli Shen, Wen Lai, Shuo Wang, Kangyang Luo, Alexander Fraser, Maosong Sun	multilingual large language models, alignment, parallel corpora, scaling
SQLWOZ: A Realistic Task-Oriented Dialogue Dataset with SQL-Based Dialogue State Representation for Complex User Requirements	Heng-Da Xu, Xian-Ling Mao, Fanshu Sun, Tian-Yi Che, Cheng-Xin Xin, Heyan Huang	task-oriented dialogue, datasets, SQL, dialogue state representation
MentalGLM Series: Explainable Large Language Models for Mental Health Analysis on Chinese Social Media	Wei Zhai, Nan Bai, Qing Zhao, Jianqiang Li, Fan Wang, Hongzhi Qi, Meng Jiang, Xiaoqin Wang, Bing Xiang Yang, Guanghui FU	large language models, explainability, mental health, social media, chinese language
Mind the Inclusivity Gap: Multilingual Gender-Neutral Translation Evaluation with mGeNTE	beatrice savoldi, Giuseppe Attanasio, Eleonora Cupin, Eleni Gkovedarou, Janiça Hackenbuchner, Anne Lauscher, Matteo Negri, Andrea Piergentili, Manjinder Thind, Luisa Bentivogli	multilingual translation, gender-neutral translation, evaluation, inclusivity
Translation in the Hands of Many: Centering Lay Users in Machine Translation Interactions	beatrice savoldi, Alan Ramponi, Matteo Negri, Luisa Bentivogli	machine translation, user interaction, lay users
MAgICoRe: Multi-Agent, Iterative, Coarse-to-Fine Refinement for Reasoning	Gaurav Srivastava, Shuxiang Cao, Xuan Wang	multi-agent systems, iterative refinement, reasoning
Position: LLMs Can be Good Tutors in English Education	Jingheng Ye, Shen Wang, Deqing Zou, Yibo Yan, Kun Wang, Hai-Tao Zheng, Ruitong Liu, Zenglin Xu, Irwin King, Philip S. Yu, Qingsong Wen	large language models, education, tutoring, english language
MemeArena: Automating Context-Aware Unbiased Evaluation of Harmfulness Understanding for Multimodal Large Language Models	Zixin Chen, Hongzhan Lin, Kaixin Li, Ziyang Luo, Yayue Deng, Jing Ma	multimodal large language models, harmfulness evaluation, context-aware evaluation
Phi: Preference Hijacking in Multi-modal Large Language Models at Inference Time	Yifan Lan, Yuanpu Cao, Weitong Zhang, Lu Lin, Jinghui Chen	multi-modal large language models, preference hijacking, inference
Synthetic Socratic Debates: Examining Persona Effects on Moral Decision and Persuasion Dynamics	Jiarui Liu, Yueqi Song, Yunze Xiao, Mingqian Zheng, Lindia Tjuatja, Jana Schaich Borg, Mona T. Diab, Maarten Sap	dialogue systems, persona, moral decision making, persuasion
Draft Model Knows When to Stop: Self-Verification Speculative Decoding for Long-Form Generation	Ziyin Zhang, Jiahao Xu, Tian Liang, Xingyu Chen, Zhiwei He, Rui Wang, Zhaopeng Tu	long-form generation, self-verification, decoding strategies
Prototypical Human-AI Collaboration Behaviors from LLM-Assisted Writing in the Wild	Sheshera Mysore, Debarati Das, Hancheng Cao, Bahareh Sarrafzadeh	human-ai collaboration, writing assistance, large language models
SUE: Sparsity-based Uncertainty Estimation via Sparse Dictionary Learning	Justin Vasselli, Eunike Andriani Kardinata, Yusuke Sakai, Taro Watanabe	uncertainty estimation, sparsity, sparse dictionary learning
Promote, Suppress, Iterate: How Language Models Answer One-to-Many Factual Queries	Tianyi Lorena Yan, Robin Jia	language models, factual queries, question answering
CARMA: Enhanced Compositionality in LLMs via Advanced Regularisation and Mutual Information Alignment	Nura Aljaafari, Danilo Carvalho, Andre Freitas	large language models, compositionality, regularization
Argument Summarization and its Evaluation in the Era of Large Language Models	Moritz Altemeyer, Steffen Eger, Johannes Daxenberger, Yanran Chen, Tim Altendorf, Philipp Cimiano, Benjamin Schiller	summarization, argument mining, large language models, evaluation
Iterative Prompt Refinement for Safer Text-to-Image Generation	Jinwoo Jeon, JunHyeok Oh, Hayeong Lee, Byung-Jun Lee	prompt refinement, text-to-image generation, safety
Unsupervised Word-level Quality Estimation for Machine Translation Through the Lens of Annotators (Dis)agreement	Gabriele Sarti, Vilém Zouhar, Malvina Nissim, Arianna Bisazza	machine translation, quality estimation, unsupervised learning, annotator disagreement
Beyond Demographics: Enhancing Cultural Value Survey Simulation with Multi-Stage Personality-Driven Cognitive Reasoning	Haijiang Liu, Qiyuan Li, Chao Gao, Yong Cao, Xiangyu Xu, XUN WU, Daniel Hershcovich, Jinguang Gu	cultural value survey, cognitive reasoning, personality-driven simulation
3MDBench: Medical Multimodal Multi-agent Dialogue Benchmark	Ivan Sviridov, Amina Miftahova, Tereshchenko Artemiy Vladimirovich, Galina Zubkova, Pavel Blinov, Andrey Savchenko	medical, multimodal, dialogue, benchmark
Large Language Models Badly Generalize across Option Length, Problem Types, and Irrelevant Noun Replacements	Guangxiang Zhao, Saier Hu, Xiaoqi Jian, Wu Jinzhu, Yuhan Wu, Lin Sun, Xiangzheng Zhang	large language models, generalization, robustness
M-Wanda: Improving One-Shot Pruning for Multilingual LLMs	Rochelle Choenni, Ivan Titov	multilingual large language models, model pruning, one-shot pruning
Annotating Training Data for Conditional Semantic Textual Similarity Measurement using Large Language Models	Gaifan Zhang, Yi Zhou, Danushka Bollegala	semantic textual similarity, training data annotation, large language models
Speculative Streaming: Efficient and Scalable Speculative Decoding with Multi-Stream Attention	Nikhil Bhendawade, Irina Belousova, Qichen Fu, Henry Mason, Antonie Lin, Mohammad Rastegari, Mahyar Najibi	speculative decoding, efficient decoding, multi-stream attention
Search Wisely: Mitigating Sub-optimal Agentic Searches By Reducing Uncertainty	Peilin Wu, Mian Zhang, Xinlu Zhang, Xinya Du, Zhiyu Chen	search algorithms, uncertainty reduction, agentic search
Unconditional Truthfulness: Learning Unconditional Uncertainty of Large Language Models	Artem Vazhentsev, Ekaterina Fadeeva, Rui Xing, Gleb Kuzmin, Ivan Lazichny, Alexander Panchenko, Preslav Nakov, Timothy Baldwin, Maxim Panov, Artem Shelmanov	large language models, uncertainty estimation, truthfulness
Procedural Environment Generation for Tool-Use Agents	Michael Sullivan, Mareike Hartmann, Alexander Koller	procedural generation, tool-use agents, environment simulation
PunMemeCN: A Benchmark to Explore Vision-Language Models’ Understanding of Chinese Pun Memes	Zhijun Xu, Siyu Yuan, Yiqiao Zhang, Jingyu Sun, Tong Zheng, Deqing Yang	vision-language models, pun memes, benchmark
CARE: Multilingual Human Preference Learning for Cultural Awareness	Tonmoy Hasan, Razvan Bunescu	multilingual learning, human preference learning, cultural awareness
NOVA-63: Native Omni-lingual Versatile Assessments of 63 Disciplines	Jinyang Zhang, Kexin Yang, Yu Wan, Muyang Ye, Baosong Yang, Fei Huang, Junyang Lin, Dayiheng Liu	multilingual, evaluation, cross-disciplinary, language assessment
TopicAttack: An Indirect Prompt Injection Attack via Topic Transition	Yulin Chen, Haoran Li, Yuexin Li, Yue Liu, Yangqiu Song, Bryan Hooi	prompt injection, security, adversarial attacks, topic transition
Probabilistic Soundness Guarantees in LLM Reasoning Chains	Weiqiu You, Anton Xue, Shreya Havaldar, Delip Rao, Helen Jin, Chris Callison-Burch, Eric Wong	large language models, reasoning chains, probabilistic guarantees
Do Large Language Models Truly Grasp Addition? A Rule-Focused Diagnostic Using Two-Integer Arithmetic	Yang Yan, Yu Lu, Renjun Xu, Zhenzhong Lan	large language models, arithmetic reasoning, diagnostics, rule-based reasoning
MAVL: A Multilingual Audio-Video Lyrics Dataset for Animated Song Translation	Woohyun Cho, Youngmin Kim, Sunghyun Lee, Youngjae Yu	multilingual datasets, audio-video data, song translation, multimodal
Section-Level Simplification of Biomedical Abstracts	Jan Bakker, Jaap Kamps	text simplification, biomedical domain, abstracts
SynC-LLM: Generation of Large-Scale Synthetic Circuit Code with Hierarchical Language Models	Shang Liu, Yao Lu, Wenji Fang, Jing Wang, Zhiyao Xie	large language models, code generation, hierarchical models
Temporal Referential Consistency: Do LLMs Favor Sequences Over Absolute Time References?	Ashutosh Bajpai, Tanmoy Chakraborty	large language models, temporal consistency, sequence modeling
From Automation to Autonomy: A Survey on Large Language Models in Scientific Discovery	Tianshi Zheng, Zheye Deng, Hong Ting Tsang, Weiqi Wang, Jiaxin Bai, Zihao Wang, Yangqiu Song	large language models, scientific discovery, survey
COAS2W: A Chinese Older-Adults Spoken-to-Written Transformation Corpus with Context Awareness	Chun Kang, Zhigu Qian, Zhen Fu, Jiaojiao Fu, Yangfan Zhou	spoken-to-written transformation, chinese language, older adults, corpus, context awareness
Reliable and Cost-Effective Exploratory Data Analysis via Graph-Guided RAG	Mossad Helali, Yutai Luo, Tae Jun Ham, Jim Plotts, Ashwin Chaugule, Jichuan Chang, Parthasarathy Ranganathan, Essam Mansour	exploratory data analysis, graph neural networks, retrieval augmented generation, cost-effectiveness
Graders Should Cheat: Privileged Information Enables Expert-Level Automated Evaluations	Jin Peng Zhou, Séb Arnold, Nan Ding, Kilian Q Weinberger, Nan Hua, Fei Sha	automated evaluation, privileged information, expert systems
Advancing Arabic Diacritization: Improved Datasets, Benchmarking, and State-of-the-Art Models	Abubakr Mohamed, Hamdy Mubarak	arabic diacritization, datasets, benchmarking, state-of-the-art models
TRIAL: Token Relations and Importance Aware Late-interaction for Accurate Text Retrieval	Hyukkyu Kang, Injung Kim, Wook-Shin Han	text retrieval, token relations, late interaction
VisEscape: A Benchmark for Evaluating Exploration-driven Decision-making in Virtual Escape Rooms	Seungwon Lim, Sungwoong Kim, Jihwan Yu, Sungjae Lee, Jiwan Chung, Youngjae Yu	benchmarks, decision-making, virtual environments, exploration
Do Slides Help? Multi-modal Context for Automatic Transcription of Conference Talks	Supriti Sinhamahapatra, Jan Niehues	multimodal learning, automatic transcription, conference talks
ASTRA: A Negotiation Agent with Adaptive and Strategic Reasoning via Tool-integrated Action for Dynamic Offer Optimization	Deuksin Kwon, Jiwon Hae, Emma Clift, Daniel Shamsoddini, Jonathan Gratch, Gale Lucas	negotiation agents, strategic reasoning, adaptive systems
Faster In-Context Learning for LLMs via N-Gram Trie Speculative Decoding	Jinglin Chen, Qiwei Li, Zuchao Li, Baoyuan Qi, Liu Guoming, Haojun Ai, hai zhao, Ping Wang	in-context learning, large language models, decoding, n-gram trie
Thread: A Logic-Based Data Organization Paradigm for How-To Question Answering with Retrieval Augmented Generation	Kaikai An, Fangkai Yang, Liqun Li, Junting Lu, Sitao Cheng, Shuzheng Si, Lu Wang, Pu Zhao, Lele Cao, Qingwei Lin, Saravan Rajmohan, Dongmei Zhang, Baobao Chang	logic-based data organization, question answering, retrieval augmented generation
CrystalICL: Enabling In-Context Learning for Crystal Generation	Ruobing Wang, Qiaoyu Tan, Yili Wang, Ying Wang, Xin Wang	in-context learning, crystal generation
OpenTuringBench: An Open-Model-based Benchmark and Framework for Machine-Generated Text Detection and Attribution	Lucio La Cava, Andrea Tagarelli	machine-generated text, detection, attribution, benchmark
Translate Smart, not Hard: Cascaded Translation Systems with Quality-Aware Deferral	António Farinhas, Nuno M Guerreiro, Sweta Agrawal, Ricardo Rei, Andre Martins	machine translation, cascaded systems, quality-aware deferral
Leveraging Text-to-Text Transformers as Classifier Chain for Few-Shot Multi-Label Classification	Quang Anh Nguyen, Nadi Tomeh, Mustapha Lebbah, Thierry Charnois, Hanane AZZAG	text-to-text transformers, few-shot learning, multi-label classification
Artificial Impressions: Evaluating Large Language Model Behavior Through the Lens of Trait Impressions	Nicholas Deas, Kathleen McKeown	large language models, evaluation, behavior analysis
Path Drift in Large Reasoning Models: How First-Person Commitments Override Safety	Yuyi Huang	large reasoning models, safety, reasoning
DSMoE: Matrix-Partitioned Experts with Dynamic Routing for Computation-Efficient Dense LLMs	Minxuan Lv, Zhenpeng Su, Leiyu Pan, Yizhe Xiong, Zijia Lin, Hui Chen, Wei Zhou, Jungong Han, Guiguang Ding, Wenwu Ou, Di ZHANG, Kun Gai, Songlin Hu	large language models, model efficiency, dynamic routing, mixture of experts
Step-level Verifier-guided Hybrid Test-Time Scaling for Large Language Models	Kaiyan Chang, Yonghao Shi, Chenglong Wang, Hang Zhou, Chi Hu, Xiaoqian Liu, yingfeng luo, Yuan Ge, Tong Xiao, JingBo Zhu	test-time scaling, large language models, model efficiency
Retrieval over Classification: Integrating Relation Semantics for Multimodal Relation Extraction	Lei Hei, Tingjing Liao, peiyingxin, Yiyang Qi, Jiaqi Wang, Ruiting Li, Feiliang Ren	relation extraction, multimodal, retrieval, classification
An Orthogonal High-Rank Adaptation for Large Language Models	Xin Zhang, Guang-Ze Chen, Shuzhen Li, zhulin liu, C.L.Philip Chen, Tong Zhang	model adaptation, large language models, high-rank methods
Grammar Pruning: Enabling Low-Latency Zero-Shot Task-Oriented Language Models for Edge AI	Octavian Alexandru Trifan, Jason Lee Weber, Marc Titus Trifan, Alexandru Nicolau, Alexander Veidenbaum	grammar pruning, low-latency, zero-shot learning, task-oriented language models, edge AI
Detecting Legal Citations in United Kingdom Court Judgments	Holli Sargeant, Andreas Östling, Måns Magnusson	legal NLP, citation detection, court judgments
Beyond Hate Speech: NLP’s Challenges and Opportunities in Uncovering Dehumanizing Language	Hamidreza Saffari, Mohammadamin Shafiei, Hezhao Zhang, Lasana T. Harris, Nafise Sadat Moosavi	hate speech, dehumanizing language, NLP challenges
R-CHAR: A Metacognition-Driven Framework for Role-Playing in Large Language Models	Haiming Qin, Jiwei Zhang, Wei Zhang, KeZhong Lu, Mingyang Zhou, Hao Liao, Rui Mao	metacognition, role-playing, large language models
Evaluating Cognitive-Behavioral Fixation via Multimodal User Viewing Patterns on Social Media	Yujie Wang, Yunwei Zhao, Jing Yang, Han han, Shiguang Shan, Jie Zhang	evaluation, cognitive-behavioral analysis, multimodal, social media
Do It Yourself (DIY): Modifying Images for Poems in a Zero-Shot Setting Using Weighted Prompt Manipulation	Sofia Jamil, Kotla Sai Charan, Sriparna Saha, Koustava Goswami, Joseph K J	image modification, zero-shot learning, prompt manipulation
(Almost) Free Modality Stitching of Foundation Models	Jaisidh Singh, Diganta Misra, Boris Knyazev, Antonio Orvieto	foundation models, modality stitching, multi-modal
Evaluating Spatiotemporal Consistency in Automatically Generated Sewing Instructions	Luisa Geiger, Mareike Hartmann, Michael Sullivan, Alexander Koller	spatiotemporal consistency, instruction generation, multimodal data
Med-VRAgent: A Framework for Medical Visual Reasoning-Enhanced Agents	guangfu guo, Xiaoqian Lu, Yue Feng	medical visual reasoning, agents, healthcare applications
TreeRare: Syntax Tree-Guided Retrieval and Reasoning for Knowledge-Intensive Question Answering	Boyi Zhang, Zhuo Liu, Hangfeng He	syntax trees, retrieval, reasoning, question answering
VisiPruner: Decoding Discontinuous Cross-Modal Dynamics for Efficient Multimodal LLMs	Yingqi Fan, Anhao Zhao, Jinlan Fu, Junlong Tong, Hui Su, Yijie Pan, Wei Zhang, Xiaoyu Shen	cross-modal dynamics, multimodal models, model efficiency
ThinkEdit: Interpretable Weight Editing to Mitigate Overly Short Thinking in Reasoning Models	Chung-En Sun, Ge Yan, Tsui-Wei Weng	interpretable weight editing, reasoning models, model editing, interpretability
RoDEval: A Robust Word Sense Disambiguation Evaluation Framework for Large Language Models	Luyang Zhang, Shuaimin Li, Yishuo Li, Kunpeng Kang, Kaiyuan Zhang, Cong Wang, Wenpeng Lu	word sense disambiguation, evaluation framework, large language models, robustness
Bias Mitigation or Cultural Commonsense? Evaluating LLMs with a Japanese Dataset	Taisei Yamamoto, Ryoma Kumon, Danushka Bollegala, Hitomi Yanaka	bias mitigation, cultural commonsense, evaluation, large language models, Japanese dataset
SMART: Simulated Students Aligned with Item Response Theory for Question Difficulty Prediction	Alexander Scarlatos, Nigel Fernandez, Christopher Ormerod, Susan Lottridge, Andrew Lan	student simulation, item response theory, question difficulty prediction
ReSeeding Latent States for Sequential Language Understanding	Stéphane Aroca-Ouellette, Katharina von der Wense, Alessandro Roncone	sequential language understanding, latent states
Proactive Hearing Assistants that Isolate Egocentric Conversations	Guilin Hu, Malek Itani, Tuochao Chen, Shyamnath Gollakota	hearing assistants, egocentric conversations, proactive systems
Forget What You Know about LLMs Evaluations - LLMs are Like a Chameleon	Nurit Cohen Inger, Yehonatan Elisha, Bracha Shapira, Lior Rokach, Seffi Cohen	large language models, evaluation, robustness, adaptability
Does Localization Inform Unlearning? A Rigorous Examination of Local Parameter Attribution for Knowledge Unlearning in Language Models	Hwiyeong Lee, Uiji Hwang, Hyelim Lim, Taeuk Kim	large language models, knowledge unlearning, parameter attribution, model interpretability
The Ranking Blind Spot: Decision Hijacking in LLM-based Text Ranking	Yaoyao Qian, Yifan Zeng, Yuchao Jiang, Chelsi Jain, Huazheng Wang	large language models, text ranking, decision hijacking, information retrieval
Unsupervised Hallucination Detection by Inspecting Reasoning Processes	Ponhvoan Srey, Xiaobao Wu, Anh Tuan Luu	hallucination detection, unsupervised learning, reasoning processes
Aspect-Oriented Summarization for Psychiatric Short-Term Readmission Prediction	WonJin Yoon, Boyu Ren, Spencer Thomas, Chanhwi Kim, Guergana K Savova, Mei-Hua Hall, Timothy A. Miller	summarization, psychiatric prediction, healthcare, clinical NLP
Scaling Up Temporal Domain Generalization via Temporal Experts Averaging	Aoming Liu, Kevin Miller, Venkatesh Saligrama, Kate Saenko, Boqing Gong, Ser-Nam Lim, Bryan A. Plummer	domain generalization, temporal models, averaging, machine learning
LLMs are Better Than You Think: Label-Guided In-Context Learning for Named Entity Recognition	Fan Bai, Hamid Hassanzadeh, Ardavan Saeedi, Mark Dredze	large language models, in-context learning, named entity recognition
Beyond Static Testbeds: An Interaction-Centric Agent Simulation Platform for Dynamic Recommender Systems	Song Jin, Juntian Zhang, Yuhan Liu, Xun Zhang, Yufei zhang, Guojun Yin, Fei Jiang, Wei Lin, Rui Yan	recommender systems, agent simulation, interaction, dynamic systems
Anecdoctoring: Automated Red-Teaming Across Language and Place	Alejandro Cuevas, Saloni Dash, Dan Vann, Madeleine I. G. Daepp	automated red-teaming, language, robustness, security
Multi-Document Event Extraction Using Large and Small Language Models	Qingkai Min, Zitian Qu, Qipeng Guo, Xiangkun Hu, Zheng Zhang, Yue Zhang	event extraction, multi-document, large language models, small language models
DCR: Quantifying Data Contamination in LLMs Evaluation	Cheng Xu, Nan Yan, Shuhao Guan, Changhong Jin, Yuke Mei, Yibing Guo, Tahar Kechadi	large language models, evaluation, data contamination
KCS: Diversify Multi-hop Question Generation with Knowledge Composition Sampling	Yangfan Wang, Jie Liu, Chen Tang, Lian Yan, Jingchi Jiang	question generation, multi-hop reasoning, knowledge composition
CodeRAG: Finding Relevant and Necessary Knowledge for Retrieval-Augmented Repository-Level Code Completion	Sheng Zhang, Yifan Ding, Shuquan Lian, Shun Song, Hui Li	code completion, retrieval-augmented models, knowledge retrieval
Discourse-Driven Code-Switching: Analyzing the Role of Content and Communicative Function in Spanish-English Bilingual Speech	Debasmita Bhattacharya, Juan Junco, Divya Tadimeti, Julia Hirschberg	code-switching, bilingual speech, discourse analysis
Can Prompts Rewind Time for LLMs? Evaluating the Effectiveness of Prompted Knowledge Cutoffs	Xin Gao, Ruiyi Zhang, Sai Ashish Somayajula, Daniel Du, Saurabh Mahindre, Pengtao Xie	large language models, prompting, knowledge cutoff, evaluation
Distribution Prompting: Understanding the Expressivity of Language Models Through the Next-Token Distributions They Can Produce	Haojin Wang, Zining Zhu, Freda Shi	language models, prompting, expressivity, next-token distribution
Studying the Role of Input-Neighbor Overlap in Retrieval-Augmented Language Models Training Efficiency	Ehsan Doostmohammadi, Marco Kuhlmann	retrieval-augmented language models, training efficiency
Shared Path: Unraveling Memorization in Multilingual LLMs through Language Similarities	Xiaoyu Luo, Yiyi Chen, Johannes Bjerva, Qiongxiu Li	large language models, multilingual, memorization, language similarities
Intrinsic Test of Unlearning Using Parametric Knowledge Traces	Yihuai Hong, Lei Yu, Haiqin Yang, Shauli Ravfogel, Mor Geva	unlearning, parametric knowledge, evaluation
Beyond the Score: Uncertainty-Calibrated LLMs for Automated Essay Assessment	Ahmed Karim, Zheng Yuan, Qiao Wang	large language models, uncertainty calibration, automated essay assessment
Towards a Unified Paradigm of Concept Editing in Large Language Models	Zhuowen Han, Xinwei Wu, Dan Shi, Renren Jin, Deyi Xiong	concept editing, large language models, model interpretability
Group-SAE: Efficient Training of Sparse Autoencoders for Large Language Models via Layer Groups	Davide Ghilardi, Federico Belotti, Marco Molinari, Tao Ma, Matteo Palmonari	sparse autoencoders, large language models, efficient training
On Pruning State-Space LLMs	Tamer Ghattas, Michael Hassid, Roy Schwartz	model pruning, state-space models, large language models
ReviewRL: Towards Automated Scientific Review with RL	Sihang Zeng, Kai Tian, Kaiyan Zhang, Yuru wang, Junqi Gao, Runze Liu, Sa Yang, Jingxuan Li, Xinwei Long, Jiaheng Ma, Biqing Qi, Bowen Zhou	automated review, reinforcement learning, scientific review, evaluation
Incorporating Diverse Perspectives in Cultural Alignment: Survey of Evaluation Benchmarks Through A Three-Dimensional Framework	Meng-Chen Wu, Si-Chi Chin, Tess Wood, Ayush Goyal, Narayanan Sadagopan	cultural alignment, evaluation benchmarks, survey, diversity, fairness
Chameleon LLMs: User Personas Influence Chatbot Personality Shifts	Jane Xing, Tianyi Niu, Shashank Srivastava	chatbots, user personas, personality shifts, large language models
ALLabel: Three-stage Active Learning for LLM-based Entity Recognition using Demonstration Retrieval	Zihan Chen, Lei Shi, Weize Wu, Qiji Zhou, Yue Zhang	active learning, entity recognition, large language models, demonstration retrieval
Social Good or Scientific Curiosity? Uncovering the Research Framing Behind NLP Artefacts	Eric Chamoun, Nedjma Ousidhoum, Michael Sejr Schlichtkrull, Andreas Vlachos	research framing, nlp artefacts, social good, scientific curiosity
Interpretable Mnemonic Generation for Kanji Learning via Expectation-Maximization	Jaewook Lee, Alexander Scarlatos, Andrew Lan	mnemonic generation, kanji learning, expectation-maximization
Continuous-Time Attention: PDE-Guided Mechanisms for Long-Sequence Transformers	Yukun Zhang, Xueqing Zhou	transformers, long-sequence modeling, attention mechanisms, continuous-time models
ArgCMV: An Argument Summarization Benchmark for the LLM-era	Omkar Gurjar, Agam Goyal, Eshwar Chandrasekharan	argument summarization, benchmarks, large language models
Understanding and Leveraging the Expert Specialization of Context Faithfulness in Mixture-of-Experts LLMs	Jun Bai, Minghao Tong, Yang Liu, Zixia Jia, Zilong Zheng	mixture-of-experts, large language models, context faithfulness, expert specialization
One Planner To Guide Them All ! Learning Adaptive Conversational Planners for Goal-oriented Dialogues	Huy Quang Dao, Lizi Liao	conversational planners, goal-oriented dialogue, adaptive learning
Adapting Bias Evaluation to Domain Contexts using Generative Models	Tamara Quiroga, Felipe Bravo-Marquez, Valentin Barriere	bias evaluation, generative models, domain adaptation, fairness
Leveraging What’s Overfixed: Post-Correction via LLM Grammatical Error Overcorrection	Taehee Park, Heejin Do, Gary Lee	large language models, grammatical error correction, post-correction
Unsupervised Concept Vector Extraction for Bias Control in LLMs	Hannah Cyberey, Yangfeng Ji, David Evans	bias control, large language models, unsupervised learning
OG-RAG: Ontology-grounded retrieval-augmented generation for large language models	Ashmari Pramodya, Nirasha Nelki, Heshan Shalinda, Chamila Liyanage, Yusuke Sakai, Randil Pushpananda, Ruvan Weerasinghe, Hidetaka Kamigaito, Taro Watanabe	ontology-grounded retrieval, retrieval-augmented generation, large language models
Women, Infamous, and Exotic Beings: A Comparative Study of Honorific Usages in Wikipedia and LLMs for Bengali and Hindi	Sourabrata Mukherjee, Atharva Mehta, Sougata Saha, Akhil Arora, Monojit Choudhury	honorific usages, comparative study, Bengali language, Hindi language, large language models
Enhancing Speech Large Language Models with Prompt-Aware Mixture of Audio Encoders	Weiqiao Shan, Yuang Li, Yuhao Zhang, yingfeng luo, Chen Xu, Xiaofeng Zhao, Long Meng, Yunfei Lu, Min Zhang, Hao Yang, Tong Xiao, JingBo Zhu	speech, large language models, audio encoders, prompt-aware models
Surprise Calibration for Better In-Context Learning	Zhihang Tan, Jingrui Hou, Ping Wang, Qibiao Hu, Peng Zhu	in-context learning, calibration, large language models
Disentangled Information Bottleneck for Adversarial Text Defense	Yidan Xu, Xinghao Yang, Wei Liu, Bao-di Liu, Weifeng Liu	adversarial defense, text classification, information bottleneck
Toward Machine Interpreting: Lessons from Human Interpreting Studies	Matthias Sperber, Maureen de Seyssel, Jiajun Bao, Matthias Paulik	machine interpreting, human studies, speech translation
ClimateViz: A Benchmark for Statistical Reasoning and Fact Verification on Scientific Charts	Ruiran Su, Jiasheng Si, Zhijiang Guo, Janet B. Pierrehumbert	benchmarks, statistical reasoning, fact verification, scientific charts
LogicTree: Structured Proof Exploration for Coherent and Rigorous Logical Reasoning with Large Language Models	Kang He, Kaushik Roy	logical reasoning, large language models, structured proof, exploration
Tool Preferences in Agentic LLMs are Unreliable	Kazem Faghih, Wenxiao Wang, Yize Cheng, Siddhant Bharti, Gaurang Sriramanan, Sriram Balasubramanian, Parsa Hosseini, Soheil Feizi	large language models, agentic models, tool use, reliability
Step Guided Reasoning: Improving Mathematical Reasoning using Guidance Generation and Step Reasoning	Lang Cao, Yingtian Zou, Chao Peng, Renhong Chen, Wu Ning, Yitong Li	mathematical reasoning, guided reasoning, step reasoning, generation
Zero-shot Multimodal Document Retrieval via Cross-modal Question Generation	Huaqin Zhao, Jiaxi Li, Yi Pan, Shizhe Liang, Xiaofeng Yang, Fei Dou, Tianming Liu, Jin Lu	zero-shot learning, multimodal retrieval, cross-modal, question generation
DiMo-GUI: Advancing Test-time Scaling in GUI Grounding via Modality-Aware Visual Reasoning	Hanqing Li, Diego Klabjan	test-time scaling, GUI grounding, visual reasoning, multimodal
Decoding Dense Embeddings: Sparse Autoencoders for Interpreting and Discretizing Dense Retrieval	Yu Sun, Xingyu Qian, Weiwen Xu, Hao Zhang, Chenghao Xiao, Long Li, Yu Rong, Wenbing Huang, Qifeng Bai, Tingyang Xu	dense embeddings, sparse autoencoders, dense retrieval, interpretation
LLM-Driven Completeness and Consistency Evaluation for Cultural Heritage Data Augmentation in Cross-Modal Retrieval	Jian Zhang, Junyi Guo, Junyi Yuan, Huanda Lu, Yanlin Zhou, Fangyu Wu, Qiufeng Wang, Dongming Lu	large language models, evaluation, cultural heritage, data augmentation, cross-modal retrieval
VocalNet: Speech LLMs with Multi-Token Prediction for Faster and High-Quality Generation	Yuhao Wang, Heyang Liu, Ziyang Cheng, Ronghua Wu, Qunshan Gu, Yanfeng Wang, Yu Wang	speech, large language models, multi-token prediction, generation
Who Holds the Pen? Caricature and Perspective in LLM Retellings of History	Lubna Zahan Lamia, Mabsur Fatin Bin Hossain, Md Mosaddek Khan	large language models, history, narrative perspective
Benchmarking Debiasing Methods for LLM-based Parameter Estimates	Nicolas Audinet de Pieuchon, Adel Daoud, Connor Thomas Jerzak, Moa Johansson, Richard Johansson	large language models, debiasing, parameter estimation
RRInf: Efficient Influence Function Estimation via Ridge Regression for Large Language Models and Text-to-Image Diffusion Models	Zhuozhuo Tu, Cheng Chen, Yuxuan Du	influence function estimation, ridge regression, large language models, text-to-image diffusion
TrojanWave: Exploiting Prompt Learning for Stealthy Backdoor Attacks on Large Audio-Language Models	Asif Hanif, Maha Tufail Agro, Fahad Shamshad, Karthik Nandakumar	backdoor attacks, prompt learning, audio-language models, security
Mapping Toxic Comments Across Demographics: A Dataset from German Public Broadcasting	Jan Fillies, Michael Peter Hoffmann, Rebecca Reichel, Roman Salzwedel, Sven Bodemer, Adrian Paschke	toxic comments, demographics, dataset, social media analysis
Convergence and Divergence of Language Models under Different Random Seeds	Kartik Sharma, Peeyush Kumar, Yunqing Li	language models, random seeds, convergence, divergence
Stepwise Reasoning Checkpoint Analysis: A Test Time Scaling Method to Enhance LLMs’ Reasoning	Zezhong WANG, Xingshan Zeng, Weiwen Liu, Yufei Wang, Liangyou Li, Yasheng Wang, Lifeng Shang, Xin Jiang, Qun Liu, Kam-Fai Wong	stepwise reasoning, checkpoint analysis, test time scaling, large language models, reasoning enhancement
Media Source Matters More Than Content: Unveiling Political Bias in LLM-Generated Citations	Sunhao Dai, Zhanshuo Cao, Wenjie Wang, Liang Pang, Jun Xu, See-Kiong Ng, Tat-Seng Chua	political bias, citations, large language models, media source
HESEIA: A community-based dataset for evaluating social biases in large language models, co-designed in real school settings in Latin America	Guido Ivetta, Marcos J Gomez, Sofía Martinelli, Pietro Palombini, M Emilia Echeveste, Nair Carolina Mazzeo, Beatriz Busaniche, Luciana Benotti	dataset, social biases, large language models, education, community-based
Morpheme Induction for Emergent Language	Brendon Boldt, David R. Mortensen	morpheme induction, emergent language
Refining Attention for Explainable and Noise-Robust Fact-Checking with Transformers	Jean-Flavien Bussotti, Paolo Papotti	attention refinement, explainability, noise robustness, fact-checking, transformers
RD-MCSA: A Multi-Class Sentiment Analysis Approach Integrating In-Context Classification Rationales and Demonstrations	Haihua Xie, Yinzhu Cheng, Yaqing Wang, Miao He, Mingming Sun	sentiment analysis, multi-class classification, in-context learning, rationales
Mitigating Catastrophic Forgetting in Large Language Models with Forgetting-aware Pruning	Wei Huang, Anda Cheng, Yinggui Wang	large language models, catastrophic forgetting, pruning, model compression
HMoE: Heterogeneous Mixture of Experts for Language Modeling	An Wang, Xingwu Sun, Ruobing Xie, Shuaipeng Li, Jiaqi Zhu, Zhen Yang, Pinxue Zhao, Weidong Han, Zhanhui Kang, Di Wang, Naoaki Okazaki, Cheng-zhong Xu	heterogeneous mixture of experts, language modeling, large language models
Comprehensive and Efficient Distillation for Lightweight Sentiment Analysis Models	Guangyu Xie, Yice Zhang, Jianzhu Bao, Qianlong Wang, Yang Sun, Bingbing Wang, Ruifeng Xu	model distillation, sentiment analysis, lightweight models, efficiency
Do RAG Systems Really Suffer From Positional Bias?	Florin Cuconasu, Simone Filice, Guy Horowitz, Yoelle Maarek, Fabrizio Silvestri	retrieval-augmented generation, positional bias, evaluation
Improving Large Language Model Safety with Contrastive Representation Learning	Samuel Simko, Mrinmaya Sachan, Bernhard Schölkopf, Zhijing Jin	large language models, safety, contrastive learning, representation learning
Investigating the interaction of linguistic and mathematical reasoning in language models using multilingual number puzzles	Antara Raaghavi Bhattacharya, Isabel Papadimitriou, Kathryn Davidson, David Alvarez-Melis	language models, linguistic reasoning, mathematical reasoning, multilingual
AMQ: Enabling AutoML for Mixed-precision Weight-Only Quantization of Large Language Models	Sangjun Lee, Seung-taek Woo, Jun-gyu Jin, Changhun Lee, Eunhyeok Park	automl, model quantization, large language models, efficiency
ACING: Actor-Critic for Instruction Learning in Black-Box LLMs	Salma Kharrat, Fares Fourati, Marco Canini	instruction learning, actor-critic, black-box large language models
E2LLM: Encoder Elongated Large Language Models for Long-Context Understanding and Reasoning	Zihan Liao, Jun Wang, Hang Yu, Lingxiao Wei, Jianguo Li, Jun Wang, Wei Zhang	large language models, long-context understanding, reasoning, encoder models
Mind the Blind Spots: A Focus-Level Evaluation Framework for LLM Reviews	Hyungyu Shin, Jingyu Tang, Yoonjoo Lee, Nayoung Kim, Hyunseung Lim, Ji Yong Cho, Hwajung Hong, Moontae Lee, Juho Kim	evaluation, large language models, review analysis
Can Large Language Models Translate Unseen Languages in Underrepresented Scripts?	Dianqing Lin, Aruukhan, Hongxu Hou, shuo sun, Wei Chen, Yichen Yang, Guo dong Shi	large language models, machine translation, low-resource languages, scripts
Does Context Matter? A Prosodic Comparison of English and Spanish in Monolingual and Multilingual Discourse Settings	Debasmita Bhattacharya, David Sasu, Michela Marchini, Natalie Schluter, Julia Hirschberg	prosody, multilingual discourse, English, Spanish
What You See is What You Ask: Evaluating Audio Descriptions	Divy Kala, Eshika Khandelwal, Makarand Tapaswi	audio description, evaluation, multimodal
SOLAR: Towards Characterizing Subjectivity of Individuals through Modeling Value Conflicts and Trade-offs	Younghun Lee, Dan Goldwasser	subjectivity analysis, value conflicts, modeling, trade-offs
MultiDocFusion : Hierarchical and Multimodal Chunking Pipeline for Enhanced RAG on Long Industrial Documents	Joong Min Shin, Chanjun Park, Jeongbae Park, Jaehyung Seo, Heuiseok Lim	multimodal learning, hierarchical chunking, retrieval-augmented generation, long documents, industrial domain
STRICT: Stress-Test of Rendering Image Containing Text	Tianyu Zhang, Xinyu Wang, Zhenghan Tai, Lu Li, Jijun Chi, Jingrui Tian, Hailin He, Suyuchen Wang	image rendering, stress testing, text in images
Dynamic Expert Specialization: Towards Catastrophic Forgetting-Free Multi-Domain MoE Adaptation	Junzhuo Li, Bo Wang, Xiuze Zhou, Xuming Hu	mixture of experts, catastrophic forgetting, multi-domain adaptation
FacLens: Transferable Probe for Foreseeing Non-Factuality in Fact-Seeking Question Answering of Large Language Models	Yanling Wang, Haoyang Li, Hao Zou, Jing Zhang, Xinlei He, Qi Li, Ke Xu	fact-checking, question answering, large language models, non-factuality detection
UltraIF: Advancing Instruction Following from the Wild	Kaikai An, Li Sheng, Ganqu Cui, Shuzheng Si, Ning Ding, Yu Cheng, Baobao Chang	instruction following, large language models, robustness
Debatable Intelligence: Benchmarking LLM Judges via Debate Speech Evaluation	Noy Sternlicht, Ariel Gera, Roy Bar-Haim, Tom Hope, Noam Slonim	benchmarking, debate evaluation, large language models
Calibrating LLMs for Text-to-SQL Parsing by Leveraging Sub-clause Frequencies	Terrance Liu, Shuyi Wang, Daniel Preotiuc-Pietro, Yash Chandarana, Chirag Gupta	large language models, text-to-SQL parsing, calibration, sub-clause frequencies
Governance in Motion: Co-evolution of Constitutions and AI models for Scalable Safety	Chenhao Huang, Ziyu Shen, Yicong Ren, Huiyuan Zheng, Jiazheng Zhang, Mingxu Chai, Ming Zhang, Shihan Dou, Fan Mo, Jie Shi, Tao Gui, Qi Zhang, Xuanjing Huang	governance, AI models, co-evolution, scalable safety, constitutions
GuessingGame: Measuring the Informativeness of Open-Ended Questions in Large Language Models	Dylan Hutson, Daniel Vennemeyer, Aneesh Deshmukh, Justin Zhan, Tianyu Jiang	open-ended questions, informativeness, large language models, evaluation
WebMMU: A Benchmark for Multimodal Multilingual Website Understanding and Code Generation	Rabiul Awal, Mahsa Massoud, Aarash Feizi, Zichao Li, Suyuchen Wang, Christopher Pal, Aishwarya Agrawal, David Vazquez, Siva Reddy, Juan A. Rodriguez, Perouz Taslakian, Spandana Gella, Sai Rajeswar	benchmark, multimodal, multilingual, website understanding, code generation
Identifying & Interactively Refining Ambiguous User Goals for Data Visualization Code Generation	Mert Inan, Anthony Sicilia, Alex Xie, Saujas Vaduguru, Daniel Fried, Malihe Alikhani	user goals, data visualization, code generation, interactive refinement
SafeKey: Amplifying Aha-Moment Insights for Safety Reasoning	Kaiwen Zhou, Xuandong Zhao, Jayanth Srinivasa, Gaowen Liu, Aosong Feng, Dawn Song, Xin Eric Wang	safety reasoning, aha-moment insights, amplification
Pathway to Relevance: How Cross-Encoders Implement a Semantic Variant of BM25	Meng Lu, Catherine Chen, Carsten Eickhoff	cross-encoders, semantic search, bm25 variant
CREPE: Rapid Chest X-ray Report Evaluation by Predicting Multi-category Error Counts	Gihun Cho, Seunghyun Jang, Hanbin Ko, Inhyeok Baek, Chang Min Park	medical, chest x-ray, report evaluation, error prediction
RICO: Improving Accuracy and Completeness in Image Recaptioning via Visual Reconstruction	Yuchi Wang, Yishuo Cai, Shuhuai Ren, Sihan Yang, Linli Yao, Yuanxin Liu, Yuanxing Zhang, Pengfei Wan, Xu Sun	image captioning, visual reconstruction, multimodal, image understanding
Joint Modeling of Entities and Discourse Relations for Coherence Assessment	Wei Liu, Michael Strube	coherence assessment, discourse relations, entity modeling, text coherence
Data-Efficient Selection via Grammatical Complexity in Continual Pre-training of Domain-Specific LLMs	Yizhou Ying, Geng Zhang, Cui Danxin, Chengyu Du, Guanglei Yue, Sihang Jiang, Jiaqing Liang, Yifei Fu, Hailin Hu, Yanghua Xiao	continual pre-training, domain-specific language models, grammatical complexity, data efficiency
Emergent morpho-phonological representations in self-supervised speech models	Jon Gauthier, Canaan Breiss, Matthew K Leonard, Edward F. Chang	self-supervised learning, speech models, morpho-phonology, representation learning
LinguaLens: Towards Interpreting Linguistic Mechanisms of Large Language Models via Sparse Auto-Encoder	Yi Jing, Zijun Yao, Hongzhu Guo, Lingxu Ran, Xiaozhi Wang, Lei Hou, Juanzi Li	large language models, interpretability, linguistic mechanisms, auto-encoder
Seeing the Same Story Differently: Framing‑Divergent Event Coreference for Computational Framing Analysis	Jin Zhao, Xinrui Hu, Nianwen Xue	event coreference, computational framing, framing analysis
SheetDesigner: MLLM-Powered Spreadsheet Layout Generation with Rule-Based and Vision-Based Reflection	Qin Chen, Yuanyi Ren, Xiaojun Ma, Mugeng Liu, Shi Han, Dongmei Zhang	multimodal large language models, spreadsheet layout, rule-based systems, vision-based systems
ExpandR: Teaching Dense Retrievers Beyond Queries with LLM Guidance	Sijia Yao, Pengcheng Huang, Zhenghao Liu, Yu Gu, Yukun Yan, Shi Yu, Ge Yu	dense retrieval, large language models, query expansion, information retrieval
DivScore: Zero-Shot Detection of LLM-Generated Text in Specialized Domains	Zhihui Chen, Kai He, Yucheng Huang, Yunxiao Zhu, Mengling Feng	zero-shot detection, large language models, generated text, specialized domains
Building Trust in Clinical LLMs: Bias Analysis and Dataset Transparency	Svetlana Maslenkova, Clement Christophe, Marco AF Pimentel, Tathagata Raha, Muhammad Umar Salman, Ahmed Al Mahrooqi, Avani Gupta, Shadab Khan, Ronnie Rajan, Praveenkumar Kanithi	clinical, large language models, bias, dataset transparency
Fooling the LVLM Judges: Visual Biases in LVLM-Based Evaluation	Yerin Hwang, Dongryeol Lee, Kyungmin Min, taegwan kang, Yongil Kim, Kyomin Jung	large vision-language models, evaluation, visual bias
ZERA: Zero-init Instruction Evolving Refinement Agent – From Zero Instructions to Structured Prompts via Principle-based Optimization	Seungyoun Yi, Minsoo Khang, Sungrae Park	instruction tuning, prompt engineering, optimization
Investigating How Pre-training Data Leakage Affects Models’ Reproduction and Detection Capabilities	Masahiro Kaneko, Timothy Baldwin	pre-training, data leakage, model reproduction, detection
Unmasking Fake Careers: Detecting Machine-Generated Career Trajectories via Multi-layer Heterogeneous Graphs	Michiharu Yamashita, Thanh Tran, Delvin Ce Zhang, Dongwon Lee	machine-generated text, career trajectories, graph-based detection, heterogeneous graphs
EIFBENCH: Extremely Complex Instruction Following Benchmark for Large Language Models	Tao Zou, Xinghua Zhang, Haiyang Yu, Minzheng Wang, Fei Huang, Yongbin Li	large language models, benchmarks, instruction following, complex instructions
The Emperor’s New Reasoning: Format Imitation Overshadows Genuine Mathematical Understanding in SFT	Linyao Yang, Jian-Tao Huang, Yafei Lu, Zhenhui Jessie Li, Guirong Xue	mathematical reasoning, format imitation, supervised fine-tuning
HELENE: Hessian Layer-wise Clipping and Gradient Annealing for Accelerating Fine-tuning LLM with Zeroth-order Optimization	heng Yu, Zhe Hu, Haoyu Xie, Guoqi Yu, Lei Shang, Shujun Wang	large language models, optimization, fine-tuning, zeroth-order optimization
The Stepwise Deception: Simulating the Evolution from True News to Fake News with LLM Agents	Chenxu Yang, Ruipeng Jia, Mingyu Zheng, Naibin Gu, Zheng Lin, Siyuan Chen, Weichong Yin, Hua Wu, Weiping Wang	large language models, fake news, simulation, misinformation
Identifying Pre-training Data in LLMs: A Neuron Activation-Based Detection Framework	HONGYI TANG, Zhihao Zhu, Yi Yang	pre-training data detection, neuron activation, large language models
METok: Multi-Stage Event-based Token Compression for Efficient Long Video Understanding	Mengyue Wang, Shuo Chen, Kristian Kersting, Volker Tresp, Yunpu Ma	token compression, long video understanding, event-based methods
REACT: Representation Extraction And Controllable Tuning to Overcome Overfitting in LLM Knowledge Editing	Haitian Zhong, Yuhuan Liu, Ziyang Xu, Guofan Liu, Qiang Liu, Shu Wu, Zhe Zhao, Liang Wang, Tieniu Tan	representation extraction, controllable tuning, overfitting, knowledge editing, large language models
Are Large Language Models Chronically Online Surfers? A Dataset for Chinese Internet Meme Explanation	Yubo Xie, Chenkai Wang, Zongyang Ma, Fahui Miao	large language models, dataset, internet memes, Chinese, explanation
Web Intellectual Property at Risk: Preventing Unauthorized Real-Time Retrieval by Large Language Models	Yisheng Zhong, Yizhu Wen, Junfeng Guo, Mehran Kafai, Heng Huang, Hanqing Guo, Zhuangdi Zhu	intellectual property, real-time retrieval, large language models, security
Analyzing and Modeling LLM Response Lengths with Extreme Value Theory: Anchoring Effects and Hybrid Distributions	Finlay Fehlauer, Kyle Mahowald, Tiago Pimentel	large language models, response length modeling, extreme value theory
LLaMP: Large Language Model Made Powerful for High-fidelity Materials Knowledge Retrieval	Yuan Chiang, Elvis Hsieh, Chia-Hong Chou, Janosh Riebesell	large language models, materials knowledge retrieval, high-fidelity
Stepwise Informativeness Search for Improving LLM Reasoning	Siyuan Wang, Enda Zhao, Xiang Ren	informative search, large language models, reasoning
HypER: Literature-grounded Hypothesis Generation and Distillation with Provenance	Rosni Vasu, Chandrayee Basu, Bhavana Dalvi Mishra, Cristina Sarasua, Peter Clark, Abraham Bernstein	hypothesis generation, literature grounding, distillation, provenance
Rewarding the Unlikely: Lifting GRPO Beyond Distribution Sharpening	Andre Wang He, Daniel Fried, Sean Welleck	reinforcement learning, distribution sharpening, grpo
TIDES: Technical Information Discovery and Extraction System	Jihee Kim, Subeen Park, Hakyung Lee, YongTaek Lim, Hyo-won Suh, Kyungwoo Song	information extraction, technical domain, system development
Dynamic Model-Bank Test-Time Adaptation for Automatic Speech Recognition	Yanshuo Wang, Yanghao Zhou, Yukang Lin, Haoxing Chen, Jin Zhang, Wentao Zhu, Jie Hong, Xuesong Li	automatic speech recognition, test-time adaptation, dynamic models
Uniform Information Density and Syntactic Reduction: Revisiting that-Mentioning in English Complement Clauses	Hailin Hao, Elsi Kaiser	syntax, information density, syntactic reduction, linguistics
Synth-SBDH: A Synthetic Dataset of Social and Behavioral Determinants of Health for Clinical Text	Avijit Mitra, Zhichao Yang, Emily Druhl, Raelene Goodwin, hong yu	dataset, social determinants of health, clinical text, synthetic data
IntentionFrame: A Semi-Structured, Multi-Aspect Framework for Fine-Grained Conversational Intention Understanding	Jinggui Liang, Dung Vo, Lizi Liao	conversational intention, dialogue systems, framework, fine-grained understanding
Improving the Quality of Web-mined Parallel Corpora of Low-Resource Languages using Debiasing Heuristics	Surangika Ranathunga, Aloka Fernando, Menan Velayuthan, Charitha Rathnayaka, Nisansa de Silva	parallel corpora, low-resource languages, debiasing, data quality
SimpleDoc: Multi‑Modal Document Understanding with Dual‑Cue Page Retrieval and Iterative Refinement	Chelsi Jain, Yiran Wu, Yifan Zeng, Jiale Liu, Shengyu Dai, Zhenwen Shao, Qingyun Wu, Huazheng Wang	document understanding, multimodal, page retrieval, iterative refinement
ReSURE: Regularizing Supervision Unreliability for Multi-turn Dialogue Fine-tuning	Yiming Du, Yifan Xiang, Bin Liang, Dahua Lin, Kam-Fai Wong, Fei Tan	dialogue systems, multi-turn dialogue, fine-tuning, supervision regularization
Process-Supervised Reward Models for Verifying Clinical Note Generation: A Scalable Approach Guided by Domain Expertise	Hanyin Wang, Chufan Gao, Qiping Xu, Bolun Liu, Guleid Hussein, Hariprasad Reddy Korsapati, Mohamad El Labban, Kingsley Iheasirim, Mohamed Hassan, Gokhan Anil, Brian Bartlett, Jimeng Sun	clinical note generation, reward models, process supervision, domain expertise
CIKT: A Collaborative and Iterative Knowledge Tracing Framework with Large Language Models	Runze Li, siyu wu, Jun Wang, Wei Zhang	knowledge tracing, large language models, collaborative learning, iterative learning
SPARK: Simulating the Co-evolution of Stance and Topic Dynamics in Online Discourse with LLM-based Agents	Bowen Zhang, Yi Yang, Fuqiang Niu, Xianghua Fu, Genan Dai, Hu Huang	stance detection, topic dynamics, online discourse, large language models, simulation
Enhancing LLM-Based Social Bot via an Adversarial Learning Framework	Fanqi Kong, Xiaoyuan Zhang, Xinyu Chen, Yaodong Yang, Song-Chun Zhu, Xue Feng	large language models, social bots, adversarial learning
FLARE: Faithful Logic-Aided Reasoning and Exploration	Erik Arakelyan, Pasquale Minervini, Patrick Lewis, Pat Verga, Isabelle Augenstein	reasoning, logic, exploration, large language models
Bridging the Gap Between Molecule and Textual Descriptions via Substructure-aware Alignment	Hyuntae Park, Yeachan Kim, SangKeun Lee	molecule-text alignment, substructure-aware alignment, multimodal
Metric Calculating Benchmark: Code-Verifiable Complicate Instruction Following Benchmark for Large Language Models	Hyeonseok Moon, Seongtae Hong, Jaehyung Seo, Heuiseok Lim	large language models, benchmarks, instruction following, code verification
Enhancing Large Language Model for Knowledge Graph Completion via Structure-Aware Alignment-Tuning	Yu Liu, Yanan Cao, Xixun Lin, Yanmin Shang, Shi Wang, Shirui Pan	large language models, knowledge graph completion, alignment tuning, structure-aware methods
Flexibly Utilize Memory for Long-Term Conversation via a Fragment-then-Compose Framework	Cai Ke, Yiming Du, Bin Liang, Yifan Xiang, Lin Gui, Zhongyang Li, Baojun Wang, Yue Yu, Hui Wang, Kam-Fai Wong, Ruifeng Xu	long-term conversation, memory utilization, dialogue systems, fragment-then-compose
Logical Reasoning with Outcome Reward Models for Test-Time Scaling	Suqing Wang, Zuchao Li, Shi Luohe, Bo Du, hai zhao, Yun Li, Qianren Wang	logical reasoning, reward models, test-time scaling
SMEC:Rethinking Matryoshka Representation Learning for Retrieval Embedding Compression	Kangtao Lv, Haibin Chen, Yujin Yuan, Langming Liu, Shilei Liu, Yongwei Wang, Wenbo Su, Bo Zheng	representation learning, embedding compression, retrieval
FedMABench: Benchmarking Mobile GUI Agents on Decentralized Heterogeneous User Data	Zhihao Jia, Mingyi Jia, Junwen Duan, Jianxin Wang	benchmarking, mobile GUI agents, decentralized data, heterogeneous data
BSFA: Leveraging the Subspace Dichotomy to Accelerate Neural Network Training	WenJie Zhou, Bohan Wang, Wei Chen, Xueqi Cheng	neural network training, subspace methods, acceleration
Fair or Framed? Political Bias in News Articles Generated by LLMs	Junho Yoo	political bias, news articles, large language models, fairness
Inter-sentence Context Modeling and Structure-aware Representation Enhancement for Conversational Sentiment Quadruple Extraction	Yu Zhang, Zhaoman Zhong, Huihui LV	conversational sentiment analysis, context modeling, structure-aware representation, sentiment quadruple extraction
SciEvent: Benchmarking Multi-domain Scientific Event Extraction	Bofu Dong, Pritesh Shah, Sumedh Sonawane, Tiyasha Banerjee, Erin Brady, Xinya Du, Ming Jiang	scientific event extraction, multi-domain, benchmarking, information extraction
Analyzing values about gendered language reform in LLMs’ revisions	Jules Watson, Xi Wang, Raymond Liu, Suzanne Stevenson, Barend Beekhuizen	gendered language, language reform, large language models, analysis
FairGen: Controlling Sensitive Attributes for Fair Generations in Diffusion Models via Adaptive Latent Guidance	Mintong Kang, Vinayshekhar Bannihatti Kumar, Shamik Roy, Abhishek Kumar, Sopan Khosla, Balakrishnan Murali Narayanaswamy, Rashmi Gangadharaiah	fairness, sensitive attributes, diffusion models, latent guidance
Empowering GraphRAG with Knowledge Filtering and Integration	Kai Guo, Harry Shomer, Shenglai Zeng, Haoyu Han, Yu Wang, Jiliang Tang	knowledge filtering, knowledge integration, graph-based models
PhoniTale: Phonologically Grounded Mnemonic Generation for Typologically Distant Language Pairs	Sana Kang, Myeongseok Gwon, Su Young Kwon, Jaewook Lee, Andrew Lan, Bhiksha Raj, Rita Singh	mnemonic generation, phonology, typologically distant languages
Learning to Ask: When LLM Agents Meet Unclear Instruction	Wenxuan Wang, Shi Juluan, Zixuan Ling, Yuk-Kit Chan, Chaozheng Wang, Cheryl Lee, Youliang Yuan, Jen-tse Huang, Wenxiang Jiao, Michael R. Lyu	large language models, agents, instruction understanding, interactive learning
StepSearch: Igniting LLMs Search Ability via Step-Wise Proximal Policy Optimization	Xuhui Zheng, Kang An, Ziliang Wang, Yuhang Wang, Yichao Wu	large language models, search, reinforcement learning, policy optimization
GRIT: Guided Relational Integration for Efficient Multi-Table Understanding	Yujin Kang, Park Seong Woo, Yoon-Sik Cho	multi-table understanding, relational integration, data integration
Pun Unintended: LLMs and the Illusion of Humor Understanding	Alessandro Zangari, Matteo Marcuzzo, Andrea Albarelli, Mohammad Taher Pilehvar, Jose Camacho-Collados	large language models, humor understanding, evaluation
Multilingual Language Model Pretraining using Machine-translated Data	Jiayi Wang, Yao Lu, Maurice Weber, Max Ryabinin, David Ifeoluwa Adelani, Yihong Chen, Raphael Tang, Pontus Stenetorp	multilingual models, pretraining, machine translation, language modeling
The Strawberry Problem: Emergence of Character-level Understanding in Tokenized Language Models	Adrian Cosma, Stefan Ruseti, Emilian Radoi, Mihai Dascalu	language models, character-level understanding, tokenization
COUNTDOWN: Contextually Sparse Activation Filtering Out Unnecessary Weights in Down Projection	Jaewon Cheon, Pilsung Kang	model efficiency, sparse activation, neural networks
CAIR: Counterfactual-based Agent Influence Ranker for Agentic AI Workflows	Amit Giloni, Chiara Picardi, Roy Betser, Shamik Bose, Aishvariya Priya Rathina Sabapathy, Roman Vainshtein	counterfactual reasoning, agentic AI, influence ranking, AI workflows
SAFE-SQL: Self-Augmented In-Context Learning with Fine-grained Example Selection for Text-to-SQL	Jimin Lee, Ingeol Baek, Byeongjeong Kim, Hyunkyung Bae, Hwanhee Lee	text-to-SQL, in-context learning, example selection, fine-grained learning
MA-GTS: A Multi-Agent Framework for Solving Complex Graph Problems in Real-World Applications	Zike Yuan, Ming Liu, Hui Wang, Bing Qin	multi-agent systems, graph problems, real-world applications
How do Language Models Reshape Entity Alignment? A Survey of LM-Driven EA Methods: Advances, Benchmarks, and Future	Zerui Chen, huiming fan, Qianyu Wang, Tao He, Ming Liu, Heng Chang, Weijiang Yu, Ze Li, Bing Qin	entity alignment, language models, survey
FlashAdventure: A Benchmark for GUI Agents Solving Full Story Arcs in Diverse Adventure Games	Jaewoo Ahn, Junseo Kim, Heeseung Yun, Jaehyeon Son, Dongmin Park, Jaewoong Cho, Gunhee Kim	benchmarks, gui agents, adventure games, reinforcement learning
TAPS: Tool-Augmented Personalisation via Structured Tagging	Ekaterina Taktasheva, Jeff Dalton	personalization, structured tagging, tools
GAP: a Global Adaptive Pruning Method for Large Language Models	Zhihua Ban, Haotian Ma, Siheng Zhang, Shengyu Liu, Xichen Chen, Ming Yang	large language models, model pruning, efficiency, adaptive methods
Attention-guided Self-reflection for Zero-shot Hallucination Detection in Large Language Models	Qiang Liu, Xinlong Chen, Yue Ding, Bowen Song, Weiqiang Wang, Shu Wu, Liang Wang	large language models, hallucination detection, self-reflection, zero-shot learning
Leveraging Large Models to Evaluate Novel Content: A Case Study on Advertisement Creativity	Zhaoyi Joey Hou, Adriana Kovashka, Xiang Lorraine Li	large language models, content evaluation, advertisement creativity
Speculating LLMs’ Chinese Training Data Pollution from Their Tokens	Ramya Keerthy Thatikonda, Wray Buntine, Ehsan Shareghi	large language models, data pollution, training data analysis, Chinese language
SocioBench: Modeling Human Behavior in Sociological Surveys with Large Language Models	Hang Wu, Hongkai Chen, Yujun Cai, Chang Liu, Qingwen Ye, Ming-Hsuan Yang, Yiwei Wang	human behavior modeling, sociological surveys, large language models
VLA-Mark: A cross modal watermark for large vision-language alignment models	WenHao Wang, Zijie Yu, Rui Ye, Jianqing Zhang, Guangyi Liu, Liang Liu, Siheng Chen, Yanfeng Wang	cross-modal watermarking, vision-language models, alignment
Evaluating Robustness of Large Audio Language Models to Audio Injection: An Empirical Study	Guanyu Hou, Jiaming He, Yinhang Zhou, Ji Guo, Yitong Qiao, Rui Zhang, Wenbo Jiang	robustness, audio language models, audio injection, empirical study
Sali4Vid: Saliency-Aware Video Reweighting and Adaptive Caption Retrieval for Dense Video Captioning	MinJu Jeon, Si-Woo Kim, Ye-Chan Kim, HyunGee Kim, Dong-Jin Kim	video captioning, saliency, adaptive retrieval, dense captioning
How to Protect Yourself from 5G Radiation? Investigating LLM Responses to Implicit Misinformation	Ruohao Guo, Wei Xu, Alan Ritter	large language models, misinformation, 5G, investigation
PychoAgent: Psychology-driven LLM Agents for Explainable Panic Prediction on Social Media during Sudden Disaster Events	Mengzhu Liu, Zhengqiu Zhu, Chuan Ai, Chen Gao, Xinghong Li, Lingnan He, Kaisheng Lai, Yingfeng Chen, Xin Lu, Yong Li, Quanjun Yin	psychology-driven agents, large language models, panic prediction, social media, disaster events, explainability
RJE: A Retrieval-Judgment-Exploration Framework for Efficient Knowledge Graph Question Answering with LLMs	Can Lin, Zhengwang Jiang, Ling Zheng, Qi Zhao, Yuhang Zhang, Qi Song, Wangqiu Zhou	knowledge graph question answering, retrieval, judgment, exploration, large language models
HyperKGR: Knowledge Graph Reasoning in Hyperbolic Space with Graph Neural Network Encoding Symbolic Path	Lihui Liu	knowledge graph reasoning, hyperbolic space, graph neural networks
Contra4: Evaluating Contrastive Cross-Modal Reasoning in Audio, Video, Image, and 3D	Artemis Panagopoulou, Le Xue, Honglu Zhou, silvio savarese, Ran Xu, Caiming Xiong, Chris Callison-Burch, Mark Yatskar, Juan Carlos Niebles	contrastive reasoning, cross-modal, audio, video, image, 3d
Harmful Prompt Laundering: Jailbreaking LLMs with Abductive Styles and Symbolic Encoding	Seongho Joo, Hyukhun Koh, Kyomin Jung	prompt laundering, jailbreaking, large language models, abductive styles, symbolic encoding
Puzzled by Puzzles: When Vision-Language Models Can’t Take a Hint	Heekyung Lee, Jiaxin Ge, Tsung-Han Wu, Minwoo Kang, Trevor Darrell, David M. Chan	vision-language models, multimodal, reasoning, puzzles
VistaWise: Building Cost-Effective Agent with Cross-Modal Knowledge Graph for Minecraft	Honghao Fu, Junlong Ren, Qi Chai, Deheng Ye, Yujun Cai, Hao Wang	agents, cross-modal, knowledge graphs, gaming, cost-effective systems
RPDR: A Round-trip Prediction-Based Data Augmentation Framework for Long-Tail Question Answering	Yiming Zhang, Siyue Zhang, Junbo Zhao, Chen Zhao	data augmentation, long-tail question answering, prediction frameworks
Pre-trained Models Perform the Best When Token Distributions Follow Zipf’s Law	Yanjin He, Qingkai Zeng, Meng Jiang	pre-trained models, token distribution, language modeling
Efficient Compositional Multi-tasking for On-device Large Language Models	Ondrej Bohdal, Mete Ozay, Jijoong Moon, Kyenghun Lee, Hyeonmok Ko, Umberto Michieli	large language models, multi-task learning, efficiency, on-device models
Weaver: Interweaving SQL and LLM for Table Reasoning	Rohit Khoja, Devanshu Gupta, Yanjie Fu, Dan Roth, Vivek Gupta	table reasoning, large language models, SQL, multimodal reasoning
QG-CoC: Question-Guided Chain-of-Captions for Large Multimodal Models	Kuei-Chun Kao, Hsu Tzu-Yin, Yunqi Hong, Ruochen Wang	question answering, multimodal models, captioning, large models
Precise In-Parameter Concept Erasure in Large Language Models	Yoav Gur-Arieh, Clara Haya Suslik, Yihuai Hong, Fazl Barez, Mor Geva	large language models, concept erasure, model editing
GCML: Gradient Coherence Guided Meta-Learning for Cross-Domain Emerging Topic Rumor Detection	Zejiang He, jingyuan huang, Menglong Lu, Zhen Huang, Shanshan Liu, Zhiliang Tian, Dongsheng Li	meta-learning, rumor detection, cross-domain, emerging topics
Mitigating Hallucinations in LM-Based TTS Models via Distribution Alignment Using GFlowNets	Chenlin Liu, Jiqing Han, Minghui Fang, Wei Zhou, Jie Gao	hallucination mitigation, text-to-speech, language models, distribution alignment
Can Large Language Models be Effective Online Opinion Miners?	Ryang Heo, Yongsik Seo, JunseongLee, Dongha Lee	large language models, opinion mining, online text
GER-LLM: Efficient and Effective Geospatial Entity Resolution with Large Language Model	Haojia Zhu, Zhicheng Li, Jiahui Jin	large language models, geospatial, entity resolution
Can Large Language Models Translate Spoken-Only Languages through International Phonetic Transcription?	Jiale Chen, Xuelian Dong, Qihao Yang, Wenxiu Xie, Tianyong Hao	large language models, machine translation, phonetic transcription
DSVD: Dynamic Self-Verify Decoding for Faithful Generation in Large Language Models	YiQiu Guo, Yuchen Yang, Zhe Chen, Pingjie Wang, Yusheng Liao, Ya Zhang, Yanfeng Wang, Yu Wang	large language models, decoding, generation, self-verification
LGA: LLM-GNN Aggregation for Temporal Evolution Attribute Graph Prediction	Feng Zhao, Ruoyu Chai, Kangzheng Liu, Xianggan Liu	large language models, graph neural networks, temporal prediction, attribute graphs
MMAG: Multimodal Learning for Mucus Anomaly Grading in Nasal Endoscopy via Semantic Attribute Prompting	Xinpan Yuan, Mingzhu Huang, Liujie Hua, JianuoJu, XuZhang	multimodal learning, medical imaging, anomaly grading, semantic prompting
DCP: Dual-Cue Pruning for Efficient Large Vision-Language Models	Lei Jiang, Zixun Zhang, Yuting Zeng, Chunzhao Xie, Tongxuan Liu, Zhen Li, Lechao Cheng, Xiaohua Xu	vision-language models, model pruning, efficiency, dual-cue methods
How to inject knowledge efficiently? Knowledge Infusion Scaling Law for Pre-training Large Language Models	Yuhan Liu, Zirui Song, Juntian Zhang, Xiaoqing Zhang, Xiuying Chen, Rui Yan	knowledge infusion, pre-training, large language models, scaling laws
DDO: Dual-Decision Optimization for LLM-Based Medical Consultation via Multi-Agent Collaboration	Yuhao Yang, Jiabin Tang, Lianghao Xia, Xingchen Zou, Yuxuan Liang, Chao Huang	medical consultation, large language models, multi-agent collaboration, optimization
Computational Analysis of Conversation Dynamics through Participant Responsivity	Margaret Hughes, Brandon Roy, Elinor Poole-Dayan, Deb Roy, Jad Kabbara	conversation analysis, dialogue systems, participant responsivity
How Far Can LLMs Improve from Experience? Measuring Test-Time Learning Ability in LLMs with Human Comparison	Jiayin Wang, Zhiqiang Guo, Weizhi Ma, Min Zhang	large language models, test-time learning, human comparison, evaluation
Sparse Activation Editing for Reliable Instruction Following in Narratives	Runcong Zhao, Chengyu Cao, Qinglin Zhu, Xiucheng Ly, Shun Shao, Lin Gui, Ruifeng Xu, Yulan He	activation editing, instruction following, narratives, reliability
ICL CIPHERS: Quantifying ‘‘Learning’’ in In-Context Learning via Substitution Ciphers	Zhouxiang Fang, Aayush Mishra, Muhan Gao, Anqi Liu, Daniel Khashabi	in-context learning, substitution ciphers, learning quantification
Rule Discovery for Natural Language Inference Data Generation Using Out-of-Distribution Detection	Juyoung Han, Hyunsun Hwang, Changki Lee	rule discovery, natural language inference, data generation, out-of-distribution detection
Temporal Scaling Law for Large Language Models	Yizhe Xiong, Xiansheng Chen, Xin Ye, Hui Chen, Zijia Lin, Haoran Lian, Zhenpeng Su, Wei Huang, Jianwei Niu, Jungong Han, Guiguang Ding	large language models, scaling laws, temporal scaling
Mixing Inference-time Experts for Enhancing LLM Reasoning	Soumya Sanyal, Tianyi Xiao, Xiang Ren	large language models, reasoning, ensemble methods, inference-time experts
Igniting Creative Writing in Small Language Models: LLM-as-a-Judge versus Multi-Agent Refined Rewards	Xiaolong Wei, Bo Lu, Xingyu Zhang, Zhejun Zhao, Dongdong Shen, Long Xia, Dawei Yin	creative writing, small language models, multi-agent systems, reward refinement
Beyond Averages: Learning with Annotator Disagreement in STS	Alejandro Benito-Santos, Adrian Ghajari	semantic textual similarity, annotator disagreement, learning with disagreement
Don’t Sweat the Small Stuff: Segment-Level Meta-Evaluation Based on Pairwise Difference Correlation	Colten DiIanni, Daniel Deutsch	evaluation, meta-evaluation, segment-level, correlation
DPED: Multi-Layer Noise Distillation for Privacy-Preserving Text Embeddings	Shuya Feng, Yuan Hong	privacy-preserving, text embeddings, noise distillation
fLSA: Learning Semantic Structures in Document Collections Using Foundation Models	Weijia Xu, Nebojsa Jojic, Nicolas Le Roux	semantic structures, document collections, foundation models
Memorization or Reasoning? Exploring the Idiom Understanding of LLMs	Jisu Kim, Youngwoo Shin, Uiji Hwang, Jihun Choi, Richeng Xuan, Taeuk Kim	large language models, idiom understanding, reasoning, memorization
GraphKV: Breaking the Static Selection Paradigm with Graph-Based KV Cache Eviction	Xuelin Li, Xiangqi Jin, Linfeng Zhang	graph neural networks, cache eviction, key-value stores, dynamic selection
Discrepancy Detection at the Data Level: Toward Consistent Multilingual Question Answering	Lorena Calvo-Bartolomé, Valérie Aldana, Karla Cantarero, Alonso Madroñal de Mesa, Jerónimo Arenas-García, Jordan Lee Boyd-Graber	multilingual question answering, discrepancy detection, data consistency
RACCooN: Versatile Instructional Video Editing with Auto-Generated Narratives	Jaehong Yoon, Shoubin Yu, Mohit Bansal	video editing, instructional videos, narrative generation, multimodal
Video-RTS: Rethinking Reinforcement Learning and Test-Time Scaling for Efficient and Enhanced Video Reasoning	Ziyang Wang, Jaehong Yoon, Shoubin Yu, Md Mohaiminul Islam, Gedas Bertasius, Mohit Bansal	reinforcement learning, video reasoning, efficiency, test-time scaling
ECO Decoding: Entropy-Based Control for Controllability and Fluency in Controllable Dialogue Generation	Seungmin Shin, Dooyoung Kim, Youngjoong Ko	dialogue generation, controllability, entropy-based control, fluency
VLP: Vision-Language Preference Learning for Embodied Manipulation	Runze Liu, Chenjia Bai, Jiafei Lyu, Shengjie Sun, Yali Du, Xiu Li	vision-language models, preference learning, embodied manipulation, multimodal
PhonoThink: Improving Large Language Models’ Reasoning on Chinese Phonological Ambiguities	Jianfei Ma, Zhaoxin Feng, Emmanuele Chersoni, Huacheng Song, Ziqi Zhang	large language models, phonological ambiguities, Chinese language, reasoning
Can LLMs Generate and Solve Linguistic Olympiad Puzzles?	Neh Majmudar, Elena Filatova	large language models, puzzle solving, linguistic olympiad
MolErr2Fix: Benchmarking LLM Trustworthiness in Chemistry via Modular Error Detection, Localization, Explanation, and Correction	Yuyang Wu, Jinhui Ye, Shuhao Zhang, Lu Dai, Yonatan Bisk, Olexandr Isayev	large language models, trustworthiness, chemistry, error detection, error correction
Drivel-ology: Challenging LLMs with Interpreting Nonsense with Depth	Yang Wang, Chenghao Xiao, Chia-Yi Hsiao, Zi Yan Chang, Chi-Li Chen, Tyler Loakman, Chenghua Lin	large language models, robustness, nonsense interpretation
Searching for the Most Human-like Emergent Language	Brendon Boldt, David R. Mortensen	emergent language, language evolution, human-like language
SLlama: Parameter-Efficient Language Model Architecture for Enhanced Linguistic Competence Under Strict Data Constraints	Victor Adelakun Omolaoye, Babajide Alamu Owoyele, Gerard de Melo	language model architecture, parameter efficiency, linguistic competence
Generative Annotation for ASR Named Entity Correction	Yuanchang Luo, Daimeng Wei, Shaojun Li, Hengchao Shang, Jiaxin GUO, Zongyao Li, Zhanglin Wu, Xiaoyu Chen, Zhiqiang Rao, Jinlong Yang, Hao Yang	automatic speech recognition, named entity correction, annotation, generative models
‘Rich Dad, Poor Lad’: How do Large Language Models Contextualize Socioeconomic Factors in College Admission ?	Huy Nghiem, Phuong-Anh Nguyen-Le, John Prindle, Rachel Rudinger, Hal Daumé III	large language models, socioeconomic factors, contextualization, college admission
BIRD: Bronze Inscription Restoration and Dating	Wenjie Hua, Hoang H Nguyen, Gangyan Ge	inscription restoration, dating, historical documents
Weights-Rotated Preference Optimization for Large Language Models	Abhay Gupta, Kevin Zhu, Vasu Sharma, Sean O’Brien, Michael Lu	large language models, optimization, preference learning
CopySpec: Accelerating LLMs with Speculative Copy-and-Paste	Wei-Ning Chiu, Yu-Hsiang Wang, Andy Hsiao, Yu-Shiang Huang, Chuan-Ju Wang	large language models, acceleration, speculative execution
ReasonMed: A 370K Multi-Agent Generated Dataset for Advancing Medical Reasoning	Hongji Li, Andrianos Michail, Reto Gubelmann, Simon Clematide, Juri Opitz	medical reasoning, multi-agent systems, datasets
Exploring Chain-of-Thought Reasoning for Steerable Pluralistic Alignment	Yunfan Zhang, Kathleen McKeown, Smaranda Muresan	chain-of-thought reasoning, alignment, interpretability, reasoning
SwiftKV: Fast Prefill-Optimized Inference with Knowledge-Preserving Model Transformation	Aurick Qiao, Zhewei Yao, Samyam Rajbhandari, Yuxiong He	model transformation, inference optimization, knowledge preservation
Inceptive Transformers: Enhancing Contextual Representations through Multi-Scale Feature Learning Across Domains and Languages	Asif Shahriar, Rifat Shahriyar, M Saifur Rahman	transformers, contextual representations, multi-scale feature learning, cross-domain, multilingual
OWL: Probing Cross-Lingual Recall of Memorized Texts via World Literature	Alisha Srivastava, Emir Kaan Korukluoglu, Minh Nhat Le, Duyen Tran, Chau Minh Pham, Marzena Karpinska, Mohit Iyyer	cross-lingual recall, memorization, world literature, multilingual NLP
Corrupted but Not Broken: Understanding and Mitigating the Negative Impacts of Corrupted Data in Visual Instruction Tuning	Yunhao Gou, Hansi Yang, Zhili Liu, Kai Chen, Yihan Zeng, Lanqing HONG, Zhenguo Li, Qun Liu, Bo Han, James Kwok, Yu Zhang	corrupted data, visual instruction tuning, robustness, mitigation
Jigsaw-Puzzles: From Seeing to Understanding to Reasoning in Vision-Language Models	Zesen Lyu, Dandan Zhang, Wei Ye, Fangdi Li, Zhihang Jiang, Yao Yang	vision-language models, reasoning, understanding, multimodal AI
Language Model Based Text-to-Audio Generation: Anti-Causally Aligned Collaborative Residual Transformers	Juncheng Wang, Chao Xu, Cheng Yu, Zhe Hu, Haoyu Xie, Guoqi Yu, Lei Shang, Shujun Wang	text-to-audio generation, language models, transformers, audio synthesis
RAVEN: Query-Guided Representation Alignment for Question Answering over Audio, Video, Embedded Sensors, and Natural Language	Subrata Biswas, Mohammad Nur Hossain Khan, Bashima Islam	multimodal question answering, representation alignment, audio, video, sensors
Understanding and Mitigating Overrefusal in LLMs from an Unveiling Perspective of Safety Decision Boundary	Licheng Pan, Yongqi Tong, Xin Zhang, Xiaolu Zhang, JUN ZHOU, Zhixuan Chu	large language models, safety, overrefusal, decision boundary
A Sequential Multi-Stage Approach for Code Vulnerability Detection via Confidence- and Collaboration-based Decision Making	Chung-Nan Tsai, Xin Wang, Cheng-Hsiung Lee, Ching-Sheng Lin	code vulnerability detection, sequential approach, confidence-based decision making, collaboration
NovelHopQA: Diagnosing Multi-Hop Reasoning Failures in Long Narrative Contexts	Qingjie Zhang, Di Wang, Haoting Qian, Liu Yan, Tianwei Zhang, Ke Xu, Qi Li, Minlie Huang, Hewu Li, Han Qiu	multi-hop reasoning, question answering, long narrative, diagnostics
Financial Risk Relation Identification through Dual-view Adaptation	jia WANG, Ziyu Zhao, Tingjuntao Ni, zhongyu wei	financial risk, relation identification, dual-view adaptation
Sentence Smith: Controllable Edits for Evaluating Text Embeddings	Shuliang Liu, Zheng Qi, Jesse Jiaxi Xu, Yibo Yan, He GENG, Junyan Zhang, Aiwei Liu, Peijie Jiang, Jia Liu, Yik-Cheung Tam, Xuming Hu	text embeddings, controllable edits, evaluation
Which Word Orders Facilitate Length Generalization in LMs? An Investigation with GCG-Based Artificial Languages	Nadine El-Naggar, Tatsuki Kuribayashi, Ted Briscoe	language modeling, word order, length generalization, artificial languages
Co-Eval: Augmenting LLM-based Evaluation with Machine Metrics	Ling-I Wu, Weijie Wu, Minyu Chen, Jianxin Xue, Guoqiang Li	evaluation, large language models, machine metrics
Causal Tree Extraction from Medical Case Reports: A Novel Task for Experts-like Text Comprehension	Sakiko Yahata, Zhen Wan, Fei Cheng, Sadao Kurohashi, Hisahiko Sato, Ryozo Nagai	causal extraction, medical case reports, text comprehension, expert systems
VisFinEval: A Scenario-Driven Chinese Multimodal Benchmark for Holistic Financial Understanding	Zhaowei Liu, Xin Guo, Haotian Xia, Lingfeng Zeng, Fangqi Lou, Jinyi Niu, Mengping Li, Qi Qi, Jiahuan Li, Wei Zhang, Yinglong Wang, Weige Cai, Weining Shen, Liwen Zhang	multimodal, financial understanding, chinese, benchmark
Memory-QA: Answering Recall Questions Based on Multimodal Memories	Hongda Jiang, Xinyuan Zhang, Siddhant Garg, Rishab Arora, Shiun-Zu Kuo, Jiayang Xu, AARON COLAK, Xin Luna Dong	question answering, recall, multimodal memories
Hallucination Detection in LLMs Using Spectral Features of Attention Maps	Jakub Binkowski, Denis Janiak, Albert Sawczyn, Bogdan Gabrys, Tomasz Jan Kajdanowicz	hallucination detection, large language models, attention maps, spectral features
Reframe Your Life Story: Interactive Narrative Therapist and Innovative Moment Assessment with Large Language Models	Yi Feng, Jiaqi Wang, Wenxuan Zhang, Zhuang Chen, Shen Yutong, Xiyao Xiao, Minlie Huang, Liping Jing, Jian Yu	interactive narrative, therapy, large language models, assessment
Improving Context Fidelity via Native Retrieval-Augmented Reasoning	Suyuchen Wang, Jinlin Wang, Xinyu Wang, Shiqi Li, Xiangru Tang, Sirui Hong, Xiao-Wen Chang, Chenglin Wu, Bang Liu	retrieval-augmented reasoning, context fidelity, large language models
zFLoRA: Zero-Latency Fused Low-Rank Adapters	Dhananjaya Gowda, Seoha Song, Harshith Goka, Junhyun Lee	low-rank adapters, model efficiency, large language models
Look Beyond Feeling: Unveiling Latent Needs from Implicit Expressions for Proactive Emotional Support	Xing Fu, Haozhen Li, Bichen Wang, Hao Yang, Yanyan Zhao, Bing Qin	emotional support, latent needs, implicit expressions, proactive support
From Understanding to Generation: An Efficient Shortcut for Evaluating Language Models	hipeng Yang, Junzhuo Li, Siyu Xia, Xuming Hu	language models, evaluation, generation
Blind Men and the Elephant: Diverse Perspectives on Gender Stereotypes in Benchmark Datasets	Changjiang Gao, Hankun Lin, Xin Huang, Xue Han, Junlan Feng, Chao Deng, Jiajun Chen, Shujian Huang	gender stereotypes, bias, benchmark datasets
R-BPE: Improving BPE-Tokenizers with Token Reuse	Anh Ha Ngo, Nicolas Rollet, Catherine Pelachaud, Chloé Clavel	tokenization, BPE, token reuse, model efficiency
When Life Gives You Samples: The Benefits of Scaling up Inference Compute for Multilingual LLMs	Ammar Khairi, Daniel D’souza, Ye Shen, Julia Kreutzer, Sara Hooker	large language models, multilingual, inference scaling, compute optimization
Tailoring Table Retrieval from a Field-aware Hybrid Matching Perspective	Da Li, Keping Bi, Jiafeng Guo, Xueqi Cheng	table retrieval, information retrieval, hybrid matching
Charting the Landscape of African NLP: Mapping Progress and Shaping the Road Ahead	Jesujoba Oluwadara Alabi, Michael A. Hedderich, David Ifeoluwa Adelani, Dietrich Klakow	african nlp, survey, progress mapping
On the Same Wavelength? Evaluating Pragmatic Reasoning in Language Models across Broad Concepts	Linlu Qiu, Cedegao E. Zhang, Joshua B. Tenenbaum, Yoon Kim, Roger P. Levy	language models, pragmatic reasoning, evaluation
Balanced Multi-Factor In-Context Learning for Multilingual Large Language Models	Masahiro Kaneko, Alham Fikri Aji, Timothy Baldwin	in-context learning, multilingual, large language models
CoMAT: Chain of Mathematically Annotated Thought Improves Mathematical Reasoning	Joshua Ong Jun Leang, Aryo Pradipta Gema, Shay B Cohen	mathematical reasoning, chain of thought, evaluation
DiffusionAttacker: Diffusion-Driven Prompt Manipulation for LLM Jailbreak	Hao Wang, Hao Li, Junda Zhu, Xinyuan Wang, Chengwei Pan, Minlie Huang, Lei Sha	diffusion models, prompt manipulation, large language models, security, jailbreak
Dyve: Thinking Fast and Slow for Dynamic Process Verification	Jianyuan Zhong, Zeju Li, Zhijian Xu, Xiangyu Wen, Qiang Xu	dynamic process verification, neural methods, efficiency
The Role of Outgoing Connection Heterogeneity in Feedforward Layers of Large Language Models	Felix Stahlberg, Shankar Kumar	large language models, feedforward layers, neural architecture
Chinese Toxic Language Mitigation via Sentiment Polarity Consistent Rewrites	Xintong Wang, Yixiao Liu, Jingheng Pan, Liang Ding, Longyue Wang, Chris Biemann	toxic language detection, language mitigation, sentiment analysis, Chinese language
RAcQUEt: Unveiling the Dangers of Overlooked Referential Ambiguity in Visual LLMs	Alberto Testoni, Barbara Plank, Raquel Fernández	referential ambiguity, visual large language models, evaluation
Audio-Reasoner: Improving Reasoning Capability in Large Audio Language Models	Xie Zhifei, Mingbao Lin, Zihang Liu, Pengcheng Wu, Shuicheng YAN, Chunyan Miao	audio language models, reasoning, model improvement
Scalable and Culturally Specific Stereotype Dataset Construction via Human-LLM Collaboration	Weicheng Ma, John J. Guerrerio, Soroush Vosoughi	dataset construction, stereotypes, human-LLM collaboration, cultural specificity
LCES: Zero-shot Automated Essay Scoring via Pairwise Comparisons Using Large Language Models	Takumi Shibata, Yuichi Miyamura	automated essay scoring, zero-shot, large language models
From Parameters to Performance: A Data-Driven Study on LLM Structure and Development	Yejin Choi, Jaewoo Park, Janghan Yoon, Saejin Kim, Jaehyun Jeon, Youngjae Yu	large language models, model analysis, performance study
Reverse Prompt Engineering: A Zero-Shot, Genetic Algorithm Approach to Language Model Inversion	Biao Zhang, Lixin Chen, Tong Liu, Bo Zheng	prompt engineering, zero-shot learning, genetic algorithms, model inversion
GraphAgent: Agentic Graph Language Assistant	Kainan Liu, Yong Zhang, Ning Cheng, Zhitao Li, Shaojun Wang, Jing Xiao	graph language assistant, agentic models, graph-based NLP
Leaky Thoughts: Large Reasoning Models Are Not Private Thinkers	Yuanzhang Lin, Zhe Zhang, He Rui, Qingao Dong, Mingyi Zhou, Jing Zhang, Xiang Gao, Hailong Sun	large reasoning models, privacy, reasoning
CMedCalc-Bench: A Fine-Grained Benchmark for Chinese Medical Calculations in LLM	Yunyan Zhang, Zhihong Zhu, Xian Wu	benchmark, medical calculations, Chinese, large language models, evaluation
Semantic Networks Extracted from Students’ Think-Aloud Data are Correlated with Students’ Learning Performance	Pingjing Yang, Sullam Jeoung, Jennifer Cromley, Jana Diesner	semantic networks, think-aloud data, learning performance, educational data mining
Text Takes Over: A Study of Modality Bias in Multimodal Intent Detection	Ankan Mullick, Saransh Sharma, Abhik Jana, Pawan Goyal	modality bias, multimodal, intent detection
Socratic-MCTS: Test-Time Visual Reasoning by Asking the Right Questions	David Acuna, Ximing Lu, Jaehun Jung, Hyunwoo Kim, Amlan Kar, Sanja Fidler, Yejin Choi	visual reasoning, test-time, question answering
NEXUS: Network Exploration for eXploiting Unsafe Sequences in Multi-Turn LLM Jailbreaks	Javad Rafiei Asl, Sidhant Narula, Mohammad Ghasemigol, Eduardo Blanco, Daniel Takabi	network exploration, unsafe sequences, multi-turn, large language models, jailbreaks
Composable Cross-prompt Essay Scoring by Merging Models	Sanwoo Lee, Kun Liang, Yunfang Wu	essay scoring, cross-prompt, model merging
AdaSteer: Your Aligned LLM is Inherently an Adaptive Jailbreak Defender	Weixiang Zhao, Jiahe Guo, Yulin Hu, Yang Deng, An Zhang, Xingyu Sui, Xinyang Han, Yanyan Zhao, Bing Qin, Tat-Seng Chua, Ting Liu	large language models, jailbreak defense, alignment, adaptive methods
EnAnchored-X2X: English-Anchored Optimization for Many-to-Many Translation	Sen Yang, Yu Bao, Yu Lu, Jiajun Chen, Shujian Huang, Shanbo Cheng	machine translation, many-to-many translation, optimization
Interpretation Meets Safety: A Survey on Interpretation Methods and Tools for Improving LLM Safety	Seongmin Lee, Aeree Cho, Grace C. Kim, ShengYun Peng, Mansi Phute, Duen Horng Chau	interpretation methods, safety, large language models, survey
MS-RAG: Simple and Effective Multi-Semantic Retrieval-Augmented Generation	Max Conti, Manuel Faysse, Gautier Viaud, Antoine Bosselut, CELINE HUDELOT, Pierre Colombo	retrieval-augmented generation, multi-semantic, generation, retrieval
TASO: Task-Aligned Sparse Optimization for Parameter-Efficient Model Adaptation	Esther Shizgal, Eitan Wagner, Renana Keydar, Omri Abend	model adaptation, sparse optimization, parameter efficiency
Mixture of Weight-shared Heterogeneous Group Attention Experts for Dynamic Token-wise KV Optimization	Gleb Mezentsev, Ivan Oseledets	attention mechanisms, dynamic optimization, token-wise, model efficiency
Surprise Calibration	Svetlana Maslenkova, Clement Christophe, Marco AF Pimentel, Tathagata Raha, Muhammad Umar Salman, Ahmed Al Mahrooqi, Avani Gupta, Shadab Khan, Ronnie Rajan, Praveenkumar Kanithi	calibration, evaluation, surprise
Creativity in LLM-based Multi-Agent Systems: A Survey	Yi-Cheng Lin, Kang-Chieh Chen, Zhe-Yan Li, Tzu-Heng Wu, Tzu-Hsuan Wu, Kuan-Yu Chen, Hung-yi Lee, Yun-Nung Chen	large language models, multi-agent systems, creativity, survey
MessIRve: A Large-Scale Spanish Information Retrieval Dataset	Francisco Valentini, Viviana Cotik, Damián Furman, Ivan Bercovich, Edgar Altszyler, Juan Manuel Pérez	information retrieval, dataset, spanish language
Topic Coverage-based Demonstration Retrieval for In-Context Learning	Wonbin Kweon, SeongKu Kang, Runchu Tian, Pengcheng Jiang, Jiawei Han, Hwanjo Yu	in-context learning, demonstration retrieval, topic coverage
SAFENUDGE: Safeguarding Large Language Models in Real-time with Tunable Safety-Performance Trade-offs	Joao Fonseca, Andrew Bell, Julia Stoyanovich	large language models, safety, performance trade-offs
Languages Still Left Behind: Toward a Better Multilingual Machine Translation Benchmark	Chihiro Taguchi, Seng Mai, Keita Kurabe, Yusuke Sakai, Georgina Agyei, Soudabeh Eslami, David Chiang	multilingual, machine translation, benchmarking
Training compute-optimal transformer encoder models	Megi Dervishi, Alexandre Allauzen, Gabriel Synnaeve, Yann LeCun	transformers, model training, compute optimization
LLM-Guided Semantic Relational Reasoning for Multimodal Intent Recognition	Qianrui Zhou, Hua Xu, Yifan Wang, Xinzhi Dong, Hanlei Zhang	large language models, semantic reasoning, multimodal, intent recognition
T2R-BENCH: A Benchmark for Real World Table-to-Report Task	JieZhangChinaTele, Changzai Pan, Sishi Xiong, Kaiwen Wei, Yu Zhao, xiangyu Li, Jiaxin Peng, Xiaoyan Gu, Jian Yang, Wenhan Chang, Zhenhe Wu, Jiang Zhong, Shuangyong Song, Xuelong Li	benchmark, table-to-report, real world, evaluation
AccessEval: Benchmarking Disability Bias in Large Language Models	Srikant Panda, Amit Agarwal, Hitesh Laxmichand Patel	bias, disability, large language models, evaluation
Agent-as-Judge for Factual Summarization of Long Narratives	Yeonseok Jeong, Minsoo Kim, seung-won hwang, Byung-Hak Kim	factual summarization, long narratives, evaluation
Grounded Semantic Role Labelling from Synthetic Multimodal Data for Situated Robot Commands	Claudiu Daniel Hromei, Antonio Scaiella, Danilo Croce, Roberto Basili	semantic role labeling, multimodal data, robotics, situated commands
Graph-R1: Incentivizing the Zero-Shot Graph Learning Capability in LLMs via Explicit Reasoning	Yicong Wu, Guangyue Lu, Yuan Zuo, Huarong Zhang, Junjie Wu	zero-shot learning, graph learning, large language models, explicit reasoning
KGE Calibrator: An Efficient Probability Calibration Method of Knowledge Graph Embedding Models for Trustworthy Link Prediction	Yang Yang, Mohan Timilsina, Edward Curry	knowledge graph embeddings, probability calibration, link prediction
Correct-Detect: Balancing Performance and Ambiguity Through the Lens of Coreference Resolution in LLMs	Amber Shore, Russell Scheinberg, Ameeta Agrawal, So Young Lee	coreference resolution, large language models, ambiguity, performance
GRASP: Replace Redundant Layers with Adaptive Singular Parameters for Efficient Model Compression	Razvan-Gabriel Dumitru, Minglai Yang, Vikas Yadav, Mihai Surdeanu	model compression, efficient models, adaptive parameters
UICOMPASS: UI Map Guided Mobile Task Automation via Adaptive Action Generation	Seongwan park, Taeklim Kim, Youngjoong Ko	mobile task automation, UI maps, adaptive action generation
Dipper: Diversity in Prompts for Producing Large Language Model Ensembles in Reasoning Tasks	Gregory Kang Ruey Lau, Wenyang Hu, Liu Diwen, Chen Jizhuo, See-Kiong Ng, Bryan Kian Hsiang Low	prompt engineering, large language models, ensemble methods, reasoning
Measuring Chain of Thought Faithfulness by Unlearning Reasoning Steps	Martin Tutek, Fateme Hashemi Chaleshtori, Ana Marasovic, Yonatan Belinkov	chain of thought, reasoning, evaluation
Evaluating the Evaluators: Are readability metrics good measures of readability?	Isabel Cachola, Daniel Khashabi, Mark Dredze	evaluation, readability metrics, readability assessment
Following Length Constraints in Instructions	Weizhe Yuan, Ilia Kulikov, Ping Yu, Kyunghyun Cho, Sainbayar Sukhbaatar, Jason E Weston, Jing Xu	instruction following, length constraints
Logos as a Well-Tempered Pre-train for Sign Language Recognition	Ilya Ovodov, Petr Surovtsev, Karina Kvanchiani, Alexander Kapitanov, Alexander Nagaev	sign language recognition, pre-training
Evaluation and Facilitation of Online Discussions in the LLM Era: A Survey	Katerina Korre, Dimitris Tsirmpas, Nikos Gkoumas, Emma Cabalé, Danai Myrtzani, Theodoros Evgeniou, Ion Androutsopoulos, John Pavlopoulos	evaluation, online discussions, large language models, survey
Infini-gram mini: Exact n-gram Search at the Internet Scale with FM-Index	Hao Xu, Jiacheng Liu, Yejin Choi, Noah A. Smith, Hannaneh Hajishirzi	n-gram search, information retrieval, internet scale
TokenSelect: Efficient Long-Context Inference and Length Extrapolation for LLMs via Dynamic Token-Level KV Cache Selection	Wei Wu, Zhuoshi Pan, Kun Fu, Chao Wang, Liyi Chen, Yunchu Bai, Tianfu Wang, Zheng Wang, Hui Xiong	long-context inference, large language models, token selection, efficiency
PLAN-TUNING: Post-Training Language Models to Learn Step-by-Step Planning for Complex Problem Solving	Mihir Parmar, Palash Goyal, Xin Liu, Yiwen Song, Mingyang Ling, Chitta Baral, Hamid Palangi, Tomas Pfister	post-training, language models, planning, complex problem solving
s3: You Don’t Need That Much Data to Train a Search Agent via RL	Pengcheng Jiang, Xueqiang Xu, Jiacheng Lin, Jinfeng Xiao, Zifeng Wang, Jimeng Sun, Jiawei Han	search agents, reinforcement learning, data efficiency
Transitive self-consistency evaluation of NLI models without gold labels	Xiaozhou You, Yahui Luo, Lihong Gu	natural language inference, evaluation, self-consistency
Job Unfair: An Investigation of Gender and Occupational Bias in Free-Form Text Completions by LLMs	Rui Liu, Jiahao Cao, Jiaqian Ren, Xu Bai, Yanan Cao	bias, gender bias, occupational bias, large language models, text completions
PathwiseRAG: Multi-Dimensional Exploration and Integration Framework	Guanghui Song, Dongping Liao, Yiren Zhao, Kejiang Ye, Cheng-zhong Xu, Xitong Gao	retrieval-augmented generation, multi-dimensional, integration framework
WildDoc: How Far Are We from Achieving Comprehensive and Robust Document Understanding in the Wild?	Fanzhen Liu, Sharif Abuadbba, Kristen Moore, Surya Nepal, Cecile Paris, Jia Wu, Jian Yang, Quan Z. Sheng	document understanding, robustness, comprehensive analysis
BOUQuET : dataset, Benchmark and Open initiative for Universal Quality Evaluation in Translation	Pierre Andrews, Mikel Artetxe, Mariano Coria Meglioli, Marta R. Costa-jussà, Joe Chuang, David Dale, Mark Duppenthaler, Nathanial Paul Ekberg, Cynthia Gao, Daniel Edward Licht, Jean Maillard, Alexandre Mourachko, Christophe Ropers, Safiyyah Saleem, Eduardo Sánchez, Ioannis Tsiamas, Arina Turkatenko, Albert Ventayol-Boada, Shireen Yates	machine translation, dataset, evaluation, benchmarking
Linguistic Neuron Overlap Patterns to Facilitate Cross-lingual Transfer on Low-resource Languages	Yuemei Xu, Kexin Xu, Jian Zhou, Ling Hu, Lin Gui	cross-lingual transfer, low-resource languages, linguistic neurons
Social Bias in Multilingual Language Models: A Survey	Lance Calvin Lim Gamboa, Yue Feng, Mark G. Lee	social bias, multilingual language models, survey
Exploring Artificial Image Generation for Stance Detection	Zhengkang Zhang, Zhongqing Wang, Guodong Zhou	stance detection, image generation, multimodal
A Graph-Theoretical Framework for Analyzing the Behavior of Causal Language Models	Rashin Rahnamoun, Mehrnoush Shamsfard	graph theory, causal language models, behavior analysis
MobiZO: Enabling Efficient LLM Fine-Tuning at the Edge via Inference Engines	Lei Gao, Amir Ziashahabi, Yue Niu, Salman Avestimehr, Murali Annavaram	large language models, fine-tuning, edge computing, efficiency
Lemmatization of Polish Multi-word Expressions	Magdalena Król, Aleksander Smywiński-Pohl, Zbigniew Kaleta, Paweł Lewkowicz	lemmatization, polish, multi-word expressions
Orchestrating Audio: Multi-Agent Framework for Long-Video Audio Synthesis	Yehang Zhang, Xinli Xu, Xiaojie Xu, Doudou ZHANG, Li Liu, Ying-Cong Chen	multi-agent systems, audio synthesis, long-video, multimodal
Bias Beware: The Impact of Cognitive Biases on LLM-Driven Product Recommendations	Giorgos Filandrianos, Angeliki Dimitriou, Maria Lymperaiou, Konstantinos Thomas, Giorgos Stamou	cognitive biases, large language models, product recommendations, fairness
Cache-Efficient Posterior Sampling for Reinforcement Learning with LLM-Derived Priors Across Discrete and Continuous Domains	Ibne Farabi Shihab, Sanjeda Akter, Anuj Sharma	reinforcement learning, posterior sampling, large language models, efficiency
In Benchmarks We Trust … Or Not?	Ine Gevers, Victor De Marez, Jens Van Nooten, Jens Lemmens, Andriy Kosar, Ehsan Lotfi, Nikolay Banar, Pieter Fivez, Luna De Bruyne, Walter Daelemans	benchmarking, evaluation, trustworthiness
Query-Focused Retrieval Heads Improve Long-Context Reasoning and Re-ranking	Wuwei Zhang, Fangcong Yin, Howard Yen, Danqi Chen, Xi Ye	retrieval, long-context reasoning, re-ranking
Can Large Language Models Be Good Language Teachers?	LiQing Xu, Qiwei Li, Tianshuo Peng, Zuchao Li, hai zhao, Ping Wang	large language models, language teaching, evaluation
The Arabic Generality Score: Another Dimension of Modeling Arabic Dialectness	Sanad Sha’ban, Nizar Habash	arabic dialect, dialect modeling, language scoring
Expectation Preference Optimization: Reliable Preference Estimation for Improving the Reasoning Capability of Large Language Models	Zelin Li, Dawei Song	preference optimization, reasoning, large language models
MemeIntel: Explainable Detection of Propagandistic and Hateful Memes	Mohamed Bayan Kmainasi, Abul Hasnat, Md Arid Hasan, Ali Ezzat Shahroor, Firoj Alam	explainability, meme detection, propaganda, hate speech
Amulet: Putting Complex Multi-Turn Conversations on the Stand with LLM Juries	Sahana Ramnath, ANURAG MUDGIL, Brihi Joshi, Skyler Hallinan, Xiang Ren	multi-turn conversations, large language models, dialogue systems, evaluation
Less is More: The Effectiveness of Compact Typological Language Representations	York Hay Ng, Phuong Hanh Hoang, En-Shiun Annie Lee	typological language representations, compact representations, language typology
Enhanced Noun-Noun Compound Interpretation through Textual Enrichment	Bingyang Ye, Jingxuan Tu, James Pustejovsky	noun-noun compound interpretation, textual enrichment, semantic analysis
Memory OS of AI Agent	Jiazheng Kang, Mingming Ji, Zhe Zhao, Ting Bai	memory systems, AI agents, operating systems
Definition Generation for Word Meaning Modeling: Monolingual, Multilingual, and Cross-Lingual Perspectives	Francesco Periti, Roksana Goworek, Haim Dubossarsky, Nina Tahmasebi	definition generation, word meaning modeling, monolingual, multilingual, cross-lingual
From Word to World: Evaluate and Mitigate Culture Bias in LLMs via Word Association Test	Xunlian Dai, Li Zhou, Benyou Wang, Haizhou Li	culture bias, large language models, evaluation, mitigation
Koel-TTS: Enhancing LLM based Speech Generation with Preference Alignment and Classifier Free Guidance	Shehzeen Samarah Hussain, Paarth Neekhara, Xuesong Yang, Edresson Casanova, Subhankar Ghosh, Roy Fejgin, Mikyas T. Desta, Rafael Valle, Jason Li	speech generation, large language models, preference alignment, classifier-free guidance
Supervised Attention Mechanism for Low-quality Multimodal Data	Sijie Mai, Shiqin Han, Haifeng Hu	attention mechanism, multimodal data, supervised learning, low-quality data
ActionStudio: A Lightweight Framework for Data and Training of Large Action Models	Jianguo Zhang, Thai Quoc Hoang, Ming Zhu, Zuxin Liu, Shiyu Wang, Tulika Manoj Awalgaonkar, Akshara Prabhakar, Haolin Chen, Weiran Yao, Zhiwei Liu, Juntao Tan, Juan Carlos Niebles, Shelby Heinecke, Huan Wang, Silvio Savarese, Caiming Xiong	action models, training frameworks, large models, data management
Generative or Discriminative? Revisiting Text Classification in the Era of Transformers	Siva Rajesh Kasa, Karan Gupta, Sumegh Roychowdhury, Ashutosh Kumar, Yaswanth Biruduraju, SANTHOSH KUMAR KASA, Pattisapu Nikhil Priyatam, Arindam Bhattacharya, Shailendra Agarwal, Vijay huddar	text classification, transformers, generative models, discriminative models
Enhancing Chinese Offensive Language Detection with Homophonic Perturbation	Jonghwi Kim, Deokhyung Kang, Seonjeong Hwang, Yunsu Kim, Jungseul Ok, Gary Lee	offensive language detection, Chinese, perturbation, language detection
Understanding LLMs’ Cross-Lingual Context Retrieval: How Good It Is And Where It Comes From	Chengqian Ma, Wei Tao, Steven Y. Guo	large language models, cross-lingual, context retrieval
Language Models Can be Efficiently Steered via Minimal Embedding Layer Transformations	Nancy Hamdan, Osama Rakan Al Mraikhat, Fadi zaraket	language models, embedding transformations, model efficiency
HealthCards: Exploring Text-to-Image Generation as Visual Aids for Healthcare Knowledge Democratizing and Education	Qian Wu, Zheyao Gao, Longfei Gou, Yifan Hou, Qi Dou	text-to-image generation, healthcare, education, visual aids
Morables: A Benchmark for Assessing Abstract Moral Reasoning in LLMs with Fables	Matteo Marcuzzo, Alessandro Zangari, Andrea Albarelli, Jose Camacho-Collados, Mohammad Taher Pilehvar	benchmark, moral reasoning, large language models, evaluation
InterIDEAS: Philosophical Intertextuality via LLMs	Yue Yang, Yinzhi Xu, Chenghao Huang, JohnMichael Jurgensen, Han Hu, Hao Wang	large language models, intertextuality, philosophy
Flaw or Artifact? Rethinking Prompt Sensitivity in Evaluating LLMs	Andong Hua, Kenan Tang, Chenhe Gu, Jindong Gu, Eric Wong, Yao Qin	large language models, prompt sensitivity, evaluation
RaDeR: Reasoning-aware Dense Retrieval Models	DEBRUP DAS, Sam O’Nuallain, Razieh Rahimi	dense retrieval, reasoning, information retrieval
Think Globally, Group Locally: Evaluating LLMs Using Multi-Lingual Word Grouping Games	César Guerra-Solano, Zhuochun Li, Xiang Lorraine Li	large language models, multilingual, evaluation, word grouping
Learning Subjective Label Distributions via Sociocultural Descriptors	MOHAMMED FAYIZ PARAPPAN, Ricardo Henao	subjective label learning, sociocultural descriptors, classification
Rank-Awareness and Angular Constraints: A New Perspective on Learning Sentence Embeddings from NLI Data	Zicheng Zhou, Min Huang, Qinghai Miao	sentence embeddings, natural language inference, representation learning
PERSEVAL: A Framework for Perspectivist Classification Evaluation	Soda Marem Lo, Silvia Casola, Erhan Sezerer, Valerio Basile, Franco Sansonetti, Antonio Uva, Davide Bernardi	classification evaluation, perspectivist evaluation, frameworks
Collaborative Rational Speech Act: Pragmatic Reasoning for Multi-Turn Dialog	Lautaro Estienne, Gabriel Ben Zenou, Nona Naderi, Jackie CK Cheung, Pablo Piantanida	pragmatic reasoning, multi-turn dialogue, collaborative models
Walk and Read Less: Improving the Efficiency of Vision-and-Language Navigation via Tuning-Free Multimodal Token Pruning	Wenda Qin, Andrea Burns, Bryan A. Plummer, Margrit Betke	vision-and-language navigation, efficiency, multimodal, token pruning
Discriminating Form and Meaning in Multilingual Models with Minimal-Pair ABX Tasks	Maureen de Seyssel, Jie Chi, Skyler Seto, Maartje Ter Hoeve, Masha Fedzechkina, Natalie Schluter	multilingual models, minimal-pair tasks, form and meaning, evaluation
REALM: Recursive Relevance Modeling for LLM-based Document Re-Ranking	Pinhuan Wang, Zhiqiu Xia, Chunhua Liao, Feiyi Wang, Hang Liu	document re-ranking, large language models, recursive relevance modeling
TSVer: A Benchmark for Fact Verification Against Time-Series Evidence	Marek Strong, Andreas Vlachos	fact verification, time-series, benchmark
LaMDAgent: An Autonomous Framework for Post-Training Pipeline Optimization via LLM Agents	Taro Yano	large language models, pipeline optimization, autonomous agents
FLUID QA: A Multilingual Benchmark for Figurative Language Usage in Dialogue across English, Chinese, and Korean	Seoyoon Park, Hyeji Choi, Minseon Kim, Subin An, Xiaonan Wang, Gyuri Choi, Hansaem Kim	figurative language, multilingual, dialogue, benchmark
Probing and Boosting Large Language Models Capabilities via Attention Heads	Dezhi Zhao, Xiaocheng Feng, Xin Liu, Hui Wang, Bing Qin	large language models, attention heads, model probing, model boosting
Detecting Knowledge Boundary of Vision Large Language Models by Sampling-Based Inference	Zhuo Chen, Xinyu Wang, Yong Jiang, Zhen Zhang, Xinyu Geng, Pengjun Xie, Fei Huang, Kewei Tu	knowledge boundary, vision large language models, sampling-based inference
XLQA: A Benchmark for Locale-Aware Multilingual Open-Domain Question Answering	Keonwoo Roh, Yeong-Joon Ju, Seong-Whan Lee	question answering, multilingual, open-domain, benchmark
Subtle Risks, Critical Failures: A Framework for Diagnosing Physical Safety of LLMs for Embodied Decision Making	Yejin Son, Minseo Kim, Sungwoong Kim, Seungju Han, Jian Kim, Dongju Jang, Youngjae Yu, Chan Young Park	physical safety, embodied decision making, large language models, risk analysis
Tokenization and Representation Biases in Multilingual Models on Dialectal NLP Tasks	gzi Shi, Jintian Feng, Shengyingjie Liu, Luona Wei, Zhicheng Dai, Jianwen Sun	tokenization, representation bias, multilingual models, dialectal nlp
Identifying and Answering Questions with False Assumptions: An Interpretable Approach	Zijie Wang, Eduardo Blanco	question answering, false assumptions, interpretability
LLMs Don’t Know Their Own Decision Boundaries: The Unreliability of Self-Generated Counterfactual Explanations	Harry Mayne, Ryan Othniel Kearns, Yushi Yang, Andrew M. Bean, Eoin D. Delaney, Chris Russell, Adam Mahdi	large language models, decision boundaries, counterfactual explanations, reliability
Sketch-of-Thought: Efficient LLM Reasoning with Adaptive Cognitive-Inspired Sketching	Simon A. Aytes, Jinheon Baek, Sung Ju Hwang	large language models, reasoning, cognitive-inspired, efficiency
Towards a Holistic and Automated Evaluation Framework for Multi-Level Comprehension of LLMs in Book-Length Contexts	Yuho Lee, Jiaqi Deng, Nicole Hee-Yeon Kim, Hyangsuk Min, Taewon Yun, Minjeong Ban, Kim Yul, Hwanjun Song	evaluation framework, comprehension, large language models, long context
A Head to Predict and a Head to Question: Pre-trained Uncertainty Quantification Heads for Hallucination Detection in LLM Outputs	Artem Shelmanov, Ekaterina Fadeeva, Akim Tsvigun, Ivan Tsvigun, Zhuohan Xie, Igor Kiselev, Nico Daheim, Caiqi Zhang, Artem Vazhentsev, Mrinmaya Sachan, Preslav Nakov, Timothy Baldwin	hallucination detection, uncertainty quantification, large language models
MUSE: MCTS-Driven Red Teaming Framework for Enhanced Multi-Turn Dialogue Safety in Large Language Models	Siyu Yan, Long Zeng, Xuecheng Wu, Chengcheng Han, Kongcheng Zhang, Chong Peng, Xuezhi Cao, Xunliang Cai, Chenjuan Guo	red teaming, dialogue safety, multi-turn dialogue, large language models
Unveiling the Response of Large Vision-Language Models to Visually Absent Tokens	Sohee Kim, Soohyun Ryu, Joonhyung Park, Eunho Yang	vision-language models, token response, large models
Debiasing Multilingual LLMs in Cross-lingual Latent Space	Viktor Hangya, Fabian Küch, Darina Gold	multilingual, large language models, debiasing, cross-lingual
Persona-Augmented Benchmarking: Evaluating LLMs Across Diverse Writing Styles	Junqi Wu, Jishujie, Kang Zhong, Huiling Peng, Zhendongxiao, Xiongding Liu, Wu Wei	benchmarking, large language models, writing styles, evaluation
Linguistic and Embedding-Based Profiling of Texts Generated by Humans and Large Language Models	Mahdi Zakizadeh, Mohammad Taher Pilehvar	linguistic profiling, embeddings, text generation, large language models
Adversarial Attacks Against Automated Fact-Checking: A Survey	Diogo Tavares, David Semedo, Joao Magalhaes, Alexander Rudnicky	adversarial attacks, fact-checking, survey
Context and POS in Action: A Comparative Study of Chinese Homonym Disambiguation in Human and Language Models	XIE Chenwei, Matthew King-Hang Ma, Wenbo Wang, William Shiyuan Wang	homonym disambiguation, chinese language, pos tagging, language models
Randomly Removing 50% of Dimensions in Text Embeddings has Minimal Impact on Retrieval and Classification Tasks	Sotaro Takeshita, Yurina Takeshita, Daniel Ruffinelli, Simone Paolo Ponzetto	text embeddings, dimensionality reduction, retrieval, classification
MuseScorer: Idea Originality Scoring At Scale	Ali Sarosh Bangash, Krish Veera, Ishfat Abrar Islam, Raiyan Abdul Baten	idea originality, scoring, evaluation
Efficient Context Selection for Long-Context QA: No Tuning, No Iteration, Just Adaptive‑$k$	Chihiro Taguchi, Seiji Maekawa, Nikita Bhutani	long-context question answering, context selection, efficiency
s1: Simple test-time scaling	Niklas Muennighoff, Zitong Yang, Weijia Shi, Xiang Lisa Li, Li Fei-Fei, Hannaneh Hajishirzi, Luke Zettlemoyer, Percy Liang, Emmanuel Candes, Tatsunori Hashimoto	test-time scaling, model efficiency, evaluation
Targeted Distillation for Sentiment Analysis	Yice Zhang, Guangyu Xie, Jingjie Lin, Jianzhu Bao, Qianlong Wang, Xi Zeng, Ruifeng Xu	distillation, sentiment analysis
Interpretable Text Embeddings and Text Similarity Explanation: A Survey	Juri Opitz, Lucas Moeller, Andrianos Michail, Sebastian Padó, Simon Clematide	text embeddings, interpretability, text similarity, survey
Follow the Flow: Fine-grained Flowchart Attribution with Neurosymbolic Agents	Manan Suri, Puneet Mathur, Nedim Lipka, Franck Dernoncourt, Ryan A. Rossi, Vivek Gupta, Dinesh Manocha	flowchart attribution, neurosymbolic agents, fine-grained analysis
DnDScore: Decontextualization and Decomposition for Factuality Verification in Long-Form Text Generation	Miriam Wanner, Benjamin Van Durme, Mark Dredze	factuality verification, long-form text generation, decontextualization, decomposition
Easy as PIE? Identifying Multi-Word Expressions with LLMs	Kai Golan Hashiloni, Ofri Hefetz, Kfir Bar	multi-word expressions, large language models, identification
Empowering Math Problem Generation and Reasoning for Large Language Model via Synthetic Data based Continual Learning Framework	Qian Wan, Wangzi Shi, Jintian Feng, Shengyingjie Liu, Luona Wei, Zhicheng Dai, Jianwen Sun	math problem generation, reasoning, large language models, synthetic data, continual learning
Sparse Autoencoder Features for Classifications and Transferability	Jack Gallifant, Shan Chen, Kuleen Sasse, Hugo Aerts, Thomas Hartvigsen, Danielle Bitterman	autoencoder, classification, transfer learning
How Private are Language Models in Abstractive Summarization?	Anthony Hughes, Ning Ma, Nikolaos Aletras	privacy, large language models, abstractive summarization
VeriLocc: End-to-End Cross-Architecture Register Allocation via LLM	Lesheng Jin, Zhenyuan Ruan, Haohui Mai, Jingbo Shang	register allocation, large language models, cross-architecture
AutoSDT: Scaling Data-Driven Discovery Tasks Toward Open Co-Scientists	Yifei Li, Hanane Nour Moussa, Ziru Chen, Shijie Chen, Botao Yu, Mingyi Xue, Benjamin Burns, Tzu-Yao Chiu, Vishal Dey, Zitong Lu, Chen Wei, Qianheng Zhang, Tianyu Zhang, Song Gao, Xuhui Huang, Xia Ning, Nesreen K. Ahmed, Ali Payani, Huan Sun	data-driven discovery, scaling, scientific tasks
Do All Autoregressive Transformers Remember Facts the Same Way? A Cross-Architecture Analysis of Recall Mechanisms	Minyeong Choe, Haehyun Cho, Changho Seo, Hyunil Kim	autoregressive transformers, recall mechanisms, model analysis
MAviS: A Multimodal Conversational Assistant For Avian Species	Yevheniia Kryklyvets, Mohammed Irfan Kurpath, Sahal Shaji Mullappilly, Jinxing Zhou, Fahad Shahbaz Khan, Rao Muhammad Anwer, Salman Khan, Hisham Cholakkal	multimodal, conversational assistant, avian species, domain-specific
What’s in a prompt? Language models encode literary style in prompt embeddings	Raphaël Sarfati, Haley Moller, Toni J.B. Liu, Nicolas Boulle, Christopher Earls	language models, prompt embeddings, literary style
Grounding Multilingual Multimodal LLMs With Cultural Knowledge	Jean de Dieu Nyandwi, Yueqi Song, Simran Khanuja, Graham Neubig	multilingual, multimodal, large language models, cultural knowledge
From Language to Cognition: How LLMs Outgrow the Human Language Network	Badr AlKhamissi, Greta Tuckute, Yingtian Tang, Taha Osama A Binhuraib, Antoine Bosselut, Martin Schrimpf	large language models, cognition, language network
Improving Large Language Models Function Calling and Interpretability via Guided-Structured Templates	Hy Dang, Tianyi Liu, Zhuofeng Wu, Jingfeng Yang, Haoming Jiang, Tao Yang, Pei Chen, Zhengyang Wang, Helen Wang, Huasheng Li, Bing Yin, Meng Jiang	large language models, function calling, interpretability, templates
Mitigating the Privacy Issues in Retrieval-Augmented Generation (RAG) via Pure Synthetic Data	Shenglai Zeng, Jiankun Zhang, Pengfei He, Jie Ren, Tianqi Zheng, Hanqing Lu, Han Xu, Hui Liu, Yue Xing, Jiliang Tang	privacy, retrieval-augmented generation, synthetic data
Reinforced Query Reasoners for Reasoning-intensive Retrieval Tasks	Xubo Qin, Jun Bai, Jiaqi Li, Zixia Jia, Zilong Zheng	reasoning, retrieval tasks, reinforcement learning
Nullspace Disentanglement for Red Teaming Language Models	Yi Han, Yuanxing Liu, Weinan Zhang, Ting Liu	red teaming, language models, disentanglement, robustness
Semantic Inversion, Identical Replies: Revisiting Negation Blindness in Large Language Models	Jinsung Kim, Seonmin Koo, Heuiseok Lim	negation blindness, large language models, semantic inversion
FuseChat: Knowledge Fusion of Chat Models	Fanqi Wan, Longguang Zhong, Ziyi Yang, Ruijun Chen, Xiaojun Quan	knowledge fusion, chat models, conversational AI
Seeing Through Words, Speaking Through Pixels: Deep Representational Alignment Between Vision and Language Models	Zoe Wanying He, Sean Trott, Meenakshi Khosla	multimodal learning, vision and language models, representation learning
MiLQ: Benchmarking IR Models for Bilingual Web Search with Mixed Language Queries	Wei Wu, Mark Last	information retrieval, bilingual, web search, benchmarking
C3: A Bilingual Benchmark for Spoken Dialogue Models Exploring Challenges in Complex Conversations	Camilla Casula, Sebastiano Vecellio Salto, Elisa Leonardelli, Sara Tonelli	spoken dialogue, bilingual, benchmarking, complex conversations
“Mm, Wat?” Detecting Other-intiated Repair Requests in Dialogue	Hengrui Zhang, Pin-Siang Huang, Zhen Zhang, Peican Lin, Yao-Ching Yu, Bo Hu, Yulu Du	dialogue, repair requests, detection
PIIvot: A Lightweight NLP Anonymization Framework for Question-Anchored Tutoring Dialogues	Matthew Zent, Digory Smith, Simon Woodhead	nlp anonymization, tutoring dialogues, question answering
Attacking Misinformation Detection Using Adversarial Examples Generated by Language Models	Piotr Przybyła, Euan McGill, Horacio Saggion	misinformation detection, adversarial examples, language models, robustness
BYOKG-RAG: Multi-Strategy Graph Retrieval for Knowledge Graph Question Answering	Costas Mavromatis, Soji Adeshina, Vassilis N. Ioannidis, Zhen Han, Qi Zhu, Ian Robinson, Bryan Thompson, Huzefa Rangwala, George Karypis	knowledge graph, question answering, graph retrieval
Rescorla-Wagner Steering of LLMs for Undesired Behaviors over Disproportionate Inappropriate Context	Rushi Wang, Jiateng Liu, Cheng Qian, Yifan Shen, Yanzhou Pan, Zhaozhuo Xu, Ahmed Abbasi, Heng Ji, Denghui Zhang	large language models, behavior control, safety
DRES: Fake news detection by dynamic representation and ensemble selection	Faramarz Farhangian, Leandro Augusto Ensina, George D C Cavalcanti, Rafael M. O. Cruz	fake news detection, dynamic representation, ensemble methods
MR. Judge: Multimodal Reasoner as a Judge	Renjie Pi, Haoping Bai, Qibin Chen, Xiaoming Simon Wang, Jiulong Shan, Xiaojiang Liu, Meng Cao	multimodal, reasoning, evaluation
Causal Interventions Reveal Shared Structure Across English Filler–Gap Constructions	Sasha Boguraev, Christopher Potts, Kyle Mahowald	causal interventions, syntax, linguistic structure
Seeing Culture: A Benchmark for Visual Reasoning and Grounding	Burak Satar, Zhixin Ma, Patrick Amadeus Irawan, Wilfried Ariel Mulyawan, Jing Jiang, Ee-Peng Lim, Chong-Wah Ngo	benchmark, visual reasoning, grounding, multimodal
Massive Supervised Fine-tuning Experiments Reveal How Data, Layer, and Training Factors Shape LLM Alignment Quality	Yuto Harada, Yusuke Yamauchi, Yusuke Oda, Yohei Oseki, Yusuke Miyao, Yu Takagi	large language models, fine-tuning, alignment, training factors
Understanding Subword Compositionality of Large Language Models	Qiwei Peng, Yekun Chai, Anders Søgaard	large language models, subword compositionality, representation learning
Circuit Complexity Bounds for RoPE-based Transformer Architecture	Bo Chen, Xiaoyu Li, Yingyu Liang, Jiangxuan Long, Zhenmei Shi, Zhao Song, Jiahao Zhang	transformers, model architecture, circuit complexity
Video2Roleplay: A Multimodal Dataset and Framework for Video-Guided Role-playing Agents	Xueqiao Zhang, Chao Zhang, Jingtao Xu, Yifan Zhu, Xin Shi, Yi Yang, Yawei Luo	multimodal dataset, video-guided agents, role-playing, multimodal learning
From perception to production: how acoustic invariance facilitates articulatory learning in a self-supervised vocal imitation model	Marvin Lavechin, Thomas Hueber	acoustic invariance, articulatory learning, self-supervised learning, vocal imitation
SUA: Stealthy Multimodal Large Language Model Unlearning Attack	Xianren Zhang, Hui Liu, Delvin Ce Zhang, Xianfeng Tang, Qi He, Dongwon Lee, Suhang Wang	multimodal learning, large language models, security, unlearning attack
A Comprehensive Framework to Operationalize Social Stereotypes for Responsible AI Evaluations	Aida Mostafazadeh Davani, Sunipa Dev, Héctor Pérez-Urbina, Vinodkumar Prabhakaran	social stereotypes, responsible AI, evaluation framework
Model Consistency as a Cheap yet Predictive Proxy for LLM Elo Scores	Ashwin Ramaswamy, Nestor Demeure, Ermal Rrapaj	model consistency, large language models, evaluation metrics
VerIF: Verification Engineering for Reinforcement Learning in Instruction Following	Hao Peng, Yunjia Qi, Xiaozhi Wang, Bin Xu, Lei Hou, Juanzi Li	verification, reinforcement learning, instruction following
DEL-ToM: Inference-Time Scaling for Theory-of-Mind Reasoning via Dynamic Epistemic Logic	Yuheng Wu, Jianwen Xie, Denghui Zhang, Zhaozhuo Xu	theory of mind, reasoning, dynamic epistemic logic, inference-time scaling
A Survey of Link Prediction in N-ary Knowledge Graphs	Jiyao Wei, Saiping Guan, Da Li, Zhongni Hou, Miao Su, Yucan Guo, Xiaolong Jin, Jiafeng Guo, Xueqi Cheng	link prediction, knowledge graphs, n-ary relations, survey
Multi-view-guided Passage Reranking with Large Language Models	Jeongwoo Na, Jun Kwon, Eunseong Choi, Jongwuk Lee	passage reranking, multi-view, large language models
“I’ve Decided to Leak”: Probing Internals Behind Prompt Leakage Intents	Jianshuo Dong, Yutong Zhang, Liu Yan, Zhenyu Zhong, Tao Wei, Tianwei Zhang, Ke Xu, Minlie Huang, Chao Zhang, Han Qiu	prompt leakage, large language models, security, privacy
Improving Task Diversity in Label Efficient Supervised Finetuning of LLMs	Abhinav Arabelly, Jagrut Nemade, Robert D Nowak, Jifan Zhang	task diversity, supervised finetuning, large language models, label efficiency
Context is Gold to find the Gold Passage: Evaluating and Training Contextual Document Embeddings	Qiwei Peng, Guimin Hu, Yekun Chai, Anders Søgaard	document embeddings, evaluation, training, contextual embeddings
Computational Analysis of Character Development in Holocaust Testimonies	Kimberly Truong, Riccardo Fogliato, Hoda Heidari, Steven Wu	computational analysis, character development, historical texts
Exploring the Hidden Capacity of LLMs for One-Step Text Generation	Marine Carpuat, Omri Asscher, Kalika Bali, Luisa Bentivogli, Fred Blain, Lynne Bowker, Monojit Choudhury, Hal Daumé III, Kevin Duh, Ge Gao, Alvin C Grissom II, Marzena Karpinska, Elaine C Khoong, William D. Lewis, Andre Martins, Mary Nurminen, Douglas W. Oard, Maja Popovic, Michel Simard, François Yvon	large language models, text generation, capacity
LingGym: How Far Are LLMs from Thinking Like Field Linguists?	Changbing Yang, Franklin Ma, Freda Shi, Jian Zhu	large language models, linguistics, evaluation
Trustworthy Medical Question Answering: An Evaluation-Centric Survey	Yinuo Wang, Baiyang Wang, Robert E. Mercer, Frank Rudzicz, Sudipta Singha Roy, Pengjie Ren, Zhumin Chen, and Xindi Wang	medical question answering, evaluation, trustworthy ai
Leveraging Loanword Constraints for Improving Machine Translation in a Low-Resource Multilingual Context	Felermino D. M. A. Ali, Henrique Lopes Cardoso, Rui Sousa-Silva	machine translation, low-resource languages, multilingual, loanwords
AFRIDOC-MT: Document-level MT Corpus for African Languages	Jesujoba Oluwadara Alabi, Israel Abebe Azime, Miaoran Zhang, Cristina España-Bonet, Rachel Bawden, Dawei Zhu, David Ifeoluwa Adelani, Clement Oyeleke Odoje, Idris Akinade, Iffat Maab, Davis David, Shamsuddeen Hassan Muhammad, Neo Putini, David O. Ademuyiwa, Andrew Caines, Dietrich Klakow	machine translation, african languages, document-level corpus
DiscoSG: Towards Discourse-Level Text Scene Graph Parsing through Iterative Graph Refinement	Shaoqing Lin, Chong Teng, Fei Li, Donghong Ji, Lizhen Qu, Zhuang Li	discourse parsing, text scene graphs, graph refinement
A Culturally-diverse Multilingual Multimodal Video Benchmark & Model	Bhuiyan Sanjid Shafique, Ashmal Vayani, Muhammad Maaz, Hanoona Abdul Rasheed, Dinura Dissanayake, Mohammed Irfan Kurpath, Yahya Hmaiti, Go Inoue, Jean Lahoud, Md. Safirur Rashid, Shadid Intisar Quasem, Maheen Fatima, Franco Vidal, Mykola Maslych, Ketan Pravin More, Sanoojan Baliah, Hasindri Watawana, Yuhao Li, Fabian Farestam, Leon Schaller, Roman Tymtsiv, Simon Weber, Hisham Cholakkal, Ivan Laptev, Shin’ichi Satoh, Michael Felsberg, Mubarak Shah, Salman Khan, Fahad Shahbaz Khan	multilingual, multimodal, video, benchmarking, cultural diversity
Fann or Flop: A Multigenre, Multiera Benchmark for Arabic Poetry Understanding in LLMs	Wafa Al Ghallabi, Ritesh Thawkar, Sara Ghaboura, Ketan Pravin More, Omkar Thawakar, Hisham Cholakkal, Salman Khan, Rao Muhammad Anwer	benchmarking, poetry understanding, arabic, large language models
LATTE: Learning to Think with Vision Specialists	Zixian Ma, Jianguo Zhang, Zhiwei Liu, Jieyu Zhang, Juntao Tan, Manli Shu, Juan Carlos Niebles, Shelby Heinecke, Huan Wang, Caiming Xiong, Ranjay Krishna, silvio savarese	multimodal learning, vision, large language models
GRADA: Graph-based Reranking against Adversarial Documents Attack	Jingjie Zheng, Aryo Pradipta Gema, Giwon Hong, Xuanli He, Pasquale Minervini, Youcheng Sun, Qiongkai Xu	graph-based methods, reranking, adversarial attacks, document classification
TCP: a Benchmark for Temporal Constraint-Based Planning	Zifeng Ding, Sikuan Yan, Moy Yuan, Xianglong Hu, Fangru Lin, Andreas Vlachos	benchmark, temporal constraint, planning
Dual-Path Dynamic Fusion with Learnable Query for Multimodal Sentiment Analysis	Miao Zhou, Lina Yang, Thomas Wu, Dongnan Yang, Xinru Zhang	multimodal sentiment analysis, dynamic fusion, learnable query
Resource-Rational Noisy-Channel Language Processing: Testing the Effect of Algorithmic Constraints on Inferences	Thomas Hikaru Clark, Jacob Hoover Vigly, Edward Gibson, Roger P. Levy	language processing, noisy-channel model, algorithmic constraints, inference
Robust Adaptation of Large Multimodal Models for Retrieval Augmented Hateful Meme Detection	Jingbiao Mei, Jinghong Chen, Guangyu Yang, Weizhe Lin, Bill Byrne	multimodal models, retrieval augmentation, hateful meme detection, robustness
Stimulate the Critical Thinking of LLMs via Debiasing Discussion	Ruiyu Xiao, Lei Wu, Yuanxing Liu, Weinan Zhang, Ting Liu	critical thinking, large language models, debiasing
Lemmatization as a Classification Task: Results from Arabic across Multiple Genres	Mostafa Saeed, Nizar Habash	lemmatization, classification, arabic, multilingual
Split-Merge: Scalable and Memory-Efficient Merging of Expert LLMs	Sruthi Gorantla, Aditya Rawal, Devamanyu Hazarika, Kaixiang Lin, Mingyi Hong, Mahdi Namazifar	large language models, model merging, scalability, memory efficiency
Structured Moral Reasoning in Language Models: A Value-Grounded Evaluation Framework	Mohna Chakraborty, Lu Wang, David Jurgens	moral reasoning, evaluation framework, large language models
ti‑Modal Document Understanding with Dual‑Cue Page Retrieval and Iterative Refinement	Chelsi Jain, Yiran Wu, Yifan Zeng, Jiale Liu, Shengyu Dai, Zhenwen Shao, Qingyun Wu, Huazheng Wang	document understanding, multimodal, retrieval, iterative refinement
Multi-Frequency Contrastive Decoding: Alleviating Hallucinations for Large Vision-Language Models	Bingqian Liu, Fu Zhang, Guoqing Chen, Jingwei Cheng	contrastive decoding, hallucination, vision-language models, large models
Explaining Differences Between Model Pairs in Natural Language through Sample Learning	Advaith Malladi, Rakesh R Menon, Yuvraj Jain, Shashank Srivastava	model comparison, natural language, sample learning
AmpleHate: Amplifying the Attention for Versatile Implicit Hate Detection	Yejin Lee, Joonghyuk Hahn, Hyeseon Ahn, Yo-Sub Han	hate detection, implicit hate, attention mechanisms
StepER: Step-wise Knowledge Distillation for Enhancing Reasoning Ability in Multi-Step Retrieval-Augmented Language Models	Kyumin Lee, Minjin Jeon, Sanghwan Jang, Hwanjo Yu	knowledge distillation, reasoning, retrieval-augmented models, multi-step reasoning
V-VAE: A Variational Auto Encoding Framework Towards Fine-Grained Control over Human-Like Chat	Qi Lin, Weikai Xu, Lisi Chen, Bin Dai	variational autoencoder, chatbots, fine-grained control, human-like chat
Analysing Chain of Thought Dynamics: Active Guidance or Unfaithful Post-hoc Rationalisation?	Samuel Lewis-Lim, Xingwei Tan, Zhixue Zhao, Nikolaos Aletras	chain of thought, reasoning, interpretability, analysis
Reinforcement Learning for Large Language Models via Group Preference Reward Shaping	Huaisheng Zhu, Siyuan Xu, Hangfan Zhang, Teng Xiao, Zhimeng Guo, Shijie Zhou, Shuyue Hu, Vasant G Honavar	reinforcement learning, large language models, preference reward shaping
AMACE: Automatic Multi-Agent Chart Evolution for Iteratively Tailored Chart Generation	Hyuk Namgoong, Jeesu Jung, Hyeonseok Kang, Sangkeun Jung	multi-agent systems, chart generation, iterative methods
Autoformalization in the Wild: Assessing LLMs on Real-World Mathematical Definitions	Lan Zhang, Marco Valentino, Andre Freitas	autoformalization, large language models, mathematical definitions
Dual-Path Counterfactual Integration for Multimodal Aspect-Based Sentiment Classification	Daiye Miao, Yufang Liu, Jie Wang, Changzhi Sun, Yunke Zhang, Demei Yan, Shaokang Dong, Qi Zhang, Yuanbin Wu	multimodal, sentiment classification, aspect-based, counterfactual integration
An Interdisciplinary Approach to Human-Centered Machine Translation	Sergio E. Zanotto, Segun Aroyehun	machine translation, human-centered, interdisciplinary
Unpacking Let Alone: Human-Scale Models Generalize to a Rare Construction in Form but not Meaning	Wesley Scivetti, Tatsuya Aoyama, Ethan Wilcox, Nathan Schneider	language models, generalization, rare linguistic constructions
Scaling Low-Resource MT via Synthetic Data Generation with LLMs	Ona De Gibert Bonet, Joseph Attieh, Teemu Vahtola, Mikko Aulamo, Zihao Li, Raúl Vázquez, Tiancheng Hu, Jörg Tiedemann	machine translation, low-resource languages, synthetic data, large language models
GLIMPSE: Do Large Vision-Language Models Truly Think With Videos or Just Glimpse at Them?	Yiyang Zhou, Linjie Li, Shi Qiu, Zhengyuan Yang, Yuyang Zhao, Siwei Han, Yangfan He, Kangqi Li, Haonian Ji, Zihao Zhao, Haibo Tong, Lijuan Wang, Huaxiu Yao	vision-language models, video understanding, large models
Hope vs. Hate: Understanding User Interactions with LGBTQ+ News Content in Mainstream US News Media through the Lens of Hope Speech	Jonathan Pofcher, Christopher M Homan, Randall Sell, Ashiqur R. KhudaBukhsh	user interaction, news media, hate speech, hope speech, social media analysis
Membership and Memorization in LLM Knowledge Distillation	Ziqi Zhang, Ali Shahin Shamsabadi, Hanxiao Lu, Yifeng Cai, Hamed Haddadi	knowledge distillation, large language models, memorization
Pointing to a Llama and Call it a Camel: On the Sycophancy of Multimodal Large Language Models	Renjie Pi, Kehao Miao, LI PEIHANG, Runtao Liu, Jiahui Gao, Jipeng Zhang, Xiaofang Zhou	multimodal, large language models, sycophancy, evaluation
Multimodal Neural Machine Translation: A Survey of the State of the Art	Yi Feng, Chuanyi Li, Jiatong He, Zhenyu Hou, Vincent Ng	multimodal, neural machine translation, survey
MADAWSD: Multi-Agent Debate Framework for Adversarial Word Sense Disambiguation	Kaiyuan Zhang, Qian Liu, Luyang Zhang, Chaoqun Zheng, Shuaimin Li, Bing Xu, Muyun Yang, Xinxiao Qiao, Wenpeng Lu	multi-agent systems, adversarial attacks, word sense disambiguation
IndiGEC: Multilingual Grammar Error Correction for Low-Resource Indian Languages	Ujjwal Sharma, Pushpak Bhattacharyya	grammar error correction, multilingual, low-resource languages, indian languages
Internal Chain-of-Thought: Empirical Evidence for Layer‑wise Subtask Scheduling in LLMs	Zhipeng Yang, Junzhuo Li, Siyu Xia, Xuming Hu	large language models, chain-of-thought, subtask scheduling
Connecting the Knowledge Dots: Retrieval-augmented Knowledge Connection for Commonsense Reasoning	Junho Kim, Soyeon Bak, Mingyu Lee, Minju Hong, Songha Kim, Tae-Eui Kam, SangKeun Lee	retrieval-augmented, knowledge connection, commonsense reasoning
Rethinking Text-based Protein Understanding: Retrieval or LLM?	Juntong Wu, Zijing Liu, He CAO, Li Hao, Bin Feng, Zishan Shu, Ke Yu, Li Yuan, Yu Li	protein understanding, text-based, retrieval, large language models
PLLuM-Align: Polish Preference Dataset for Large Language Model Alignment	Karolina Seweryn, Anna Kołos, Agnieszka Karlińska, Katarzyna Lorenc, Katarzyna Dziewulska, Maciej Chrabaszcz, Aleksandra Krasnodębska, Paula Betscher, Zofia Cieślińska, Katarzyna Kowol, Julia Moska, Dawid Motyka, Paweł Walkowiak, Bartosz Żuk, Arkadiusz Janz	dataset, large language model alignment, polish language
Cross-MoE: An Efficient Temporal Prediction Framework Integrating Textual Modality	Ruizheng Huang, Zhicheng Zhang, Yong Wang	temporal prediction, multimodal, efficiency
GRAID: Synthetic Data Generation with Geometric Constraints and Multi-Agentic Reflection for Harmful Content Detection	Melissa Kazemi Rad, Alberto Purpura, Himanshu Kumar, Emily Chen, Mohammad Shahed Sorower	synthetic data generation, harmful content detection, geometric constraints
TaxoAlign: Scholarly Taxonomy Generation Using Language Models	Avishek Lahiri, Yufang Hou, Debarshi Kumar Sanyal	taxonomy generation, language models, scholarly domain
Enhancing Study-Level Inference from Clinical Trial Papers via Reinforcement Learning-Based Numeric Reasoning	Massimiliano Pronesti, Michela Lorandi, Paul Flanagan, Oisín Redmond, Anya Belz, Yufang Hou	clinical trials, reinforcement learning, numeric reasoning
MULTIVOX: A Benchmark for Evaluating Voice Assistants for Multimodal Interactions	Ramaneswaran Selvakumar, Ashish Seth, Nishit Anand, Utkarsh Tyagi, Sonal Kumar, Sreyan Ghosh, Dinesh Manocha	voice assistants, multimodal interactions, benchmarking
Large Language Models Threaten Language’s Epistemic and Communicative Foundations	Shashank Srivastava	large language models, language foundations, epistemic, communicative
Causal Representation Learning from Multimodal Clinical Records under Non-Random Modality Missingness	Zihan Liang, Ziwen Pan, Ruoxuan Xiong	causal representation learning, multimodal clinical records, missing modality
How Does DPO Reduce Toxicity? A Mechanistic Neuron-Level Analysis	Yushi Yang, Filip Sondej, Harry Mayne, Andrew Lee, Adam Mahdi	toxicity reduction, mechanistic analysis, neuron-level, language models
Data-Efficient Hate Speech Detection via Cross-Lingual Nearest Neighbor Retrieval with Limited Labeled Data	Faeze Ghorbanpour, Daryna Dementieva, Alexander Fraser	hate speech detection, cross-lingual, nearest neighbor retrieval, data efficiency
GenLink: Generation-Driven Schema-Linking via Multi-Model Learning for Text-to-SQL	Zhifeng Hao, Junqi Huang, Shaobin Shi, Ruichu Cai, Boyan Xu	text-to-SQL, schema linking, multi-model learning, generation
Correlation-Aware Example Selection for In-Context Learning with Nonsymmetric Determinantal Point Processes	Qiunan Du, Zhiliang Tian, Zhen Huang, Kailun Bian, Tianlun Liu, Zhaoning Zhang, Xinwang Liu, Feng Liu, Dongsheng Li	in-context learning, example selection, determinantal point processes
Finetuning LLMs for Human Behavior Prediction in Social Science Experiments	Akaash Kolluri, Shengguang Wu, Joon Sung Park, Michael S. Bernstein	large language models, finetuning, human behavior prediction, social science
DiNaM: Disinformation Narrative Mining with Large Language Models	Witold Sosnowski, Arkadiusz Modzelewski, Kinga Skorupska, Adam Wierzbicki	disinformation detection, narrative mining, large language models
Context-aware Biases for Length Extrapolation	Ali veisi, Hamidreza Amirzadeh, Amir M. Mansourian	length extrapolation, context-aware biases
Probing Narrative Morals: A New Character-Focused MFT Framework for Use with Large Language Models	Luca Mitran, Sophie Wu, Andrew Piper	narrative analysis, morals, character-focused, large language models
Refining Text Generation for Realistic Conversational Recommendation via Direct Preference Optimization	Manato Tajiri, Michimasa Inaba	text generation, conversational recommendation, preference optimization
A Multi-Level Benchmark for Causal Language Understanding in Social Media Discourse	Xiaohan Ding, Kaike Ping, Buse Çarık, Eugenia Rho	causal language understanding, social media, discourse, benchmark
Graph-Guided Textual Explanation Generation Framework	Shuzhou Yuan, Jingyi Sun, Ran Zhang, Michael Färber, Steffen Eger, Pepa Atanasova, Isabelle Augenstein	explanation generation, graph-based methods, interpretability
Sequential-NIAH: A Needle-In-A-Haystack Benchmark for Extracting Sequential Needles from Long Contexts	Yifei Yu, Qian-Wen Zhang, Lingfeng Qiao, di yin, Fang Li, Jie Wang, ChenZengXi, Suncong Zheng, Xiaolong Liang, Xing Sun	benchmark, long context, information extraction, sequential data
MetaFaith: Faithful Natural Language Uncertainty Expression in LLMs	Gabrielle Kaili-May Liu, Gal Yona, Avi Caciularu, Idan Szpektor, Tim G. J. Rudner, Arman Cohan	uncertainty expression, large language models, faithfulness, natural language
Measuring and Mitigating Media Outlet Name Bias in Large Language Models	Seong-Jin Park, Kang-Min Kim	bias, media outlet, large language models, fairness
MiCRo: Mixture Modeling and Context-aware Routing for Personalized Preference Learning	Jingyan Shen, Jiarui Yao, Rui Yang, Yifan Sun, Feng Luo, Rui Pan, Tong Zhang, Han Zhao	preference learning, mixture modeling, context-aware models, personalization
CAVE : Detecting and Explaining Commonsense Anomalies in Visual Environments	Rishika Bhagwatkar, Syrielle Montariol, Angelika Romanou, Beatriz Borges, Irina Rish, Antoine Bosselut	commonsense reasoning, anomaly detection, visual environments
TrojanStego: Your Language Model Can Secretly Be A Steganographic Privacy Leaking Agent	Dominik Meier, Jan Philip Wahle, Paul Röttger, Terry Ruas, Bela Gipp	large language models, steganography, privacy, security
TALON: A Multi-Agent Framework for Long-Table Exploration and Question Answering	Ruochun Jin, Xiyue Wang, DongWang, Haoqi Zheng, Yunpeng Qi, Silin Yang, Meng Zhang	multi-agent systems, question answering, long-table exploration
From Charts to Fair Narratives: Uncovering and Mitigating Geo-Economic Biases in Chart-to-Text	Ridwan Mahbub, Mohammed Saidul Islam, Mir Tafseer Nayeem, Md Tahmid Rahman Laskar, Mizanur Rahman, Shafiq Joty, Enamul Hoque	chart-to-text, bias mitigation, geo-economic bias, fairness, data-to-text generation
Multilingual vs Crosslingual Retrieval of Fact-Checked Claims: A Tale of Two Approaches	Alan Ramponi, Marco Rovera, Robert Moro, Sara Tonelli	fact-checking, multilingual retrieval, crosslingual retrieval, claim verification
Iterative Multilingual Spectral Attribute Erasure	Shun Shao, Yftah Ziser, Zheng Zhao, Yifu QIU, Shay B Cohen, Anna Korhonen	multilingual, attribute erasure, spectral methods
Exploring morphology-aware tokenization: A case study on Spanish language modeling	Maya Kruse, Majid Afshar, Saksham Khatwani, Anoop Mayampurath, Guanhua Chen, Yanjun Gao	tokenization, morphology, language modeling, Spanish
Are Language Models Consequentialist or Deontological Moral Reasoners?	Yunzhe Wang, Gale Lucas, Burcin Becerik-Gerber, Volkan Ustun	language models, moral reasoning, ethics
ModelCitizens: Representing Community Voices in Online Safety	Rui Wang, Bohao Li, Xiyang Dai, Jianwei Yang, Yi-Ling Chen, Zhen Xing, Yifan Yang, Dongdong Chen, Xipeng Qiu, Zuxuan Wu, Yu-Gang Jiang	online safety, community representation, social media
Cacheback: Speculative Decoding With Nothing But Cache	Zhiyao Ma, In Gim, Lin Zhong	speculative decoding, caching, efficient decoding, language models
Token-level Proximal Policy Optimization for Query Generation	Yichen Ouyang, Lu Wang, Fangkai Yang, Pu Zhao, Chenghua Huang, Jianfeng Liu, Bochen Pang, Yaming Yang, Yuefeng Zhan, Hao Sun, Qingwei Lin, Saravan Rajmohan, Weiwei Deng, Dongmei Zhang, Feng Sun	query generation, reinforcement learning, proximal policy optimization, token-level optimization
Beyond the Leaderboard: Understanding Performance Disparities in Large Language Models via Model Diffing	Sabri Boughorbel, Fahim Dalvi, Nadir Durrani, Majd Hawasly	large language models, performance analysis, model diffing, evaluation
Back Attention: Understanding and Enhancing Multi-Hop Reasoning in Large Language Models	Zeping Yu, Yonatan Belinkov, Sophia Ananiadou	multi-hop reasoning, large language models, attention mechanisms
Collaborative Beam Search: Enhancing LLM Reasoning via Collective Consensus	Yangyifan Xu, Shuo Ren, Jiajun Zhang	beam search, large language models, reasoning, collective consensus
CoMMIT: Coordinated Multimodal Instruction Tuning	Xintong Li, Junda Wu, Tong Yu, Rui Wang, Yu Wang, Xiang Chen, Jiuxiang Gu, Lina Yao, Julian McAuley, Jingbo Shang	multimodal instruction tuning, coordination, large language models
Cache-of-Thought: Master-Apprentice Framework for Cost-Effective Vision Language Model Reasoning	Mingyuan Wu, Jize Jiang, Haozhen Zheng, Meitang Li, Zhaoheng Li, Beitong Tian, Bo Chen, Yongjoo Park, Minjia Zhang, ChengXiang Zhai, Klara Nahrstedt	vision language models, reasoning, efficiency
F²Bench: An Open-ended Fairness Evaluation Benchmark for LLMs with Factuality Considerations	Tian Lan, Jiang Li, Yemin Wang, Xu Liu, Xiangdong Su, Guanglai Gao	fairness, evaluation, large language models, factuality
Unveiling Internal Reasoning Modes in LLMs: A Deep Dive into Latent Reasoning vs. Factual Shortcuts with Attribute Rate Ratio	Yiran Yang, Haifeng Sun, Jingyu Wang, Qi Qi, Zirui Zhuang, Huazheng Wang, Pengfei Ren, Jing Wang, Jianxin Liao	internal reasoning, large language models, factual shortcuts
Plutus: Benchmarking Large Language Models in Low-Resource Greek Finance	Xueqing Peng, Triantafillos Papadopoulos, Efstathia Soufleri, Polydoros Giannouris, Ruoyu Xiang, Yan Wang, Lingfei Qian, Jimin Huang, Qianqian Xie, Sophia Ananiadou	benchmarking, large language models, low-resource languages, finance domain
UNCLE: Benchmarking Uncertainty Expressions in Long-Form Generation	Ruihan Yang, Caiqi Zhang, Zhisong Zhang, Xinting Huang, Dong Yu, Nigel Collier, Deqing Yang	uncertainty, benchmarking, long-form generation
EGOILLUSION: Benchmarking Hallucinations in Egocentric Video Understanding	Ashish Seth, Utkarsh Tyagi, Ramaneswaran Selvakumar, Nishit Anand, Sonal Kumar, Sreyan Ghosh, Ramani Duraiswami, Chirag Agarwal, Dinesh Manocha	hallucination, egocentric video, video understanding, benchmarking
BrailleLLM: Braille Instruction Tuning with Large Language Models for Braille Domain Tasks	Tianyuan Huang, Zepeng Zhu, Hangdi Xing, Zirui Shao, Zhi Yu, Chaoxiong Yang, Jiaxian He, Xiaozhong Liu, Jiajun Bu	braille, instruction tuning, large language models, domain-specific tasks
Disentangling Subjectivity and Uncertainty for Hate Speech Annotation and Modeling using Gaze	Özge Alacam, Sanne Hoeken, Andreas Säuberli, Hannes Gröner, Diego Frassinelli, Sina Zarrieß, Barbara Plank	hate speech, subjectivity, uncertainty, annotation, modeling, gaze tracking
Transformer-Based Temporal Information Extraction and Application: A Review	Xin Su, Phillip Howard, Steven Bethard	temporal information extraction, transformer, review
A Causal Lens for Evaluating Faithfulness Metrics	Kerem Zaman, Shashank Srivastava	causality, faithfulness evaluation, metrics, interpretability
Where to show Demos in Your Prompt: A Positional Bias of In-Context Learning	Kwesi Adu Cobbina, Tianyi Zhou	in-context learning, positional bias, prompt design
Assessing effective de-escalation of crisis conversations using transformer-based models and trend statistics	Ignacio J. Tripodi, Greg Buda, Margaret Meagher, Elizabeth A. Olson	crisis conversation, de-escalation, transformer models, trend analysis
Mind the Value-Action Gap: Do LLMs Act in Alignment with Their Values?	Hua Shen, Nicholas Clark, Tanu Mitra	large language models, alignment, ethics, value-action gap
Enhancing LLM Language Adaption through Cross-lingual In-Context Pre-training	Linjuan Wu, Hao-Ran Wei, Huan Lin, Tianhao Li, Baosong Yang, Fei Huang, Weiming Lu	large language models, cross-lingual, in-context pre-training, language adaptation
CogDual: Enhancing Dual Cognition of LLMs via Reinforcement Learning with Implicit Rule-Based Rewards	Cheng Liu, YifeiLu, Fanghua Ye, Jian Li, Xingyu Chen, Feiliang Ren, Zhaopeng Tu, Xiaolong Li	large language models, reinforcement learning, cognition, rule-based rewards
CLMTracing: Black-box User-level Watermarking for Code Language Model Tracing	Boyu Zhang, Ping He, Tianyu Du, Xuhong Zhang, LEI YUN, Kingsum Chow, Jianwei Yin	code language models, watermarking, model tracing, black-box methods
Improving Handshape Representations for Sign Language Processing: A Graph Neural Network Approach	Alessa Carbo, Eric Nalisnick	sign language processing, handshape representation, graph neural networks
Logit Space Constrained Fine-Tuning for Mitigating Hallucinations in LLM-Based Recommender Systems	Jianfeng Deng, Qingfeng Chen, Debo Cheng, Jiuyong Li, Lin Liu	hallucination mitigation, fine-tuning, large language models, recommender systems
Leveraging Knowledge Graph-Enhanced LLMs for Context-Aware Medical Consultation	Yao Fu, Xianxuan Long, Runchao Li, Haotian Yu, Mu Sheng, Xiaotian Han, Yu Yin, Pan Li	knowledge graphs, large language models, medical consultation, context-aware systems
Can LLMs Extract Frame-Semantic Arguments?	Varun Dhanraj, Chris Eliasmith	large language models, frame-semantic parsing, argument extraction
A Position Paper on the Automatic Generation of Machine Learning Leaderboards	Siddarth Mamidanna, Daking Rai, Ziyu Yao, Yilun Zhou	machine learning, leaderboards, automatic generation
Is Cognition Consistent with Perception? Assessing and Mitigating Multimodal Knowledge Conflicts in Document Understanding	Zirui Shao, Feiyu Gao, Zhaoqing Zhu, Chuwei Luo, Hangdi Xing, Zhi Yu, Qi Zheng, Ming Yan, Jiajun Bu	multimodal learning, document understanding, knowledge conflicts, perception, cognition
LLM-Guided Co-Training for Text Classification	Md Mezbaur Rahman, Cornelia Caragea	large language models, co-training, text classification, semi-supervised learning
Beyond WER: Probing Whisper’s Sub‑token Decoder Across Diverse Language Resource Levels	Siyu Liang, Nicolas Ballier, Gina-Anne Levow, Richard Wright	speech recognition, whisper model, sub-token decoding, language resources
Flexible-length Text Infilling for Discrete Diffusion Models	Andrew Zhang, Anushka Sivakumar, Chia-Wei Tang, Chris Thomas	text infilling, discrete diffusion models, generative models
ResFormer: All-Time Reservoir Memory for Long Sequence Classification	Hongbo Liu, Jia Xu	long sequence classification, memory models, transformers
Reward-Shifted Speculative Sampling Is An Efficient Test-Time Weak-to-Strong Aligner	Bolian Li, Yanran Wu, Xinyu Luo, Ruqi Zhang	sampling, test-time efficiency, alignment
We Politely Insist: Your LLM Must Learn the Persian Art of Taarof	Nikta Gohari Sadr, Sahar Heidariasl, Karine Megerdoomian, Laleh Seyyed-Kalantari, Ali Emami	large language models, politeness, cultural language understanding
Unstructured Evidence Attribution for Long Context Query Focused Summarization	Dustin Wright, Zain Muhammad Mujahid, Lu Wang, Isabelle Augenstein, David Jurgens	summarization, long context, evidence attribution
Direct Judgement Preference Optimization	PeiFeng Wang, Austin Xu, Yilun Zhou, Caiming Xiong, Shafiq Joty	preference optimization, judgement, machine learning
WebInject: Prompt Injection Attack to Web Agents	Xilong Wang, John Bloch, Zedian Shao, Yuepeng Hu, Shuyan Zhou, Neil Zhenqiang Gong	prompt injection, web agents, security
CodeMixBench: Evaluating Code-Mixing Capabilities of LLMs Across 18 Languages	Yilun Yang, Yekun Chai	code-mixing, multilingual, large language models
BabyLM’s First Constructions: Causal interventions provide a signal of learning	Joshua Rozner, Leonie Weissweiler, Cory Shain	causal interventions, language learning, constructions
Effective Red-Teaming of Policy-Adherent Agents	Itay Nakash, George Kour, Koren Lazar, Matan Vetzler, Guy Uziel, Ateret Anaby Tavor	red-teaming, policy adherence, agent systems
CondAmbigQA: A Benchmark and Dataset for Conditional Ambiguous Question Answering	Zongxi Li, Yang Li, Haoran Xie, S. Joe Qin	question answering, ambiguous questions, benchmarks
Personality Vector: Modulating Personality of Large Language Models by Model Merging	Seungjong Sun, Seo Yeon Baek, Jang Hyun Kim	large language models, personality, model merging
ORPP: Self-Optimizing Role-playing Prompts to Enhance Language Model Capabilities	Yifan Duan, Yihong Tang, Kehai Chen, Liqiang Nie, Min Zhang	role-playing prompts, language models, self-optimization, model capabilities
VoiceBBQ: Investigating Effect of Content and Acoustics in Social Bias of Spoken Language Model	Junhyuk Choi, Ro-hoon Oh, Jihwan Seol, Bugeun Kim	social bias, spoken language models, content effect, acoustics effect
Can Large Language Models Act as Ensembler for Multi-GNNs?	Hanqi Duan, Yao Cheng, Jianxiang Yu, Yao Liu, Xiang Li	large language models, ensembling, graph neural networks
FISTAPruner: Layer-wise Post-training Pruning for Large Language Models	Pengxiang Zhao, Hanyu Hu, Ping Li, Yi ZHENG, Zhefeng Wang, Xiaoming Yuan	large language models, model pruning, efficiency, post-training
Machine-generated text detection prevents language model collapse	George Drayson, Emine Yilmaz, Vasileios Lampos	machine-generated text detection, language model collapse, robustness
The Good, the Bad, and the Debatable: A Survey on the Impacts of Data for In-Context Learning	Stephanie Schoch, Yangfeng Ji	survey, data impact, in-context learning
Towards Infinite-Long Prefix in Transformer	Yingyu Liang, Zhenmei Shi, Zhao Song, Chiwun Yang	transformers, long context, model architecture
Beyond Online Sampling: Bridging Offline-to-Online Alignment via Dynamic Data Transformation for LLMs	Zhang Zhang, Guhao Feng, Jian Guan, Di He, Wei Wu	large language models, data transformation, offline-to-online alignment
Frequency & Compositionality in Emergent Communication	Jean-Baptiste Sevestre, Emmanuel Dupoux	emergent communication, frequency, compositionality
Improving Neutral Point-of-View Generation with Data- and Parameter-Efficient RL	Jessica Hoffmann, Christiane Ahlheim, Zac Yu, Aria Walfrand, Jarvis Jin, Marie Tano, Ahmad Beirami, Erin MacMurray van Liemt, Nithum Thain, Hakim Sidahmed, Lucas Dixon	point-of-view generation, reinforcement learning, data efficiency, parameter efficiency
Agent-to-Agent Theory of Mind: Testing Interlocutor Awareness among Large Language Models	Younwoo Choi, Changling Li, Yongjin Yang, Zhijing Jin	large language models, theory of mind, agent interaction, awareness
LiTransProQA: An LLM-based Literary Translation Evaluation Metric with Professional Question Answering	Ran Zhang, Wei Zhao, Lieve Macken, Steffen Eger	literary translation, evaluation metrics, large language models, question answering
SCRIBE: Structured Chain Reasoning for Interactive Behaviour Explanations using Tool Calling	Fares Fawzi, Vinitra Swamy, Dominik Glandorf, Tanya Nazaretsky, Tanja Käser	structured chain reasoning, interactive explanations, tool calling
Quantized but Deceptive? A Multi-Dimensional Truthfulness Evaluation of Quantized LLMs	Nir Sweed, Hanit Hakim, Ben Wolfson, Hila Lifshitz, Dafna Shahaf	quantized models, large language models, evaluation, truthfulness
Improving Rule-based Reasoning in LLMs using Neurosymbolic Representations	DongGeon Lee, Joonwon Jang, Jihae Jeong, Hwanjo Yu	rule-based reasoning, large language models, neurosymbolic representations
PatentScore: Multi-dimensional Evaluation of LLM-Generated Patent Claims	Keenan Samway, Max Kleiman-Weiner, David Guzman Piedrahita, Rada Mihalcea, Bernhard Schölkopf, Zhijing Jin	patent claim evaluation, large language models, multi-dimensional evaluation
UnifiedVisual: A Framework for Constructing Unified Vision-Language Datasets	Ashima Suvarna, Christina A Chance, Karolina Naranjo, Hamid Palangi, Sophie Hao, Thomas Hartvigsen, Saadia Gabriel	vision-language datasets, dataset construction, unified framework
Demystifying Domain-adaptive Post-training for Financial LLMs	Zixuan Ke, Yifei Ming, Xuan-Phi Nguyen, Caiming Xiong, Shafiq Joty	domain adaptation, post-training, financial large language models, transfer learning
X-CoT: Explainable Text-to-Video Retrieval via LLM-based Chain-of-Thought Reasoning	Prasanna Reddy Pulakurthi, Jiamian Wang, MAJID RABBANI, Sohail Dianat, Raghuveer Rao, Zhiqiang Tao	text-to-video retrieval, explainability, chain-of-thought reasoning, large language models
LoRACoE: Improving Large Language Model via Composition-based LoRA Expert	Guanyu Li, Zhiheng Xi, Zhihao Zhang, Boyang Hong, Tao Gui, Qi Zhang, Xuanjing Huang	large language models, model improvement, LoRA, composition-based methods
Analyzing Uncertainty of LLM-as-a-Judge: Interval Evaluations with Conformal Prediction	Huanxin Sheng, Xinyi Liu, Hangfeng He, Jieyu Zhao, Jian Kang	uncertainty analysis, large language models, evaluation, conformal prediction
Toward Multi-Session Personalized Conversation: A Large-Scale Dataset and Hierarchical Tree Framework for Implicit Reasoning	Xintong Li, Jalend Bantupalli, Ria Dharmani, Yuwei Zhang, Jingbo Shang	personalized conversation, datasets, implicit reasoning, hierarchical models
Video Compression Commander: Plug-and-Play Inference Acceleration for Video Large Language Models	Xuyang Liu, Yiyu Wang, Junpeng Ma, Linfeng Zhang	video compression, large language models, inference acceleration
Language Models as Causal Effect Generators	Lucius E.J. Bynum, Kyunghyun Cho	causal effect, language models
Large Language Models Meet Knowledge Graphs for Question Answering: Synthesis and Opportunities	Chuangtao Ma, Yongrui Chen, Tianxing Wu, Arijit Khan, Haofen Wang	large language models, knowledge graphs, question answering
MERMAID: Multi-perspective Self-reflective Agents with Generative Augmentation for Emotion Recognition	Zhongyu Yang, Junhao Song, Siyang Song, Wei Pang, Yingfang Yuan	emotion recognition, generative models, self-reflective agents
LASER: An LLM-based ASR Scoring and Evaluation Rubric	Amruta Parulekar, Preethi Jyothi	automatic speech recognition, evaluation, large language models
Beyond Text: Unveiling Privacy Vulnerabilities in Multi-modal Retrieval-Augmented Generation	Jiankun Zhang, Shenglai Zeng, Jie Ren, Tianqi Zheng, Hui Liu, Xianfeng Tang, Hui Liu, Yi Chang	privacy, multimodal, retrieval-augmented generation
Profiler: Black-box AI-generated Text Origin Detection via Context-aware Inference Pattern Analysis	Hanxi Guo, Siyuan Cheng, Xiaolong Jin, ZHUO ZHANG, Guangyu Shen, Kaiyuan Zhang, Shengwei An, Guanhong Tao, Xiangyu Zhang	AI-generated text detection, black-box methods, inference pattern analysis
Speech Discrete Tokens or Continuous Features? A Comparative Analysis for Spoken Language Understanding in SpeechLLMs	Dingdong WANG, Junan Li, Mingyu Cui, Dongchao Yang, Xueyuan Chen, Helen M. Meng	spoken language understanding, speech LLMs, discrete tokens, continuous features
MPCG: Multi-Round Persona-Conditioned Generation for Modeling the Evolution of Misinformation with LLMs	Chong Jun Rong Brian, Yixuan Tang, Anthony Kum Hoe Tung	large language models, misinformation, persona-conditioned generation, text generation
Personalization up to a Point: Why Personalized Content Moderation Needs Boundaries, and How We Can Enforce Them	Emanuele Moscato, Tiancheng Hu, Matthias Orlikowski, Paul Röttger, Debora Nozza	content moderation, personalization, fairness, ethics
Compound AI Systems Optimization: A Survey of Methods, Challenges, and Future Directions	Yu-Ang Lee, Guan-Ting Yi, Mei-Yi Liu, Jui-Chao Lu, Guan-Bo Yang, Yun-Nung Chen	compound AI systems, optimization, survey, challenges, future directions
y-Aware Reasoning Can Defend Large Language Models from Jailbreaking	Junda Zhu, Lingyong Yan, Shuaiqiang Wang, Dawei Yin, Lei Sha	large language models, reasoning, security, robustness
It’s All About In-Context Learning! Teaching Extremely Low-Resource Languages to LLMs	Yue Li, Zhixue Zhao, Carolina Scarton	in-context learning, low-resource languages, large language models
Too Helpful, Too Harmless, Too Honest or Just Right?	Gautam Siddharth Kashyap, Mark Dras, Usman Naseem	language model behavior, helpfulness, harmlessness, honesty, evaluation
Playpen: An Environment for Exploring Learning From Dialogue Game Feedback	Nicola Horst, Davide Mazzaccara, Antonia Schmidt, Michael Sullivan, Filippo Momentè, Luca Franceschetti, Philipp Sadler, Sherzod Hakimov, Alberto Testoni, Raffaella Bernardi, Raquel Fernández, Alexander Koller, Oliver Lemon, David Schlangen, Mario Giulianelli, Alessandro Suglia	dialogue systems, learning from feedback, game environment
Improving Online Job Advertisement Analysis via Compositional Entity Extraction	Kai Krüger, Stefan Winnige, Alan Akbik, Johanna Binnewitt, Kathrin Ehmann	entity extraction, job advertisement analysis, compositional methods
Type-Less yet Type-Aware Inductive Link Prediction with Pretrained Language Models	Alessandro De Bellis, Salvatore Bufi, Giovanni Servedio, Vito Walter Anelli, Tommaso Di Noia, Eugenio Di Sciascio	link prediction, pretrained language models, inductive learning
Assay2Mol: Large Language Model-based Drug Design Using BioAssay Context	Yifan Deng, Spencer S Ericksen, Anthony Gitter	large language models, drug design, bioassay context
Efficient Unstructured Pruning of Mamba State-Space Models for Resource-Constrained Environments	Ibne Farabi Shihab, Sanjeda Akter, Anuj Sharma	model pruning, state-space models, efficiency, resource-constrained environments
The Good, the Bad and the Constructive: Automatically Measuring Peer Review’s Utility for Authors	Abdelrahman Sadallah, Tim Baumgärtner, Iryna Gurevych, Ted Briscoe	peer review, evaluation, utility measurement, automatic assessment
Instructing Large Language Models for Low-Resource Languages: A Systematic Study for Basque	Oscar Sainz, Naiara Perez, Julen Etxaniz, Joseba Fernandez de Landa, Itziar Aldabe, Iker García-Ferrero, Aimar Zabala, Ekhi Azurmendi, German Rigau, Eneko Agirre, Mikel Artetxe, Aitor Soroa	large language models, low-resource languages, basque, instruction tuning
PACHAT: Persona-Aware Speech Assistant for Multi-party Dialogue	Dongjie Fu, Xize Cheng, Linjun Li, Xiaoda Yang, Lujia Yang, Tao Jin	speech assistant, multi-party dialogue, persona awareness
Reflective Agreement: Combining Self-Mixture of Agents with a Sequence Tagger for Robust Event Extraction	Su-Hyeong Park, Ho-Beom Kim, Seong-Jin Park, Dinara Aliyeva, Kang-Min Kim	event extraction, sequence tagging, multi-agent systems
Accelerated Test-Time Scaling with Model-Free Speculative Sampling	Jacob Devasier, Rishabh Mediratta, Chengkai Li	test-time scaling, model-free methods, sampling
All for One: LLMs Solve Mental Math at the Last Token With Information Transferred From Other Tokens	Yongmin Yoo, Qiongkai Xu, Longbing Cao	large language models, mental math, token information transfer
The Pursuit of Empathy: Evaluating Small Language Models for PTSD Dialogue Support	Pengyu Wang, Shaojun Zhou, Chenkun Tan, Xinghao Wang, Wei Huang, Zhen Ye, Zhaowei Li, Botian Jiang, Dong Zhang, Xipeng Qiu	small language models, empathy, PTSD, dialogue support
HICode: Hierarchical Inductive Coding with LLMs	Mian Zhong, Pristina Wang, Anjalie Field	hierarchical coding, inductive coding, large language models, text coding
A Multilingual, Culture-First Approach to Addressing Misgendering in LLM Applications	Sunayana Sitaram, Adrian de Wynter, Isobel McCrum, Qilong Gu, Si-Qing Chen	multilingual, fairness, bias, misgendering, large language models
Same Question, Different Words: A Latent Adversarial Framework for Prompt Robustness	Tingchen Fu, Fazl Barez	prompt robustness, adversarial learning, latent frameworks
CaKE: Circuit-aware Editing Enables Generalizable Knowledge Learners	Yunzhi Yao, Jizhan Fang, Jia-Chen Gu, Ningyu Zhang, Shumin Deng, Huajun Chen, Nanyun Peng	knowledge editing, circuit-aware models, generalization
Unlearning vs. Obfuscation: Are We Truly Removing Knowledge?	Guangzhi Sun, Potsawee Manakul, Xiao Zhan, Mark Gales	unlearning, knowledge removal, obfuscation
Foot-In-The-Door: A Multi-turn Jailbreak for LLMs	Zixuan Weng, Xiaolong Jin, Jinyuan Jia, Xiangyu Zhang	large language models, security, jailbreak attacks
Constructions are Revealed in Word Distributions	Joshua Rozner, Leonie Weissweiler, Kyle Mahowald, Cory Shain	word distributions, linguistic constructions
Hidden in Plain Sight: Reasoning in Underspecified and Misspecified Scenarios for Multimodal LLMs	Qianqi Yan, Hongquan Li, Shan Jiang, Yang Zhao, Xinze Guan, Ching-Chen Kuo, Xin Eric Wang	multimodal language models, reasoning, underspecified scenarios
Code Execution as Grounded Supervision for LLM Reasoning	Dongwon Jung, Wenxuan Zhou, Muhao Chen	code execution, large language models, reasoning, supervision
Social Genome: Grounded Social Reasoning Abilities of Multimodal Models	Leena Mathur, Marian Qian, Paul Pu Liang, Louis-Philippe Morency	multimodal models, social reasoning
Adaptively profiling models with task elicitation	Davis Brown, Prithvi Balehannina, Helen Jin, Shreya Havaldar, Hamed Hassani, Eric Wong	model profiling, task elicitation, adaptivity
Toward Machine Translation Literacy: How Lay Users Perceive and Rely on Imperfect Translations	Yimin Xiao, Yongle Zhang, Dayeon Ki, Calvin Bao, Marianna J. Martindale, Charlotte Vaughn, Ge Gao, Marine Carpuat	machine translation, user study, translation quality, human-computer interaction
FillerSpeech: Towards Human-Like Text-to-Speech Synthesis with Filler Insertion and Filler Style Control	Seung-Bin Kim, Jun-Hyeok Cha, Hyung-Seok Oh, Heejin Choi, Seong-Whan Lee	text-to-speech, speech synthesis, filler insertion, style control
CodeSSM: Towards State Space Models for Code Understanding	Shweta Verma, Abhinav Anand, Mira Mezini	code understanding, state space models, program analysis
The Validation Gap: A Mechanistic Analysis of How Language Models Compute Arithmetic but Fail to Validate It	Leonardo Bertolazzi, Philipp Mondorf, Barbara Plank, Raffaella Bernardi	language models, arithmetic, mechanistic analysis, validation
Multilingual Pretraining for Pixel Language Models	Ilker Kesen, Jonas F. Lotz, Ingo Ziegler, Phillip Rust, Desmond Elliott	multilingual pretraining, pixel language models, multimodal, pretraining
Cardiverse: Harnessing LLMs for Novel Card Game Prototyping	Danrui Li, Sen Zhang, Samuel S. Sohn, Kaidong Hu, Muhammad Usman, Mubbasir Kapadia	large language models, game prototyping, interactive applications
AlphaOne: Reasoning Models Thinking Slow and Fast at Test Time	Junyu Zhang, Runpei Dong, Han Wang, Xuying Ning, Haoran Geng, Peihao Li, Xialin He, Yutong Bai, Jitendra Malik, Saurabh Gupta, Huan Zhang	reasoning models, test-time adaptation, large language models
Leveraging Cognitive Complexity of Texts for Contextualization in Dense Retrieval	Effrosyni Sokli, Georgios Peikos, Pranav Kasela, Gabriella Pasi	dense retrieval, cognitive complexity, text contextualization
Beyond Correctness: Confidence-Aware Reward Modeling for Enhancing Large Language Model Reasoning	Qianxi He, Qingyu Ren, Shanzhe Lei, Xuhong Wang, Yingchun Wang	large language models, reasoning, reward modeling, confidence awareness
You Are What You Train: Effects of Data Composition on Training Context-aware Machine Translation Models	Paweł Mąka, Yusuf Can Semerci, Jan Scholtes, Gerasimos Spanakis	machine translation, data composition, context-aware models
Deriving Strategic Market Insights with Large Language Models: A Benchmark for Forward Counterfactual Generation	Keane Ong, Rui Mao, Deeksha varshney, Paul Pu Liang, Erik Cambria, Gianmarco Mengaldo	market insights, large language models, counterfactual generation, benchmarking
Evolving Chinese Spelling Correction with Corrector-Verifier Collaboration	Linfeng Liu, Hongqiu Wu, hai zhao	spelling correction, chinese language, corrector-verifier collaboration, error correction
SOCIAL SCAFFOLDS: A Generalization Framework for Social Understanding Tasks	Ritam Dutt, Carolyn Rose, Maarten Sap	social understanding, generalization framework, social tasks
Reasoning-to-Defend: Safety-Aware Reasoning Can Defend Large Language Models from Jailbreaking	Junda Zhu, Lingyong Yan, Shuaiqiang Wang, Dawei Yin, Lei Sha	large language models, safety, reasoning, jailbreaking defense
Simple Yet Effective: An Information-Theoretic Approach to Multi-LLM Uncertainty Quantification	Fatemeh Haji, Mazal Bethany, Cho-Yu Jason Chiang, Anthony Rios, Peyman Najafirad	uncertainty quantification, large language models, information theory
Enhancing RLHF with Human Gaze Modeling	Woomin Song, Saket Dingliwal, Sai Muralidhar Jayanthi, Bhavana Ganesh, Jinwoo Shin, Aram Galstyan, Sravan Babu Bodapati	reinforcement learning, human gaze modeling, alignment
SimMark: A Robust Sentence-Level Similarity-Based Watermarking Algorithm for Large Language Models	Roelien C. Timmer, Yufang Hou, Stephen Wan	watermarking, sentence similarity, large language models
Router-Tuning: A Simple and Effective Approach for Dynamic Depth	Shwai He, Tao Ge, Guoheng Sun, Bowei Tian, Xiaoyang Wang, Dong Yu	model tuning, dynamic depth, neural networks
MA-DPR: Manifold-aware Distance Metrics for Dense Passage Retrieval	Yifan Liu, Qianfeng Wen, Mark Zhao, Jiazhou Liang, Scott Sanner	dense passage retrieval, distance metrics, manifold learning, information retrieval
Prior Prompt Engineering for Reinforcement Fine-Tuning	Pittawat Taveekitworachai, Potsawee Manakul, Sarana Nutanong, Kunat Pipatanakul	prompt engineering, reinforcement learning, fine-tuning
Explicit Learning and the LLM in Machine Translation	Malik Marmonier, Rachel Bawden, Benoît Sagot	machine translation, explicit learning, large language models
Value Profiles for Encoding Human Variation	Taylor Sorensen, Pushkar Mishra, Roma Patel, Michael Henry Tessler, Michiel A. Bakker, Georgina Evans, Iason Gabriel, Noah Goodman, Verena Rieser	human variation, encoding, value profiles
TFDP: Token-Efficient Disparity Audits for Autoregressive LLMs via Single-Token Masked Evaluation	Inderjeet Singh, Ramya Srinivasan, Roman Vainshtein, Hisashi Kojima	autoregressive language models, evaluation, efficiency, fairness audits
Subjective Behaviors and Preferences in LLM: Language of Browsing	Sai Sundaresan, Harshita Chopra, Atanu R. Sinha, Koustava Goswami, Nagasai Saketh Naidu, Raghav Karan, N Anushka	large language models, user behavior, preferences, browsing
TactfulToM: Do LLMs have the Theory of Mind ability to understand White Lies?	Yiwei Liu, Emma Jane Pretty, Jiahao Huang, Saku Sugawara	large language models, theory of mind, white lies, social cognition
Multi-LMentry: Can Multilingual LLMs Solve Elementary Tasks Across Languages?	Luca Moroni, Javier Aula-Blasco, Simone Conia, Irene Baucells, Naiara Perez, Silvia Paniagua Suárez, Anna Sallés, Malte Ostendorff, Júlia Falcão, Guijin Son, Aitor Gonzalez-Agirre, Roberto Navigli, Marta Villegas	multilingual models, large language models, elementary tasks, cross-lingual
LoCt-Instruct: An Automatic Pipeline for Constructing Datasets of Logical Continuous Instructions	Hongyu Sun, Yusuke Sakai, Haruki Sakajo, Shintaro Ozaki, Kazuki Hayashi, Hidetaka Kamigaito, Taro Watanabe	dataset construction, instructions, logical reasoning, continuous instructions
NitiBench: Benchmarking LLM Frameworks on Thai Legal Question Answering Capabilities	Pawitsapak Akarajaradwong, Pirat Pothavorn, Chompakorn Chaksangchaichot, Panuthep Tasawong, Thitiwat Nopparatbundit, Keerakiat Pratai, Sarana Nutanong	benchmarking, large language models, legal domain, question answering
Towards Event Extraction with Massive Types: LLM-based Collaborative Annotation and Partitioning Extraction	Wenxuan Liu, Zixuan Li, Long Bai, Yuxin Zuo, Daozhu Xu, Xiaolong Jin, Jiafeng Guo, Xueqi Cheng	event extraction, large language models, annotation, partitioning
Personalized Language Models via Privacy-Preserving Evolutionary Model Merging	Kyuyoung Kim, Jinwoo Shin, Jaehyung Kim	personalized language models, privacy-preserving, model merging, evolutionary algorithms
Do LLMs Encode Frame Semantics? Evidence from Frame Identification	Jayanth Krishna Chundru, Rudrashis Poddar, Jie Cao, Tianyu Jiang	large language models, frame semantics, semantic parsing, frame identification
Mixture of Languages: Improved Multilingual Encoders Through Language Grouping	João Maria Janeiro, Belen Alastruey, Francisco Massa, Maha Elbayad, Benjamin Piwowarski, Patrick Gallinari, Loic Barrault	multilingual encoders, language grouping, multilingual NLP
Where Confabulation Lives: Latent Feature Discovery in LLMs	Thibaud Ardoin, Yi Cai, Gerhard Wunder	latent features, confabulation, large language models
When Words Smile: Generating Diverse Emotional Facial Expressions from Text	Haidong Xu, Meishan Zhang, Hao Ju, Zhedong Zheng, Erik Cambria, Min Zhang, Hao Fei	text-to-image, emotional expression generation, multimodal, facial expressions
Order Doesn’t Matter, But Reasoning Does: Training LLMs with Order-Centric Augmentation	Qianxi He, Qianyu He, Jiaqing Liang, Weikang Zhou, Zeye Sun, Fei Yu, Yanghua Xiao	large language models, reasoning, data augmentation
MrGuard: A Multilingual Reasoning Guardrail for Universal LLM Safety	Yahan Yang, Soham Dan, Shuo Li, Dan Roth, Insup Lee	large language models, multilingual, reasoning, safety
Interdisciplinary Research in Conversation: A Case Study in Computational Morphology for Language Documentation	Enora Rice, Katharina von der Wense, Alexis Palmer	computational morphology, language documentation, conversation analysis
M2Edit: Locate and Edit Multi-Granularity Knowledge in Multimodal Large Language Model	Yang Zhou, Pengfei Cao, Yubo Chen, Qingbin Liu, Dianbo Sui, Xi Chen, Kang Liu, Jun Zhao	multimodal large language models, knowledge editing, multi-granularity knowledge, model editing
Beyond A Single AI Cluster: A Survey of Decentralized LLM Training	Haotian Dong, Jingyan Jiang, Rongwei Lu, Jiajun Luo, Jiajun Song, Bowen Li, Ying Shen, Zhi Wang	large language models, decentralized training, survey
Towards Statistical Factuality Guarantee for Large Vision-Language Models	Zhuohang Li, Chao Yan, Nicholas J Jackson, Wendi Cui, Bo Li, Jiaxin Zhang, Bradley A. Malin	vision-language models, factuality, statistical guarantees
Are Vision-Language Models Safe in the Wild? A Meme-Based Benchmark Study	Xiaoyuan Wu, Weiran Lin, Omer Akgul, Lujo Bauer	vision-language models, safety, benchmarking, memes
Implicit Behavioral Alignment of Language Agents in High-Stakes Crowd Simulations	Aneesh Komanduri, Karuna Bhaila, Xintao Wu	behavioral alignment, language agents, crowd simulations
SERVAL: Surprisingly Effective Zero-Shot Visual Document Retrieval Powered by Large Vision and Language Models	Amirhossein Dabiriaghdam, Lele Wang	zero-shot learning, visual document retrieval, vision-language models
MMDocIR: Benchmarking Multimodal Retrieval for Long Documents	Kuicai Dong, Yujing Chang, Derrick Goh Xin Deik, Dexun Li, Ruiming Tang, Yong Liu	multimodal retrieval, long documents, benchmarking, information retrieval
LeanK: Learnable K Cache Channel Pruning for Efficient Decoding	Yike Zhang, Zhiyuan He, Huiqiang Jiang, Chengruidong Zhang, Yuqing Yang, Jianyong Wang, Lili Qiu	channel pruning, efficient decoding, learnable cache, model compression
\\texttt{Droid}: A Resource Suite for AI-Generated Code Detection	Daniil Orel, Indraneil Paul, Iryna Gurevych, Preslav Nakov	code detection, ai-generated code, resource suite, software analysis
Transferable Direct Prompt Injection via Activation-Guided MCMC Sampling	Minghui Li, Hao Zhang, Yechao Zhang, Wei Wan, Shengshan Hu, pei Xiaobing, Jing Wang	prompt injection, security, MCMC sampling
RBPtool: A Deep Language Model Framework for Multi-Resolution RBP-RNA Binding Prediction and RNA Molecule Design	Jiyue Jiang, Yitao Xu, Zikang Wang, Yihan Ye, Yanruisheng Shao, Yuheng Shan, Jiuming Wang, Xiaodan Fan, Jiao Yuan, Yu Li	RNA binding prediction, RNA molecule design, deep language models
PrimeX: A Dataset of Worldview, Opinion, and Explanation	Rik Koncel-Kedziorski, Brihi Joshi, Tim Paek	datasets, opinion mining, explanation, worldview
Balcony: A Lightweight Approach to Dynamic Inference of Generative Language Models	Benyamin Jamialahmadi, Parsa Kavehzadeh, Mehdi Rezagholizadeh, Parsa Farinneya, Hossein Rajabzadeh, Aref Jafari, Boxing Chen, Marzieh S. Tahaei	generative language models, dynamic inference, efficiency
LiteraryQA: Towards Effective Evaluation of Long-document Narrative QA	Tommaso Bonomo, Luca Gioffré, Roberto Navigli	question answering, long documents, narrative QA, evaluation
PerspectiveMod: A Perspectivist Resource for Deliberative Moderation	Eva Maria Vecchi, Neele Falk, Carlotta Quensel, Iman Jundi, Gabriella Lapesa	content moderation, resources, deliberation, fairness
xCoRe: Cross-context Coreference Resolution	Giuliano Martinelli, Bruno Gatti, Roberto Navigli	coreference resolution, cross-context, natural language processing
$Wojood^{Relations}$: Arabic Relation Extraction Corpus and Modeling	Alaa Aljabari, Mohammed Khalilia, Mustafa Jarrar	relation extraction, Arabic, corpus, modeling
RAED: Retrieval-Augmented Entity Description Generation for Emerging Entity Linking and Disambiguation	Karim Ghonim, Pere-Lluís Huguet Cabot, Riccardo Orlando, Roberto Navigli	entity linking, retrieval-augmented generation, entity description, disambiguation
Improving Instruct Models for Free: A Study on Partial Adaptation	Ozan Irsoy, Pengxiang Cheng, Jennifer L Chen, Daniel Preotiuc-Pietro, Shiyue Zhang, Duccio Pappadopulo	instruction tuning, model adaptation, large language models
SemVink: Advancing VLMs’ Semantic Understanding of Optical Illusions via Visual Global Thinking	Sifan Li, Yujun Cai, Yiwei Wang	vision-language models, semantic understanding, optical illusions
Summarizing Speech: A Comprehensive Survey	Fabian Retkowski	speech summarization, survey
Randomized Smoothing Meets Vision-Language Models	Emmanouil Seferis, Changshun Wu, Stefanos Kollias, Saddek Bensalem, Chih-Hong Cheng	vision-language models, randomized smoothing, robustness
Toward Efficient Sparse Autoencoder-Guided Steering for Improved In-Context Learning in Large Language Models	Ikhyun Cho, Julia Hockenmaier	large language models, in-context learning, sparse autoencoder, efficiency
Do LLMs Behave as Claimed? Investigating How LLMs Follow Their Own Claims using Counterfactual Questions	Haochen Shi, Shaobo Li, Guoqing Chao, Xiaoliang Shi, Wentao Chen, Zhenzhou Ji	large language models, behavior analysis, counterfactual questions, model evaluation
Can LLM Agents Maintain a Persona in Discourse?	Pranav Bhandari, Nicolas Fay, Michael J Wise, Amitava Datta, Stephanie Meek, Usman Naseem, Mehwish Nasim	large language models, agents, persona, discourse
TurnaboutLLM: A Deductive Reasoning Benchmark from Detective Games	Yuan Yuan, Muyu He, Muhammad Adil Shahid, Ziyang Li, Jiani Huang, Li Zhang	deductive reasoning, benchmarks, large language models
Estimating LLM Consistency: A User Baseline vs Surrogate Metrics	Oghenevovwe Ikumariegbe, Eduardo Blanco, Ellen Riloff	large language models, consistency evaluation, metrics
Mapping semantic networks to Dutch word embeddings as a diagnostic tool for cognitive decline	Karim Galliamov, Ivan Titov, Ilya Pershin	semantic networks, word embeddings, cognitive decline, diagnostics
Meta-Semantics Augmented Few-Shot Relational Learning	Thong Nguyen, Yibin Lei, Jia-Huei Ju, Andrew Yates	few-shot learning, relational learning, semantics
Waste-Bench: A Comprehensive Benchmark for Evaluating VLLMs in Cluttered Environments	Muhammad Ali, Salman Khan	benchmarking, very large language models, cluttered environments, evaluation
NL2Lean: Translating Natural Language into Lean 4 through Multi-Aspect Reinforcement Learning	Yue Fang, Shaohan Huang, Xin Yu, Haizhen Huang, Zihan Zhang, Weiwei Deng, Furu Wei, Feng Sun, Qi Zhang, Zhi Jin	natural language to code, reinforcement learning, program synthesis, lean 4
Pluralistic Alignment for Healthcare: A Role-Driven Framework	Jiayou Zhong, Anudeex Shetty, Chao Jia, Xuanrui Lin, Usman Naseem	healthcare, role-driven frameworks, alignment, pluralistic alignment
SAE-SSV: Supervised Steering in Sparse Representation Spaces for Reliable Control of Language Models	Zirui He, Mingyu Jin, Bo Shen, Ali Payani, Yongfeng Zhang, Mengnan Du	language model control, sparse representation, supervised learning
Beyond Outlining: Heterogeneous Recursive Planning for Adaptive Long-form Writing with Language Models	Ruibin Xiong, Yimeng Chen, Dmitrii Khizbullin, Mingchen Zhuge, Jürgen Schmidhuber	long-form writing, language models, planning, adaptive generation
Pixels Versus Priors: Controlling Knowledge Priors in Vision-Language Models through Visual Counterfacts	Michal Golovanevsky, William Rudman, Michael A. Lepori, Amir Bar, Ritambhara Singh, Carsten Eickhoff	vision-language models, knowledge priors, visual counterfacts
Mahānāma: A Unique Testbed for Literary Entity Discovery and Linking	Sujoy Sarkar, Gourav Sarkar, Manoj Balaji Jagadeeshan, Jivnesh Sandhan, Amrith Krishna, Pawan Goyal	entity discovery, entity linking, literary domain
LiTEx: A Linguistic Taxonomy of Explanations for Understanding Within-Label Variation in Natural Language Inference	Pingjun Hong, Beiduo Chen, Siyao Peng, Marie-Catherine de Marneffe, Barbara Plank	natural language inference, explanations, linguistic analysis, taxonomy
EduAdapt: A Question Answer Benchmark Dataset for Evaluating Grade-Level Adaptability in LLMs	Numaan Naeem, Abdellah EL MEKKI, Muhammad Abdul-Mageed	question answering, benchmark dataset, grade-level adaptability, large language models
Retrieval-Augmented Generation with Estimation of Source Reliability	Jeongyeon Hwang, Junyoung Park, Hyejin Park, Dongwoo Kim, Sangdon Park, Jungseul Ok	retrieval-augmented generation, source reliability, text generation
Conflicting Needles in a Haystack: How LLMs behave when faced with contradictory information	Murathan Kurfali	large language models, contradictory information, model behavior
Concept-pedia: a Wide-coverage Semantically-annotated Multimodal Dataset	Karim Ghonim, Andrei Stefan Bejgu, Alberte Fernández-Castro, Roberto Navigli	multimodal dataset, semantic annotation, wide coverage
Extracting Linguistic Information from Large Language Models: Syntactic Relations and Derivational Knowledge	Tsedeniya Kinfe Temesgen, Marion Di Marco, Alexander Fraser	large language models, linguistic information extraction, syntax, derivational knowledge
Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	Zehan Li, Fu Zhang, Wenqing Zhang, JiaweiLi, Zhou Li, Jingwei Cheng, Tianyue Peng	relation extraction, frame-semantic parsing, zero-shot learning
Real-time Ad Retrieval via LLM-generative Commercial Intention for Sponsored Search Advertising	Tongtong Liu, Zhaohui Wang, Meiyue Qin, Zenghui Lu, Xudong Chen, Yuekui Yang, Peng Shu	large language models, ad retrieval, sponsored search, commercial intention, real-time systems
How Much Do LLMs Hallucinate across Languages? On Realistic Multilingual Estimation of LLM Hallucination	Saad Obaid Ul Islam, Anne Lauscher, Goran Glavaš	large language models, hallucination, multilingual, evaluation
TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	Abir HARRASSE, Philip Quirke, Clement Neo, Dhruv Nathawani, Luke Marks, Amir Abdullah	text-to-sql, dataset, mechanistic interpretability
Studying Rhetorically Ambiguous Questions	Alba Táboas García, Piotr Przybyła, Leo Wanner	rhetorical analysis, question understanding, ambiguity
CausalVLBench: Benchmarking Visual Causal Reasoning in Large Vision-Language Models	Maithe van Noort, Michal Korenar, Jelke Bloem	visual causal reasoning, vision-language models, benchmarking
ProLongVid: A Simple but Strong Baseline for Long-context Video Instruction Tuning	Han Wu, Jie Yin	video instruction tuning, long-context learning, baseline models
Program of Thoughts for Financial Reasoning: Leveraging Dynamic In-Context Examples and Generative Retrieval	Subhendu Khatuya, Shashwat Naidu, Pawan Goyal, Niloy Ganguly	financial reasoning, in-context learning, generative retrieval, program of thoughts, finance
DELOC: Document Element Localizer	Hammad Ayyubi, Puneet Mathur, Mehrab Tanjim, Vlad I Morariu	document element localization, document understanding, information extraction
ThinkTuning: Instilling Cognitive Reflections without Distillation	Aswin RRV, Jacob Dineen, Divij Handa, Md Nayem Uddin, Mihir Parmar, Chitta Baral, Ben Zhou	cognitive reflections, model tuning, large language models, distillation-free methods
Towards Language-Agnostic STIPA: Universal Phonetic Transcription to Support Language Documentation at Scale	Jacob Lee Suchardt, Hana El-Shazli, Pierluigi Cassotti	phonetic transcription, language documentation, language-agnostic methods
Hanfu-Bench: A Multimodal Benchmark on Cross-Temporal Cultural Understanding and Transcreation	Li Zhou, Lutong Yu, Dongchu Xie, Shaohuan Cheng, Wenyan Li, Haizhou Li	multimodal, benchmarking, cultural understanding, transcreation
Improving Zero-shot Sentence Decontextualisation with Content Selection and Planning	Zhenyun Deng, Yulong Chen, Andreas Vlachos	zero-shot learning, sentence decontextualisation, content selection, planning
RAG-Zeval: Enhancing RAG Responses Evaluator through End-to-End Reasoning and Ranking-Based Reinforcement Learning​	Kun LI, Yunxiang Li, Tianhua Zhang, Hongyin Luo, Xixin Wu, James R. Glass, Helen M. Meng	retrieval-augmented generation, evaluation, reasoning, reinforcement learning
Lookahead Q-Cache: Achieving More Consistent KV Cache Eviction via Pseudo Query	Yixuan Wang, Shiyu Ji, Yijun Liu, Yuzhuang Xu, Yang Xu, Qingfu Zhu, Wanxiang Che	cache management, query processing, efficiency, large language models
From Input Perception to Predictive Insight: Modeling Model Blind Spots Before They Become Errors	Maggie Mi, Aline Villavicencio, Nafise Sadat Moosavi	modeling, error prediction, model blind spots, robustness
Liaozhai through the Looking-Glass: On Paratextual Explicitation of Culture-Bound Terms in Machine Translation	Sherrie Shen, Weixuan Wang, Alexandra Birch	machine translation, culture-bound terms, paratextual explicitation
\.


--
-- Data for Name: internship_candidates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internship_candidates (author_name, personal_website_url, scholar_citations, acl_papers_since_2021, emnlp_papers_since_2021, naacl_papers_since_2021) FROM stdin;
Rudrashis Poddar	https://jiangtianyu.com/lab/	0	1	1	0
Terrance Liu	https://terranceliu.github.io	1265	2	1	0
Xin Yang	https://xin-yang-liu.github.io	223	3	\N	\N
Jimin Lee	https://sites.google.com/view/cau-li/members/student/24-1-bjk	175	3	2	1
Yihan Wang	https://wyh2000.github.io	668	3	0	1
Jayanth Krishna Chundru	https://github.com/jayanthchundru	1	1	1	0
Ingeol Baek	https://sites.google.com/view/cau-li/members/student/24-1-bjk	23	5	4	1
Byeongjeong Kim	https://sites.google.com/view/cau-li/members/student/24-1-bjk	\N	5	\N	\N
Simone Papicchio	https://www.polito.it/en/staff/?p=052022	67	4	2	0
Varun Dhanraj	https://compneuro.uwaterloo.ca/people/varun-dhanraj.html	91	1	1	0
Yanlin Feng	\N	\N	\N	\N	\N
\.


--
-- Data for Name: megagon_publications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.megagon_publications (publication_url, title, authors, venue, year, research_area, external_link, github_link, abstract, tags) FROM stdin;
\.


--
-- Data for Name: megagon_team_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.megagon_team_members (person_name, profile_url, job_title, self_introduction) FROM stdin;
Eser Kandogan	https://megagon.ai/our-team/eser-kandogan	Principal Research Engineer	Eser is Principal Research Engineer at Megagon Labs. Between 2000-2019, he worked as a research staff member at IBM Almaden Research Center, conducting research on visual analytics, human-computer interaction, computer-supported cooperative work, semantic search, data science, search, and graphs. At IBM he contributed to several IBM products and patents in data and systems management areas. Prior to IBM, he worked at Silicon Graphics (SGI) in data mining and visualization group. He holds a Ph.D. degree from the University of Maryland in Computer Science. He is a co-author of Taming Information Technology by Oxford University Press.
\.


--
-- Data for Name: papers_from_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.papers_from_files (file_name, paper_title, authors, organizations, source_files) FROM stdin;
blue_paper.pdf	A Blueprint Architecture of Compound AI Systems for Enterprise	Eser Kandogan, Sajjadur Rahman, Nikita Bhutani, Dan Zhang, Rafael Li Chen, Kushan Mitra, Sairam Gurajada, Pouya Pezeshkpour, Hayate Iso, Yanlin Feng, Hannah Kim, Chen Shen, Jin Wang, Estevam Hruschka	Eser Kandogan (Megagon Labs, USA); Sajjadur Rahman (Megagon Labs, USA); Nikita Bhutani (Megagon Labs, USA); Dan Zhang (Megagon Labs, USA); Rafael Li Chen (Megagon Labs, USA); Kushan Mitra (Megagon Labs, USA); Sairam Gurajada (Megagon Labs, USA); Pouya Pezeshkpour (Megagon Labs, USA); Hayate Iso (Megagon Labs, USA); Yanlin Feng (Megagon Labs, USA); Hannah Kim (Megagon Labs, USA); Chen Shen (Megagon Labs, USA); Jin Wang (Megagon Labs, USA); Estevam Hruschka (Megagon Labs, USA)	{blue_paper.pdf}
\.


--
-- Data for Name: restaurants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.restaurants (url, name, street_address, city, neighborhood, cuisine, price_level, rating, review_count, phone_number, website, latitude, longitude, source_site) FROM stdin;
https://www.openstreetmap.org/node/1311379474	Sushi Arashi	240 Castro Street	Mountain View	\N	japanese;sushi	\N	\N	\N	\N	\N	37.3933354	-122.079555	openstreetmap.org
https://www.openstreetmap.org/node/1322647963	Napoletana Pizzeria	1910C West El Camino Real	Mountain View	\N	pizza	\N	\N	\N	\N	\N	37.3941375	-122.0968246	openstreetmap.org
https://www.openstreetmap.org/node/1330277742	3 Kingdoms	134 Castro Street	Mountain View	\N	chinese;hotpot	\N	\N	\N	\N	\N	37.394686	-122.0786965	openstreetmap.org
https://www.openstreetmap.org/node/1311379483	Zhangliang Malatang	246 Castro Street	Mountain View	\N	chinese	\N	\N	\N	\N	\N	37.3932435	-122.0795926	openstreetmap.org
https://www.openstreetmap.org/node/1313566127	Gochi Japanese Tapas	1943 West El Camino Real	Mountain View	\N	japanese;tapas	\N	\N	\N	+1 650-965-8304	https://www.gochifusiontapas.com/mountain-view-gochi-fusion-tapas	37.3934044	-122.098072	openstreetmap.org
https://www.openstreetmap.org/node/1357074679	Sushi Katsu	859 Villa Street	Mountain View	\N	sushi	\N	\N	\N	\N	\N	37.3939401	-122.0797838	openstreetmap.org
https://www.openstreetmap.org/node/1388187050	Hyderabad Dum Biryani	\N	Mountain View	\N	indian	\N	\N	\N	+1-650-386-1752	https://hdbiryani.com	37.4141257	-122.0932183	openstreetmap.org
https://www.openstreetmap.org/node/1306274949	Joyous Cuisine	124 Castro Street	Mountain View	\N	chinese	\N	\N	\N	\N	https://pos.chowbus.com/online-ordering/store/HuaXiWang-Mountain-View/14707	37.3948224	-122.078626	openstreetmap.org
https://www.openstreetmap.org/node/1538487239	Hummus Mediterranean Kitchen	185 Castro Street	Mountain View	\N	mediterranean	\N	\N	\N	+1 650-386-1860	https://www.eatathummus.com	37.3939675	-122.0786736	openstreetmap.org
https://www.openstreetmap.org/node/3683008965	The Voya Restaurant	1390 B Pear Avenue	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.4158353	-122.077583	openstreetmap.org
https://www.openstreetmap.org/node/1576214409	Garden Fresh	1245 West El Camino Real	Mountain View	\N	chinese	\N	\N	\N	+1 650 2541688	https://www.gardenfreshca.com	37.3878676	-122.0890177	openstreetmap.org
https://www.openstreetmap.org/node/3725512509	Khao Kang Thai Kitchen	225-2 East Middlefield Road	Mountain View	\N	asian	\N	\N	\N	+1 650-960-7100	https://www.khaokang.com	37.3966659	-122.061578	openstreetmap.org
https://www.openstreetmap.org/node/3725512510	La Costeña	235 East Middlefield Road	Mountain View	\N	mexican	\N	\N	\N	\N	\N	37.397335	-122.0611786	openstreetmap.org
https://www.openstreetmap.org/node/3764833760	Joy Sushi	225-1B East Middlefield Road	Mountain View	\N	sushi	\N	\N	\N	\N	\N	37.396619	-122.0613691	openstreetmap.org
https://www.openstreetmap.org/node/3836342851	Himalayan Kitchen	\N	Mountain View	\N	indian	\N	\N	\N	\N	\N	37.3772272	-122.0626946	openstreetmap.org
https://www.openstreetmap.org/node/3996459057	Everest Cuisine	425 100 North Whisman Road	Mountain View	\N	indian	\N	\N	\N	\N	\N	37.4008439	-122.0579321	openstreetmap.org
https://www.openstreetmap.org/node/4053643839	Hon Sushi	1477 A Plymouth Street	Mountain View	\N	japanese;sushi	\N	\N	\N	\N	https://honsushi.eat24hour.com	37.4163022	-122.0794242	openstreetmap.org
https://www.openstreetmap.org/node/4240016788	SAJJ Mediterranean	2580 West El Camino Real	Mountain View	\N	mediterranean	\N	\N	\N	+1 650 941 7255	https://www.sajjstreeteats.com/location/mountain-view-at-the-village	37.4009224	-122.1122907	openstreetmap.org
https://www.openstreetmap.org/node/4395482133	Momoya Sushi	570 J North Shoreline Boulevard	Mountain View	\N	sushi	\N	\N	\N	\N	\N	37.4027436	-122.0794147	openstreetmap.org
https://www.openstreetmap.org/node/5452430810	Pho Tran Vu	1020 C North Rengstorff Avenue	Mountain View	\N	vietnamese	\N	\N	\N	+1-650-386-5928	https://photranvu.com	37.4198781	-122.0960339	openstreetmap.org
https://www.openstreetmap.org/node/5127223604	Shana Thai	311A Moffett Boulevard	Mountain View	\N	thai	\N	\N	\N	+1-650-940-9990	https://www.shanathai.com	37.3977578	-122.0760602	openstreetmap.org
https://www.openstreetmap.org/node/41737	Caspian Grill Restaurant	1910 West El Camino Real	Mountain View	\N	kebab;middle_eastern;mediterranean	\N	\N	\N	+1-650-967-7752	https://caspiangrillrestaurant.com	37.419627	-122.096921	openstreetmap.org
https://www.openstreetmap.org/node/6672995951	Annachikadai	\N	Mountain View	\N	indian	\N	\N	\N	\N	\N	37.3817334	-122.0749781	openstreetmap.org
https://www.openstreetmap.org/node/6334494410	Queen House	273 Castro Street	Mountain View	\N	chinese;taiwanese	\N	\N	\N	\N	\N	37.3929378	-122.0793508	openstreetmap.org
https://www.openstreetmap.org/node/5127223599	Taqueria Tres Hermanos	327D Moffett Boulevard	Mountain View	\N	mexican	\N	\N	\N	\N	\N	37.3980721	-122.0753192	openstreetmap.org
https://www.openstreetmap.org/node/5125561609	Chef Zhao Bistro	400 H Moffett Boulevard	Mountain View	\N	chinese	\N	\N	\N	\N	\N	37.3996276	-122.074975	openstreetmap.org
https://www.openstreetmap.org/node/6842547984	Fairchilds Public House	409 San Antonio Road	Mountain View	\N	\N	\N	\N	\N	+1-650-966-6949	https://www.fairchildspublichouse.com	37.4038921	-122.1103971	openstreetmap.org
https://www.openstreetmap.org/node/7034726047	Papas and Eggs (Mountain View)	2070 Old Middlefield Way	Mountain View	\N	american	\N	\N	\N	+1-650-242-0222	https://mv.papasandeggs.com	37.4146855	-122.0923693	openstreetmap.org
https://www.openstreetmap.org/node/8609343321	Casa Mia Restaurant	2483 Suite A Old Middlefield Way	Mountain View	\N	american;breakfast;mexican	\N	\N	\N	+1-650-336-7261	https://www.casamiarestaurantmtv.com	37.4146053	-122.0992848	openstreetmap.org
https://www.openstreetmap.org/node/9115285018	Das Bierhauz	135 Castro Street	Mountain View	\N	german	\N	\N	\N	+1 650 336 7613	\N	37.3944916	-122.0782847	openstreetmap.org
https://www.openstreetmap.org/node/3224283361	Masa Sushi	650 Unit 180 Castro Street	Mountain View	\N	japanese	\N	\N	\N	+1-650-282-5222	\N	37.3882323	-122.082698	openstreetmap.org
https://www.openstreetmap.org/node/3441175105	Pacific Catch	545 San Antonio Road	Mountain View	\N	seafood	\N	\N	\N	+1-650-941-1810	https://pacificcatch.com/locations/mountain-view	37.403218	-122.1115538	openstreetmap.org
https://www.openstreetmap.org/node/3544924417	Zareen’s	1477 Unit C Plymouth Street	Mountain View	\N	indian;pakistani	\N	\N	\N	+1 650-628-6100	https://www.zareensrestaurant.com/orderlocation11e95584f3cc2d7697f50cc47a2b63cc.html	37.4162132	-122.079425	openstreetmap.org
https://www.openstreetmap.org/node/3282721066	Ramen Izakaya Yu-Gen	152 Castro Street	Mountain View	\N	japanese;ramen	\N	\N	\N	+1 650 4280888	\N	37.394492	-122.0787802	openstreetmap.org
https://www.openstreetmap.org/node/3487285493	Yami Grill	699 Calderon Avenue	Mountain View	\N	asian	\N	\N	\N	+1 650-584-3328	https://yamigrill.com	37.385011	-122.0753673	openstreetmap.org
https://www.openstreetmap.org/node/2898441801	Satsuma	705 East El Camino Real	Mountain View	\N	japanese	\N	\N	\N	\N	\N	37.3756158	-122.06379	openstreetmap.org
https://www.openstreetmap.org/node/3282721067	Blue Line Pizza	146 Castro Street	Mountain View	\N	pizza	\N	\N	\N	\N	https://bluelinepizza.com	37.3945576	-122.0787546	openstreetmap.org
https://www.openstreetmap.org/node/3641632110	Evolution Cafe	\N	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.4245354	-122.0940626	openstreetmap.org
https://www.openstreetmap.org/node/4609012003	Idly Express	26 565 San Antonio Road	Mountain View	\N	indian	\N	\N	\N	\N	\N	37.402701	-122.1122848	openstreetmap.org
https://www.openstreetmap.org/node/2157827674	Amarin Thai Cusine	147 Castro Street	Mountain View	\N	thai	\N	\N	\N	\N	\N	37.3944133	-122.0784014	openstreetmap.org
https://www.openstreetmap.org/node/2207131298	New Mongolian BBQ	304 Castro Street	Mountain View	\N	mongolian_grill	\N	\N	\N	\N	\N	37.3924372	-122.080006	openstreetmap.org
https://www.openstreetmap.org/node/344561369	Phở Tô Châu	853 Villa Street	Mountain View	\N	vietnamese	\N	\N	\N	+1 650-961-8069	\N	37.3939064	-122.0796563	openstreetmap.org
https://www.openstreetmap.org/node/9795735564	VIP Terrace	\N	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.4270036	-122.0797122	openstreetmap.org
https://www.openstreetmap.org/node/12857122803	Amici	450 San Antonio Road	Mountain View	\N	pizza	\N	\N	\N	+1-650-961-6666	\N	37.404492	-122.1119227	openstreetmap.org
https://www.openstreetmap.org/node/1975950766	Le Petit Bistro	1405 West El Camino Real	Mountain View	\N	french	\N	\N	\N	\N	https://www.lepetitbistromountainview.com	37.3888892	-122.0907548	openstreetmap.org
https://www.openstreetmap.org/node/4406237431	Jennifer Taqueria	1928 Latham Street	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.3943617	-122.0965848	openstreetmap.org
https://www.openstreetmap.org/node/2103435736	Sushi Jin	580 J North Rengstorff Avenue	Mountain View	\N	sushi	\N	\N	\N	+1-650-386-5885	\N	37.4107090	-122.0937824	openstreetmap.org
https://www.openstreetmap.org/node/2187335117	Asian Box	142 Castro Street	Mountain View	\N	asian	\N	\N	\N	\N	https://www.asianbox.com	37.3946069	-122.0787278	openstreetmap.org
https://www.openstreetmap.org/node/2505144210	New York Pizza Mountain View	1040 #310 Grant Road	Mountain View	\N	pizza	\N	\N	\N	+1-650-210-9700	\N	37.3795761	-122.0743191	openstreetmap.org
https://www.openstreetmap.org/node/761343882	Rincón Sabroso	122 North Rengstorff Avenue	Mountain View	\N	mexican;salvadoran	\N	\N	\N	+1-650-968-3990	https://rinconsabrosorestaurant.com	37.4043631	-122.0975553	openstreetmap.org
https://www.openstreetmap.org/node/11129235068	Local Kitchens	1711 B West El Camino Real	Mountain View	\N	\N	\N	\N	\N	\N	https://www.localkitchens.com/order/store/mountainview/popular	37.3904349	-122.0941239	openstreetmap.org
https://www.openstreetmap.org/node/12651122601	HalalStreet Xinjiang Cuisine Mountain View	174 Castro Street	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.3942839	-122.0789386	openstreetmap.org
https://www.openstreetmap.org/node/1722140170	La Fontaine	186 Castro Street	Mountain View	\N	french;italian	\N	\N	\N	+1-650-968-2300	https://www.lafontainerestaurant.com	37.3941236	-122.0790291	openstreetmap.org
https://www.openstreetmap.org/node/4609011998	Dong Lai Shun	545 San Antonio Road	Mountain View	\N	chinese	\N	\N	\N	+1-650-209-5490	http://usdls.com	37.403271	-122.111743	openstreetmap.org
https://www.openstreetmap.org/node/2157827673	Fu Lam Mum	153 Castro Street	Mountain View	\N	chinese	\N	\N	\N	\N	\N	37.3943113	-122.0784664	openstreetmap.org
https://www.openstreetmap.org/node/2207131297	Crepevine	300 Castro Street	Mountain View	\N	crepe;pasta;sandwich	\N	\N	\N	+1-650-969-6878	https://www.crepevine.com	37.3924964	-122.0799731	openstreetmap.org
https://www.openstreetmap.org/node/2619982663	House of Bagels	\N	Mountain View	\N	bagel	\N	\N	\N	\N	\N	37.372799	-122.0874728	openstreetmap.org
https://www.openstreetmap.org/node/441986670	American Bistro	3160 North Shoreline Boulevard	Mountain View	\N	american	\N	\N	\N	\N	https://shorelinelake.com/american_bistro.html	37.4325903	-122.0881664	openstreetmap.org
https://www.openstreetmap.org/node/9753130038	Superhot Hot Pot	210 Hope Street	Mountain View	\N	korean;hotpot	\N	\N	\N	+1 650 9639819	https://superhotrestaurant.weebly.com	37.3933378	-122.0780541	openstreetmap.org
https://www.openstreetmap.org/node/1578531271	Mr. Bao Kitchen	Castro Street	Mountain View	\N	chinese	\N	\N	\N	+1-650-282-5026	http://www.mrbaokitchen.com	37.3917906	-122.0800145	openstreetmap.org
https://www.openstreetmap.org/node/1722162306	Quality Bourbons & Barbecue	216 Castro Street	Mountain View	\N	barbecue	\N	\N	\N	\N	\N	37.3936702	-122.0793379	openstreetmap.org
https://www.openstreetmap.org/node/4395482135	Round Table Pizza	570 North Shoreline Boulevard	Mountain View	\N	pizza	\N	\N	\N	+1 650-961-0361	https://www.roundtablepizza.com	37.4026914	-122.07945	openstreetmap.org
https://www.openstreetmap.org/node/2157827670	Bushido Izakaya	156 Castro Street	Mountain View	\N	japanese	\N	\N	\N	\N	https://www.bushidoizakaya.com	37.3944553	-122.0787959	openstreetmap.org
https://www.openstreetmap.org/node/2207131289	Ristorante Don Giovanni	235 Castro Street	Mountain View	\N	italian	\N	\N	\N	\N	https://www.dongiovannis.com/contact/index.html	37.3933544	-122.079029	openstreetmap.org
https://www.openstreetmap.org/node/2604121125	Pizza My Heart	1037 Unit B El Monte Avenue	Mountain View	\N	pizza	\N	\N	\N	+1 650-938-4200	https://www.pizzamyheart.com/location/pizza-my-heart-mt-view/	37.3909282	-122.094852	openstreetmap.org
https://www.openstreetmap.org/node/347409668	Mantra India	288 Castro Street	Mountain View	\N	indian	\N	\N	\N	+1-650-960-1000	https://www.mantraindiausa.com	37.3928055	-122.0798058	openstreetmap.org
https://www.openstreetmap.org/node/9795735563	Sushi Confidential	\N	Mountain View	\N	sushi	\N	\N	\N	\N	\N	37.4259076	-122.0812926	openstreetmap.org
https://www.openstreetmap.org/node/1578531270	Sakoon	357 Castro Street	Mountain View	\N	indian	\N	\N	\N	\N	\N	37.3916883	-122.0800849	openstreetmap.org
https://www.openstreetmap.org/node/1783200421	Mediterranean Grill House	650 Unit 110 Castro Street	Mountain View	\N	mediterranean	\N	\N	\N	\N	\N	37.3877352	-122.082993	openstreetmap.org
https://www.openstreetmap.org/node/4609011999	Il Fornaio	545 San Antonio Road	Mountain View	\N	italian	\N	\N	\N	\N	https://www.ilfornaio.com/location/mountain-view	37.4033341	-122.1119599	openstreetmap.org
https://www.openstreetmap.org/node/2157948558	Mifen 101	841 Villa Street	Mountain View	\N	chinese;noodle	\N	\N	\N	\N	\N	37.3938882	-122.0794991	openstreetmap.org
https://www.openstreetmap.org/node/2217251295	Fiesta del Mar Too	735 Villa Street	Mountain View	\N	mexican	\N	\N	\N	\N	\N	37.3934273	-122.0782923	openstreetmap.org
https://www.openstreetmap.org/node/2452349995	The Counter	2580 West El Camino Real	Mountain View	\N	burger	\N	\N	\N	+1 650-948-2333	https://www.thecounter.com/stores/mountain-view/32033	37.4008779	-122.1121905	openstreetmap.org
https://www.openstreetmap.org/node/343268782	Eureka!	191 Castro Street	Mountain View	\N	burger	\N	\N	\N	\N	https://eurekarestaurantgroup.com/blog/locations/mountain-view	37.3938542	-122.0786759	openstreetmap.org
https://www.openstreetmap.org/node/11030582305	Limón	\N	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.3915057	-122.0805983	openstreetmap.org
https://www.openstreetmap.org/node/1578531275	Scratch	\N	Mountain View	\N	american	\N	\N	\N	\N	\N	37.3910482	-122.0803992	openstreetmap.org
https://www.openstreetmap.org/node/1975950418	El Paso Cafe	1407 West El Camino Real	Mountain View	\N	\N	\N	\N	\N	\N	https://www.elpasocafe.com	37.3889488	-122.0908415	openstreetmap.org
https://www.openstreetmap.org/node/4609012006	Mizu Sushi Bar & Grill	2590 Unit 13 West El Camino Real	Mountain View	\N	sushi	\N	\N	\N	+1 650 397 7700	https://mizusbg.com/mtnview	37.4012889	-122.1129808	openstreetmap.org
https://www.openstreetmap.org/node/2172216358	Chaat Bhavan	165 East El Camino Real	Mountain View	\N	indian	\N	\N	\N	\N	\N	37.3784592	-122.0710570	openstreetmap.org
https://www.openstreetmap.org/node/2199903060	Kirin	485 Castro Street	Mountain View	\N	chinese	\N	\N	\N	\N	https://www.kirinmountainview.com	37.3902968	-122.080876	openstreetmap.org
https://www.openstreetmap.org/node/2604121117	Bagel Street Cafe	1049 Unit E North El Monte Avenue	Mountain View	\N	\N	\N	\N	\N	\N	\N	37.3899273	-122.0952901	openstreetmap.org
https://www.openstreetmap.org/node/343562073	Bangkok Spoon	702 Villa Street	Mountain View	\N	thai	\N	\N	\N	\N	\N	37.3935198	-122.0779217	openstreetmap.org
https://www.openstreetmap.org/node/11686371915	K-Pot Grill	\N	Mountain View	\N	korean	\N	\N	\N	\N	\N	37.3904162	-122.0808174	openstreetmap.org
https://www.openstreetmap.org/node/1596744376	Hobee’s	2312 Central Expressway	Mountain View	\N	breakfast	\N	\N	\N	\N	\N	37.4038826	-122.098133	openstreetmap.org
https://www.openstreetmap.org/node/5031457746	Caspian Grill Restaurant	1910 West El Camino Real	Mountain View	\N	kebab;middle_eastern;mediterranean	\N	\N	\N	+1-650-967-7752	https://caspiangrillrestaurant.com	37.3941737	-122.096921	openstreetmap.org
https://www.openstreetmap.org/node/2157948572	Totoro	\N	Mountain View	\N	vietnamese	\N	\N	\N	\N	\N	37.3922751	-122.0806824	openstreetmap.org
https://www.openstreetmap.org/node/2192480912	Cucina Venti	1390 Pear Avenue	Mountain View	\N	italian	\N	\N	\N	\N	https://www.cucinaventi.com	37.4160222	-122.077593	openstreetmap.org
https://www.openstreetmap.org/node/2280997765	Lucky	1040 #100 Grant Road	Mountain View	\N	chinese	\N	\N	\N	\N	\N	37.3787228	-122.075679	openstreetmap.org
https://www.openstreetmap.org/node/314150535	Shiba Sushi	\N	Mountain View	\N	sushi	\N	\N	\N	\N	\N	37.3719501	-122.0883667	openstreetmap.org
https://www.openstreetmap.org/node/1306272796	Cascal	400 Castro Street	Mountain View	\N	spanish	\N	\N	\N	\N	https://www.cascalrestaurant.com	37.3911883	-122.0809425	openstreetmap.org
https://www.openstreetmap.org/node/11382864169	Veggie Garden	2464 West El Camino Real	Mountain View	\N	asian;chinese	\N	\N	\N	+1-650-961-6888	https://www.veggiegardenvip.com	37.3991581	-122.1086138	openstreetmap.org
https://www.openstreetmap.org/node/931314	Bonchon Chicken	260 Castro Street	Mountain View	\N	chicken;korean	\N	\N	\N	\N	https://bonchon.com/korean-fried-chicken-mountain-view-ca	37.391314	-122.079645	openstreetmap.org
https://www.openstreetmap.org/node/1722142269	Doppio Zero	160 Castro Street	Mountain View	\N	pizza	\N	\N	\N	\N	https://www.dzpizzeria.com	37.3943827	-122.078829	openstreetmap.org
https://www.openstreetmap.org/node/4538700725	Pho Avenue	2500 Unit B West El Camino Real	Mountain View	\N	vietnamese	\N	\N	\N	+1 650-935-2183	https://www.facebook.com/phoavenue	37.3998627	-122.1101198	openstreetmap.org
https://www.openstreetmap.org/node/2157827669	Agave Mexican Bistro	194 Castro Street	Mountain View	\N	mexican	\N	\N	\N	+1 650-969-6767	https://www.agaveca.com	37.3940321	-122.0790703	openstreetmap.org
https://www.openstreetmap.org/node/2199903066	Casa Lupe	459 Castro Street	Mountain View	\N	mexican	\N	\N	\N	\N	https://www.casalupemountainview.com	37.3906693	-122.080667	openstreetmap.org
https://www.openstreetmap.org/node/2600782850	Sushi 85	1350 Unit 7;8 Grant Road	Mountain View	\N	sushi	\N	\N	\N	\N	\N	37.3771619	-122.0770313	openstreetmap.org
https://www.openstreetmap.org/node/347409552	Taqueria Los Charros	854 West Dana Street	Mountain View	\N	mexican	\N	\N	\N	+1 650 969 1464	\N	37.392923	-122.080372	openstreetmap.org
https://www.openstreetmap.org/node/1242843999	Dumpling Garden	108 North Rengstorff Avenue	Mountain View	\N	chinese	\N	\N	\N	+1-650-967-7334	https://www.dumplinggarden.com	37.4040957	-122.0980999	openstreetmap.org
https://www.openstreetmap.org/node/11365172584	Google Cafe	\N	Mountain View	\N	\N	\N	\N	\N	\N	https://visit.withgoogle.com/visitor-experience/cafe	37.4216191	-122.080368	openstreetmap.org
https://www.openstreetmap.org/node/1722141153	Udon Mugizo	180 Castro Street	Mountain View	\N	japanese;udon	\N	\N	\N	+1 650 9618880	https://www.mugizo-us.com/mountainview	37.3942032	-122.0789954	openstreetmap.org
https://www.openstreetmap.org/node/13140140267	Giorgio's	\N	Mountain View	\N	italian	\N	\N	\N	\N	\N	37.3862233	-122.0853901	openstreetmap.org
\.


--
-- Data for Name: text2sql_authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.text2sql_authors (author_name, paper_title, personal_website_url, is_phd_student, acl_papers_since_2021, scholar_citations, emnlp_papers_since_2021, naacl_papers_since_2021) FROM stdin;
Tianyue Peng	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	\N	\N	3	\N	\N	\N
Terrance Liu	Calibrating LLMs for Text-to-SQL Parsing by Leveraging Sub-clause Frequencies	https://terranceliu.github.io	t	2	1265	1	0
Dhruv Nathawani	TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	https://aclanthology.org/people/dhruv-nathawani	\N	5	225	1	0
Xi Cao	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	https://scholar.google.com/citations?user=Gd4-5bMAAAAJ&hl=en	\N	0	302	1	0
Ingeol Baek	SAFE-SQL: Self-Augmented In-Context Learning with Fine-grained Example Selection for Text-to-SQL	https://sites.google.com/view/cau-li/members/student/24-1-bjk	t	5	23	4	1
Philip Quirke	TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	\N	\N	\N	147	1	0
Jimin Lee	SAFE-SQL: Self-Augmented In-Context Learning with Fine-grained Example Selection for Text-to-SQL	https://sites.google.com/view/cau-li/members/student/24-1-bjk	t	3	175	2	1
Shaobin Shi	GenLink: Generation-Driven Schema-Linking via Multi-Model Learning for Text-to-SQL	https://aclanthology.org/people/shaobin-shi/	\N	2	\N	1	0
Yihan Wang	LinkAlign: Scalable Schema Linking for Real-World Large-Scale Multi-Database Text-to-SQL	https://wyh2000.github.io	t	3	668	0	1
Fu Zhang	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	https://aclanthology.org/people/fu-zhang/	\N	7	\N	14	1
Clement Neo	TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	\N	\N	\N	189	3	0
Rudrashis Poddar	Do LLMs Encode Frame Semantics? Evidence from Frame Identification	https://jiangtianyu.com/lab/	t	1	0	1	0
Chang Xu	JOLT-SQL: Joint Loss Tuning of Text-to-SQL with Confusion-aware Noisy Schema Sampling	https://chang-xu.github.io	f	5	4039	3	0
Jie Cao	Do LLMs Encode Frame Semantics? Evidence from Frame Identification	https://mlciv.com	f	6	332	\N	\N
Boyan Xu	GenLink: Generation-Driven Schema-Linking via Multi-Model Learning for Text-to-SQL	https://boyanxu1.github.io	f	7	379	1	0
Shuyi Wang	Calibrating LLMs for Text-to-SQL Parsing by Leveraging Sub-clause Frequencies	https://aclanthology.org/people/shuyi-wang	\N	1	93	0	0
Tianyu Jiang	Do LLMs Encode Frame Semantics? Evidence from Frame Identification	https://jiangtianyu.com	f	3	103	3	2
Jayanth Krishna Chundru	Do LLMs Encode Frame Semantics? Evidence from Frame Identification	https://github.com/jayanthchundru	t	1	1	1	0
Varun Dhanraj	Can LLMs Extract Frame-Semantic Arguments?	https://compneuro.uwaterloo.ca/people/varun-dhanraj.html	t	1	91	1	0
Bo Xu	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	https://cst.dhu.edu.cn/2019/0312/c3133a210245/page.htm	f	0	0	3	2
Jiaqing Liang	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	https://lsdefine.github.io	f	10	1987	3	1
Xin Yang	LinkAlign: Scalable Schema Linking for Real-World Large-Scale Multi-Database Text-to-SQL	https://xin-yang-liu.github.io	t	3	223	\N	\N
Wei Wang	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	https://web.cs.ucla.edu/~weiwang	f	6	166457	\N	\N
Yash Chandarana	Calibrating LLMs for Text-to-SQL Parsing by Leveraging Sub-clause Frequencies	https://yashchandarana.com	\N	3	0	1	0
Luke Marks	TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	https://lukemarks.bot	\N	7	21	\N	\N
Peng Wang	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	https://aclanthology.org/people/peng-wang	\N	7	1126	1	0
Zhou Li	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	https://lizhou21.github.io	f	3	770	\N	\N
Chirag Gupta	Calibrating LLMs for Text-to-SQL Parsing by Leveraging Sub-clause Frequencies	https://scholar.google.com/citations?user=2ALBM1sAAAAJ	f	1	774	1	0
Daniel Preotiuc-Pietro	Calibrating LLMs for Text-to-SQL Parsing by Leveraging Sub-clause Frequencies	https://www.preotiuc.ro/index.html	f	4	7126	7	1
Jia Chen	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	\N	\N	1	400	1	0
Jie Shi	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	https://aclanthology.org/people/jie-shi	\N	5	1490	1	0
Yanghua Xiao	Dialect-SQL: An Adaptive Framework for Bridging the Dialect Gap in Text-to-SQL	http://kw.fudan.edu.cn/people/xiaoyanghua	f	11	9108	0	0
Zhifeng Hao	GenLink: Generation-Driven Schema-Linking via Multi-Model Learning for Text-to-SQL	https://english.stu.edu.cn/info/1024/1192.htm	f	6	4430	1	0
Jingwei Cheng	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	https://colsa.unh.edu/person/jingwei-cheng	f	\N	2515	0	0
Luca Cagliero	SQUAB: Evaluating LLM robustness to Ambiguous and Unanswerable Questions in Semantic Parsing	https://www.polito.it/en/staff?p=luca.cagliero	f	8	1418	\N	\N
Junqi Huang	GenLink: Generation-Driven Schema-Linking via Multi-Model Learning for Text-to-SQL	\N	\N	\N	\N	\N	\N
Amir Abdullah	TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	\N	\N	5	3468	\N	\N
Hwanhee Lee	SAFE-SQL: Self-Augmented In-Context Learning with Fine-grained Example Selection for Text-to-SQL	https://hwanheelee1993.github.io	f	3	880	3	2
Wenqing Zhang	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	\N	\N	1	2164	\N	\N
Chris Eliasmith	Can LLMs Extract Frame-Semantic Arguments?	https://watarts.uwaterloo.ca/~celiasmi	f	3	14683	2	0
Ruichu Cai	GenLink: Generation-Driven Schema-Linking via Multi-Model Learning for Text-to-SQL	https://ruichucai.github.io	f	5	4430	1	1
Paolo Papotti	SQUAB: Evaluating LLM robustness to Ambiguous and Unanswerable Questions in Semantic Parsing	https://papotti.eurecom.io	f	7	7155	2	0
Byeongjeong Kim	SAFE-SQL: Self-Augmented In-Context Learning with Fine-grained Example Selection for Text-to-SQL	https://sites.google.com/view/cau-li/members/student/24-1-bjk	t	5	\N	\N	\N
Abir HARRASSE	TinySQL: A Progressive Text-to-SQL Dataset for Mechanistic Interpretability Research	https://abirharrasse.github.io	f	3	147	\N	\N
Zijian Wang	JOLT-SQL: Joint Loss Tuning of Text-to-SQL with Confusion-aware Noisy Schema Sampling	https://zijianwang.me	f	7	4575	\N	\N
Zehan Li	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	\N	\N	6	689	\N	\N
JiaweiLi	Frame First, Then Extract: A Frame-Semantic Reasoning Pipeline for Zero-Shot Relation Triplet Extraction	https://profiles.stanford.edu/370509	f	7	136	2	0
Simone Papicchio	SQUAB: Evaluating LLM robustness to Ambiguous and Unanswerable Questions in Semantic Parsing	https://www.polito.it/en/staff/?p=052022	t	4	67	2	0
Hyunkyung Bae	SAFE-SQL: Self-Augmented In-Context Learning with Fine-grained Example Selection for Text-to-SQL	https://aclanthology.org/people/hyunkyung-bae	\N	9	5	1	0
Peiyu Liu	LinkAlign: Scalable Schema Linking for Real-World Large-Scale Multi-Database Text-to-SQL	\N	\N	\N	67	2	1
\.


--
-- Data for Name: us_mass_shootings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.us_mass_shootings (incident_id, incident_date, state, city_or_county, address, victims_killed, victims_injured, suspects_killed, suspects_injured, suspects_arrested, incident_url, source_url) FROM stdin;
3309664	2025-09-17	Pennsylvania	Spring Grove	1879 Haar Rd	3	2	1	0	0	https://www.gunviolencearchive.org/incident/3309664	https://www.yorkdispatch.com/story/news/local/2025/09/22/funeral-services-planned-for-police-officers-killed-in-north-codorus-shooting/86291931007
3345956	2025-11-02	Ohio	Akron	933 Top Of The Hill Dr	1	7	0	0	3	https://www.gunviolencearchive.org/incident/3345956	https://www.cleveland19.com/2025/11/22/arraignment-1-3-arrested-deadly-airbnb-birthday-party-shooting-bath-township
3298204	2025-08-30	Mississippi	Jackson	5627 Dogwood Trail	2	2	0	0	3	https://www.gunviolencearchive.org/incident/3298204	https://www.wjtv.com/news/local-news/third-suspect-arrested-in-jackson-quadruple-shooting
3297867	2025-08-30	Illinois	Chicago	3500 block of S State St	0	7	0	0	0	https://www.gunviolencearchive.org/incident/3297867	https://www.fox32chicago.com/news/chicago-labor-day-weekend-25-mass-shootings
3311161	2025-09-18	Florida	Jacksonville	I-10 and I-95	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3311161	https://www.news4jax.com/news/local/2025/09/19/1-dead-3-hurt-in-possible-road-rage-shooting-on-i-10-at-i-95
3297889	2025-08-30	Illinois	Chicago Heights	400 block of W 14th St	1	4	0	0	1	https://www.gunviolencearchive.org/incident/3297889	https://www.chicagotribune.com/2025/09/02/1-dead-4-wounded-chicago-heights-shooting
3345850	2025-11-02	California	Elk Grove	8409 Elk Grove Florin Rd	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3345850	https://www.abc10.com/article/news/local/elk-grove/second-man-dead-elk-grove-bar-shooting-identified/103-bab2cb38-2372-4783-904a-45ba300b48f9
3312027	2025-09-21	Indiana	Indianapolis	7038 Shore Terrace	0	5	0	0	2	https://www.gunviolencearchive.org/incident/3312027	https://www.wthr.com/article/news/crime/this-weekend-is-a-setback-but-it-does-not-define-our-city-chief-bailey-responds-to-sunday-mass-shooting/531-290dc9df-fcf5-4157-b93e-52165ae7e086
3283060	2025-08-09	Maryland	Baltimore	5101 Queensbury Ave	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3283060	https://www.cbsnews.com/baltimore/news/mass-shooting-in-park-heights-northwest
3312054	2025-09-21	North Carolina	Rocky Mount	2129 Benvenue Rd	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3312054	https://www.cbs17.com/video/search-continues-for-suspects-in-rocky-mount-shooting-that-left-1-dead-4-hurt
3311924	2025-09-20	Michigan	Kalamazoo	2730 W Michigan Ave	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3311924	https://www.mlive.com/news/kalamazoo/2025/11/man-arrested-after-allegedly-shooting-4-people-at-kalamazoo-restaurant-fleeing-the-state.html
3253096	2025-07-05	New York	Albany	300 block of Livingston Ave	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3253096	https://www.wivb.com/news/multiple-shootings-in-albany-on-july-4-no-arrests-made
3217276	2025-05-22	Texas	Mckinney	7560 SH-121	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3217276	https://www.fox4news.com/news/mckinney-man-arrested-after-fatal-shooting-outside-wine-bar
3253722	2025-07-05	Missouri	Saint Louis	N 9th St and Chambers St	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3253722	https://www.firstalert4.com/2025/07/05/1-dead-3-injured-near-north-riverfront-shooting
3212153	2025-05-18	Missouri	Saint Louis	800 block of Schirmer St	4	0	0	0	0	https://www.gunviolencearchive.org/incident/3212153	https://www.stltoday.com/news/local/crime-courts/article_c5207f37-3689-4086-bc24-93b71f28aa1f.html
3251434	2025-05-18	Arizona	Tucson	1100 block of S 6th Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3251434	https://www.kvoa.com/news/crime/tucson-police-search-for-south-6th-ave-shooting-suspect/article_9490da1f-550e-49cc-ad00-f5d8f002e793.html
3329357	2025-10-12	South Carolina	Anderson	208 W Franklin St	2	3	0	0	4	https://www.gunviolencearchive.org/incident/3329357	https://www.wyff4.com/article/four-charged-2-dead-anderson-bar-shooting/69057184
3282825	2025-08-09	Texas	Midland	610 E Industrial Ave	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3282825	https://www.yourbasin.com/news/midland-man-jailed-on-875k-bond-after-bar-11-shooting-injures-four
3281735	2025-08-07	Ohio	Cleveland	1900 block of N Taylor Rd	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3281735	https://www.wlwt.com/article/suspect-identified-in-shooting-incidents-near-cleveland/65648734
3329781	2025-10-12	Texas	Dallas	8300 La Prada Dr	2	3	0	0	1	https://www.gunviolencearchive.org/incident/3329781	https://www.fox4news.com/news/suspect-arrested-dallas-party-shooting-killed-2-injured-3
3248741	2025-06-28	Texas	Austin	900 E Braker Ln	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3248741	https://www.kxan.com/news/local/austin/overnight-shooting-near-a-nightclub-in-north-austin-leaves-four-injured-sources-confirm
3248330	2025-06-28	Missouri	Kansas City	E 24th St and Lister Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3248330	https://www.wibw.com/2025/06/28/1-man-killed-3-others-hospitalized-after-overnight-shooting-east-kansas-city
3248162	2025-06-28	Louisiana	New Orleans	8500 block of Bill St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3248162	https://www.nola.com/news/crime_police/4-people-shot-at-little-woods-house-party-new-orleans-police-say/article_da6ba627-e9c6-418a-ab25-392b408be245.html
3330656	2025-10-12	Kansas	Wichita	E Morris St and S Clifton Ave	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3330656	https://www.ksn.com/top-stories/wichita-teen-charged-after-shooting-leaves-four-wounded/
3271342	2025-07-24	Georgia	Atlanta	279 Oak Dr	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3271342	https://www.11alive.com/article/news/crime/teen-killed-atlanta-park-shooting-empire-park-six-shot-empire-oak-drive/85-8efd63d1-a2d6-4498-9371-2986568de43f
3271477	2025-07-24	Pennsylvania	Philadelphia	2300 block of N Lambert St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3271477	https://www.nbcphiladelphia.com/news/local/four-people-shot-at-graduation-party-lambert-street-philadelphia/4242032/
3269743	2025-07-23	California	Needles	1900 block of Erin Dr	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3269743	https://ktla.com/news/southern-california-murder-suspect-arrested-after-months-on-the-run
3238923	2025-06-17	Wisconsin	Milwaukee	1000 block of W Mineral St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3238923	https://www.fox6now.com/news/milwaukee-shooting-10th-mineral
3238015	2025-06-16	Ohio	Cleveland	5900 block of Luther Ave	1	6	0	0	0	https://www.gunviolencearchive.org/incident/3238015	https://www.news5cleveland.com/news/local-news/1-dead-3-injured-in-cleveland-shooting-on-luther-avenue-1-killed-in-parkgate-avenue-shooting
3329440	2025-10-12	South Carolina	Saint Helena Island	7 Dr Martin Luther King Jr Dr	3	15	1	1	1	https://www.gunviolencearchive.org/incident/3329440	https://www.wjcl.com/article/st-helena-island-mass-shooting-update-1/69427494
3326623	2025-10-08	Missouri	Saint Louis	5900 block of Wells Ave	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3326623	https://www.firstalert4.com/2025/10/09/shooting-balloon-release-north-city-kills-1-injures-4
3326263	2025-10-07	Minnesota	Minneapolis	420 S 4th St	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3326263	https://kstp.com/kstp-news/local-news/charges-man-accused-of-fatally-shooting-1-injuring-3-others-in-minneapolis-bar
3370518	2025-12-06	Texas	Dallas	2984 W Wheatland Rd	1	3	0	1	1	https://www.gunviolencearchive.org/incident/3370518	https://www.dallasnews.com/news/crime/2025/12/09/weekend-dallas-baby-shower-turns-chaotic-then-deadly-after-fight-led-to-gunfire
3297408	2025-08-29	Florida	Fort Lauderdale	657 NW 9th St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3297408	https://www.local10.com/news/local/2025/09/04/fort-lauderdale-shooting-investigation-active-911-calls-released
3345920	2025-11-01	Arizona	Tucson	W Drexel Rd and S 12th Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3345920	https://www.kold.com/2025/11/02/gunfire-tucson-house-party-kills-one-three-others-wounded
3223359	2025-06-01	North Carolina	Asheville	College St and Rankin Ave	0	4	1	0	0	https://www.gunviolencearchive.org/incident/3223359	https://wnctimes.com/news/10452-no-charges-filed-in-rankin-avenue-shooting-following-investigation
3201959	2025-05-03	Colorado	Denver	Market St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3201959	https://www.denver7.com/news/crime/arrest-made-in-downtown-denver-quadruple-shooting-that-left-4-wounded
3264154	2025-07-15	New York	Bronx	E 187th St and Park Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3264154	https://www.nydailynews.com/2025/07/16/four-men-wounded-wild-bronx-shooting
3341164	2025-10-25	Pennsylvania	Lincoln University	1570 Baltimore Pike	1	6	0	0	1	https://www.gunviolencearchive.org/incident/3341164	https://6abc.com/post/multiple-victims-injured-shooting-lincoln-university/18071874
3277877	2025-08-02	Illinois	Harvey	14400 block of Des Plaines St	0	5	1	1	0	https://www.gunviolencearchive.org/incident/3277877	https://abc7chicago.com/post/harvey-shooting-today-child-among-7-shot-14400-block-des-plaines-street-officials-say-suspect-killed-ccl-holder/17415754
3313413	2025-09-20	North Carolina	Burlington (Green Level)	W Simpson Rd and Florence Rd	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3313413	https://www.wyff4.com/article/five-people-shot-large-party-north-carolina/68263514
3166785	2025-03-23	Texas	Houston	6419 1/2 Hillcroft St	0	6	0	0	1	https://www.gunviolencearchive.org/incident/3166785	https://www.click2houston.com/news/local/2025/03/26/suspect-arrested-in-hillcroft-bar-shooting-identified-as-venezuelan-national
3245226	2025-06-23	Georgia	Jonesboro	148 Church St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3245226	https://www.fox5atlanta.com/news/four-men-shot-after-basketball-game-jonesboro-church
3288499	2025-08-17	Virginia	Richmond	1700 block of Clarkson Rd	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3288499	https://www.wric.com/news/local-news/richmond/quadruple-shooting-clarkson-road
3285455	2025-08-11	Oregon	Grants Pass	230 Hussey Ln	4	0	1	0	0	https://www.gunviolencearchive.org/incident/3285455	https://www.facebook.com/jcsosheriff/posts/pfbid022kXFBKhdBFtaEu9DuwpXVPGuxRoqsGoM4ursrfjTVNaYdNk6c3M8LSdBD5wSbg7sl
3328483	2025-10-10	Ohio	Youngstown	300 block of Willis Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3328483	https://www.vindy.com/news/local-news/2025/10/one-of-four-victims-remains-critical-in-oct-9-shooting
3370550	2025-12-07	California	San Jose	2229 Lincoln Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3370550	https://www.mercurynews.com/2025/12/07/san-jose-four-men-shot-early-sunday-morning
3228792	2025-06-07	Michigan	Benton Harbor	1000 block of Bishop St	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3228792	https://www.heraldpalladium.com/communities/benton_harbor/several-injured-in-two-benton-harbor-shootings/article_4f1f67e3-a8e7-51ef-ab7c-acfd2aef87da.html
3345889	2025-11-02	District of Columbia	Washington	2335 Bladensburg Rd NE	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3345889	https://www.congressheightsontherise.com/blog/langston-wedge-19-arrested-for-shooting-outside-of-nightclub
3123627	2025-01-24	Alabama	Mobile	1200 Murray Hill Ct	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3123627	https://www.al.com/news/mobile/2025/02/21-year-old-man-jailed-on-murder-charges-in-mobile-quadruple-shooting.html
3320275	2025-10-01	Georgia	Atlanta	2157 Lenox Rd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3320275	https://www.atlantapd.org/Home/Components/News/News/7551/631
3198160	2025-04-29	Minnesota	Minneapolis	1508 E 25th St	4	1	0	0	1	https://www.gunviolencearchive.org/incident/3198160	https://www.startribune.com/teen-fatally-shot-man-on-minneapolis-street-shot-2-more-days-later-during-crime-spree-charges-say/601350630
3266574	2025-07-19	Ohio	Cleveland	16400 block of Highview Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3266574	https://www.cleveland.com/news/2025/07/15-year-old-dies-3-other-teens-injured-in-clevelands-lee-miles-neighborhood.html
3342227	2025-10-26	Tennessee	Nashville	600 block of Cleveland St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3342227	https://www.wsmv.com/2025/10/27/4-injured-drive-by-shooting-turned-shootout-east-nashville
3337769	2025-10-20	Delaware	Dover	100 block of Mifflin Rd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3337769	https://www.wmdt.com/2025/10/drive-by-shooting-in-dover-leaves-four-injured-police-investigating
3235671	2025-06-16	Florida	Miami	NW 62nd St and NW 2nd Ave	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3235671	https://www.cbsnews.com/miami/news/one-dead-three-injured-in-little-haiti-shooting
3311577	2025-09-20	Louisiana	Shreveport	1635 Poland St	2	6	0	0	1	https://www.gunviolencearchive.org/incident/3311577	https://www.ktalnews.com/news/top-stories/man-sought-in-mass-shooting-in-allendale-arrested-shreveport-police-say
3170672	2025-03-26	Florida	Hallandale (Hallandale Beach)	3181 W Hallandale Beach Blvd	4	1	1	0	0	https://www.gunviolencearchive.org/incident/3170672	https://cbs12.com/news/local/suspect-dies-in-hospital-after-south-florida-deputies-find-mother-and-three-sons-shot-dead-broward-county-sheriffs-office-west-hallandale-beach-boulevard-pemboke-pines-news-march-31-2025
3246330	2025-06-25	Mississippi	Moorhead	800 E Southern Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3246330	https://www.deltadailynews.com/local/four-shot-in-moorhead-shootout-near-discount-store
3288282	2025-08-17	New York	Brooklyn	903 Franklin Ave	1	11	2	0	1	https://www.gunviolencearchive.org/incident/3288282	https://www.nydailynews.com/2025/10/01/bloods-member-charged-brooklyn-nightclub-mass-shooting-killed-three-people
3288301	2025-08-16	Illinois	Chicago	2400 block of W Jackson Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3288301	https://www.fox32chicago.com/news/4-shot-near-w-side-chicago
3331319	2025-10-10	South Carolina	Kingstree	Jericho Rd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3331319	https://www.counton2.com/news/williamsburg-county-deputies-investigating-2-cedar-hill-shootings
3370170	2025-12-06	Maryland	Baltimore	1800 block of McHenry St	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3370170	https://www.baltimorepolice.org/news/media-advisory-december-6-2025
3294737	2025-08-27	Minnesota	Minneapolis	509 W 54th St	2	27	1	0	0	https://www.gunviolencearchive.org/incident/3294737	https://www.mprnews.org/story/2025/10/08/authorities-increase-count-of-injured-in-annunciation-shooting
3345289	2025-10-31	Texas	San Antonio	1200 block of Lee Hall St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3345289	https://www.ksat.com/news/local/2025/11/01/4-hospitalized-after-north-side-halloween-party-shooting-sapd-says
3226727	2025-06-05	Texas	Dallas	3412 S Malcolm X Blvd	0	7	0	0	0	https://www.gunviolencearchive.org/incident/3226727	https://www.nbcdfw.com/news/local/multiple-people-shot-in-dallas-2-in-critical-condition/3857321
3322765	2025-10-04	Texas	Angleton	22679 State Hwy 288	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3322765	https://nypost.com/2025/10/08/us-news/mom-allegedly-shot-4-of-her-kids-said-they-were-with-the-devil
3317532	2025-09-28	Louisiana	New Orleans	100 block of Bourbon St	1	4	0	0	1	https://www.gunviolencearchive.org/incident/3317532	https://nopdnews.com/post/september-2025/nopd-announces-arrest-of-suspects-in-eighth-distri
3266713	2025-07-19	Tennessee	Cordova	71 Fern Glade Cove	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3266713	https://www.kplctv.com/2025/07/20/former-edna-karr-football-standout-corey-adams-fatally-shot-tennessee-reports-say
3336200	2025-10-20	California	Buena Park	Beach Blvd and Commonwealth Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3336200	https://www.ocregister.com/2025/10/20/3-youths-1-adult-injured-in-buena-park-shooting
3278919	2025-08-03	Virginia	Virginia Beach	4900 block of Gulfstream Cir	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3278919	https://www.wavy.com/news/crime/vbpd-four-hurt-following-early-sunday-morning-shooting-on-gulfstream-circle
3234040	2025-06-15	Ohio	Canton	2900 8th St NE	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3234040	https://www.cantonrep.com/story/news/local/stark-county/2025/06/15/four-people-shot-inside-ashtons-bar-grill-in-canton-township/84218361007
3310864	2025-09-18	California	Antioch	1821 A St	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3310864	https://www.mercurynews.com/2025/09/29/east-bay-antioch-two-identified-shot-to-death-near-restaurant
3149025	2025-02-27	Ohio	Columbus	480 block of Kimball Pl	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3149025	https://www.10tv.com/article/news/local/shooting-columbus-kimball-place-4-shot/530-8a9213f4-2b49-4e5d-9d4c-49c46682e9c4
3166767	2025-03-21	Washington	Moses Lake	500 block of W Loop Dr	1	4	0	1	3	https://www.gunviolencearchive.org/incident/3166767	https://www.khq.com/news/moses-lake-murder-suspect-surrenders-in-california/article_bdf539ec-8614-4795-9d33-8f5ad40e287c.html
3243988	2025-06-23	Maryland	Baltimore	2500 block of Edmondson Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3243988	https://foxbaltimore.com/news
3290307	2025-08-16	Washington	Grandview	Apricot Rd and County Line Rd	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3290307	https://www.applevalleynewsnow.com/news/grandview-raises-funds-to-help-teen-recover-from-shooting-injury/article_85de4fbc-b611-43ae-b73c-7e04d4e66cea.html
3283186	2025-08-10	Illinois	Chicago	100 block of N La Crosse Ave	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3283186	https://cwbchicago.com/2025/08/10k-reward-offered-in-mass-shooting-left-22-year-old-dead-at-street-party.html
3328758	2025-10-10	Mississippi	Leland	400 block of Main St	7	12	0	0	9	https://www.gunviolencearchive.org/incident/3328758	https://desotocountynews.com/mississippi-news/fbi-seeks-publics-help-in-leland-mass-shooting-investigation-nine-arrested-seven-dead
3370354	2025-12-06	Michigan	Muskegon	633 Jackson Ave	2	3	0	0	0	https://www.gunviolencearchive.org/incident/3370354	https://www.wzzm13.com/article/news/local/family-friends-hold-vigils-for-muskegon-shooting-victims/69-26f0fd4e-b008-4f3e-a433-2989ce96ba0d
3227904	2025-06-07	North Carolina	Sanford	102 E Trade St	0	5	0	1	3	https://www.gunviolencearchive.org/incident/3227904	https://www.sanfordherald.com/archives/sanford-bar-shooting-results-in-two-more-arrests/article_bc07d182-3b9a-59fe-8193-1f71916b36e0.html
3293218	2025-08-24	Maryland	Hagerstown	11205 John F Kennedy Dr	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3293218	https://www.dcnewsnow.com/news/local-news/maryland/washington-county/four-hurt-in-hagerstown-bar-shooting
3345818	2025-11-02	Illinois	Chicago	3400 block of N Clark St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3345818	https://www.fox32chicago.com/news/4-shot-lakeview-sun
3227101	2025-06-06	South Carolina	Columbia	2408 Lincoln St	1	3	0	0	3	https://www.gunviolencearchive.org/incident/3227101	https://columbiapd.net/2025/11/24/third-arrest-made-in-fatal-shooting-at-airbnb-teen-suspect-being-held-at-djj
3122078	2025-01-22	Texas	San Antonio	18777 Stone Oak Pkwy	0	7	1	0	0	https://www.gunviolencearchive.org/incident/3122078	https://www.ksat.com/news/local/2025/01/24/sapd-identifies-7-officers-injured-in-stone-oak-shooting/
3317486	2025-09-28	Michigan	Grand Blanc	4285 McCandlish Rd	4	7	1	0	0	https://www.gunviolencearchive.org/incident/3317486	https://www.facebook.com/permalink.php?story_fbid=1613775673411325&id=100043367242229
3196464	2025-04-27	Tennessee	Memphis	2871 S Perkins Rd	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3196464	https://www.fox13memphis.com/news/5-shot-1-dead-after-gunfire-erupts-at-parkway-village-restaurant-mpd-says/article_c14bd6c1-a60c-48e5-bb29-b20a176fa1a6.html
3278590	2025-08-04	California	Los Angeles	E 14th Pl and Paloma St	2	6	0	0	0	https://www.gunviolencearchive.org/incident/3278590	https://www.hollywoodlanews.com/africa-johnson-dead
3234370	2025-06-15	Utah	Salt Lake City (West Valley City)	5405 W 3100 S	3	2	0	0	1	https://www.gunviolencearchive.org/incident/3234370	https://www.ksl.com/article/51333147
3317906	2025-09-19	Oregon	Portland	8220 SE Harrison St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3317906	https://eastpdxnews.com/general-news-features/three-shootings-in-four-days-in-outer-east-portland-one-was-fatal
3166569	2025-03-22	Louisiana	Natchitoches	LA-1225 and Catholic Ln	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3166569	https://www.ksla.com/2025/03/25/trail-ride-shooting-police-chase-fiery-wreck-natchitoches-parish-connected-police-say
3248058	2025-06-27	Oregon	Portland	14919 SE Stark St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3248058	https://www.kptv.com/2025/06/29/portland-shooting-that-left-four-hurt-happened-graduation-party-family-says
3292026	2025-08-22	New York	Bronx	1401 Overing St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3292026	https://www.timesnownews.com/world/us/us-news/bronx-shootings-today-at-least-11-people-shot-across-multiple-incidents-including-4-teens-in-daylight-attack-article-152513249
3283199	2025-08-10	Illinois	Chicago	4500 block of W Wilcox St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3283199	https://www.fox32chicago.com/news/w-garfield-park-4-shot
3323482	2025-10-05	Texas	Fort Worth	3005 Bledsoe St	1	5	0	0	2	https://www.gunviolencearchive.org/incident/3323482	https://www.dallasnews.com/news/crime/2025/11/05/second-suspect-arrested-in-fort-worth-club-shooting-that-left-1-dead-5-hurt
3228103	2025-06-07	Virginia	Portsmouth	400 block of Viking St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3228103	https://www.wtkr.com/news/in-the-community/portsmouth/police-search-for-suspect-after-2-adults-2-teens-were-shot-at-portsmouth-graduation-party
3292906	2025-08-24	Missouri	Kansas City	E 13th St and Grand Blvd	2	3	0	0	0	https://www.gunviolencearchive.org/incident/3292906	https://fox4kc.com/news/police-name-victims-killed-in-downtown-kansas-city-shooting
3345666	2025-11-01	Connecticut	New Haven	Church St and Chapel St	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3345666	https://www.wfsb.com/2025/11/01/1-dead-following-quadruple-shooting-new-haven
3223058	2025-06-01	Virginia	Danville	Carver Dr and Cheyenne Dr	1	4	0	0	2	https://www.gunviolencearchive.org/incident/3223058	https://www.facebook.com/DanvilleVAPD/posts/pfbid02Z47N1RZD7ezGxQgfQnHTteghggqd7PfPUtehjB3vTKqAyZhoTwoacyzQUiYhko3Ql
3323336	2025-10-04	Alabama	Montgomery	Bibb St and Commerce St	2	12	0	0	4	https://www.gunviolencearchive.org/incident/3323336	https://www.wbrc.com/2025/11/07/fifth-arrest-made-deadly-montgomery-mass-shooting
3199958	2025-05-02	Maryland	Gwynn Oak (Woodlawn)	1800 block of Woodlawn Dr	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3199958	https://www.cbsnews.com/baltimore/news/man-dies-quadruple-shooting-baltimore-county-maryland
3266988	2025-07-19	Arkansas	Little Rock	1800 Broadway St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3266988	https://katv.com/news/local/lrpd-investigating-shooting-at-parris-towers-apartments
3345118	2025-10-31	Oklahoma	Oklahoma City	NW 11th St and N Rockwell Ave	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3345118	https://www.koco.com/article/five-juveniles-hospitalized-after-being-shot-at-halloween-party/69224666
3278132	2025-08-03	California	Fresno	3938 E Ashcroft Ave	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3278132	https://www.yourcentralvalley.com/news/crime/fresno-party-shooting-arrest
3245191	2025-06-15	Pennsylvania	Johnstown	74 Fairfield Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3245191	https://www.wtaj.com/news/the-tribune-democrat/johnstown-police-search-for-suspect-after-4-women-shot-at-new-nightclub
3310815	2025-09-18	Georgia	Atlanta	942 Hank Aaron Dr SE	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3310815	https://www.atlantanewsfirst.com/2025/09/19/4-people-shot-southeast-atlanta-police-say
3146395	2025-02-24	Texas	Dallas	Canada Dr and Gulden Ln	3	2	0	0	2	https://www.gunviolencearchive.org/incident/3146395	https://dpdbeat.com/2025/02/25/homicide-at-3100-gulden-lane-2
3249173	2025-06-28	Ohio	Columbus	800 block of Avonia Dr	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3249173	https://www.dispatch.com/story/news/crime/2025/07/01/911-callers-describe-columbus-shooting-that-killed-one-hurt-three/84429608007
3292691	2025-08-23	New York	Bronx	Burke Ave and Wickham Ave	2	3	0	0	4	https://www.gunviolencearchive.org/incident/3292691	https://bronx.news12.com/baychester-mass-shooting-victim-dies-from-injuries
3288736	2025-08-16	Michigan	Saginaw	S 23rd St and Perkins St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3288736	https://www.mlive.com/news/saginaw-bay-city/2025/08/investigation-continues-into-weekend-shooting-that-left-five-people-injured-in-saginaw.html
3373304	2025-12-10	New Jersey	Newark	790 Clinton Ave	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3373304	https://abc7ny.com/post/newark-recording-studio-shooting-leaves-2-people-dead-others-injured/18273776
3294361	2025-08-26	California	Los Angeles	8501 S Figueroa St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3294361	https://abc7.com/post/5-people-shot-outside-corner-store-south-los-angeles-fire-department-says/17656378
3346551	2025-11-01	Florida	Gretna	181 Beech Ave	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3346551	https://www.wctv.tv/2025/11/04/suspect-arrested-connection-with-gretna-memorial-shooting
3222953	2025-06-01	North Carolina	Hickory	1125 Walnut Acres Dr	1	12	0	0	6	https://www.gunviolencearchive.org/incident/3222953	https://www.wxii12.com/article/north-carolina-mass-shooting-pool-party-indictments-catawba-co/65173890
3121802	2025-01-22	Maryland	Baltimore	5400 block of York Rd	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3121802	https://www.cbsnews.com/baltimore/news/baltimore-paraeducateor-waverly-shooting-maryland/
3318495	2025-09-28	Michigan	Highland Park	14201 2nd Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3318495	https://www.facebook.com/TheDetroitScanner/posts/pfbid0iNL9GVXHQ1XUZ8E2kYQdPEaZvUfA34afbnsPhwe4DPBUaRApTS3H3ju9h4VCc6yJl
3195984	2025-04-27	North Carolina	Elizabeth City	1704 Weeksville Rd	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3195984	https://www.witn.com/2025/04/29/sbi-confirms-name-man-killed-ecsu-mass-shooting
3265909	2025-07-19	Illinois	Chicago	8200 block of S Houston Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3265909	https://www.cbsnews.com/chicago/news/person-killed-3-others-hurt-south-chicago-mass-shooting
3340387	2025-10-25	North Carolina	Maxton	298 Dixon Dr	2	11	0	0	0	https://www.gunviolencearchive.org/incident/3340387	https://www.wmbfnews.com/2025/11/25/1-wanted-5-arrested-hosting-party-where-nc-mass-shooting-occurred-deputies-say
3278049	2025-08-03	Iowa	Iowa City	600 block of E Court St	0	4	0	0	2	https://www.gunviolencearchive.org/incident/3278049	https://www.kcrg.com/2025/08/22/teen-juvenile-arrested-connection-iowa-city-shooting
3237753	2025-06-16	Ohio	Middletown	1200 Elliott Dr	1	3	0	0	2	https://www.gunviolencearchive.org/incident/3237753	https://www.whio.com/news/local/woman-man-arrested-part-ongoing-shooting-investigation-middletown/RPGKB2PYBRGN3KZ243OAV5G5JY
3311721	2025-09-19	Nebraska	Omaha	3247 N 42nd St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3311721	https://www.ketv.com/article/omaha-police-investigating-shooting-with-5-possible-victims/67973153
3172644	2025-03-29	Washington	Tacoma	17800 block of 25th Ave Ct E	2	4	0	1	2	https://www.gunviolencearchive.org/incident/3172644	https://komonews.com/news/local/second-alleged-shooter-arrested-for-pierce-county-house-party-mass-shooting-chaotic-scene-gun-violence-handgun-fight-video-teen-teenager-washington-crime-hospital
3247121	2025-06-26	New Jersey	Trenton	100 block of Passaic St	1	3	0	0	2	https://www.gunviolencearchive.org/incident/3247121	https://newjersey.news12.com/2-arrested-in-deadly-trenton-drive-by-shooting
3289583	2025-08-18	West Virginia	Mount Carbon	Adena Dr	1	3	1	0	0	https://www.gunviolencearchive.org/incident/3289583	https://wvmetronews.com/2025/08/19/names-released-in-mount-carbon-shooting
3284255	2025-08-11	Illinois	Chicago	700 block of E 43rd St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3284255	https://chicago.suntimes.com/crime/2025/08/12/residents-on-edge-after-5-shot-in-bronzeville-they-were-just-shooting-at-all-old-people
3371075	2025-12-07	Florida	Clearwater	1270 S Highland Ave	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3371075	https://www.wtsp.com/article/news/local/pinellascounty/clearwater-sports-bar-shooting-one-dead/67-f961fe48-0236-466c-94a8-347f217e2ae8
3294369	2025-08-26	Minnesota	Minneapolis	E 29th St and Clinton Ave	1	6	0	0	1	https://www.gunviolencearchive.org/incident/3294369	https://www.startribune.com/amid-many-victims-sister-of-one-man-killed-in-minneapolis-mass-shooting-wants-him-remembered/601478737
3345842	2025-11-01	California	Sacramento	3300 block of Paumanok Way	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3345842	https://www.abc10.com/article/news/local/sacramento/4-hurt-north-natomas-shooting-sacramento/103-69854e20-7a5a-4a27-a83a-d52c0d9d3911
3223558	2025-06-01	Minnesota	Minneapolis	724 Sibley St NE	1	4	0	2	4	https://www.gunviolencearchive.org/incident/3223558	https://www.cbsnews.com/minnesota/news/man-charges-boom-island-shooting-illegal-firearm
3323489	2025-10-04	Alabama	Mobile	1441 Navco Rd	0	4	1	0	0	https://www.gunviolencearchive.org/incident/3323489	https://www.fox10tv.com/2025/10/06/man-shot-death-mobile-club-was-aggressor-district-attorney-says
3267641	2025-07-20	Mississippi	Waynesboro	Turner St and Grey St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3267641	https://www.wjtv.com/news/pine-belt/five-injured-in-waynesboro-drive-by-shooting
3341621	2025-10-26	Washington	Pasco	5500 block of Robert Wayne Dr	0	6	0	0	2	https://www.gunviolencearchive.org/incident/3341621	https://www.tri-cityherald.com/news/local/crime/article312685369.html
3280275	2025-08-06	Georgia	Fort Stewart	594 Vanguard Rd	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3280275	https://www.wjbf.com/news/georgia-news/alleged-fort-stewart-shooter-claimed-one-of-the-victims-was-his-husband-report-says
3233803	2025-06-15	Indiana	Elkhart	W Garfield Ave and Benham Ave	1	11	0	0	0	https://www.gunviolencearchive.org/incident/3233803	https://www.southbendtribune.com/story/news/local/2025/06/16/dozen-injured-in-elkhart-mass-shooting-30-year-old-man-dead/84228362007
3144174	2025-02-22	Pennsylvania	York	1701 Innovation Dr	1	5	1	0	0	https://www.gunviolencearchive.org/incident/3144174	https://www.ydr.com/story/news/crime/2025/10/06/911-calls-reveal-new-details-about-upmc-memorial-hostage-tragedy/86481214007
3248449	2025-06-28	Ohio	Springfield	1000 block of W Rose St	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3248449	https://www.wdtn.com/top-stories/springfield-mass-shooting-police-media-briefing-update
3288024	2025-08-16	Indiana	Indianapolis	3100 block of Brouse Ave	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3288024	https://cbs4indy.com/news/indycrime/4-injured-in-shooting-at-near-ne-side-apartment-complex
3371246	2025-12-08	Montana	Nye	1015 Stillwater River Rd	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3371246	https://www.ktvq.com/news/crime-watch/mother-and-daughter-killed-in-stillwater-county-shooting
3297573	2025-08-29	New York	Syracuse (Geddes)	1002 State Fair Blvd	0	4	0	1	2	https://www.gunviolencearchive.org/incident/3297573	https://cnycentral.com/news/local/38-year-old-syracuse-man-arrested-for-alleged-role-in-geddes-rec-hall-shooting
3227478	2025-06-06	Louisiana	Cheneyville	200 block of Derbourne St	0	5	0	0	13	https://www.gunviolencearchive.org/incident/3227478	https://whnt.com/news/six-arrested-for-shooting-at-cheneyville-memorial-service-in-june
3121297	2025-01-22	California	Los Angeles	600 block of S Alvarado St	0	5	0	1	1	https://www.gunviolencearchive.org/incident/3121297	https://www.audacy.com/knxnews/news/local/man-charged-in-shooting-near-macarthur-park-that-injured-5
3317588	2025-09-28	Texas	Eagle Pass	794 Lucky Eagle Dr	2	6	0	0	1	https://www.gunviolencearchive.org/incident/3317588	https://cbsaustin.com/news/local/bond-raised-to-51m-for-suspect-in-lucky-eagle-casino-shooting-as-new-charges-surface-texas-investigation-police-evidence-attorney-lawyers-prosecution
3266723	2025-07-20	Illinois	Chicago	4935 W Ferdinand St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3266723	https://twitter.com/SPOTNEWSonIG/status/1947006954020196600
3340194	2025-10-24	District of Columbia	Washington	600 block of Howard Pl NW	0	5	0	0	3	https://www.gunviolencearchive.org/incident/3340194	https://nextdoor.com/agency-post/dc/washington/metropolitan-police-department/mpd-arrests-suspect-in-shooting-near-howard-university-439528884
3278491	2025-08-02	Nebraska	Omaha	3501 N 30th St	0	6	0	1	1	https://www.gunviolencearchive.org/incident/3278491	https://www.wowt.com/2025/08/04/arrest-made-after-north-omaha-shooting-that-left-7-people-injured
3234286	2025-06-15	Connecticut	Hartford	181 Homestead Ave	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3234286	https://www.audacy.com/wtic/news/local/five-shot-injured-in-hartford-shooting
3151139	2025-03-01	Alabama	Sardis	304 Co Rd 134	0	6	0	0	1	https://www.gunviolencearchive.org/incident/3151139	https://selmasun.com/news/selma-youth-arrested-for-shooting-that-wounded-six-in-sardis-dallas-county-sheriff-mike-granthum/article_71082585-9270-5d3a-b0f0-d9c55bad3d20.html
3166540	2025-03-22	Mississippi	Jackson	Lamar St and Pearl St	1	7	0	0	3	https://www.gunviolencearchive.org/incident/3166540	https://www.wlbt.com/2025/12/09/im-not-guy-they-accuse-me-be-suspect-charged-jackson-mass-shooting-still-seeks-preliminary-hearing
3244129	2025-06-23	New Jersey	Newark	367 6th Ave W	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3244129	https://dailyvoice.com/nj/elizabeth/mass-shooting-paterson-man-dead-4-wounded-in-newark-prosecutor-says-photos
3290521	2025-08-17	Mississippi	Prentiss	84 Young Rd	1	4	0	0	5	https://www.gunviolencearchive.org/incident/3290521	https://www.wlox.com/2025/09/13/eight-suspects-charged-death-mississippi-teenager
3283977	2025-08-10	Mississippi	Jackson	357 N Mart Plaza	0	8	0	0	0	https://www.gunviolencearchive.org/incident/3283977	https://www.wapt.com/article/8-people-wounded-in-jackson-shooting/65654272
3144274	2025-02-21	Indiana	Lake Station	6700 block of 9th Ave	4	0	1	0	0	https://www.gunviolencearchive.org/incident/3144274	https://www.cbsnews.com/chicago/news/five-people-found-dead-lake-station-indiana
3139838	2025-02-15	Virginia	Roanoke	4100 block of Melrose Ave NW	0	4	0	1	1	https://www.gunviolencearchive.org/incident/3139838	https://www.wdbj7.com/2025/02/15/five-people-injured-roanoke-police-investigating-shooting-northwest
3140814	2025-02-16	Georgia	Decatur	5300 block of Panola Industrial Blvd	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3140814	https://www.11alive.com/article/news/crime/deadly-shooting-on-panola-industrial-boulevard-sunday-morning/85-101ccf69-7fc6-43c2-8b2a-b3a3bdd737f3
3135132	2025-02-09	California	Woodland Hills	5850 Winnetka Ave	1	6	0	0	0	https://www.gunviolencearchive.org/incident/3135132	https://www.canyon-news.com/police-seek-public-assistance-locating-murder-suspect/190912
3136711	2025-02-10	Wyoming	Byron	239 E Shoshone Ave	4	0	1	0	0	https://www.gunviolencearchive.org/incident/3136711	https://cowboystatedaily.com/2025/02/16/olivia-7-year-old-lone-survivor-of-byron-murder-suicide-dies-in-utah-hospital
3141807	2025-02-18	Florida	Tampa	2600 E 28th Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3141807	https://www.wfla.com/news/hillsborough-county/man-killed-in-quadruple-shooting-identified-by-tampa-police
3138476	2025-02-12	Missouri	Saint Louis (Ferguson)	7000 block of Halpin Dr	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3138476	https://www.firstalert4.com/2025/02/13/2-people-shot-ferguson-police-investigating
3211202	2025-05-16	Nevada	Las Vegas	1725 N Rainbow Blvd	1	4	1	0	0	https://www.gunviolencearchive.org/incident/3211202	https://www.8newsnow.com/investigators/las-vegas-police-investigate-drug-link-to-gym-shooting
3212178	2025-05-18	Georgia	Macon	4376 Log Cabin Dr	3	6	0	0	3	https://www.gunviolencearchive.org/incident/3212178	https://wgxa.tv/news/local/fourth-suspect-in-macon-bar-triple-homicide-dies-by-suicide-bibb-county-coroner-confirms-christopher-valentine-jr-coroner-leon-jones-bibb-county-sheriffs-office-midtown-daiqirui-bar-and-grill-mass-shooting-gun-violence
3211548	2025-05-16	Illinois	Chicago	600 block of S Homan Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3211548	https://www.cbsnews.com/chicago/news/mass-shooting-east-garfield-park-gas-station
3211604	2025-05-17	Washington	Seattle	172 S Washington St	3	1	0	0	3	https://www.gunviolencearchive.org/incident/3211604	https://www.kiro7.com/news/local/murder-charges-filed-2-suspects-pioneer-square-nightclub-mass-shooting/K44PPBKBYVHRDFFGPDMVJC7SAA/
3211829	2025-05-17	Michigan	Jackson	103 Lincoln Ct	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3211829	https://www.mlive.com/news/jackson/2025/05/son-of-jacksons-beloved-mama-tu-tu-killed-in-quadruple-shooting.html
3206964	2025-05-11	South Carolina	Florence	3027 E Palmetto St	1	5	0	1	1	https://www.gunviolencearchive.org/incident/3206964	https://www.wmbfnews.com/2025/05/14/arrest-made-florence-county-nightclub-that-killed-security-guard-sheriff-says
3209696	2025-05-11	Georgia	Valdosta	700 block of E Gordon St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3209696	https://www.walb.com/2025/05/16/update-wanted-man-turns-himself-following-south-georgia-prom-party-shooting
3172689	2025-03-29	Maryland	Baltimore	400 block of Venable Ave	0	4	0	0	2	https://www.gunviolencearchive.org/incident/3172689	https://www.baltimorepolice.org/news/northern-district-attempted-murder-arrest-update
3173569	2025-03-30	Texas	Austin	215 E 6th St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3173569	https://www.kvue.com/article/news/crime/lit-lounge-shooting-arrest-affidavit/269-26e1ebd9-3f31-41ba-be19-a5f71badcdd6
3173872	2025-03-30	California	San Francisco	58 Middle Point Rd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3173872	https://www.kron4.com/news/bay-area/multiple-people-injured-after-shooting-in-sfs-bayview-neighborhood
3253102	2025-07-05	Pennsylvania	Philadelphia	1136 S 11th St	0	8	0	0	1	https://www.gunviolencearchive.org/incident/3253102	https://phl17.com/phl17-news/crime/police-announce-additional-arrest-in-south-philadelphia-mass-shooting
3113477	2025-01-11	Louisiana	Dubberly	5185 State Rte 531	0	6	0	0	4	https://www.gunviolencearchive.org/incident/3113477	https://www.ksla.com/2025/01/15/2-suspects-arrested-connection-with-bonfire-shooting-webster-parish
3252547	2025-07-04	Ohio	Columbus	827 Wilson Ave	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3252547	https://www.nbc4i.com/news/local-news/columbus/17-year-old-identified-as-victim-of-fatal-east-columbus-party-shooting
3249480	2025-06-29	South Carolina	Kingstree	200 N Brooks St	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3249480	https://www.wbtw.com/news/pee-dee/man-jailed-on-murder-attempted-murder-charges-in-shooting-at-pee-dee-apartment-complex
3187190	2025-04-17	Florida	Tallahassee	75 N Woodward Ave	2	5	0	1	1	https://www.gunviolencearchive.org/incident/3187190	https://www.wtxl.com/college-town/fsu-shooting/fsu-shooting-victim-releases-statement-following-deadly-shooting-on-campus
3316718	2025-09-27	North Carolina	Raleigh	2600 block of E Millbrook Rd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3316718	https://www.wral.com/news/local/hookah-millbrook-shooting-sept-2025
3334403	2025-10-17	Texas	Mabank	7000 block of Broken Bow Dr	3	2	1	0	0	https://www.gunviolencearchive.org/incident/3334403	https://www.dallasnews.com/news/crime/2025/10/27/suspect-in-triple-homicide-who-crashed-into-ennis-buc-ees-dies-officials-say
3220528	2025-05-28	Hawaii	Waianae	Lahaina St and Jade St	1	3	0	1	4	https://www.gunviolencearchive.org/incident/3220528	https://www.hawaiinewsnow.com/2025/08/19/fourth-suspect-pleads-not-guilty-deadly-makaha-shooting
3217732	2025-05-25	Tennessee	Oak Ridge	S Benedict Ave	0	9	0	0	0	https://www.gunviolencearchive.org/incident/3217732	https://www.wbir.com/article/news/local/oak-ridge-anderson/mother-of-victim-from-scarboro-block-party-shooting-speaks-out/51-e9d271f2-e01d-4db9-8923-608e3ca72b53
3206052	2025-05-09	Michigan	Eastpointe	8 Mile and Kelly Rd	1	4	0	0	1	https://www.gunviolencearchive.org/incident/3206052	https://www.detroitnews.com/story/news/local/macomb-county/2025/07/24/man-charged-with-killing-1-injuring-4-in-eastpointe-drive-by-shooting/85356147007
3201452	2025-05-04	Oklahoma	Tulsa	E 2nd St S and S Elgin Ave	0	5	1	1	0	https://www.gunviolencearchive.org/incident/3201452	https://www.kjrh.com/news/local-news/downtown-shooting-chaotic-scene-in-downtown-tulsa-2-officer-involved-shootings
3261161	2025-07-12	Wisconsin	Milwaukee	618 N Water St	2	3	0	0	1	https://www.gunviolencearchive.org/incident/3261161	https://www.fox6now.com/news/milwaukee-shootings-violent-weekend-4-dead-others-injured
3254764	2025-07-07	Pennsylvania	Philadelphia	1500 block of S Etting St	3	9	0	0	4	https://www.gunviolencearchive.org/incident/3254764	https://www.nbcphiladelphia.com/news/local/4th-suspect-arrested-in-south-philly-mass-shooting-that-left-3-dead-9-hurt/4272201
3276908	2025-08-01	Montana	Anaconda	819 E 3rd St	4	0	0	0	1	https://www.gunviolencearchive.org/incident/3276908	https://www.kbzk.com/news/crime-courts/suspect-in-anaconda-shootings-has-been-captured
3272738	2025-07-27	Illinois	Mount Vernon	600 block of S 15th St	2	5	0	0	3	https://www.gunviolencearchive.org/incident/3272738	https://www.wmix94.com/2025/08/07/two-more-arrested-in-deadly-mt-vernon-shooting-case-investigation-continues
3185538	2025-04-15	Texas	Dallas	5520 Langdon Rd	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3185538	https://www.fox4news.com/news/dallas-school-shooting-teacher-grazed-affidavit
3180141	2025-04-08	Virginia	Fredericksburg	415 Olde Greenwich Cir	3	3	0	1	5	https://www.gunviolencearchive.org/incident/3180141	https://fredericksburg.com/news/local/crime-courts/article_ab5c6d63-118c-46a9-97bb-7e329870bbbf.html
3231819	2025-06-11	Florida	Jacksonville	5020 Cleveland Rd	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3231819	https://www.wokv.com/news/local/four-young-people-shot-one-dead-northwest-jacksonville/A7MHBB5G2FCA7HZDA4GRXPA7RE/
3303073	2025-09-07	Ohio	Cleveland	1051 W 10th St	0	5	0	1	3	https://www.gunviolencearchive.org/incident/3303073	https://www.cleveland.com/news/2025/10/two-men-teen-indicted-in-cleveland-flats-shooting-that-wounded-six-during-browns-home-opener.html
3313554	2025-09-22	Texas	El Paso	10700 Montana Ave	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3313554	https://kvia.com/news/abc-7-alert-center/2025/09/25/multiple-injured-after-reported-shooting
3161075	2025-03-14	Illinois	Chicago	1949 W 51st St	0	4	0	1	3	https://www.gunviolencearchive.org/incident/3161075	https://cwbchicago.com/2025/06/third-person-charged-with-mass-shooting-at-goldmore-liquors.html
3151474	2025-03-01	California	Hayward	21933 Foothill Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3151474	https://www.eastbaytimes.com/2025/03/03/four-people-shot-outside-restaurant-in-hayward
3135318	2025-02-08	North Carolina	Raleigh	1000 block of Auston Grove Dr	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3135318	https://www.wral.com/news/local/four-men-shot-on-auston-grove-drive-raleigh-feb-2025
3124977	2025-01-26	Texas	Amarillo	709 S Polk St	1	8	0	0	1	https://www.gunviolencearchive.org/incident/3124977	https://abc7amarillo.com/news/local/city-of-amarillo-releases-statement-on-polk-street-shooting
3243663	2025-06-23	Maryland	Baltimore	1900 block of McHenry St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3243663	https://www.baltimoresun.com/2025/06/24/edmondson-avenue-shootings-baltimore
3242431	2025-06-21	California	Compton	1300 W El Segundo Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3242431	https://2urbangirls.com/2025/06/4-shot-at-sibrie-park-in-compton
3369496	2025-12-05	South Carolina	Union	683 Rice Ave Ext	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3369496	https://www.foxcarolina.com/2025/12/05/3-adults-1-minor-hospitalized-following-shooting-union-deputies-say
3356033	2025-11-15	New Jersey	Newark	300 block of Chancellor Ave	3	2	0	0	0	https://www.gunviolencearchive.org/incident/3356033	https://www.nj.com/essex/2025/11/19-year-old-victim-dies-days-after-deadly-nj-shooting-that-killed-young-woman-and-child.html
3173790	2025-03-29	South Carolina	Orangeburg	1175 Five Chop Rd	0	7	0	0	1	https://www.gunviolencearchive.org/incident/3173790	https://abcnews4.com/news/state/fugitive-arrested-for-party-shooting-after-extensive-manhunt-sincere-gibbs-june-2025
3114020	2025-01-12	Nebraska	Omaha	N 24th St and Binney St	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3114020	https://www.ketv.com/article/five-people-injured-in-shooting-at-24th-and-binney-st/63402315
3319064	2025-09-28	Alabama	Selma	1200 Woodrow Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3319064	https://www.waka.com/2025/09/29/drive-by-shooting-in-selma-leaves-one-dead-and-three-hurt
3253178	2025-07-04	Virginia	Charlottesville	Orangedale Ave	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3253178	https://www.cbs19news.com/news/cpd-announces-charges-in-orangedale-avenue-shooting/article_e665530a-b74d-4977-98d8-7409b0be6d18.html
3251873	2025-07-03	Illinois	Chicago	600 block of E 133rd St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3251873	https://www.fox32chicago.com/news/chicago-crime-five-people-hospitalized-after-shooting-far-south-side
3190014	2025-04-20	Louisiana	Ruston	302 S Farmerville St	1	5	0	0	1	https://www.gunviolencearchive.org/incident/3190014	https://www.knoe.com/2025/05/08/us-marshals-arrest-ruston-easter-shooting-suspect
3335652	2025-10-18	Mississippi	Gautier	2726 Ladnier Rd	1	3	0	0	3	https://www.gunviolencearchive.org/incident/3335652	https://www.fox10tv.com/2025/10/21/gpd-3-teens-arrested-charged-with-murder-following-shooting-gautier-apartment-complex
3221157	2025-05-29	Indiana	Haubstadt	12000 block of S Scottsdale Dr	3	1	0	0	1	https://www.gunviolencearchive.org/incident/3221157	https://www.wevv.com/news/crime/man-accused-of-killing-three-in-gibson-county-files-lawsuit-alleging-elder-abuse-and-fraud/article_36a82ff2-e286-45cd-be57-17df08699561.html
3217117	2025-05-23	Pennsylvania	Chester	205 E 10th St	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3217117	https://www.nbcphiladelphia.com/news/local/chester-pennsylvania-shooting-teen-killed-party-gathering-delaware-county/4193453
3206048	2025-05-09	Michigan	Detroit	15700 block of Patton St	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3206048	https://www.detroitnews.com/story/news/local/detroit-city/2025/05/16/feds-accuse-man-of-opening-fire-during-chaotic-scene-that-ended-with-5-shot-2-dead/83671384007
3262173	2025-07-13	Texas	Houston	6502 Dixie Dr	2	15	0	0	0	https://www.gunviolencearchive.org/incident/3262173	https://www.fox26houston.com/news/houston-drive-by-shooting-bugs-bar-woman-killed-identified
3255922	2025-07-07	California	Los Angeles	10305 Main St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3255922	https://2urbangirls.com/2025/07/4-injured-in-south-la-shooting
3273521	2025-07-28	Nevada	Reno	2500 E 2nd St	3	3	1	0	0	https://www.gunviolencearchive.org/incident/3273521	https://www.msn.com/en-us/news/crime/medical-examiner-releases-new-details-on-gsr-shooting-victims-deaths/ar-AA1JC9Pm
3273415	2025-07-27	Illinois	Chicago	W Flournoy St and S Springfield Ave	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3273415	https://www.fox32chicago.com/news/chicago-crime-teen-shooting-lawndale
3184539	2025-04-13	Missouri	Saint Louis	3800 block of Natural Bridge Ave	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3184539	https://www.ksdk.com/article/news/crime/fairgrounds-park-mass-shooting-st-louis/63-656e1585-2f6e-491a-85a3-66e013567b3c
3177421	2025-04-04	Tennessee	Knoxville	8039 Ray Mears Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3177421	https://www.wate.com/news/knox-county-news/knoxville-police-investigating-buckethead-tavern-shooting
3233357	2025-06-15	Michigan	Detroit	N/A	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3233357	https://x.com/DetroitScanner/status/1934116033901564386
3228035	2025-06-08	Ohio	Cleveland	4071 Lee Rd	0	7	0	0	4	https://www.gunviolencearchive.org/incident/3228035	https://www.cleveland.com/news/2025/07/four-teens-arrested-in-connection-with-cleveland-shooting-that-injured-seven.html
3306639	2025-09-12	Illinois	Chicago	6600 block of S Halsted St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3306639	https://www.cbsnews.com/chicago/news/chicago-south-side-mass-shooting
3300931	2025-09-03	Missouri	Kansas City	Harrison St and E Armour Blvd	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3300931	https://www.kctv5.com/2025/09/11/kansas-city-man-dies-week-after-shooting-that-injured-5
3157288	2025-03-10	Alabama	Huntsville	708 Poplar Ave NW	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3157288	https://whnt.com/news/huntsville/one-charged-with-assault-in-overnight-shooting-at-huntsville-bar-4-injured
3131985	2025-02-04	Ohio	New Albany	8825 Smiths Mill Rd N	2	4	0	0	1	https://www.gunviolencearchive.org/incident/3131985	https://abc6onyourside.com/news/local/judge-to-determine-if-new-albany-warehouse-shooter-can-stand-trial-kdc-one-six-shot-mental-health-competency-exam
3242524	2025-06-21	California	Moreno Valley	12000 block of Orchid Ln	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3242524	https://www.riversidesheriff.org/CivicAlerts.aspx?AID=6437
3355968	2025-11-16	Florida	Jacksonville	A Philip Randolph Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3355968	https://www.firstcoastnews.com/article/news/crime/four-hurt-shooting-jacksonville-party/77-39389bd9-2bd0-413b-a036-360e4530292d
3253940	2025-07-05	California	San Francisco	100 block of Harbor Rd	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3253940	https://sfist.com/2025/07/09/15-year-old-antioch-teen-shot-and-killed-at-july-4-bayview-district-block-party
3108706	2025-01-03	District of Columbia	Washington	1500 block of Harry Thomas Way NE	0	4	0	1	1	https://www.gunviolencearchive.org/incident/3108706	https://wjla.com/news/local/5-injured-fridays-northeast-dc-shooting-was-arrested-as-the-shooter-1500-block-of-harry-thomas-way-818-pm-28-year-old-deamonte-bridgeforth-of-northeast-dc-arguement
3252972	2025-07-04	Illinois	Chicago	4859 S Justine St	0	7	0	0	0	https://www.gunviolencearchive.org/incident/3252972	https://abc7chicago.com/post/back-yards-chicago-shooting-least-7-injured-mass-4800-block-south-justine-street-cpd-says/16966395
3251608	2025-07-01	Kentucky	Nicholasville	Brannon Rd and US-27	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3251608	https://www.lex18.com/news/crime/police-confirm-multiple-people-injured-in-drive-by-shooting-in-nicholasville
3189178	2025-04-19	Tennessee	Memphis	Mosby Ave and N Dunlap St	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3189178	https://www.fox13memphis.com/news/at-least-36-shot-15-dead-in-one-week-in-memphis-and-shelby-county/article_7194f2b8-f540-470f-b2e1-e93168e9173d.html
3116474	2025-01-16	Colorado	Colorado Springs	7000 block of Dove Creek Cir	1	3	0	0	5	https://www.gunviolencearchive.org/incident/3116474	https://gazette.com/news/crime/public-safety/fifth-suspect-arrested-in-connection-with-fatal-security-widefield-shootout/article_000705da-6f1a-4070-a919-5b11edddb6c7.html
3335450	2025-10-18	Texas	Dallas	900 block of N Haskell Ave	0	4	0	0	2	https://www.gunviolencearchive.org/incident/3335450	https://www.fox4news.com/news/18-year-old-arrested-after-4-shot-early-morning-dallas-attack
3222806	2025-05-31	Indiana	Clarksville	1909 Greentree Blvd	0	4	0	0	2	https://www.gunviolencearchive.org/incident/3222806	https://www.whas11.com/article/news/crime/clarksville-the-bend-apartment-complex-shooting-arrests/417-49dfa7a0-23c2-4235-a33d-a7c2e005f226
3217494	2025-05-24	Colorado	Colorado Springs	1429 Potter Dr	0	6	0	0	1	https://www.gunviolencearchive.org/incident/3217494	https://gazette.com/news/crime/palmer-park-academy-shooting-arrest/article_e9f99b26-d38a-424f-adf9-ac2876c6b9dd.html
3205141	2025-05-07	Connecticut	Hartford	Nelson St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3205141	https://www.fox61.com/article/news/local/hartford-county/hartford/hartford-shooting-investigation-nelson-street/520-de58645f-8380-4741-9197-8cbec91cc04a
3201936	2025-05-04	Arizona	Glendale	6729 N 57th Dr	3	5	0	0	0	https://www.gunviolencearchive.org/incident/3201936	https://www.kivitv.com/news/national/three-dead-five-hurt-after-shooting-at-restaurant-near-59th-and-glendale-avenues-sunday
3261477	2025-07-12	Pennsylvania	Easton	100 block of Wilkes Barre St	0	6	0	0	2	https://www.gunviolencearchive.org/incident/3261477	https://www.pennlive.com/crime/2025/08/pa-16-year-old-shot-wounded-6-at-birthday-party-police.html
3260230	2025-07-08	Idaho	Burley	723 E 14th St	4	0	0	0	1	https://www.gunviolencearchive.org/incident/3260230	https://www.ksl.com/article/51344860/court-documents-reveal-how-detectives-tracked-down-cassia-minidoka-quadruple-murder-suspect
3253521	2025-07-05	Texas	Dallas	S Good Latimer Expy and Canton St	1	4	0	1	1	https://www.gunviolencearchive.org/incident/3253521	https://dpdbeat.com/2025/07/09/homicide-at-2600-canton-street
3273804	2025-07-28	Michigan	Detroit	3344 Puritan Ave	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3273804	https://www.fox2detroit.com/news/hazel-park-man-charged-shooting-killed-2-wounded-2-others-gas-station
3273353	2025-07-27	Indiana	Indianapolis	3900 block of Hornickel Dr	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3273353	https://www.wrtv.com/news/local-news/crime/5-injured-in-shooting-on-northeast-side-of-indianapolis
3184200	2025-04-13	Arkansas	Conway	600 5th Ave	2	9	0	0	4	https://www.gunviolencearchive.org/incident/3184200	https://www.facebook.com/conwaypd/posts/pfbid023hMH8ecbTMiTvfQ75ApTzMr3DfRZqJvBqnF6aUsMUSQftJgiXmafjRX5bRtqfSoKl?__cft__[0]=AZUKX8L6Yd0WCd2E7CeTToWI9pHAiKZCcUGYLQXvAI6JvzELuhPXjFyyWVJAVs3SrGqR2J17jS9PqR92oQIrejZLTyRAcxp9VgYWL7cJBnGK1pMVgHjyPGb-k7P2pbiB_6m
3233431	2025-06-14	Tennessee	Nashville	Westchester Dr and Brick Church Pike	1	4	0	0	1	https://www.gunviolencearchive.org/incident/3233431	https://fox17.com/news/local/from-trip-to-horror-4-year-old-killed-family-reeling-after-weekend-shooting-in-madison-murder-in-tennessee-family-shot-at-google-news
3228293	2025-06-08	Georgia	Lagrange	105 Seminary St	1	6	0	0	0	https://www.gunviolencearchive.org/incident/3228293	https://www.wtvm.com/2025/06/08/19-year-old-dead-6-injured-overnight-shooting-seminary-st-lagrange
3308426	2025-09-15	Minnesota	Minneapolis	28th Ave S and E Lake St	1	7	0	0	1	https://www.gunviolencearchive.org/incident/3308426	https://www.mncrime.com/latest/drug-dispute-at-encampment-led-to-deadly-shootout-charges-say
3302041	2025-09-06	Virginia	Portsmouth	Manly St and Dahlia St S	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3302041	https://www.wtkr.com/news/in-the-community/portsmouth/portsmouth-police-investigate-deadly-saturday-morning-shooting
3166052	2025-03-21	New Mexico	Las Cruces	850 S Walnut St	3	15	0	0	4	https://www.gunviolencearchive.org/incident/3166052	https://www.kob.com/news/top-news/las-cruces-park-mass-shooting-survivors-share-story
3151104	2025-03-02	Louisiana	Franklinton	Greenlaw St	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3151104	https://www.wdsu.com/article/franklinton-police-investigating-after-shooting-leaves-five-people-hurt/64006783
3134167	2025-02-06	Florida	Quincy	3749 Pat Thomas Pkwy	2	3	1	0	0	https://www.gunviolencearchive.org/incident/3134167	https://www.wctv.tv/2025/02/13/husband-identifies-wife-second-victim-killed-quincy-gas-station-shooting
3125975	2025-01-27	Indiana	Elkhart	575 E Jackson Blvd	2	2	1	0	0	https://www.gunviolencearchive.org/incident/3125975	https://www.goshennews.com/news/update-victims-gunman-in-elkhart-martins-shooting-identified/article_3d6ddcea-ddaf-11ef-a7d4-dbb99ee1c2c1.html
3242853	2025-06-22	Michigan	Ferndale	21298 Majestic Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3242853	https://www.wxyz.com/news/1-dead-4-shot-during-party-at-the-royal-oak-township-park
3242658	2025-06-21	Oklahoma	Tulsa	300 block of N Greenwood Ave	1	7	0	0	3	https://www.gunviolencearchive.org/incident/3242658	https://www.krmg.com/news/local/third-suspect-arrested-connection-with-deadly-juneteenth-shooting-tulsa/KQTZMM2IQNFZ5HWOKIUGL2OFD4
3365899	2025-11-29	California	Stockton	1943 Lucile Ave	4	13	0	0	0	https://www.gunviolencearchive.org/incident/3365899	https://stocktonia.org/news/public-safety/2025/12/09/stockton-shooting-50-shots-5-guns
3355592	2025-11-15	Kansas	Carbondale	11222 S Topeka Ave	0	5	1	0	0	https://www.gunviolencearchive.org/incident/3355592	https://www.cjonline.com/story/news/crime/2025/11/17/heres-how-to-help-officers-trooper-hit-by-gunfire-in-osage-county/87328078007
3253594	2025-07-05	Texas	Lubbock	2902 Parkway Dr	0	5	1	0	0	https://www.gunviolencearchive.org/incident/3253594	https://www.everythinglubbock.com/news/local-news/2-arrested-in-brawl-at-lubbock-gas-station-that-led-to-officer-involved-shooting
3106379	2025-01-01	Louisiana	New Orleans	Bourbon St and Iberville St	1	7	1	0	0	https://www.gunviolencearchive.org/incident/3106379	https://www.fbi.gov/contact-us/field-offices/neworleans/news/fbi-releases-investigative-update-in-bourbon-street-attack
3253257	2025-07-04	New York	Albany	333 Madison Ave	1	3	0	0	3	https://www.gunviolencearchive.org/incident/3253257	https://spectrumlocalnews.com/news/2025/07/18/[object%20Promise]
3252377	2025-07-03	Georgia	Atlanta	600 SE Martin St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3252377	https://www.fox5atlanta.com/news/shooting-summerhill-apartment-complex-martin-street
3195885	2025-04-26	South Carolina	Myrtle Beach	913 N Ocean Blvd	0	11	1	0	0	https://www.gunviolencearchive.org/incident/3195885	https://www.wbtw.com/news/grand-strand/myrtle-beach/sled-finishes-redacting-report-on-deadly-officer-involved-shooting-in-myrtle-beach-police-say
3115486	2025-01-14	Texas	Houston	12867 Greens Bayou St	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3115486	https://abc13.com/post/narcotics-cash-found-east-houston-shooting-scene-after-2-men-killed-others-hurt-police-say/15802060
3334505	2025-10-17	Oklahoma	Bethany	N Rockwell Ave and NW 16th St	0	4	0	0	3	https://www.gunviolencearchive.org/incident/3334505	https://okcfox.com/news/local/4-injured-3-arrested-in-bethany-after-fight-leads-to-shooting-crime-rockwell
3223123	2025-05-31	Mississippi	Fayette	1483 Main St	1	8	0	0	3	https://www.gunviolencearchive.org/incident/3223123	https://www.wlbt.com/2025/07/04/exclusive-mother-brothers-arrested-fayette-day-festival-mass-shooting
3219130	2025-05-27	Connecticut	Waterbury	495 Union St	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3219130	https://www.wfsb.com/2025/05/27/police-investigating-shooting-brass-mill-center-waterbury
3203108	2025-05-06	Tennessee	Memphis	2536 N Watkins Rd	2	3	0	0	0	https://www.gunviolencearchive.org/incident/3203108	https://www.fox13memphis.com/news/5-shot-2-killed-after-shooting-at-frayser-sports-bar-mpd-says/article_9dc83080-dd54-479c-8c08-ad5dfd78501d.html
3203390	2025-05-05	Pennsylvania	Sharon	317 Baldwin Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3203390	https://www.ncnewsonline.com/news/local_news/police-find-sharon-shooting-suspect-car-in-new-castle/article_29dfd242-7036-445a-8c11-4a41142926e7.html
3261407	2025-07-13	North Carolina	Charlotte	300 N College St	1	5	0	0	3	https://www.gunviolencearchive.org/incident/3261407	https://www.wbtv.com/2025/07/18/police-charge-16-year-old-deadly-uptown-mass-shooting
3254338	2025-07-06	Louisiana	Natchitoches	300 block of Keyser Ave	1	5	0	0	2	https://www.gunviolencearchive.org/incident/3254338	https://www.kalb.com/2025/11/11/2-indicted-murder-natchitoches-parish-homicide
3275972	2025-07-30	Pennsylvania	Philadelphia	728 S 55th St	0	6	0	0	1	https://www.gunviolencearchive.org/incident/3275972	https://www.nbcphiladelphia.com/news/local/boy-8-among-those-injured-in-west-philly-rec-center-pool-shooting-officials-say/4248995
3272694	2025-07-26	Pennsylvania	Philadelphia	1900 block of W Hunting Park Ave	2	2	0	0	2	https://www.gunviolencearchive.org/incident/3272694	https://www.nbcphiladelphia.com/news/local/man-arrested-birthday-party-mass-shooting-nicetown-philadelphia-july-2025/4294027
3184142	2025-04-13	Florida	Daytona Beach	155 Ontario Ct	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3184142	https://www.clickorlando.com/news/local/2025/04/13/3-hospitalized-1-found-dead-after-daytona-beach-shooting
3178598	2025-04-05	California	Los Angeles	11000 block of S Manhattan Pl	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3178598	https://2urbangirls.com/2025/04/authorities-id-inglewood-man-killed-in-south-la-mass-shooting/#google_vignette
3238280	2025-06-14	Mississippi	Greenville	1500 block of S Colorado St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3238280	https://www.deltadailynews.com/local/four-injured-in-late-night-shooting-in-greenville
3231555	2025-06-11	Michigan	Detroit	14300 block of Mettetal St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3231555	https://www.cbsnews.com/detroit/news/4-injured-barbecue-party-detroit-june-11
3304563	2025-09-09	California	San Francisco	1555 Burke St	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3304563	https://www.ktvu.com/news/6-hurt-shooting-marijuana-event-sfs-bayview
3297880	2025-08-31	Illinois	Chicago	2700 block of W Haddon Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3297880	https://www.fox32chicago.com/news/chicago-labor-day-weekend-25-mass-shootings
3163394	2025-03-18	Georgia	Savannah	1900 Westlake Ave	0	5	0	0	4	https://www.gunviolencearchive.org/incident/3163394	https://www.savannahnow.com/story/news/crime/2025/09/24/four-arrested-in-connection-with-march-shooting-at-westlake-apartments/86328584007
3150651	2025-03-02	Texas	Houston	3333 Raleigh St	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3150651	https://cityofhouston.news/suspect-arrested-charged-in-shooting-at-3333-raleigh-street
3134984	2025-02-08	Arizona	Casa Grande	500 block of W 13th Pl	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3134984	https://www.facebook.com/cgpolice/posts/pfbid0CgegkqiKETqH3KHAHNRjL35g6GMXiT1hDMfenD37fJgDfYWVL2e4vZdHGSkKejjZl
3129663	2025-01-31	California	Los Angeles	13200 block of Jarvis Avenue	2	5	0	0	0	https://www.gunviolencearchive.org/incident/3129663	https://local.nixle.com/alert/11368223/?sub_id=0
3242610	2025-06-22	New Jersey	East Orange	375 Central Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3242610	https://www.rlsmedia.com/article/multiple-people-hospitalized-following-shooting-east-orange-mcdonalds
3242684	2025-06-21	Oklahoma	Tulsa	E Admiral Pl and S 122nd E Ave	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3242684	https://basentinel.com/another-mass-shooting-chaos-in-downtown-tulsa
3362005	2025-11-23	Tennessee	Union City	202 Railroad St	1	6	0	0	0	https://www.gunviolencearchive.org/incident/3362005	https://www.nbc39.com/news/local/shooting-in-union-city-kills-1-injures-more/article_fd41c194-345b-4fb1-beb0-e6fe692d5db0.html
3356122	2025-11-15	New Mexico	Las Cruces	2400 block of Bugatti Dr	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3356122	https://kfoxtv.com/news/local/teen-arrested-in-connection-with-fatal-las-cruces-house-party-shooting
3254389	2025-07-05	Alabama	Talladega	1509 Old Shocco Rd	4	0	0	0	1	https://www.gunviolencearchive.org/incident/3254389	https://www.wbrc.com/2025/10/02/talladega-capital-murder-suspect-case-heading-grand-jury
3106647	2025-01-01	Illinois	Kankakee	1845 Pierson Pkwy	2	5	0	0	0	https://www.gunviolencearchive.org/incident/3106647	https://wgntv.com/kankakee-county/2-dead-5-wounded-during-shooting-at-new-years-eve-party-in-kankakee
3253569	2025-07-05	Ohio	Cleveland	11501 Buckeye Rd	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3253569	https://www.facebook.com/Clevelandremembrancepage
3251635	2025-07-02	Illinois	Chicago	311 W Chicago Ave	4	14	0	0	0	https://www.gunviolencearchive.org/incident/3251635	https://cwbchicago.com/2025/07/video-shows-gang-signs-thrown-moments-before-drive-by-gunmen-killed-4-injured-14.html
3189434	2025-04-20	Texas	Houston	12929 Nyack Dr	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3189434	https://cityofhouston.news/surveillance-video-released-in-shooting-at-12929-nyack-drive
3316678	2025-09-27	Louisiana	Alexandria	7533 US-71	1	4	0	0	2	https://www.gunviolencearchive.org/incident/3316678	https://www.facebook.com/TheCenlaReport/posts/pfbid0THLmQtnUVrovr4bVZNtzNbtyB8R9RYruZcF3DcS75j3uweDZLqTcfS2adhfMqsAal?__cft__[0]=AZWY9N8cwjHhAZiq65fpfQy61yBg6cvuZ1jCNFJq2krQqtzCiSA2mM-33LtHotclDGXTXvgjz_gLnQE3xs1yBXO_4f7YFEWmvHhIswQaYOent4_tcciWNGWVg65c6d
3220589	2025-05-28	Georgia	Atlanta	2261 Cascade Rd SW	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3220589	https://www.11alive.com/article/news/crime/4-hurt-gas-station-shooting-cascade-road/85-65b76f36-c70d-4e6f-8dde-f5cada91efbb
3203683	2025-05-05	South Carolina	North Charleston	6800 block of Ward Ave	1	3	1	0	0	https://www.gunviolencearchive.org/incident/3203683	https://abcnews4.com/news/local/coroner-ids-man-and-woman-found-dead-after-alleged-murder-suicide-in-north-charleston-brianna-nelson-travis-wright-bobbi-jo-oneal-wciv-abc-news-4-5-7-2025
3254122	2025-07-06	Ohio	Toledo	159 Matzinger Rd	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3254122	https://www.13abc.com/2025/07/06/tpd-several-injured-shooting-outside-toledo-sports-bar-sunday-morning
3276476	2025-07-30	Georgia	Atlanta	2479 Abner Terrace NW	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3276476	https://www.wsbradio.com/news/local/four-people-wounded-overnight-apartment-shooting-atlanta/HC4GVHHAXND5ZNGJMMSUBUBE2E
3273390	2025-07-26	Mississippi	Yazoo City	Leach St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3273390	https://www.wdam.com/2025/07/27/four-juveniles-shot-yazoo-city-gang-retaliation-could-be-motive
3183722	2025-04-12	Texas	Crosby	13203 Crosby Lynchburg Rd	1	6	0	0	0	https://www.gunviolencearchive.org/incident/3183722	https://baytownsun.com/local/19-year-old-killed-in-crosby-mass-shooting/article_fad3baa4-4a0c-482a-a7ed-44600ccf5e85.html
3173233	2025-03-30	Indiana	Whiting	1516 Indianapolis Blvd	2	3	0	0	1	https://www.gunviolencearchive.org/incident/3173233	https://abc7chicago.com/post/merrillville-man-caprice-edward-cashaw-charged-deadly-hammond-shooting-portside-pub-indianapolis-boulevard-police/16116639
3232732	2025-06-14	Minnesota	Minneapolis (Brooklyn Park)	8710 Windsor Terrace N	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3232732	https://www.cnn.com/2025/07/15/us/vance-luther-boelter-charges-minnesota
3231072	2025-06-09	Georgia	Augusta	2101 Walton Way	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3231072	https://www.wfxg.com/news/four-injured-in-shooting-at-bon-air-apartments/article_bd6e5a94-13cb-4cfc-a644-7fba7d1c723d.html
3304605	2025-09-08	California	Santa Ana	400 S Susan St	1	3	0	0	5	https://www.gunviolencearchive.org/incident/3304605	https://newsantaana.com/the-sapd-arrested-five-suspects-in-the-fatal-shooting-of-a-13-year-old
3299148	2025-09-01	New York	Bronx	686 Allerton Ave	1	4	0	0	4	https://www.gunviolencearchive.org/incident/3299148	https://bronx.news12.com/da-drops-case-against-teen-charged-in-connection-to-allerton-shooting
3161961	2025-03-15	New Jersey	Verona	10 Park Pl	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3161961	https://newjersey.news12.com/police-4-people-injured-in-shootout-at-verona-event-venue
3152807	2025-03-04	Maryland	Severn	8100 block of Meade Village Rd	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3152807	https://patch.com/maryland/odenton/vigil-mourns-men-fatally-shot-basketball-game-fundraiser-underway
3130376	2025-02-02	Pennsylvania	Allentown	1500 Union Blvd	1	3	0	0	2	https://www.gunviolencearchive.org/incident/3130376	https://www.wfmz.com/news/area/lehighvalley/lehigh-county/allentown-area/second-arrest-made-in-bkk-lounge-homicide-case/article_64b5c40e-e64a-11ef-b44c-a35fd042bd8c.html
3127740	2025-01-29	Tennessee	Memphis	900 block of College Park Dr	2	2	0	1	1	https://www.gunviolencearchive.org/incident/3127740	https://www.actionnews5.com/2025/03/27/man-arrested-shooting-near-lemoyne-owen-that-left-two-dead
3242908	2025-06-22	Missouri	Kansas City	Vine St and E 19th St	2	4	0	0	1	https://www.gunviolencearchive.org/incident/3242908	https://www.kshb.com/news/crime/police-2nd-victim-dies-from-injuries-in-june-22-shooting-at-18th-and-vine-district
3242475	2025-06-21	South Carolina	Anderson	2009 Scarborough Rd	1	9	0	0	3	https://www.gunviolencearchive.org/incident/3242475	https://www.wistv.com/2025/06/23/deputies-arrest-made-deadly-mass-shooting-during-juneteenth-celebration-anderson
3361663	2025-11-24	Texas	Dallas	2026 Commerce St	1	3	1	0	0	https://www.gunviolencearchive.org/incident/3361663	https://www.cbsnews.com/texas/news/downtown-dallas-police-shooting-update-hyde-and-seek
3356624	2025-11-15	Mississippi	Mantee	Cousin Rd	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3356624	https://www.wtva.com/news/clay-county-sheriff-releases-more-details-about-bonfire-shooting-that-wounded-5/article_16be3032-9f14-4af3-94aa-8bb32d87d007.html
3253085	2025-07-05	Massachusetts	Brockton	May St	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3253085	https://www.enterprisenews.com/story/news/crime/2025/07/08/brockton-ma-shooting-may-street-house-party/84498079007
3107148	2025-01-01	New York	Corona (Queens)	91-12 144th Pl	0	10	0	0	0	https://www.gunviolencearchive.org/incident/3107148	https://abc7ny.com/post/mass-shooting-queens-new-york-victim-speaks-exclusively-eyewitness-news/15771606
3253871	2025-07-04	Ohio	Dayton	1600 block of W Grand Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3253871	https://www.whio.com/news/local/4-hospitalized-after-shooting-during-fourth-july-block-party-dayton/WVQL7HQA7JCWZJY2IZYGHRNY34
3121591	2025-01-21	Minnesota	Minneapolis	W 29th St and Pleasant Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3121591	https://www.facebook.com/CrimeWatch5thPct/posts/pfbid05ZTgsV3ryh5PvSRjuHLjp2oRaUdvB72dnaqCGK6nVNpeLmeZLCsA1Egh4BkHSYpfl
3334113	2025-10-17	Illinois	Chicago	1100 block of N Dearborn St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3334113	https://abc7chicago.com/post/chicago-shooting-heavy-police-presence-reported-gold-coast-witness-reports-hearing-shots/18024467
3222306	2025-05-31	Illinois	Chicago	7800 block of S Throop St	0	7	0	0	0	https://www.gunviolencearchive.org/incident/3222306	https://www.fox32chicago.com/news/chicago-mass-shooting-7-teens
3218025	2025-05-25	South Carolina	Little River	1522 Watson Ave	0	10	0	0	1	https://www.gunviolencearchive.org/incident/3218025	https://www.wmbfnews.com/2025/09/02/victims-little-river-mass-shooting-blame-lack-security-measures-new-lawsuits
3206682	2025-05-10	Pennsylvania	Philadelphia	N 33rd St and W Girard Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3206682	https://www.cbsnews.com/philadelphia/news/septa-bus-shooting-philadelphia-girard-avenue-33rd
3203064	2025-05-05	Oklahoma	Oklahoma City	308 NW 10th St	0	7	0	0	3	https://www.gunviolencearchive.org/incident/3203064	https://kfor.com/news/local/three-in-custody-in-midtown-shooting-investigation
3317255	2025-09-27	North Carolina	Southport	150 Yacht Basin Dr	3	6	0	0	1	https://www.gunviolencearchive.org/incident/3317255	https://www.wral.com/news/local/guns-seized-nigel-edge-home-october-2025
3261096	2025-07-12	Tennessee	Chattanooga	6900 Ty Hi Dr	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3261096	https://newschannel9.com/news/local/heavy-police-presence-near-tyner-community-center
3255423	2025-07-07	Ohio	Akron	700 E Exchange St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3255423	https://www.cleveland.com/metro/2025/07/5-shot-10-hit-by-cars-in-after-late-night-party-turns-violent-in-akron-school-parking-lot.html
3314438	2025-09-24	Texas	El Paso	911 N Raynor St	2	1	1	0	0	https://www.gunviolencearchive.org/incident/3314438	https://kfoxtv.com/news/local/police-identify-suspect-in-central-el-paso-deadly-shooting-3-dead-1-critically-injured
3273423	2025-07-28	Georgia	Atlanta	349 Edgewood Ave	1	10	0	0	1	https://www.gunviolencearchive.org/incident/3273423	https://www.atlantanewsfirst.com/2025/08/09/19-year-old-arrested-edgewood-avenue-mass-shooting-3-suspects-still-run
3273527	2025-07-27	Colorado	Denver	20th St and Market St	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3273527	https://www.denver7.com/news/front-range/denver/denver-pd-arrests-man-in-connection-with-lodo-shooting-that-injured-4-people
3181158	2025-04-09	Tennessee	Memphis	4005 S Mendenhall Rd	1	5	0	0	1	https://www.gunviolencearchive.org/incident/3181158	https://www.fox13memphis.com/news/survivor-of-memphis-allies-mass-shooting-speaks/article_34c2fc4c-b77d-4a88-8d38-582d0d16c327.html
3314225	2025-09-23	California	Hemet	400 block of Steiner Dr	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3314225	https://www.redlandsdailyfacts.com/2025/09/23/boy-dead-3-people-injured-in-hemet-shooting
3233274	2025-06-14	Ohio	Columbus	S Ludlow St and W Town St	1	6	0	0	0	https://www.gunviolencearchive.org/incident/3233274	https://www.10tv.com/article/news/local/mohamed-fofona-charged-with-murder-downtown-columbus-shooting/530-9e660f5a-84f5-46f8-9cb5-877440fecaf7
3229184	2025-06-09	District of Columbia	Washington	1200 block of Mt Olivet Rd NE	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3229184	https://wjla.com/news/local/dc-shootings-one-dead-lebaum-street-benning-road-mount-olivet-area-deadly-incidents-metropolitan-police-department-investigation-gunfire-shots-fired-violence-crime-public-safety-accountability
3302748	2025-09-07	Texas	Cleveland	2843 County Rd 5018	2	4	0	0	0	https://www.gunviolencearchive.org/incident/3302748	https://www.thevindicator.com/article/main-news/colony-ridge-shooting-suspect-run-two-dead
3298615	2025-09-01	Illinois	Chicago	3600 block of S Cottage Grove Ave	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3298615	https://x.com/CWBChicago/status/1962637088089874591
3161176	2025-03-15	Louisiana	Shreveport	204 Texas St	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3161176	https://www.ksla.com/2025/03/20/mant-wanted-by-police-connection-with-shooting-downtown-shreveport
3151577	2025-03-02	Virginia	Portsmouth	2900 block of Arcadia Ave	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3151577	https://www.dailypress.com/2025/03/20/man-charged-in-connection-to-portsmouth-homicide
3134788	2025-02-08	Oklahoma	Tulsa	11800 block of E 21st St	2	2	0	0	3	https://www.gunviolencearchive.org/incident/3134788	https://ktul.com/news/local/tulsa-teen-murder-suspect-captured-in-mexico-set-to-be-extradited-for-february-shooting-angel-ibarra-two-teen-deaths-first-degree-murder-charge-shooting-with-intent-to-kill-apartment-complex-east-tulsa-police-department-investi
3124458	2025-01-25	Tennessee	Memphis	2590 Park Ave	0	4	0	0	2	https://www.gunviolencearchive.org/incident/3124458	https://www.actionnews5.com/2025/10/15/second-suspect-custody-after-community-center-shootout-orange-mound-mpd-reports/?utm_source=taboola&utm_medium=organicclicks&tbref=hp
3242938	2025-06-22	Missouri	Springfield	505 E St Louis St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3242938	https://www.ky3.com/2025/06/22/police-springfield-investigating-early-morning-shooting-that-injured-multiple-people
3242052	2025-06-20	Wisconsin	Milwaukee	8300 block of W Brown Deer Rd	2	3	0	0	1	https://www.gunviolencearchive.org/incident/3242052	https://www.fox6now.com/news/milwaukee-mall-wild-west-shootout-charges
3360052	2025-11-22	Texas	Houston	15200 Vandalia Way	1	9	0	0	0	https://www.gunviolencearchive.org/incident/3360052	https://cityofhouston.news/investigation-into-fatal-shooting-at-15200-vandalia-way
3351503	2025-11-08	California	San Francisco	Great Hwy and Fulton St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3351503	https://kioncentralcoast.com/news/top-stories/2025/11/15/victim-in-outer-richmond-shooting-last-weekend-was-hit-by-stray-bullet-while-in-his-condo
3254494	2025-07-05	Washington	Sedro Woolley	697 Pacific St	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3254494	https://www.bellinghamherald.com/news/local/crime/article311466430.html
3107042	2025-01-01	Texas	Dallas	2900 block of St George Dr	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3107042	https://dpdbeat.com/2025/01/02/homicide-at-2900-st-george-drive
3253812	2025-07-04	California	Los Angeles	626 W 99th St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3253812	https://mynewsla.com/crime/2025/07/05/three-men-one-woman-wounded-in-vermont-vista-shooting
3248471	2025-06-29	Alabama	Mobile	Springhill Ave and Catherine St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3248471	https://www.wkrg.com/mobile-county/four-people-shot-in-midtown-mobile-mpd-says
3188506	2025-04-18	Texas	Garland	3820 W Walnut St	1	3	0	0	2	https://www.gunviolencearchive.org/incident/3188506	https://www.cbsnews.com/texas/news/garland-apartment-shooting-teen-killed-west-walnut-street-april-18
3118521	2025-01-18	Louisiana	New Orleans (River Ridge)	10133 Stephen Dr	2	2	1	0	0	https://www.gunviolencearchive.org/incident/3118521	https://www.nola.com/news/crime_police/jefferson-parish-deputy-shooting/article_03adf5a6-d5a5-11ef-8d0e-1351a32102f5.html
3335079	2025-10-18	Ohio	Cleveland	7025 Fleet Ave	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3335079	https://www.cleveland19.com/2025/10/18/2-dead-2-critically-injured-slavic-village-shooting-police
3220578	2025-05-28	Washington	Lakewood	8928 N Thorne Ln SW	0	7	0	0	1	https://www.gunviolencearchive.org/incident/3220578	https://www.thenewstribune.com/news/local/crime/article312183386.html
3217632	2025-05-24	Tennessee	Jackson	2700 N Parkway E	0	6	0	1	1	https://www.gunviolencearchive.org/incident/3217632	https://wreg.com/news/mid-south/teen-arrested-after-jackson-tn-shooting-that-injured-7
3206957	2025-05-10	California	Los Angeles	N/A	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3206957	https://x.com/LosAngeles_Scan/status/1921428105643597955
3261500	2025-07-13	Kentucky	Lexington	5899 Old Richmond Rd	2	3	1	0	0	https://www.gunviolencearchive.org/incident/3261500	https://www.lex18.com/news/covering-kentucky/lexington-church-holds-service-one-week-after-deadly-shooting
3253874	2025-07-05	Hawaii	Honolulu	Palamea Ln	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3253874	https://www.kitv.com/news/crime/four-men-shot-in-drive-by-shooting-in-kalihi/article_03e621f5-2dfa-488a-98ac-e687b3362ed2.html
3273958	2025-07-28	New York	New York (Manhattan)	345 Park Ave	4	2	1	0	0	https://www.gunviolencearchive.org/incident/3273958	https://nypost.com/2025/07/29/us-news/rudin-employee-killed-in-midtown-shooting-by-crazed-madman-ids-as-cornell-graduate-julia-hyman
3182714	2025-04-11	California	Stockton	517 Doctor MLK Jr Blvd	0	6	0	0	0	https://www.gunviolencearchive.org/incident/3182714	https://fox40.com/news/local-news/stockton/mass-shooting-in-stockton-leaves-at-least-6-people-shot-officials-say
3176539	2025-04-02	Maine	Sabattus	916 Middle Road	2	2	1	0	0	https://www.gunviolencearchive.org/incident/3176539	https://www.wmtw.com/article/sabattus-maine-deadly-shooting-man-kills-mother-passerby/64378039
3233175	2025-06-14	Nevada	Reno	Raggio Pkwy	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3233175	https://www.kolotv.com/2025/06/14/police-search-suspect-after-18-year-old-dies-north-reno-shooting
3228413	2025-06-08	Wisconsin	Milwaukee	300 block of W McKinley Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3228413	https://www.wisn.com/article/four-hurt-in-shooting-near-deer-district/65001649
3305393	2025-09-11	Florida	Tampa	6000 block of Woodville St	1	5	0	0	0	https://www.gunviolencearchive.org/incident/3305393	https://www.tampa.gov/news/2025-09/tampa-police-make-progress-woodville-st-shooting-investigation-reward-tips-increased
3165724	2025-03-19	Alabama	Selma	2800 block of Summerfield Rd	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3165724	https://www.yahoo.com/news/mother-son-begin-heal-father-090212217.html
3152206	2025-03-02	Mississippi	Biloxi	279 Caillavet St	0	6	0	0	1	https://www.gunviolencearchive.org/incident/3152206	https://www.wxxv25.com/two-arrested-in-connection-with-shooting-at-biloxi-nightclub
3134608	2025-02-07	Georgia	Atlanta	Lakewood Ave SE and Lethea St SE	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3134608	https://www.atlantapd.org/Home/Components/News/News/6703/71
3126004	2025-01-26	Virginia	Richmond (Bon Air)	10016 Robious Rd	0	5	0	0	1	https://www.gunviolencearchive.org/incident/3126004	https://www.12onyourside.com/2025/02/14/man-suspected-shooting-5-people-chesterfield-pub-arrested
3242627	2025-06-22	Louisiana	Baton Rouge	3535 S Choctaw Dr	1	6	0	0	2	https://www.gunviolencearchive.org/incident/3242627	https://www.louisianafirstnews.com/news/local-news/crime/baton-rouge-shooting-charges
3240121	2025-06-19	Oklahoma	Tulsa	1264 S Lawton Ave	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3240121	https://www.news9.com/story/6853d259e185f190f850cde6/tulsa-cry-baby-hill-shooting-teens-police
3360571	2025-11-22	Arizona	Phoenix	1950 W Baseline Rd	2	2	0	0	1	https://www.gunviolencearchive.org/incident/3360571	https://www.abc15.com/news/crime/pd-multiple-people-shot-suspect-in-custody
3350555	2025-11-07	Delaware	Wilmington	4th St and Lombard St	0	5	0	0	0	https://www.gunviolencearchive.org/incident/3350555	https://nixle.us/GRX93
3253021	2025-07-05	Illinois	Chicago	2700 block of S California Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3253021	https://abc7chicago.com/post/little-village-chicago-shooting-today-4-hurt-3-critically-mass-cook-county-courthouse-police-department-says/16966745
3109523	2025-01-05	Arizona	Tucson	3000 S Mission Rd	0	4	0	0	1	https://www.gunviolencearchive.org/incident/3109523	https://www.kgun9.com/news/community-inspired-journalism/westside-news/westside-shooting-early-sunday-morning
3253050	2025-07-05	Indiana	Indianapolis	W Washington St and S Illinois St	2	5	0	0	4	https://www.gunviolencearchive.org/incident/3253050	https://www.whas11.com/article/news/crime/4-teens-charged-alleged-roles-deadly-downtown-indianapolis-mass-shooting-july-5-2025/531-f733a133-bd82-4765-83d9-24c9f232a054
3252080	2025-07-03	Illinois	Chicago	1607 W 59th St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3252080	https://www.cbsnews.com/chicago/news/mass-shooting-west-englewood-59th-ashland
3196061	2025-04-27	North Carolina	Rocky Mount	W End St	0	4	0	0	2	https://www.gunviolencearchive.org/incident/3196061	https://www.facebook.com/photo/?fbid=1225677162348051&set=a.584158536499920
3119395	2025-01-19	Florida	Boynton Beach	500 block of NE 2nd St	0	5	1	0	0	https://www.gunviolencearchive.org/incident/3119395	https://cbs12.com/news/local/bbpd-says-deadly-shooting-case-meets-floridas-stand-your-ground-criteria-5-shot-one-person-killed-500-block-ne-2nd-street-florida-statutes-section-776012-south-florida-new-s-march-13-2025
3336659	2025-10-19	Alabama	Pinson	AL-75 and Clay-Palmerdale Rd	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3336659	https://abc3340.com/news/local/court-proceedings-continue-for-suspects-in-deadly-october-shooting-at-the-pit-silas-mccay-joshua-hunter-mccullogh-steven-tyler-whitehead-kimber-mills
3223369	2025-05-31	Georgia	Snellville	2500 Sawyer Pkwy SW	0	5	0	0	2	https://www.gunviolencearchive.org/incident/3223369	https://www.atlantanewsfirst.com/2025/06/16/police-2-teenage-suspects-arrested-shooting-snellville-park-that-left-several-teens-injured
3218775	2025-05-26	Pennsylvania	Philadelphia	N Lemon Hill Dr and Sedgley Dr	2	9	0	0	0	https://www.gunviolencearchive.org/incident/3218775	https://6abc.com/post/5-guns-fired-during-fairmount-park-mass-shooting-philadelphia-police-say/16588961
3210524	2025-05-10	California	Paramount	7718 Somerset Blvd	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3210524	https://www.cbsnews.com/losangeles/news/authorities-searching-for-suspect-in-paramount-shooting-that-left-2-women-2-children-hospitalized
3201117	2025-05-04	Texas	Houston	6000 block of Cherry Hill Ave	1	15	0	0	0	https://www.gunviolencearchive.org/incident/3201117	https://www.houstonchronicle.com/news/houston-texas/crime/article/joe-mendoza-cherryhill-shooting-victim-party-20317629.php
3261223	2025-07-12	Texas	Round Rock	1401 A W Grimes Blvd	2	2	0	0	0	https://www.gunviolencearchive.org/incident/3261223	https://www.facebook.com/RoundRockPoliceDepartment/posts/pfbid0ofH1xCqVQgCDoYyUuJxPkTDZabGcWNTcUP7izBM4bjhhvYpDjcw4xeKc7urT59uMl
3254794	2025-07-07	Pennsylvania	Philadelphia	N 62nd St and Vine St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3254794	https://opendataphilly.org/datasets/shooting-victims
3276738	2025-07-29	Tennessee	Tiptonville	Carrington Rd	4	0	0	0	1	https://www.gunviolencearchive.org/incident/3276738	https://www.wate.com/news/tennessee/austin-drummond-held-in-jail-without-bond-state-seeks-death-penalty
3274001	2025-07-27	Michigan	Flint	3241 Industrial Ave	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3274001	https://www.abc12.com/news/crime/authorities-identify-25-year-old-killed-in-flint-mass-shooting/article_2a2b6afb-e206-4dcf-8539-ad00a2e06286.html
3184153	2025-04-13	Louisiana	New Orleans	100 block of Decatur St	0	5	0	0	2	https://www.gunviolencearchive.org/incident/3184153	https://www.nola.com/news/crime_police/french-quarter-fest-shooting-arrest/article_701a9c57-f700-4d52-a52e-ba5a258c9124.html
3173826	2025-03-31	Texas	San Antonio	10227 Ironside Dr	0	4	1	0	0	https://www.gunviolencearchive.org/incident/3173826	https://foxsanantonio.com/newsletter-daily/suspect-killed-in-fatal-bar-gunfight-identified-accused-of-wounding-four-victims-local-news-near-me-crime-law-public-safety
3233889	2025-06-14	Missouri	Kansas City	3500 Prospect Ave	2	3	0	0	0	https://www.gunviolencearchive.org/incident/3233889	https://www.kctv5.com/2025/07/03/second-shooting-victim-dies-35th-prospect-homicide-case-suspect-remains-at-large
3232994	2025-06-14	Delaware	Dover	400 block of Barrister Pl	1	4	0	0	1	https://www.gunviolencearchive.org/incident/3232994	https://www.wgmd.com/early-morning-shooting-in-dover-leaves-1-dead-and-4-injured
3307983	2025-09-15	Minnesota	Minneapolis	E Lake St and Stevens Ave	1	4	0	0	0	https://www.gunviolencearchive.org/incident/3307983	https://bringmethenews.com/minnesota-news/man-dies-days-after-mass-shooting-near-lake-street-transit-station
3303232	2025-09-07	Tennessee	Memphis	4100 block of Rosewind Cir	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3303232	https://wreg.com/news/local/shooting-investigation-underway-in-hickory-hill
3166856	2025-03-21	Georgia	Brunswick	5700 Altama Ave	1	3	0	0	0	https://www.gunviolencearchive.org/incident/3166856	https://www.actionnewsjax.com/news/local/neighbors-retreat-apartments-shaken-after-quadruple-shooting-brunswick-leaving-one-man-dead/6JYTPE3BWJGW3DRV3LOPOJLM7M
3152667	2025-03-04	Louisiana	Mamou	Ballpark Rd	2	12	0	0	1	https://www.gunviolencearchive.org/incident/3152667	https://www.kplctv.com/2025/03/09/suspect-mamou-mardi-gras-deadly-shooting-captured-texas
3129861	2025-02-01	Oregon	Clatskanie	Quincy Mayger Rd and Ilmari Rd	1	3	1	0	0	https://www.gunviolencearchive.org/incident/3129861	https://www.kptv.com/2025/02/03/sheriffs-office-identifies-2-killed-clatskanie-shooting
3243238	2025-06-22	Pennsylvania	Pittsburgh	N St Clair St and Broad St	0	5	0	0	2	https://www.gunviolencearchive.org/incident/3243238	https://www.cbsnews.com/pittsburgh/news/east-liberty-pittsburgh-mass-shooting-aaron-pennix-charged
3239589	2025-06-17	Mississippi	Louisville	200 block of W College St	1	3	0	0	1	https://www.gunviolencearchive.org/incident/3239589	https://www.breezynews.com/local/one-killed-in-drive-by-shooting-in-louisville
3359972	2025-11-21	Illinois	Chicago	175 N State St	0	7	0	0	0	https://www.gunviolencearchive.org/incident/3359972	https://chicago.suntimes.com/crime/2025/11/24/armani-floyd-teen-takeover-project-swish
3346875	2025-11-02	California	Winnetka	Saticoy St and Oso Ave	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3346875	https://www.audacy.com/knxnews/news/local/4-injured-in-winnetka-shooting
3346630	2025-11-02	Ohio	Cincinnati	1905 Elm St	0	4	0	0	0	https://www.gunviolencearchive.org/incident/3346630	https://www.wlwt.com/article/cincinnati-otr-shooting-elm-findlay-4-hospitalized/69227850
\.


--
-- Name: ai_jobs ai_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_jobs
    ADD CONSTRAINT ai_jobs_pkey PRIMARY KEY (url);


--
-- Name: apartments apartments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apartments
    ADD CONSTRAINT apartments_pkey PRIMARY KEY (url);


--
-- Name: atlanta_apt atlanta_apt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.atlanta_apt
    ADD CONSTRAINT atlanta_apt_pkey PRIMARY KEY (url);


--
-- Name: bay_area_apt2 bay_area_apt2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bay_area_apt2
    ADD CONSTRAINT bay_area_apt2_pkey PRIMARY KEY (url);


--
-- Name: bay_area_apt bay_area_apt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bay_area_apt
    ADD CONSTRAINT bay_area_apt_pkey PRIMARY KEY (url);


--
-- Name: bay_area_rental_listings bay_area_rental_listings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bay_area_rental_listings
    ADD CONSTRAINT bay_area_rental_listings_pkey PRIMARY KEY (url);


--
-- Name: blue_citations blue_citations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blue_citations
    ADD CONSTRAINT blue_citations_pkey PRIMARY KEY (cited_paper_title);


--
-- Name: emnlp25_papers emnlp25_papers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.emnlp25_papers
    ADD CONSTRAINT emnlp25_papers_pkey PRIMARY KEY (paper_title);


--
-- Name: internship_candidates internship_candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internship_candidates
    ADD CONSTRAINT internship_candidates_pkey PRIMARY KEY (author_name);


--
-- Name: megagon_publications megagon_publications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.megagon_publications
    ADD CONSTRAINT megagon_publications_pkey PRIMARY KEY (publication_url);


--
-- Name: megagon_team_members megagon_team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.megagon_team_members
    ADD CONSTRAINT megagon_team_members_pkey PRIMARY KEY (person_name);


--
-- Name: megagon_team_members megagon_team_members_profile_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.megagon_team_members
    ADD CONSTRAINT megagon_team_members_profile_url_key UNIQUE (profile_url);


--
-- Name: papers_from_files papers_from_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.papers_from_files
    ADD CONSTRAINT papers_from_files_pkey PRIMARY KEY (file_name);


--
-- Name: restaurants restaurants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restaurants
    ADD CONSTRAINT restaurants_pkey PRIMARY KEY (url);


--
-- Name: text2sql_authors text2sql_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.text2sql_authors
    ADD CONSTRAINT text2sql_authors_pkey PRIMARY KEY (author_name, paper_title);


--
-- Name: us_mass_shootings us_mass_shootings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.us_mass_shootings
    ADD CONSTRAINT us_mass_shootings_pkey PRIMARY KEY (incident_id);


--
-- PostgreSQL database dump complete
--

\unrestrict RJalJdvbYz0JFSaIwobVpyp0eF6wf4eS3YUOHE6GadzkciF3Bf5taa4IUmEjxKH

