--
-- PostgreSQL database dump
--


-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

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

ALTER TABLE IF EXISTS ONLY public.performance_reports DROP CONSTRAINT IF EXISTS performance_reports_company_id_foreign;
ALTER TABLE IF EXISTS ONLY public.performance_reports DROP CONSTRAINT IF EXISTS performance_reports_advisor_id_foreign;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_appointment_id_foreign;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS companies_user_id_foreign;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_client_id_foreign;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_advisor_id_foreign;
DROP INDEX IF EXISTS public.sessions_user_id_index;
DROP INDEX IF EXISTS public.sessions_last_activity_index;
DROP INDEX IF EXISTS public.personal_access_tokens_tokenable_type_tokenable_id_index;
DROP INDEX IF EXISTS public.personal_access_tokens_expires_at_index;
DROP INDEX IF EXISTS public.jobs_queue_index;
DROP INDEX IF EXISTS public.cache_locks_expiration_index;
DROP INDEX IF EXISTS public.cache_expiration_index;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_unique;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY public.personal_access_tokens DROP CONSTRAINT IF EXISTS personal_access_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.performance_reports DROP CONSTRAINT IF EXISTS performance_reports_pkey;
ALTER TABLE IF EXISTS ONLY public.password_reset_tokens DROP CONSTRAINT IF EXISTS password_reset_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.news DROP CONSTRAINT IF EXISTS news_slug_unique;
ALTER TABLE IF EXISTS ONLY public.news DROP CONSTRAINT IF EXISTS news_pkey;
ALTER TABLE IF EXISTS ONLY public.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.jobs DROP CONSTRAINT IF EXISTS jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.job_batches DROP CONSTRAINT IF EXISTS job_batches_pkey;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_uuid_unique;
ALTER TABLE IF EXISTS ONLY public.failed_jobs DROP CONSTRAINT IF EXISTS failed_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.documents DROP CONSTRAINT IF EXISTS documents_pkey;
ALTER TABLE IF EXISTS ONLY public.contact_messages DROP CONSTRAINT IF EXISTS contact_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS companies_pkey;
ALTER TABLE IF EXISTS ONLY public.companies DROP CONSTRAINT IF EXISTS companies_cif_unique;
ALTER TABLE IF EXISTS ONLY public.cache DROP CONSTRAINT IF EXISTS cache_pkey;
ALTER TABLE IF EXISTS ONLY public.cache_locks DROP CONSTRAINT IF EXISTS cache_locks_pkey;
ALTER TABLE IF EXISTS ONLY public.appointments DROP CONSTRAINT IF EXISTS appointments_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.personal_access_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.performance_reports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.news ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.migrations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.failed_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.documents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contact_messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.companies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.appointments ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS public.sessions;
DROP SEQUENCE IF EXISTS public.personal_access_tokens_id_seq;
DROP TABLE IF EXISTS public.personal_access_tokens;
DROP SEQUENCE IF EXISTS public.performance_reports_id_seq;
DROP TABLE IF EXISTS public.performance_reports;
DROP TABLE IF EXISTS public.password_reset_tokens;
DROP SEQUENCE IF EXISTS public.notifications_id_seq;
DROP TABLE IF EXISTS public.notifications;
DROP SEQUENCE IF EXISTS public.news_id_seq;
DROP TABLE IF EXISTS public.news;
DROP SEQUENCE IF EXISTS public.migrations_id_seq;
DROP TABLE IF EXISTS public.migrations;
DROP SEQUENCE IF EXISTS public.jobs_id_seq;
DROP TABLE IF EXISTS public.jobs;
DROP TABLE IF EXISTS public.job_batches;
DROP SEQUENCE IF EXISTS public.failed_jobs_id_seq;
DROP TABLE IF EXISTS public.failed_jobs;
DROP SEQUENCE IF EXISTS public.documents_id_seq;
DROP TABLE IF EXISTS public.documents;
DROP SEQUENCE IF EXISTS public.contact_messages_id_seq;
DROP TABLE IF EXISTS public.contact_messages;
DROP SEQUENCE IF EXISTS public.companies_id_seq;
DROP TABLE IF EXISTS public.companies;
DROP TABLE IF EXISTS public.cache_locks;
DROP TABLE IF EXISTS public.cache;
DROP SEQUENCE IF EXISTS public.appointments_id_seq;
DROP TABLE IF EXISTS public.appointments;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appointments (
    id bigint NOT NULL,
    client_id bigint,
    advisor_id bigint,
    date timestamp(0) without time zone NOT NULL,
    "time" time(0) without time zone,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    reason character varying(255),
    notes text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    guest_name character varying(255),
    guest_email character varying(255),
    guest_phone character varying(255),
    description text
);


--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    cif character varying(255) NOT NULL,
    address character varying(255),
    fiscal_regime character varying(255),
    sector character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.companies_id_seq OWNED BY public.companies.id;


--
-- Name: contact_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_messages (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    subject character varying(255) NOT NULL,
    message text NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    read_at timestamp(0) without time zone
);


--
-- Name: contact_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contact_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contact_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contact_messages_id_seq OWNED BY public.contact_messages.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    appointment_id bigint,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    url character varying(255) NOT NULL,
    size bigint,
    uploaded_by character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    description character varying(255),
    CONSTRAINT documents_type_check CHECK (((type)::text = ANY ((ARRAY['declaracion'::character varying, 'contrato'::character varying, 'factura'::character varying, 'informe'::character varying, 'otro'::character varying])::text[])))
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: news; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.news (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    slug text NOT NULL,
    summary text,
    content text,
    source character varying(255),
    source_url text,
    category character varying(255),
    published_at timestamp(0) without time zone,
    is_published boolean DEFAULT false NOT NULL,
    created_by_automation boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    status character varying(255) DEFAULT 'pending'::character varying NOT NULL,
    image text
);


--
-- Name: news_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.news_id_seq OWNED BY public.news.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    type character varying(255) DEFAULT 'sistema'::character varying NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT notifications_type_check CHECK (((type)::text = ANY ((ARRAY['cita'::character varying, 'documento'::character varying, 'informe'::character varying, 'sistema'::character varying])::text[])))
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- Name: performance_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.performance_reports (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    advisor_id bigint NOT NULL,
    period character varying(255) NOT NULL,
    revenue numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    expenses numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    profit numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    ai_analysis text,
    generated_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: performance_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.performance_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: performance_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.performance_reports_id_seq OWNED BY public.performance_reports.id;


--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    role character varying(255) DEFAULT 'cliente'::character varying NOT NULL,
    phone character varying(255),
    avatar character varying(255),
    two_factor_secret text,
    two_factor_confirmed_at timestamp(0) without time zone,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['cliente'::character varying, 'asesor'::character varying, 'admin'::character varying])::text[])))
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies ALTER COLUMN id SET DEFAULT nextval('public.companies_id_seq'::regclass);


--
-- Name: contact_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_messages ALTER COLUMN id SET DEFAULT nextval('public.contact_messages_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: news id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news ALTER COLUMN id SET DEFAULT nextval('public.news_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: performance_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.performance_reports ALTER COLUMN id SET DEFAULT nextval('public.performance_reports_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cache (key, value, expiration) VALUES ('selectoasesores-cache-jaimer@selecto.com|172.18.0.1:timer', 'i:1777982820;', 1777982820);
INSERT INTO public.cache (key, value, expiration) VALUES ('selectoasesores-cache-jaimer@selecto.com|172.18.0.1', 'i:1;', 1777982820);


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: contact_messages; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.migrations (id, migration, batch) VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (4, '2026_03_08_000000_create_appointments_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (5, '2026_03_10_214714_add_fields_to_users_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (6, '2026_03_10_214714_create_companies_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (7, '2026_03_10_214715_create_contact_messages_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (8, '2026_03_10_214715_create_documents_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (9, '2026_03_10_214715_create_news_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (10, '2026_03_10_214715_create_notifications_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (11, '2026_03_10_214715_create_performance_reports_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (12, '2026_03_11_193623_add_read_at_to_contact_messages_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (13, '2026_03_14_211941_add_description_to_documents_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (14, '2026_03_16_000001_add_guest_fields_to_appointments', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (15, '2026_03_17_145708_create_personal_access_tokens_table', 1);
INSERT INTO public.migrations (id, migration, batch) VALUES (16, '2026_04_26_203059_add_status_to_news_table', 2);
INSERT INTO public.migrations (id, migration, batch) VALUES (17, '2026_04_27_123305_update_news_table_fields', 3);
INSERT INTO public.migrations (id, migration, batch) VALUES (18, '2026_05_04_074224_add_description_to_appointments_table', 4);
INSERT INTO public.migrations (id, migration, batch) VALUES (19, '2026_05_07_105139_add_two_factor_columns_to_users_table', 5);


--
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (2, 'Renta 2025: cómo tributar por las ganancias y pérdidas de patrimonio', 'renta-2025-como-tributar-por-las-ganancias-y-perdidas-de-patrimonio', 'La Noticia spañola sobre la Renta 2025 explica cómo aplicar determinadas deducciones fiscales en la declaración de ganancias y pérdidas patrimoniales derivadas de las transacciones de bienes, concretamente en las próximas entregas de declaración de la Renta. Esto se refiere a la fiscalización de las ganancias y pérdidas patrimoniales, y se centra en el Registro de Economistas Asesores Fiscales (REAF-CGE) y su papel en la aplicación de dichas deducciones.', 'La Noticia spañola sobre la Renta 2025 explica cómo aplicar determinadas deducciones fiscales en la declaración de ganancias y pérdidas patrimoniales derivadas de las transacciones de bienes, concretamente en las próximas entregas de declaración de la Renta. Esto se refiere a la fiscalización de las ganancias y pérdidas patrimoniales, y se centra en el Registro de Economistas Asesores Fiscales (REAF-CGE) y su papel en la aplicación de dichas deducciones.', 'Expansion.com', 'https://www.expansion.com/economia/declaracion-renta/2026/05/09/69fdb0b6e5fdea126f8b458c.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://e01-phantom-expansion.uecdn.es/deafa92794beab3eafc395359db74758/crop/16x11/2020x1346/resize/1200/f/webp/assets/multimedia/imagenes/2026/05/08/17782334756152.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (3, 'La Palma ve la luz casi cinco años después del volcán', 'la-palma-ve-la-luz-casi-cinco-anos-despues-del-volcan', 'La isla de La Palma ha enfrentado desafíos significativos debido a la erupción del Tajogaite y el subsequente incendio del volcán. Aunque la situación fiscal ha mejorado con la recuperación de infraestructuras y la application de ayudas financeiras, sigue existiendo la necesidad de inversiones y esfuerzos para garantizar el bienestar de la población.', 'La isla de La Palma ha enfrentado desafíos significativos debido a la erupción del Tajogaite y el subsequente incendio del volcán. Aunque la situación fiscal ha mejorado con la recuperación de infraestructuras y la application de ayudas financeiras, sigue existiendo la necesidad de inversiones y esfuerzos para garantizar el bienestar de la población.', 'Expansion.com', 'https://www.expansion.com/economia/2026/05/09/69fe36a1e5fdea11598b4597.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://e01-phantom-expansion.uecdn.es/1656919550ccde0fdb3fdff7a066190b/crop/320x0/2048x1152/resize/1200/f/webp/assets/multimedia/imagenes/2026/05/08/17782677431342.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (5, 'Las cotizadas catalanas del BME Growth crecen un 38% por el tirón de Ebro', 'las-cotizadas-catalanas-del-bme-growth-crecen-un-38-por-el-tiron-de-ebro', 'Las cotizaciones catalanas del BME Growth han subido un 38% en el período de Ebro, mientras que las empresas catalanas del sector energético y automovilístico han reducido casi un 35% sus pérdidas debido a mejoras en los resultados de Holaluz, Enerside y la automovilística.', 'Las cotizaciones catalanas del BME Growth han subido un 38% en el período de Ebro, mientras que las empresas catalanas del sector energético y automovilístico han reducido casi un 35% sus pérdidas debido a mejoras en los resultados de Holaluz, Enerside y la automovilística.', 'Expansion.com', 'https://www.expansion.com/catalunya/2026/05/08/69fe428ee5fdeac23b8b4593.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://e01-phantom-expansion.uecdn.es/e871bf4266267c01afb0136524f59782/crop/0x0/2048x1365/resize/1200/f/webp/assets/multimedia/imagenes/2026/05/08/17782708051445.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (6, 'IA y empleo: ¿señales tempranas de ajuste?', 'ia-y-empleo-senales-tempranas-de-ajuste', 'La EPA del primer trimestre ha reavivado el debate sobre los efectos de la inteligencia artificial (IA) en el empleo. Aunque la creación de puestos de trabajo continúa, algunos sectores enfrentan desafíos y necesitan un período de ajuste.', 'La EPA del primer trimestre ha reavivado el debate sobre los efectos de la inteligencia artificial (IA) en el empleo. Aunque la creación de puestos de trabajo continúa, algunos sectores enfrentan desafíos y necesitan un período de ajuste.', 'Expansion.com', 'https://www.expansion.com/opinion/2026/05/08/69fdba52e5fdea217f8b4581.html', 'Laboral', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://e01-phantom-expansion.uecdn.es/39d082491b73f48cfdb2824f549f00e3/crop/75x222/1661x1836/resize/1200/f/webp/assets/multimedia/imagenes/2026/05/08/17782359348720.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (7, 'El eclipse de agosto movilizará 360 millones en una semana', 'el-eclipse-de-agosto-movilizara-360-millones-en-una-semana', 'El eclipse de agosto podría tener un impacto significativo en el sistema fiscal español, generando alrededor de 360 millones de euros en una semana.', 'El eclipse de agosto podría tener un impacto significativo en el sistema fiscal español, generando alrededor de 360 millones de euros en una semana.', 'Expansion.com', 'https://www.expansion.com/sociedad/2026/05/07/69fcb542e5fdea43758b459b.html', 'General', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://e01-phantom-expansion.uecdn.es/fb123cce67e64f90e79e2f335b548d71/crop/0x88/2048x1453/resize/1200/f/webp/assets/multimedia/imagenes/2023/04/20/16819778425797.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (23, 'Asesores fiscales piden deflactar el IRPF: ''No hacerlo atenta contra el principio de capacidad económica''', 'asesores-fiscales-piden-deflactar-el-irpf-no-hacerlo-atenta-contra-el-principio-de-capacidad-economica', 'Los asesores fiscales han pedido deflactar el impuesto sobre la renta de las personas físicas (IRPF) para evitar que las empresas no cumplan con el principio de capacidad económica.', 'Los asesores fiscales han pedido deflactar el impuesto sobre la renta de las personas físicas (IRPF) para evitar que las empresas no cumplan con el principio de capacidad económica.', 'Europapress.es', 'https://www.europapress.es/economia/fiscal-00347/noticia-asesores-fiscales-piden-deflactar-irpf-no-hacerlo-atenta-contra-principio-capacidad-economica-20260506171902.html', 'IVA', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260506171902_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (8, 'Los inversores institucionales de bitcoin firman ahora un ''empate''', 'los-inversores-institucionales-de-bitcoin-firman-ahora-un-empate', 'Los inversores institucionales de Bitcoin han formalizado un ''empate'' ahora, después de un aumento reciente en el precio del Bitcoin, lo que resulta inesperado para gran parte de ellos.', 'Los inversores institucionales de Bitcoin han formalizado un ''empate'' ahora, después de un aumento reciente en el precio del Bitcoin, lo que resulta inesperado para gran parte de ellos.', 'Expansion.com', 'https://www.expansion.com/mercados/2026/05/08/69fda4c7e5fdeaf9228b45a3.html', 'Sociedades', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:06', 'published', 'https://e01-phantom-expansion.uecdn.es/fc2a95313a3e5b161e61ee3d177758a8/crop/406x23/2035x1110/resize/1200/f/webp/assets/multimedia/imagenes/2025/06/26/17509335880869.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (10, 'Feijóo y Moreno ignoran los ataques de Vox y miran al votante de izquierdas ante una ''noche de infarto'' el 17-M', 'feijoo-y-moreno-ignoran-los-ataques-de-vox-y-miran-al-votante-de-izquierdas-ante-una-noche-de-infarto-el-17-m', 'La noticia relata sobre la políticas fiscales actuales en España, con un enfoque en las estrategias del gobierno del Partido Popular (PP) para implementar una política centralista con fines de crecimiento. El leader del PP, Abascal, está luchando por materializar su estrategia, pero enfrenta dificultades al_rentabilizar la ''prioridad nacional'' y los pactos autonómicos en lossondeos.', 'La noticia relata sobre la políticas fiscales actuales en España, con un enfoque en las estrategias del gobierno del Partido Popular (PP) para implementar una política centralista con fines de crecimiento. El leader del PP, Abascal, está luchando por materializar su estrategia, pero enfrenta dificultades al_rentabilizar la ''prioridad nacional'' y los pactos autonómicos en lossondeos.', 'Elconfidencial.com', 'https://www.elconfidencial.com/espana/2026-05-08/feijoo-moreno-ignoran-ataques-vox-votante-izquierdas_4349573/', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://images.ecestaticos.com/uX5ndjrEMEpZ3gT21_U3DdetCxU=/0x0:2272x1515/600x315/filters:fill(white):format(jpg):quality(99):watermark(f.elconfidencial.com/file/bae/eea/fde/baeeeafde1b3229287b0c008f7602058.png,0,275,1)/f.elconfidencial.com/original/1a5/455/83f/1a545583f0f7391e0ab8ae8e570711de.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (11, 'José María Páez, economista: ''Si alquilas y declaras solo los ingresos estás pagando más impuestos''', 'jose-maria-paez-economista-si-alquilas-y-declaras-solo-los-ingresos-estas-pagando-mas-impuestos', 'El economista José María Páez señala que los propietarios pagan más impuestos en la Renta por no declarar todos sus ingresos y por no deducir gastos como el IBI, la comunidad, los seguros o la amortización del inmueble.', 'El economista José María Páez señala que los propietarios pagan más impuestos en la Renta por no declarar todos sus ingresos y por no deducir gastos como el IBI, la comunidad, los seguros o la amortización del inmueble.', 'Elconfidencial.com', 'https://www.elconfidencial.com/economia/2026-05-07/jose-maria-paez-economista-alquilar-declaras-impuestos_4350458/', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://images.ecestaticos.com/dfNlgNr9Cg-teXvyWcLD-zihhfQ=/0x0:587x477/600x315/filters:fill(white):format(jpg):quality(99):watermark(f.elconfidencial.com/file/bae/eea/fde/baeeeafde1b3229287b0c008f7602058.png,0,275,1)/f.elconfidencial.com/original/7dd/a7f/6a7/7dda7f6a73c55645db6ef97738bc0e82.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (12, 'UK celebra elecciones en el peor momento para Starmer: los laboristas activan una posible sucesión', 'uk-celebra-elecciones-en-el-peor-momento-para-starmer-los-laboristas-activan-una-posible-sucesion', 'La elección del UK se celebra en un momento crítico para la Partido Socialista, liderado por Starmer, con perspectivas de sucesión del poder y un desafío interno al sistema fiscal y político actual.', 'La elección del UK se celebra en un momento crítico para la Partido Socialista, liderado por Starmer, con perspectivas de sucesión del poder y un desafío interno al sistema fiscal y político actual.', 'Elconfidencial.com', 'https://www.elconfidencial.com/mundo/2026-05-07/labour-derrota-starmer-elecciones-1hms_4350739/', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://images.ecestaticos.com/eBfL6eWari-9U6uGy1625ls9YDs=/0x0:2272x1515/600x315/filters:fill(white):format(jpg):quality(99):watermark(f.elconfidencial.com/file/bae/eea/fde/baeeeafde1b3229287b0c008f7602058.png,0,275,1)/f.elconfidencial.com/original/958/31a/57a/95831a57a00ca681b3cbc58de52d1703.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (13, 'Alba Carrillo destroza a TVE por los famosos que van a ''MasterChef Celebrity Legends'': ''Me puede salir caro''', 'alba-carrillo-destroza-a-tve-por-los-famosos-que-van-a-masterchef-celebrity-legends-me-puede-salir-caro', 'La noticia relata un desfiles fiscales entre Alba Carrillo y la telefunción TVE, relacionado con la elección de dos de sus participantes famosos en ''MasterChef Celebrity Legends''.', 'La noticia relata un desfiles fiscales entre Alba Carrillo y la telefunción TVE, relacionado con la elección de dos de sus participantes famosos en ''MasterChef Celebrity Legends''.', 'Elconfidencial.com', 'https://www.elconfidencial.com/television/programas-tv/2026-05-07/alba-carrillo-masterchef-tve_4351286/', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://images.ecestaticos.com/B_OF_NqoM2NzgOgu3epjLSkS12E=/0x0:1918x1007/600x315/filters:fill(white):format(jpg):quality(99):watermark(f.elconfidencial.com/file/bae/eea/fde/baeeeafde1b3229287b0c008f7602058.png,0,275,1)/f.elconfidencial.com/original/cdb/d6f/ae2/cdbd6fae287b95638f008f7181e36e76.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (25, 'Los docentes ya pueden descargar el certificado de retenciones e ingresos actualizado para su declaración de la renta', 'los-docentes-ya-pueden-descargar-el-certificado-de-retenciones-e-ingresos-actualizado-para-su-declaracion-de-la-renta', 'Los docentes ya pueden descargar el certificado de retenciones e ingresos actualizado para su declaración de la renta.', 'Los docentes ya pueden descargar el certificado de retenciones e ingresos actualizado para su declaración de la renta.', 'Europapress.es', 'https://www.europapress.es/murcia/noticia-docentes-ya-pueden-descargar-certificado-retenciones-ingresos-actualizado-declaracion-renta-20260504115207.html', 'Laboral', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260504115207_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (14, 'El Espanyol se lanza a por Monchi, el arquitecto del mejor Sevilla de la historia', 'el-espanyol-se-lanza-a-por-monchi-el-arquitecto-del-mejor-sevilla-de-la-historia', 'El articulo habla de una propuesta fiscal española para reducir la desigualdad income, consistiendo en un impuesto al ingreso más alto y una vacancía de gasto para las familias de poca renta.', 'El articulo habla de una propuesta fiscal española para reducir la desigualdad income, consistiendo en un impuesto al ingreso más alto y una vacancía de gasto para las familias de poca renta.', 'Elconfidencial.com', 'https://www.elconfidencial.com/deportes/futbol/2026-05-07/monchi-espanyol-sevilla-salvacion-director-deportivo_4351259/', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:06', 'published', 'https://images.ecestaticos.com/OirXXbtlZUN0ArawQPiwVacQ4P4=/0x0:2272x1420/600x315/filters:fill(white):format(jpg):quality(99):watermark(f.elconfidencial.com/file/bae/eea/fde/baeeeafde1b3229287b0c008f7602058.png,0,275,1)/f.elconfidencial.com/original/d6f/8c8/67f/d6f8c867fc9bebde8646449ae5565d50.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (16, 'Ocho técnicos y especialistas de la ATRM refuerzan la atención a los ciudadanos en la campaña de la Renta', 'ocho-tecnicos-y-especialistas-de-la-atrm-refuerzan-la-atencion-a-los-ciudadanos-en-la-campana-de-la-renta', 'El Agente Tributario de la Región de Murcia (ATRM) collabora en la campaña de la Renta con ocho técnicos y especialistas para reforzar la atención a los ciudadanos.', 'El Agente Tributario de la Región de Murcia (ATRM) collabora en la campaña de la Renta con ocho técnicos y especialistas para reforzar la atención a los ciudadanos.', 'Europapress.es', 'https://www.europapress.es/murcia/noticia-ocho-tecnicos-especialistas-atrm-refuerzan-atencion-ciudadanos-campana-renta-20260509102951.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260509102951_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (17, 'Queipo defiende en Avilés ''menos impuestos, más formación y más captación de talento'' para la industria asturiana', 'queipo-defiende-en-aviles-menos-impuestos-mas-formacion-y-mas-captacion-de-talento-para-la-industria-asturiana', 'El Presidente del PP de Asturias, Álvaro Queipo, ha defendido una política industrial basada en ''menos impuestos, más formación y más captación de talento'', que exige Asturias investir en educación y la obtención de talents para superar la dependencia de solo reducir impuestos.', 'El Presidente del PP de Asturias, Álvaro Queipo, ha defendido una política industrial basada en ''menos impuestos, más formación y más captación de talento'', que exige Asturias investir en educación y la obtención de talents para superar la dependencia de solo reducir impuestos.', 'Europapress.es', 'https://www.europapress.es/asturias/noticia-queipo-defiende-aviles-menos-impuestos-mas-formacion-mas-captacion-talento-industria-asturiana-20260508152706.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260508152706_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (21, 'BUSCADOR | Oferta de empleo público 2026: estas son las 27.232 plazas publicadas en el BOE', 'buscador-oferta-de-empleo-publico-2026-estas-son-las-27232-plazas-publicadas-en-el-boe', 'El Gobierno español ha publicado 27.232 plazas de empleo público en el BOE, incluyendo 1.700 en tecnologías, como lo anuncia el Real Decreto 387/2026 de 6 de mayo.', 'El Gobierno español ha publicado 27.232 plazas de empleo público en el BOE, incluyendo 1.700 en tecnologías, como lo anuncia el Real Decreto 387/2026 de 6 de mayo.', 'Europapress.es', 'https://www.europapress.es/economia/laboral-00346/noticia-buscador-oferta-empleo-publico-2026-son-27232-plazas-publicadas-boe-20260507163702.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260507163702_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (22, 'Hacienda devuelve en el primer mes de la Campaña de la Renta 46,39 millones de euros a 88.667 contribuyentes extremeños', 'hacienda-devuelve-en-el-primer-mes-de-la-campana-de-la-renta-4639-millones-de-euros-a-88667-contribuyentes-extremenos', 'El HM Treasury ha distribuido 46.39 millones de euros a 88.667 contribuyentes extremos en el primer mes de la campaña de la Renta 46 correspondiente al ejercicio 2025.', 'El HM Treasury ha distribuido 46.39 millones de euros a 88.667 contribuyentes extremos en el primer mes de la campaña de la Renta 46 correspondiente al ejercicio 2025.', 'Europapress.es', 'https://www.europapress.es/extremadura/noticia-hacienda-devuelve-primer-mes-campana-renta-4639-millones-euros-88667-contribuyentes-extremenos-20260506174153.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260506174153_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (19, 'Hacienda devuelve en el primer mes de campaña de la renta 104,2 millones de euros a más de 168.000 murcianos', 'hacienda-devuelve-en-el-primer-mes-de-campana-de-la-renta-1042-millones-de-euros-a-mas-de-168000-murcianos', 'La Hacienda ha devuelve en el primer mes de campaña de la renta 104,2 millones de euros a más de 168.000 murcianos.', 'La Hacienda ha devuelve en el primer mes de campaña de la renta 104,2 millones de euros a más de 168.000 murcianos.', 'Europapress.es', 'https://www.europapress.es/murcia/noticia-hacienda-devuelve-primer-mes-campana-renta-1042-millones-euros-mas-168000-murcianos-20260507113900.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:08', 'published', 'https://img.europapress.es/fotoweb/fotonoticia_20260507113900_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (20, 'Intervenidos más de 800 kilos de hachís ocultos en latas de tomate en Mollina (Málaga)', 'intervenidos-mas-de-800-kilos-de-hachis-ocultos-en-latas-de-tomate-en-mollina-malaga', 'La Policía Nacional, en una operación conjunta con el Servicio de Vigilancia Aduanera de la Agencia Tributaria, ha intervenido 816,8 kilos de hachís ocultos en latas de tomate en Mollina (Málaga), category: IRPF', 'La Policía Nacional, en una operación conjunta con el Servicio de Vigilancia Aduanera de la Agencia Tributaria, ha intervenido 816,8 kilos de hachís ocultos en latas de tomate en Mollina (Málaga), category: IRPF', 'Europapress.es', 'https://www.europapress.es/andalucia/malaga-00356/noticia-dos-investigados-intervenir-mas-800-kilos-hachis-ocultos-latas-tomate-mollina-malaga-20260507103004.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:08', 'published', 'https://img.europapress.es/fotoweb/fotonoticia_20260507103004_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (18, 'La guerra interna que se está librando en la Agencia Tributaria en plena campaña de la renta: ''Se concentran en lo fácil, no en los grandes evasores''', 'la-guerra-interna-que-se-esta-librando-en-la-agencia-tributaria-en-plena-campana-de-la-renta-se-concentran-en-lo-facil-no-en-los-grandes-evasores', 'La Agencia Tributaria española está realizando una campaña intensiva para combate contra la evasión tributaria, enfocándose en casos sencillos. Un ejemplo demuestra que profesiones no consideradas de alto riesgo, como la del tráfico de narcóticos, pueden ser usadas para evitar impuestos.', 'La Agencia Tributaria española está realizando una campaña intensiva para combate contra la evasión tributaria, enfocándose en casos sencillos. Un ejemplo demuestra que profesiones no consideradas de alto riesgo, como la del tráfico de narcóticos, pueden ser usadas para evitar impuestos.', 'El Mundo', 'https://www.elmundo.es/economia/empresas/2026/05/07/69fb52c5fdddff41558b4570.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:09', 'published', 'https://e01-phantom-elmundo.uecdn.es/d734cd6099be8b15989d2aca6366fe7c/crop/0x476/1568x1522/resize/1200/f/webp/assets/multimedia/imagenes/2026/05/06/17780836730407.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (24, 'Hacienda ha devuelto ya 127,9 millones de la declaración de la renta a 214.332 contribuyentes de CyL', 'hacienda-ha-devuelto-ya-1279-millones-de-la-declaracion-de-la-renta-a-214332-contribuyentes-de-cyl', 'Hacienda ha devuelto ya 127,9 millones de la declaración de la renta a 214.332 contribuyentes de Castilla y León. Un total de 214.332 contribuyentes ya han recibido la devolución de la declaración del Impuesto sobre la Renta de las Personas Físicas correspondiente a 2025, en el primer mes de campaña, con un importe total de 137,9 millones de euros.', 'Hacienda ha devuelto ya 127,9 millones de la declaración de la renta a 214.332 contribuyentes de Castilla y León. Un total de 214.332 contribuyentes ya han recibido la devolución de la declaración del Impuesto sobre la Renta de las Personas Físicas correspondiente a 2025, en el primer mes de campaña, con un importe total de 137,9 millones de euros.', 'Europapress.es', 'https://www.europapress.es/castilla-y-leon/noticia-hacienda-devuelto-ya-1279-millones-declaracion-renta-214332-contribuyentes-cyl-20260506160207.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:12', 'published', 'https://img.europapress.es/fotoweb/fotonoticia_20260506160207_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (26, 'Una OPE sin aval sindical y con la IA por bandera: ''Transformaremos empleos''', 'una-ope-sin-aval-sindical-y-con-la-ia-por-bandera-transformaremos-empleos', 'La Oferta de Empleo Público (OEP) anunciada por el ministro de Función Pública, Óscar López, para 2026, con 37.017 plazas, busca transformar empleos y ha sido criticada por su enfoque.', 'La Oferta de Empleo Público (OEP) anunciada por el ministro de Función Pública, Óscar López, para 2026, con 37.017 plazas, busca transformar empleos y ha sido criticada por su enfoque.', 'El Mundo', 'https://www.elmundo.es/economia/2026/05/06/69fa3504fc6c83cb0e8b4599.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://e01-phantom-elmundo.uecdn.es/7887bf80bfcab45e5948afce58d514e8/crop/162x187/911x687/f/webp/assets/multimedia/imagenes/2026/05/05/17780049281470.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (27, 'Detenido en Bilbao un profesional del sector sanitario por comprar botox ilegal por internet', 'detenido-en-bilbao-un-profesional-del-sector-sanitario-por-comprar-botox-ilegal-por-internet', 'El detenido en Bilbao de un profesional sanitario por compra ilegal de toxin botulínica onlineIlustra la importancia de la vigilancia en el sector sanitario y su impacto fiscal al controlar el uso de fármacos peligrosos que pueden causar daños en la salud pública y en las contribuciones fiscales.', 'El detenido en Bilbao de un profesional sanitario por compra ilegal de toxin botulínica onlineIlustra la importancia de la vigilancia en el sector sanitario y su impacto fiscal al controlar el uso de fármacos peligrosos que pueden causar daños en la salud pública y en las contribuciones fiscales.', 'Europapress.es', 'https://www.europapress.es/euskadi/noticia-detenido-bilbao-profesional-sector-sanitario-comprar-botox-ilegal-internet-20260506091744.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260506091744_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (28, 'Trabajadores de aseguradoras avalan el ''buen'' funcionamiento del grupo funerario El Salvador', 'trabajadores-de-aseguradoras-avalan-el-buen-funcionamiento-del-grupo-funerario-el-salvador', 'Trabajadores de diferentes compañías de seguros que han prestado servicio al grupo funerario El Salvador han evaluado con sus testimonios lo que consideran como ''bueno'' el funcionamiento de dicha empresa, cuyos Gerenciales y empleados comparten bankillo.', 'Trabajadores de diferentes compañías de seguros que han prestado servicio al grupo funerario El Salvador han evaluado con sus testimonios lo que consideran como ''bueno'' el funcionamiento de dicha empresa, cuyos Gerenciales y empleados comparten bankillo.', 'Europapress.es', 'https://www.europapress.es/castilla-y-leon/noticia-trabajadores-aseguradoras-avalan-buen-funcionamiento-grupo-funerario-salvador-20260504121838.html', 'Laboral', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260504121838_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (29, 'La Agencia Tributaria pone en marcha este miércoles la atención telefónica para la Campaña de la Renta', 'la-agencia-tributaria-pone-en-marcha-este-miercoles-la-atencion-telefonica-para-la-campana-de-la-renta', 'La Agencia Tributaria española, conocida como SIGI, ha comenzado este miércoles la atención telefónica para la campaña de declaración de la Renta del año 2025. Los ciudadanos pueden pedir citas previas desde el 29 de abril para asistir al servicio tributario.', 'La Agencia Tributaria española, conocida como SIGI, ha comenzado este miércoles la atención telefónica para la campaña de declaración de la Renta del año 2025. Los ciudadanos pueden pedir citas previas desde el 29 de abril para asistir al servicio tributario.', 'Europapress.es', 'https://www.europapress.es/economia/fiscal-00347/noticia-agencia-tributaria-pone-marcha-miercoles-atencion-telefonica-campana-renta-20260506075919.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:09:31', 'pending', 'https://img.europapress.es/fotoweb/fotonoticia_20260506075919_1200.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (4, 'BBVA crea un colchón de 100 millones por la guerra en Irán', 'bbva-crea-un-colchon-de-100-millones-por-la-guerra-en-iran', 'BBVA ha aumentado sus provisiones en 98 millones de euros para cubrir el impacto de un posible alargamiento del conflicto en Oriente Medio, con la mitad de esta cantidad destinada a la defensa del Ejército Real de España.', 'BBVA ha aumentado sus provisiones en 98 millones de euros para cubrir el impacto de un posible alargamiento del conflicto en Oriente Medio, con la mitad de esta cantidad destinada a la defensa del Ejército Real de España.', 'Expansion.com', 'https://www.expansion.com/empresas/banca/2026/05/09/69fe3fe0468aebdd688b4595.html', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:05', 'published', 'https://e01-phantom-expansion.uecdn.es/dd099b744704111e3138476c81ed95c1/crop/223x14/1858x1104/resize/1200/f/webp/assets/multimedia/imagenes/2026/05/08/17782701925822.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (9, 'Un informe estima que el eclipse de agosto movilizará alrededor de 360 millones de euros en una semana', 'un-informe-estima-que-el-eclipse-de-agosto-movilizara-alrededor-de-360-millones-de-euros-en-una-semana', 'El informe estimula que el eclipse del agosto generará alrededor de 360 millones de euros en una semana, atrayendo astroturismo internacional, incrementando el gasto en alquileres de corta duración y creando empleos en regiones rurales con impacto fiscal y demanda concentrada en varias autonomías.', 'El informe estimula que el eclipse del agosto generará alrededor de 360 millones de euros en una semana, atrayendo astroturismo internacional, incrementando el gasto en alquileres de corta duración y creando empleos en regiones rurales con impacto fiscal y demanda concentrada en varias autonomías.', 'Elconfidencial.com', 'https://www.elconfidencial.com/sociedad/2026-05-07/eclipse-turismo-rural-espana-1hms-1svm_4351629/', 'IRPF', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:06', 'published', 'https://images.ecestaticos.com/GZzJcmHetLbhNBdR5X_jZATW8Ec=/0x0:2272x1515/600x315/filters:fill(white):format(jpg):quality(99):watermark(f.elconfidencial.com/file/bae/eea/fde/baeeeafde1b3229287b0c008f7602058.png,0,275,1)/f.elconfidencial.com/original/017/1ac/c7e/0171acc7e93234d7a200f0d824235aec.jpg');
INSERT INTO public.news (id, title, slug, summary, content, source, source_url, category, published_at, is_published, created_by_automation, created_at, updated_at, status, image) VALUES (15, 'Precio Gasolina hoy: Caída en el precio del barril de brent; consulte los precios del diésel y gasolina en las principales ciudades', 'precio-gasolina-hoy-caida-en-el-precio-del-barril-de-brent-consulte-los-precios-del-diesel-y-gasolina-en-las-principales-ciudades', 'La noticia habla sobre una caída en el precio del barril de Brent, lo que afecta el precio de la gasolina y el diesel. Esto puede implicar cambios en impuestos como la IVA (Impuesto a la Value Added Tax).', 'La noticia habla sobre una caída en el precio del barril de Brent, lo que afecta el precio de la gasolina y el diesel. Esto puede implicar cambios en impuestos como la IVA (Impuesto a la Value Added Tax).', 'Expansion.com', 'https://www.expansion.com/empresas/energia/precio-gasolina/2026/05/07/69fbd60b468aeb4a378b458a.html', 'IVA', NULL, false, false, '2026-05-10 11:09:31', '2026-05-10 11:45:07', 'published', 'https://e01-phantom-expansion.uecdn.es/881589cf76b99eaffa5849d9b38df4a4/resize/1200/f/webp/assets/multimedia/imagenes/2025/11/19/17635397041988.jpg');


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: performance_reports; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('PKI2pSvZi31C4WHvV95UB8NI80Q7zkhlIDx7oJvZ', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWDVTN1IxWUFzY1RiaWFPM0V1ZkIydkFxbFlZbVJnQ0I4c2g4cHg3SSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('YXY9ErqNDg2nCHIdiwG736YO4QvY6CwI6tC6rDBK', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZXBFbjI2cldxT0NDTzdodzVVWXA3V1ZERkdqMjQ5QklvWG5IYUpXNiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('yQ2FYFeSfXvasklgVONfWjdZcIY7Rtfs1Ndc48Oo', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTnhNOEs5YWZVYTNLWVhiMnB6RzJlSEJmVEVzWU52aTNvVVNMM0Y3SSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('6xImylC3giNcNUSnehnkWtR5t34Yh20rn4YQL27v', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWnltWHRXZG1wdEhnZkI2c04xTkw5enE2VnpIenZFSDJUQzRjaEZDMSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('ltW90Vx3wlcuNE9Z1FnrwyJywNO4oTTCrZNNmvOi', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUm0ySUJCVHFLTkowUDR2YU1pMVNUV0V0NGhidWtTSWgwZFVMUVNLRyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('B18pjEBy3YjwSzmIm32ijG1tL8vqZ84DkhtduHkF', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTmJONTB1WWZla0duSGNLS0ZDRTlFYUs2VlMzZjE1UmY0MWJaTXpDSiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('8hb6xzcoslNgqeFHizO9u3Hkuk7EexVb1nA4TGK5', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRG5lOUM4bmtPdXZVYkpObnJ5ZXYyaktWVFJGbXd3TnI0Z0NCa1ZraCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('FvgPrMejvVBjGrzkpGqGKEIjtd6JBiFSKGQYkOZn', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUzZJOHZCSmE3eXF2bm9HUGFQaDI4VVd1cXNCU0Y5ek5xS1haRFB2RyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('OLFCHlI15Bp69Xpd2B5BqqQZ1hBYrmjJKLABmOVm', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoib2RvZGJja2EzTnVxWXNjbjNkb0xkQzRxeHM2bjZUUVAwNktmN09xcCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('NaEvF5qljLt7MKHGpArrWGZe4Ko24hxGkGhYSEOl', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiMDR2ZU9FOWNRNjlMV0c1UHh1QXZNclc1NHVFRVhkUmlwbHBZZkZOVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('s2at6Fw2ikej4Yx6zViCh0B7ZkFICdBI3DW5eeI3', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiMmlqazdzUFM3ZWF3UGVFaDk2QjNBcDBCR3lmaEU3QmVOM0FGOUdoVyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('DrexmgEdarSQHba1ZC7uWpJ9l31s2eErEIKuIAxA', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoieVVjb01mTXV3bm1nMVhvWHpnNjdJRzZlcTVYNFI0dDlIWW5Nc3FRaCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('AoJoi4Zw7fVUko8U1l7LIM2MXUymXUCp2XEe3vSy', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiTXcxN0ZFWG5wWDlqZzQxSGRBazhTVU9hTEo4NERjb3NwN0FyU1MxSiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('Q45gz2Qs5v3OyzGfjVbIXmNWRULXaGWenzD9lP6J', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoicWhUQ3Mzd1pwb1RoaDN3SXREZjdMa0E5OHhvMzV6VWlrQUQyeWhoayI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('ukAIP0UsyS6XvZxTKSEueIF9Yz7P0HPp7w5VtKI1', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoieXhmZUxYbmlFRVkxNVNRY1k3bmY0Z0NneXIyYjEzRWt6TkZCOHVRVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('dXNV495eA7sQHwYkXeCk4wyq7U4zU227LDx2FY1s', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiN1Z1UFNEQTVqWllIQ3pQN1NYM0huNmQwS0Y0S1o1cVdrbVl4cXhSUSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('esH34w9iSioZfWULLukd1JnjrlBJ0cgMkiMfeHlU', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQ3dtMW5QelFjZ0xJcnFOOG1xSmIwQWRiZm1JMnRpaW1DYmRnY29XOCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('jwclCZrs6bhkHfkg8WY83AcWShsMF6V6U1AZSSoZ', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUGM5U3hOU3hSaGVWZ25HWkFyVkJmZTRaSUl1UGhHN0JYdnpBYzQzeCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('jurblMVSMI2MckI96oeP51epqdMRtcu9X9MoFenb', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZzJIY0xNRVBDamNSTFNQUmNPZlcxNlk2dVlmTHVUUjFQMnBDV2xDNSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('JPp6HZmP4tAEegOHRdekO7WylaxZvRPuegwZS0Xg', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUzA5VHZNRzc4cnRsQzRWMkRhbUNmVHRwNWhLc3lpM05obFFQbXk2dyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('h3m7BfPx25GGUBzBVsjzfsmIaog4ksDsudUBjvP4', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibnVNSk51ZGdNSXVxWVRwaFVEeVFJdlo4dDlIbElqQThVcklGZ29heSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('0d4zasNfQyoaKaCIeDtMRatmMNz1mLMlj0l1xbCy', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiSlRUc2E1em5GUUhONjd4RVUzQTNRNVVGT2U4SlVuUWVZZVYzclNRVyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('LK7zowNKrxrv4yMk9VhhOfLRdix2Aq3pUPiZiwR3', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNGxoc3lIOEJHQ2owcXpNcWV3Y2owSnI4dXI4ejB5dHh4UzlMQkM2cyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('7EJclNUDteELe8IpbPBAtD2fdIcPXmm8YxsL82up', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQmNlemN4dmFDRkdEZjlhaWtrS1dTSUQyTTZEM1Q4UlV5d3ZuU2dsTCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('WiTcyg4M6A2rkHoqMPQOVQ6gRpPLdRgrwVSUbgfk', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQzZtVVFzNkIwZzJ5aHZmWHo1cHdnQ0lwSWV1RmloMEZlOTdJSTFPWCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('dHR9gnHnenc8JPZSJybFz0l2Vpzjo84WUx78U0PJ', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUEZpZnFScXd0R3Jad1pzUmo1QklxWUVlTzJWaDZZcWVUU2R5cktFcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('6RgmRUmmc8MCM0Ow4cEBNnzenHbTuBMVQgnfgBdd', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiUkVDZmFJdkJMRVZVYlFLSXNOU1FGS2pSNUZ1NmxBdGs5V2djTGdPMSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('WuzsqzUnpsRpW5is5cgGkRUlEd2DmpxJDplFy6yw', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiT3hLZ2hhRUFKS2c3eEZ6Sm9uTkhPUnQ5VXNXWUUxdU1CbDA5OXRRbSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('R4ruAWf6dIqhV1UTYyjHcc8Psqd8DioONLnKqSli', NULL, '172.18.0.1', 'axios/1.13.5', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVzlwdENrUDVBMWRXdGhselliTVJzd2dzRzhZOFl1SURxelByakR0bSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1778411371);
INSERT INTO public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) VALUES ('6y648xBlmo7w0idmiwILKtNbjI5zdnldPHgLXMvF', 8, '172.18.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiem4zOXJXbHR1bWRwVU51MXBwWTZDaHNmSUJGZHUyOWdpSTVDUWJDbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7czo0OiJob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6ODt9', 1778421215);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role, phone, avatar, two_factor_secret, two_factor_confirmed_at) VALUES (1, 'Asesor Admin', 'asesor@test.com', NULL, '$2y$12$OHtzKDdI2uU.V56J71MVZOBlGc8ZittdxZ0/YT371lZRvRqPMaQyC', 'I24VboqJ1u', '2026-04-26 18:21:13', '2026-04-26 20:24:38', 'asesor', '555-555-555', 'avatars/Drt7ujoZZRS2JmWpqAesbZ1mPfHEvy2qaGsZtrNm.png', NULL, NULL);
INSERT INTO public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role, phone, avatar, two_factor_secret, two_factor_confirmed_at) VALUES (8, 'Asesor Administrador', 'asesor@selecto.com', NULL, '$2y$12$C.0LaGpzytRaLibz4e/hz.ypoG3TaL1ely8QwASa7IjJzPDTXHqyq', NULL, '2026-04-27 12:31:03', '2026-05-07 11:19:21', 'asesor', '684-743-250', 'avatars/LGy551BDJJEPr2DKdJzF7L5nlTES2pAoNVHG1KiJ.png', 'eyJpdiI6IlV4MUxSTGNxWWEyVHFwNGxBWW9za2c9PSIsInZhbHVlIjoib0ZWcVVSMkVxa29yaGp3aUVpREhqVUNuUXZXK0txZ1lid3BkNU1qYVlLRFh4ZVVvTnlIWHhGZ0JDclE3TXI3YyIsIm1hYyI6IjA0NGUyNmY3ZTRlYmEzNzFmMGNmYzg4NDFhZDQzYzVlOTEwZDk3Nzk4YjU1YTdmMjZmM2UzYWVhMWQ2NTAzY2YiLCJ0YWciOiIifQ==', '2026-05-07 11:19:21');
INSERT INTO public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role, phone, avatar, two_factor_secret, two_factor_confirmed_at) VALUES (10, 'Raul Ramirez', 'raul@selecto.com', NULL, '$2y$12$nIhdH6IWQo0pw/XX2fYHVuP0lTzPvdKeII9HGqGY9GQAlUrxJKiwy', NULL, '2026-05-07 11:34:13', '2026-05-07 11:43:11', 'cliente', '555555555', 'avatars/O8Smdnbzab1sUCrq92fpaUGuIxamrE4Bg3H1dBkD.png', 'eyJpdiI6IndTVExQd3VrQkZqK1RnRWlvUUM0TXc9PSIsInZhbHVlIjoiS29ocktUR2daOEFDYlhubGI1ODhNb2t1MWQ3amJKRTV6eHJGOHcrczRBVyt5QUxXNzFUN3h0N0NyM0JZaE1tQSIsIm1hYyI6ImU3M2EyZDc2YjJiNDNiNzhlNGYzMzA4YjgzODU2ODc4ODY4NDA4YzQ3OGZjNTk0YTU4M2E5MmM0MmU0M2E0NWIiLCJ0YWciOiIifQ==', '2026-05-07 11:43:11');


--
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.appointments_id_seq', 1, true);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.companies_id_seq', 1, false);


--
-- Name: contact_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contact_messages_id_seq', 1, false);


--
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.documents_id_seq', 2, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 19, true);


--
-- Name: news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.news_id_seq', 29, true);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: performance_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.performance_reports_id_seq', 1, false);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: companies companies_cif_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_cif_unique UNIQUE (cif);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: contact_messages contact_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_messages
    ADD CONSTRAINT contact_messages_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);


--
-- Name: news news_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_slug_unique UNIQUE (slug);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: performance_reports performance_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.performance_reports
    ADD CONSTRAINT performance_reports_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: appointments appointments_advisor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_advisor_id_foreign FOREIGN KEY (advisor_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: appointments appointments_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: companies companies_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: documents documents_appointment_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_appointment_id_foreign FOREIGN KEY (appointment_id) REFERENCES public.appointments(id) ON DELETE SET NULL;


--
-- Name: documents documents_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: performance_reports performance_reports_advisor_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.performance_reports
    ADD CONSTRAINT performance_reports_advisor_id_foreign FOREIGN KEY (advisor_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: performance_reports performance_reports_company_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.performance_reports
    ADD CONSTRAINT performance_reports_company_id_foreign FOREIGN KEY (company_id) REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


