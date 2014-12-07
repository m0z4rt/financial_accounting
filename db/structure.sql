--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: expense_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expense_categories (
    id integer NOT NULL,
    name character varying(255),
    account_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: expense_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expense_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expense_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE expense_categories_id_seq OWNED BY expense_categories.id;


--
-- Name: expenses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE expenses (
    id integer NOT NULL,
    name character varying(255),
    expense numeric(12,2),
    account_id integer,
    expense_category_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    record_type character varying(255)
);


--
-- Name: expenses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE expenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: expenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE expenses_id_seq OWNED BY expenses.id;


--
-- Name: income_categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE income_categories (
    id integer NOT NULL,
    name character varying(255),
    account_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: income_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE income_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: income_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE income_categories_id_seq OWNED BY income_categories.id;


--
-- Name: incomes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE incomes (
    id integer NOT NULL,
    name character varying(255),
    income numeric(12,2),
    account_id integer,
    income_category_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    record_type character varying(255)
);


--
-- Name: incomes_expenses_view; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW incomes_expenses_view AS
    SELECT incomes.id AS record_id, incomes.name, incomes.income AS record_value, incomes.account_id, incomes.created_at, incomes.updated_at, incomes.record_type, income_categories.name AS category FROM (incomes LEFT JOIN income_categories ON ((incomes.income_category_id = income_categories.id))) UNION SELECT expenses.id AS record_id, expenses.name, expenses.expense AS record_value, expenses.account_id, expenses.created_at, expenses.updated_at, expenses.record_type, expense_categories.name AS category FROM (expenses LEFT JOIN expense_categories ON ((expenses.expense_category_id = expense_categories.id))) ORDER BY 6 DESC;


--
-- Name: incomes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE incomes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: incomes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE incomes_id_seq OWNED BY incomes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY expense_categories ALTER COLUMN id SET DEFAULT nextval('expense_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY expenses ALTER COLUMN id SET DEFAULT nextval('expenses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY income_categories ALTER COLUMN id SET DEFAULT nextval('income_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY incomes ALTER COLUMN id SET DEFAULT nextval('incomes_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: expense_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expense_categories
    ADD CONSTRAINT expense_categories_pkey PRIMARY KEY (id);


--
-- Name: expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY expenses
    ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);


--
-- Name: income_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY income_categories
    ADD CONSTRAINT income_categories_pkey PRIMARY KEY (id);


--
-- Name: incomes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY incomes
    ADD CONSTRAINT incomes_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_accounts_on_email ON accounts USING btree (email);


--
-- Name: index_accounts_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_accounts_on_reset_password_token ON accounts USING btree (reset_password_token);


--
-- Name: index_expense_categories_on_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_expense_categories_on_account_id ON expense_categories USING btree (account_id);


--
-- Name: index_expenses_on_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_expenses_on_account_id ON expenses USING btree (account_id);


--
-- Name: index_expenses_on_expense_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_expenses_on_expense_category_id ON expenses USING btree (expense_category_id);


--
-- Name: index_income_categories_on_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_income_categories_on_account_id ON income_categories USING btree (account_id);


--
-- Name: index_incomes_on_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_incomes_on_account_id ON incomes USING btree (account_id);


--
-- Name: index_incomes_on_income_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_incomes_on_income_category_id ON incomes USING btree (income_category_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20141122172056');

INSERT INTO schema_migrations (version) VALUES ('20141127062825');

INSERT INTO schema_migrations (version) VALUES ('20141127063302');

INSERT INTO schema_migrations (version) VALUES ('20141127064801');

INSERT INTO schema_migrations (version) VALUES ('20141127065212');

INSERT INTO schema_migrations (version) VALUES ('20141128205342');

INSERT INTO schema_migrations (version) VALUES ('20141128210105');

INSERT INTO schema_migrations (version) VALUES ('20141128222507');

INSERT INTO schema_migrations (version) VALUES ('20141128222949');

INSERT INTO schema_migrations (version) VALUES ('20141128231326');

INSERT INTO schema_migrations (version) VALUES ('20141128231643');

INSERT INTO schema_migrations (version) VALUES ('20141207130456');

