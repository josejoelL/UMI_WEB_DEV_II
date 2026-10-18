--
-- PostgreSQL database dump
--

\restrict bwZEa5iH5s4oMVvIVAX2byBmslUznlCtM4pum4cWQnn9fyvcd1r2mBWOywnKxRk

-- Dumped from database version 16.6
-- Dumped by pg_dump version 18.3

-- Started on 2026-10-18 00:07:33

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
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16417)
-- Name: carrito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carrito (
    id integer NOT NULL,
    folioventa character varying(50) NOT NULL,
    totalcompra numeric(10,2) NOT NULL,
    estatus character varying(50) NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.carrito OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: carrito_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.carrito ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.carrito_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16424)
-- Name: carritodetalles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carritodetalles (
    id integer NOT NULL,
    idcarrito integer NOT NULL,
    idproducto integer NOT NULL,
    cantidad integer NOT NULL,
    subtotal numeric(10,2) NOT NULL
);


ALTER TABLE public.carritodetalles OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16423)
-- Name: carritodetalles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.carritodetalles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.carritodetalles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 16399)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias (
    id integer NOT NULL,
    descripcion character varying(255) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16398)
-- Name: categorias_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.categorias ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categorias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16405)
-- Name: marcas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marcas (
    id integer NOT NULL,
    descripcion character varying(255) NOT NULL
);


ALTER TABLE public.marcas OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16404)
-- Name: marcas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.marcas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.marcas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16411)
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    descripcion character varying(255) NOT NULL,
    precio numeric(10,2) NOT NULL,
    cantidad integer NOT NULL,
    idcategoria integer NOT NULL,
    idmarca integer NOT NULL
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16410)
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.productos ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4819 (class 0 OID 16417)
-- Dependencies: 222
-- Data for Name: carrito; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carrito (id, folioventa, totalcompra, estatus, fecha) FROM stdin;
1	FOL-2026-001	899.00	Completado	2026-10-15 10:30:00
2	FOL-2026-002	1249.00	Completado	2026-10-15 11:15:00
3	FOL-2026-003	2199.00	Pendiente	2026-10-16 14:00:00
4	FOL-2026-004	900.00	Completado	2026-10-16 16:45:00
5	FOL-2026-005	3499.00	Cancelado	2026-10-17 09:20:00
\.


--
-- TOC entry 4821 (class 0 OID 16424)
-- Dependencies: 224
-- Data for Name: carritodetalles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carritodetalles (id, idcarrito, idproducto, cantidad, subtotal) FROM stdin;
1	1	1	1	899.00
2	2	2	1	450.00
3	2	4	1	799.00
4	3	3	1	2199.00
5	4	2	2	900.00
\.


--
-- TOC entry 4813 (class 0 OID 16399)
-- Dependencies: 216
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias (id, descripcion) FROM stdin;
1	Ropa
2	Higene
3	Cocina
4	Articulos de hogar
5	bebes
\.


--
-- TOC entry 4815 (class 0 OID 16405)
-- Dependencies: 218
-- Data for Name: marcas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marcas (id, descripcion) FROM stdin;
1	Maternity Line
2	Avent
3	Chicco
4	Mustela
5	Boppy
\.


--
-- TOC entry 4817 (class 0 OID 16411)
-- Dependencies: 220
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, descripcion, precio, cantidad, idcategoria, idmarca) FROM stdin;
1	Vestido de Maternidad Casual	899.00	20	1	1
2	Crema Anti-Estrías para Embarazo	450.00	35	2	4
3	Extractor de Leche Eléctrico	2199.00	12	3	2
4	Cojín / Almohada de Lactancia Ergonomica	799.00	15	4	5
5	Mellizos / Cuna Colecho Ajustable	3499.00	8	5	3
\.


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 221
-- Name: carrito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carrito_id_seq', 5, true);


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 223
-- Name: carritodetalles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carritodetalles_id_seq', 5, true);


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 215
-- Name: categorias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_id_seq', 5, true);


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 217
-- Name: marcas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marcas_id_seq', 5, true);


--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 219
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 5, true);


--
-- TOC entry 4662 (class 2606 OID 16422)
-- Name: carrito carrito_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carrito
    ADD CONSTRAINT carrito_pkey PRIMARY KEY (id);


--
-- TOC entry 4664 (class 2606 OID 16428)
-- Name: carritodetalles carritodetalles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carritodetalles
    ADD CONSTRAINT carritodetalles_pkey PRIMARY KEY (id);


--
-- TOC entry 4656 (class 2606 OID 16403)
-- Name: categorias categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id);


--
-- TOC entry 4658 (class 2606 OID 16409)
-- Name: marcas marcas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marcas
    ADD CONSTRAINT marcas_pkey PRIMARY KEY (id);


--
-- TOC entry 4660 (class 2606 OID 16415)
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- TOC entry 4667 (class 2606 OID 16439)
-- Name: carritodetalles fk_carritodetalles_carrito; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carritodetalles
    ADD CONSTRAINT fk_carritodetalles_carrito FOREIGN KEY (idcarrito) REFERENCES public.carrito(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4668 (class 2606 OID 16444)
-- Name: carritodetalles fk_carritodetalles_productos; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carritodetalles
    ADD CONSTRAINT fk_carritodetalles_productos FOREIGN KEY (idproducto) REFERENCES public.productos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4665 (class 2606 OID 16429)
-- Name: productos fk_productos_categorias; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_productos_categorias FOREIGN KEY (idcategoria) REFERENCES public.categorias(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4666 (class 2606 OID 16434)
-- Name: productos fk_productos_marcas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT fk_productos_marcas FOREIGN KEY (idmarca) REFERENCES public.marcas(id) ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2026-10-18 00:07:34

--
-- PostgreSQL database dump complete
--

\unrestrict bwZEa5iH5s4oMVvIVAX2byBmslUznlCtM4pum4cWQnn9fyvcd1r2mBWOywnKxRk

