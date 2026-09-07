--
-- PostgreSQL database dump
--

\restrict qgBxrUhj4D84OyC951j0Dic6jASXUDKSC5dwoPohPmBPsAzsE9j5iNuZRXMl87Q

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-09-07 07:34:20

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

--
-- TOC entry 5 (class 2615 OID 16388)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 5074 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 17845)
-- Name: document_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_request (
    request_id integer NOT NULL,
    student_id integer NOT NULL,
    staff_id integer,
    document_type character varying(100) NOT NULL,
    request_date date DEFAULT CURRENT_DATE,
    status character varying(30) DEFAULT 'Pending'::character varying
);


ALTER TABLE public.document_request OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17844)
-- Name: document_request_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_request_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.document_request_request_id_seq OWNER TO postgres;

--
-- TOC entry 5076 (class 0 OID 0)
-- Dependencies: 223
-- Name: document_request_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_request_request_id_seq OWNED BY public.document_request.request_id;


--
-- TOC entry 228 (class 1259 OID 17884)
-- Name: issued_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issued_document (
    document_id integer NOT NULL,
    request_id integer NOT NULL,
    document_name character varying(150),
    file_path character varying(255),
    issue_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.issued_document OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17883)
-- Name: issued_document_document_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.issued_document_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issued_document_document_id_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 227
-- Name: issued_document_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.issued_document_document_id_seq OWNED BY public.issued_document.document_id;


--
-- TOC entry 226 (class 1259 OID 17867)
-- Name: payment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment (
    payment_id integer NOT NULL,
    request_id integer NOT NULL,
    payment_method character varying(50),
    payment_status character varying(30),
    amount numeric(10,2),
    transaction_date date DEFAULT CURRENT_DATE
);


ALTER TABLE public.payment OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17866)
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_payment_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 225
-- Name: payment_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_payment_id_seq OWNED BY public.payment.payment_id;


--
-- TOC entry 222 (class 1259 OID 17834)
-- Name: staff_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff_user (
    staff_id integer NOT NULL,
    name character varying(100) NOT NULL,
    role character varying(50),
    email character varying(100)
);


ALTER TABLE public.staff_user OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17833)
-- Name: staff_user_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_user_staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_user_staff_id_seq OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 221
-- Name: staff_user_staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_user_staff_id_seq OWNED BY public.staff_user.staff_id;


--
-- TOC entry 220 (class 1259 OID 17822)
-- Name: student; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student (
    student_id integer NOT NULL,
    name character varying(100) NOT NULL,
    national_id character varying(20) NOT NULL,
    phone character varying(20),
    email character varying(100),
    gpa numeric(3,2),
    major character varying(100)
);


ALTER TABLE public.student OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17901)
-- Name: student_requests; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.student_requests AS
 SELECT student.name,
    document_request.document_type
   FROM public.student,
    public.document_request
  WHERE (student.student_id = document_request.student_id);


ALTER VIEW public.student_requests OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17821)
-- Name: student_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.student_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.student_student_id_seq OWNER TO postgres;

--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 219
-- Name: student_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.student_student_id_seq OWNED BY public.student.student_id;


--
-- TOC entry 4882 (class 2604 OID 17848)
-- Name: document_request request_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_request ALTER COLUMN request_id SET DEFAULT nextval('public.document_request_request_id_seq'::regclass);


--
-- TOC entry 4887 (class 2604 OID 17887)
-- Name: issued_document document_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issued_document ALTER COLUMN document_id SET DEFAULT nextval('public.issued_document_document_id_seq'::regclass);


--
-- TOC entry 4885 (class 2604 OID 17870)
-- Name: payment payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment ALTER COLUMN payment_id SET DEFAULT nextval('public.payment_payment_id_seq'::regclass);


--
-- TOC entry 4881 (class 2604 OID 17837)
-- Name: staff_user staff_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_user ALTER COLUMN staff_id SET DEFAULT nextval('public.staff_user_staff_id_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 17825)
-- Name: student student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student ALTER COLUMN student_id SET DEFAULT nextval('public.student_student_id_seq'::regclass);


--
-- TOC entry 5064 (class 0 OID 17845)
-- Dependencies: 224
-- Data for Name: document_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_request (request_id, student_id, staff_id, document_type, request_date, status) FROM stdin;
1	1	1	Transcript	2026-09-06	Pending
2	3	3	Transcript	2026-09-06	Pending
\.


--
-- TOC entry 5068 (class 0 OID 17884)
-- Dependencies: 228
-- Data for Name: issued_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.issued_document (document_id, request_id, document_name, file_path, issue_date) FROM stdin;
\.


--
-- TOC entry 5066 (class 0 OID 17867)
-- Dependencies: 226
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment (payment_id, request_id, payment_method, payment_status, amount, transaction_date) FROM stdin;
\.


--
-- TOC entry 5062 (class 0 OID 17834)
-- Dependencies: 222
-- Data for Name: staff_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff_user (staff_id, name, role, email) FROM stdin;
1	Rakan Saeed	Administrator	rakan@gmail.com
2	Khaled Nawaf	Document Officer	khaled@gmail.com
3	Waleed Ata	Finance Officer	waleed@gmail.com
\.


--
-- TOC entry 5060 (class 0 OID 17822)
-- Dependencies: 220
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student (student_id, name, national_id, phone, email, gpa, major) FROM stdin;
1	Ahmed Ali	10001	0811111111	ahmed@gmail.com	3.45	Information Technology
2	Mohammed Hassan	10002	0822222222	mohammed@gmail.com	3.20	Computer Science
3	Omar Khalid	10003	0833333333	omar@gmail.com	2.95	Business Administration
4	Hassan Ahmed	10004	0844444444	hassan@gmail.com	3.75	Information Technology
5	Ali Mohammed	10005	0855555555	ali@gmail.com	3.10	Engineering
\.


--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 223
-- Name: document_request_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_request_request_id_seq', 1, false);


--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 227
-- Name: issued_document_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.issued_document_document_id_seq', 1, false);


--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 225
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 1, false);


--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 221
-- Name: staff_user_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_user_staff_id_seq', 3, true);


--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 219
-- Name: student_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.student_student_id_seq', 5, true);


--
-- TOC entry 4898 (class 2606 OID 17855)
-- Name: document_request document_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_request
    ADD CONSTRAINT document_request_pkey PRIMARY KEY (request_id);


--
-- TOC entry 4904 (class 2606 OID 17892)
-- Name: issued_document issued_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issued_document
    ADD CONSTRAINT issued_document_pkey PRIMARY KEY (document_id);


--
-- TOC entry 4906 (class 2606 OID 17894)
-- Name: issued_document issued_document_request_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issued_document
    ADD CONSTRAINT issued_document_request_id_key UNIQUE (request_id);


--
-- TOC entry 4900 (class 2606 OID 17875)
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (payment_id);


--
-- TOC entry 4902 (class 2606 OID 17877)
-- Name: payment payment_request_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_request_id_key UNIQUE (request_id);


--
-- TOC entry 4894 (class 2606 OID 17843)
-- Name: staff_user staff_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_user
    ADD CONSTRAINT staff_user_email_key UNIQUE (email);


--
-- TOC entry 4896 (class 2606 OID 17841)
-- Name: staff_user staff_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_user
    ADD CONSTRAINT staff_user_pkey PRIMARY KEY (staff_id);


--
-- TOC entry 4890 (class 2606 OID 17832)
-- Name: student student_national_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_national_id_key UNIQUE (national_id);


--
-- TOC entry 4892 (class 2606 OID 17830)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 4907 (class 2606 OID 17861)
-- Name: document_request document_request_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_request
    ADD CONSTRAINT document_request_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff_user(staff_id);


--
-- TOC entry 4908 (class 2606 OID 17856)
-- Name: document_request document_request_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_request
    ADD CONSTRAINT document_request_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(student_id);


--
-- TOC entry 4910 (class 2606 OID 17895)
-- Name: issued_document issued_document_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issued_document
    ADD CONSTRAINT issued_document_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.document_request(request_id);


--
-- TOC entry 4909 (class 2606 OID 17878)
-- Name: payment payment_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.document_request(request_id);


--
-- TOC entry 5075 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-09-07 07:34:20

--
-- PostgreSQL database dump complete
--

\unrestrict qgBxrUhj4D84OyC951j0Dic6jASXUDKSC5dwoPohPmBPsAzsE9j5iNuZRXMl87Q

