--
-- PostgreSQL database dump
--

-- Dumped from database version 13.12
-- Dumped by pg_dump version 15.9

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

--
-- Name: casino_system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA casino_system;


ALTER SCHEMA casino_system OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: multi_tenant_system; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA multi_tenant_system;


ALTER SCHEMA multi_tenant_system OWNER TO postgres;

--
-- Name: partman; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA partman;


ALTER SCHEMA partman OWNER TO postgres;

--
-- Name: casino_transactions_new_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.casino_transactions_new_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.casino_transactions_new_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: casino_transactions; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.casino_transactions (
    casino_transaction_id bigint DEFAULT nextval('casino_system.casino_transactions_new_seq'::regclass) NOT NULL,
    transaction_id uuid,
    tenant_id integer,
    user_id integer NOT NULL,
    action_type character varying(255),
    action_id character varying(255),
    amount double precision DEFAULT 0,
    game_identifier character varying(255),
    game_id character varying(255),
    wallet_id integer,
    non_cash_amount double precision DEFAULT 0,
    status integer,
    admin_id integer,
    currency_code character varying(255) NOT NULL,
    before_balance double precision,
    after_balance double precision,
    primary_currency_amount double precision,
    amount_type integer DEFAULT 0,
    elastic_updated boolean DEFAULT false NOT NULL,
    conversion_rate double precision,
    is_sticky boolean DEFAULT false,
    user_bonus_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    more_details jsonb,
    jackpot_contribution double precision DEFAULT '0'::double precision
);


ALTER TABLE casino_system.casino_transactions OWNER TO postgres;

--
-- Name: casino_transactions_a; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.casino_transactions_a (
    casino_transaction_id integer NOT NULL,
    transaction_id uuid,
    tenant_id integer,
    user_id integer NOT NULL,
    action_type character varying(255),
    action_id character varying(255),
    amount double precision DEFAULT '0'::double precision,
    game_identifier character varying(255),
    game_id character varying(255),
    wallet_id integer,
    non_cash_amount double precision DEFAULT '0'::double precision,
    status integer,
    admin_id integer,
    currency_code character varying(255) NOT NULL,
    before_balance double precision,
    after_balance double precision,
    primary_currency_amount double precision,
    amount_type integer DEFAULT 0,
    elastic_updated boolean DEFAULT false NOT NULL,
    conversion_rate double precision,
    is_sticky boolean DEFAULT false,
    user_bonus_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.casino_transactions_a OWNER TO postgres;

--
-- Name: casino_transactions_casino_transaction_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.casino_transactions_casino_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.casino_transactions_casino_transaction_id_seq OWNER TO postgres;

--
-- Name: casino_transactions_casino_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.casino_transactions_casino_transaction_id_seq OWNED BY casino_system.casino_transactions_a.casino_transaction_id;


--
-- Name: casino_transactions_copy; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.casino_transactions_copy (
    casino_transaction_id bigint NOT NULL,
    transaction_id uuid,
    tenant_id integer,
    user_id integer NOT NULL,
    action_type character varying(255),
    action_id character varying(255),
    amount double precision DEFAULT 0,
    game_identifier character varying(255),
    game_id character varying(255),
    wallet_id integer,
    non_cash_amount double precision DEFAULT 0,
    status integer,
    admin_id integer,
    currency_code character varying(255) NOT NULL,
    before_balance double precision,
    after_balance double precision,
    primary_currency_amount double precision,
    amount_type integer DEFAULT 0,
    elastic_updated boolean DEFAULT false NOT NULL,
    conversion_rate double precision,
    is_sticky boolean DEFAULT false,
    user_bonus_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    more_details jsonb,
    jackpot_contribution double precision DEFAULT '0'::double precision
);


ALTER TABLE casino_system.casino_transactions_copy OWNER TO postgres;

--
-- Name: category_games; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.category_games (
    category_game_id integer NOT NULL,
    tenant_game_sub_category_id integer NOT NULL,
    master_casino_provider_id integer NOT NULL,
    master_casino_game_id integer NOT NULL,
    return_to_player double precision,
    wagering_contribution double precision NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    name character varying(255) NOT NULL,
    thumbnail_url character varying(255),
    description text,
    tenant_id integer NOT NULL,
    order_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.category_games OWNER TO postgres;

--
-- Name: category_games_category_game_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.category_games_category_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.category_games_category_game_id_seq OWNER TO postgres;

--
-- Name: category_games_category_game_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.category_games_category_game_id_seq OWNED BY casino_system.category_games.category_game_id;


--
-- Name: daily_cumulative_report; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.daily_cumulative_report (
    daily_cumulative_report_id integer NOT NULL,
    tenant_id integer NOT NULL,
    casino_provider_id integer NOT NULL,
    amount numeric DEFAULT 0 NOT NULL,
    report_date date NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.daily_cumulative_report OWNER TO postgres;

--
-- Name: daily_cumulative_report_daily_cumulative_report_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.daily_cumulative_report_daily_cumulative_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.daily_cumulative_report_daily_cumulative_report_id_seq OWNER TO postgres;

--
-- Name: daily_cumulative_report_daily_cumulative_report_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.daily_cumulative_report_daily_cumulative_report_id_seq OWNED BY casino_system.daily_cumulative_report.daily_cumulative_report_id;


--
-- Name: favorite_games; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.favorite_games (
    favorite_game_id integer NOT NULL,
    category_game_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.favorite_games OWNER TO postgres;

--
-- Name: favorite_games_favorite_game_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.favorite_games_favorite_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.favorite_games_favorite_game_id_seq OWNER TO postgres;

--
-- Name: favorite_games_favorite_game_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.favorite_games_favorite_game_id_seq OWNED BY casino_system.favorite_games.favorite_game_id;


--
-- Name: game_aggregator_categories; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.game_aggregator_categories (
    game_aggregator_category_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    game_aggregator_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.game_aggregator_categories OWNER TO postgres;

--
-- Name: game_aggregator_categories_game_aggregator_category_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.game_aggregator_categories_game_aggregator_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.game_aggregator_categories_game_aggregator_category_id_seq OWNER TO postgres;

--
-- Name: game_aggregator_categories_game_aggregator_category_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.game_aggregator_categories_game_aggregator_category_id_seq OWNED BY casino_system.game_aggregator_categories.game_aggregator_category_id;


--
-- Name: master_casino_games; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.master_casino_games (
    master_casino_game_id integer NOT NULL,
    name character varying(255) NOT NULL,
    operator_status boolean NOT NULL,
    is_active boolean NOT NULL,
    master_casino_provider_id integer NOT NULL,
    master_game_sub_category_id integer NOT NULL,
    thumbnail_url character varying(255),
    identifier character varying(255),
    description text,
    volatility_rating character varying(255),
    has_freespins boolean,
    restrictions jsonb,
    theme text,
    feature_group text,
    devices jsonb,
    lines integer,
    return_to_player double precision,
    wagering_contribution double precision DEFAULT '100'::double precision,
    more_details jsonb,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    game_sub_category_id integer
);


ALTER TABLE casino_system.master_casino_games OWNER TO postgres;

--
-- Name: master_casino_games_master_casino_game_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.master_casino_games_master_casino_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.master_casino_games_master_casino_game_id_seq OWNER TO postgres;

--
-- Name: master_casino_games_master_casino_game_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.master_casino_games_master_casino_game_id_seq OWNED BY casino_system.master_casino_games.master_casino_game_id;


--
-- Name: master_casino_providers; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.master_casino_providers (
    master_casino_provider_id integer NOT NULL,
    name character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    master_game_aggregator_id integer NOT NULL,
    thumbnail_url character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    demo boolean,
    allowed_fee_groups jsonb,
    restricted_fee_groups jsonb
);


ALTER TABLE casino_system.master_casino_providers OWNER TO postgres;

--
-- Name: master_casino_providers_master_casino_provider_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.master_casino_providers_master_casino_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.master_casino_providers_master_casino_provider_id_seq OWNER TO postgres;

--
-- Name: master_casino_providers_master_casino_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.master_casino_providers_master_casino_provider_id_seq OWNED BY casino_system.master_casino_providers.master_casino_provider_id;


--
-- Name: master_game_aggregators; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.master_game_aggregators (
    master_game_aggregator_id integer NOT NULL,
    name character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    integration_id integer DEFAULT 1
);


ALTER TABLE casino_system.master_game_aggregators OWNER TO postgres;

--
-- Name: master_game_aggregators_master_game_aggregator_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.master_game_aggregators_master_game_aggregator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.master_game_aggregators_master_game_aggregator_id_seq OWNER TO postgres;

--
-- Name: master_game_aggregators_master_game_aggregator_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.master_game_aggregators_master_game_aggregator_id_seq OWNED BY casino_system.master_game_aggregators.master_game_aggregator_id;


--
-- Name: master_game_categories; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.master_game_categories (
    master_game_category_id integer NOT NULL,
    name jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.master_game_categories OWNER TO postgres;

--
-- Name: master_game_categories_master_game_category_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.master_game_categories_master_game_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.master_game_categories_master_game_category_id_seq OWNER TO postgres;

--
-- Name: master_game_categories_master_game_category_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.master_game_categories_master_game_category_id_seq OWNED BY casino_system.master_game_categories.master_game_category_id;


--
-- Name: master_game_sub_categories; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.master_game_sub_categories (
    master_game_sub_category_id integer NOT NULL,
    name jsonb NOT NULL,
    master_game_category_id integer NOT NULL,
    is_active boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image_url character varying(255) DEFAULT 'https://excitable-gaming.s3.amazonaws.com/staging/superadmin_gallery_image_vtfyjh7gyxj-1678789636649.png'::character varying
);


ALTER TABLE casino_system.master_game_sub_categories OWNER TO postgres;

--
-- Name: master_game_sub_categories_master_game_sub_category_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.master_game_sub_categories_master_game_sub_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.master_game_sub_categories_master_game_sub_category_id_seq OWNER TO postgres;

--
-- Name: master_game_sub_categories_master_game_sub_category_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.master_game_sub_categories_master_game_sub_category_id_seq OWNED BY casino_system.master_game_sub_categories.master_game_sub_category_id;


--
-- Name: tenant_casino_providers; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.tenant_casino_providers (
    tenant_casino_provider_id integer NOT NULL,
    master_casino_provider_id integer NOT NULL,
    master_game_aggregator_id integer NOT NULL,
    is_active boolean NOT NULL,
    thumbnail_url character varying(255),
    tenant_id integer NOT NULL,
    demo boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    order_id integer
);


ALTER TABLE casino_system.tenant_casino_providers OWNER TO postgres;

--
-- Name: tenant_casino_providers_tenant_casino_provider_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.tenant_casino_providers_tenant_casino_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.tenant_casino_providers_tenant_casino_provider_id_seq OWNER TO postgres;

--
-- Name: tenant_casino_providers_tenant_casino_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.tenant_casino_providers_tenant_casino_provider_id_seq OWNED BY casino_system.tenant_casino_providers.tenant_casino_provider_id;


--
-- Name: tenant_game_categories; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.tenant_game_categories (
    tenant_game_category_id integer NOT NULL,
    name jsonb NOT NULL,
    tenant_id integer NOT NULL,
    master_game_category_id integer,
    is_active boolean DEFAULT true,
    order_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE casino_system.tenant_game_categories OWNER TO postgres;

--
-- Name: tenant_game_categories_tenant_game_category_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.tenant_game_categories_tenant_game_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.tenant_game_categories_tenant_game_category_id_seq OWNER TO postgres;

--
-- Name: tenant_game_categories_tenant_game_category_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.tenant_game_categories_tenant_game_category_id_seq OWNED BY casino_system.tenant_game_categories.tenant_game_category_id;


--
-- Name: tenant_game_sub_categories; Type: TABLE; Schema: casino_system; Owner: postgres
--

CREATE TABLE casino_system.tenant_game_sub_categories (
    tenant_game_sub_category_id integer NOT NULL,
    name jsonb NOT NULL,
    tenant_game_category_id integer NOT NULL,
    master_game_sub_category_id integer,
    order_id integer NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image_url character varying(255),
    is_labeled_category boolean DEFAULT false,
    label_icon_url character varying(255)
);


ALTER TABLE casino_system.tenant_game_sub_categories OWNER TO postgres;

--
-- Name: tenant_game_sub_categories_tenant_game_sub_category_id_seq; Type: SEQUENCE; Schema: casino_system; Owner: postgres
--

CREATE SEQUENCE casino_system.tenant_game_sub_categories_tenant_game_sub_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE casino_system.tenant_game_sub_categories_tenant_game_sub_category_id_seq OWNER TO postgres;

--
-- Name: tenant_game_sub_categories_tenant_game_sub_category_id_seq; Type: SEQUENCE OWNED BY; Schema: casino_system; Owner: postgres
--

ALTER SEQUENCE casino_system.tenant_game_sub_categories_tenant_game_sub_category_id_seq OWNED BY casino_system.tenant_game_sub_categories.tenant_game_sub_category_id;


--
-- Name: admin_roles; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.admin_roles (
    admin_role_id integer NOT NULL,
    name character varying(255) NOT NULL,
    abbr character varying(255),
    level smallint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.admin_roles OWNER TO postgres;

--
-- Name: admin_roles_admin_role_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.admin_roles_admin_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.admin_roles_admin_role_id_seq OWNER TO postgres;

--
-- Name: admin_roles_admin_role_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.admin_roles_admin_role_id_seq OWNED BY multi_tenant_system.admin_roles.admin_role_id;


--
-- Name: admin_user_permissions; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.admin_user_permissions (
    admin_user_permission_id integer NOT NULL,
    admin_user_id integer NOT NULL,
    permission jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.admin_user_permissions OWNER TO postgres;

--
-- Name: admin_user_permissions_admin_user_permission_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.admin_user_permissions_admin_user_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.admin_user_permissions_admin_user_permission_id_seq OWNER TO postgres;

--
-- Name: admin_user_permissions_admin_user_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.admin_user_permissions_admin_user_permission_id_seq OWNED BY multi_tenant_system.admin_user_permissions.admin_user_permission_id;


--
-- Name: admin_user_settings; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.admin_user_settings (
    admin_user_setting_id integer NOT NULL,
    key character varying(255),
    value jsonb,
    admin_user_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.admin_user_settings OWNER TO postgres;

--
-- Name: admin_user_settings_admin_user_setting_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.admin_user_settings_admin_user_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.admin_user_settings_admin_user_setting_id_seq OWNER TO postgres;

--
-- Name: admin_user_settings_admin_user_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.admin_user_settings_admin_user_setting_id_seq OWNED BY multi_tenant_system.admin_user_settings.admin_user_setting_id;


--
-- Name: admin_users; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.admin_users (
    admin_user_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255),
    phone character varying(255),
    is_phone_verified boolean,
    admin_role_id integer NOT NULL,
    parent_type character varying(255) NOT NULL,
    parent_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp with time zone,
    agent_name character varying(255),
    is_active boolean DEFAULT true,
    "group" character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    auth_secret character varying(255),
    auth_url character varying(255),
    auth_enable boolean,
    tenant_ids jsonb DEFAULT '[]'::jsonb,
    owner_id integer
);


ALTER TABLE multi_tenant_system.admin_users OWNER TO postgres;

--
-- Name: admin_users_admin_user_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.admin_users_admin_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.admin_users_admin_user_id_seq OWNER TO postgres;

--
-- Name: admin_users_admin_user_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.admin_users_admin_user_id_seq OWNED BY multi_tenant_system.admin_users.admin_user_id;


--
-- Name: affiliates; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.affiliates (
    affiliate_id integer NOT NULL,
    tracking_token character varying(255),
    tenant_id integer NOT NULL,
    user_id_affiliate integer,
    user_hash_id character varying(255),
    parent_id_affiliate character varying(255),
    parent_username character varying(255),
    admin_id_affiliate integer,
    admin_username character varying(255),
    username character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    balance double precision,
    payment_type double precision,
    minimum_payment double precision,
    company character varying(255),
    dob character varying(255),
    marketing character varying(255),
    mobile character varying(255),
    skype character varying(255),
    terms_agreement character varying(255),
    website character varying(255),
    country character varying(255),
    currency character varying(255),
    status character varying(255),
    is_active boolean DEFAULT true,
    other_details jsonb,
    join_date timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    parent_name character varying(255)
);


ALTER TABLE multi_tenant_system.affiliates OWNER TO postgres;

--
-- Name: affiliates_affiliate_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.affiliates_affiliate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.affiliates_affiliate_id_seq OWNER TO postgres;

--
-- Name: affiliates_affiliate_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.affiliates_affiliate_id_seq OWNED BY multi_tenant_system.affiliates.affiliate_id;


--
-- Name: banned_players; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.banned_players (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    date_of_birth timestamp with time zone NOT NULL,
    tenant_id integer,
    admin_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.banned_players OWNER TO postgres;

--
-- Name: banned_players_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.banned_players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.banned_players_id_seq OWNER TO postgres;

--
-- Name: banned_players_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.banned_players_id_seq OWNED BY multi_tenant_system.banned_players.id;


--
-- Name: bonus; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.bonus (
    bonus_id integer NOT NULL,
    admin_id integer NOT NULL,
    tenant_id integer NOT NULL,
    parent_type character varying(255) NOT NULL,
    parent_id integer NOT NULL,
    code uuid NOT NULL,
    valid_from timestamp with time zone,
    valid_to timestamp with time zone,
    days_to_clear integer,
    promotion_title jsonb,
    bonus_type character varying(255) NOT NULL,
    term_condition jsonb,
    quantity integer,
    currency jsonb NOT NULL,
    payment_methods jsonb,
    image_url character varying(255),
    is_active boolean NOT NULL,
    deposit_bonus_percent integer DEFAULT 0,
    wagering_requirement_type character varying(255) DEFAULT 0,
    wagering_multiplier integer DEFAULT 1,
    wagering_template_id integer,
    valid_on_days jsonb,
    is_sticky boolean DEFAULT false,
    visible_in_promotions boolean DEFAULT false,
    claimed_count integer DEFAULT 0,
    applied_bonus_id integer,
    game_ids jsonb,
    description jsonb NOT NULL,
    order_id integer,
    bonus_bet_only boolean DEFAULT true,
    other jsonb,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    promotional_overview jsonb
);


ALTER TABLE multi_tenant_system.bonus OWNER TO postgres;

--
-- Name: COLUMN bonus.code; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.bonus.code IS 'unique slug';


--
-- Name: COLUMN bonus.bonus_type; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.bonus.bonus_type IS 'match- Match Bonus, balance- balance bonus, freespins- spin bonus, deposit- deposit cashback bonus, wagering- wagering cashback bonus';


--
-- Name: COLUMN bonus.wagering_requirement_type; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.bonus.wagering_requirement_type IS 'bonus:bonus, bonusdeposit:bonus+deposit';


--
-- Name: COLUMN bonus.applied_bonus_id; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.bonus.applied_bonus_id IS 'for balance bonus';


--
-- Name: bonus_bonus_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.bonus_bonus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.bonus_bonus_id_seq OWNER TO postgres;

--
-- Name: bonus_bonus_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.bonus_bonus_id_seq OWNED BY multi_tenant_system.bonus.bonus_id;


--
-- Name: cms_pages; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.cms_pages (
    cms_page_id integer NOT NULL,
    title jsonb NOT NULL,
    slug character varying(255) NOT NULL,
    content jsonb NOT NULL,
    category integer DEFAULT 1 NOT NULL,
    is_active boolean,
    admin_user_id integer,
    tenant_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    global boolean DEFAULT false NOT NULL,
    meta_title jsonb,
    meta_description jsonb,
    license_id integer
);


ALTER TABLE multi_tenant_system.cms_pages OWNER TO postgres;

--
-- Name: cms_pages_cms_page_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.cms_pages_cms_page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.cms_pages_cms_page_id_seq OWNER TO postgres;

--
-- Name: cms_pages_cms_page_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.cms_pages_cms_page_id_seq OWNED BY multi_tenant_system.cms_pages.cms_page_id;


--
-- Name: comments; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.comments (
    comment_id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    comment text NOT NULL,
    commented_by character varying(255) NOT NULL,
    status boolean DEFAULT true,
    role character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.comments OWNER TO postgres;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.comments_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.comments_comment_id_seq OWNER TO postgres;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.comments_comment_id_seq OWNED BY multi_tenant_system.comments.comment_id;


--
-- Name: credentials; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.credentials (
    credential_id integer NOT NULL,
    tenant_id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    description character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.credentials OWNER TO postgres;

--
-- Name: credentials_credential_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.credentials_credential_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.credentials_credential_id_seq OWNER TO postgres;

--
-- Name: credentials_credential_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.credentials_credential_id_seq OWNED BY multi_tenant_system.credentials.credential_id;


--
-- Name: deposit_ggr_reports; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.deposit_ggr_reports (
    id integer NOT NULL,
    license_name character varying(255),
    license_id integer,
    casino_name character varying(255),
    tenant_id integer,
    country character varying(255),
    player_type character varying(255),
    total_player_deposited integer DEFAULT 0,
    total_rounds integer DEFAULT 0,
    total_real_bets character varying(255) DEFAULT '0'::character varying,
    total_real_wins character varying(255) DEFAULT '0'::character varying,
    total_bonus_bets character varying(255) DEFAULT '0'::character varying,
    total_bonus_wins character varying(255) DEFAULT '0'::character varying,
    total_deposits character varying(255) DEFAULT '0'::character varying,
    total_ggr character varying(255) DEFAULT '0'::character varying,
    date timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.deposit_ggr_reports OWNER TO postgres;

--
-- Name: deposit_ggr_reports_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.deposit_ggr_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.deposit_ggr_reports_id_seq OWNER TO postgres;

--
-- Name: deposit_ggr_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.deposit_ggr_reports_id_seq OWNED BY multi_tenant_system.deposit_ggr_reports.id;


--
-- Name: email_logs; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.email_logs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    subject_title character varying(255) NOT NULL,
    content text NOT NULL,
    sender_email character varying(255) NOT NULL,
    sender_id integer NOT NULL,
    role character varying(255) NOT NULL,
    status character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    more_details jsonb
);


ALTER TABLE multi_tenant_system.email_logs OWNER TO postgres;

--
-- Name: email_logs_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.email_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.email_logs_id_seq OWNER TO postgres;

--
-- Name: email_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.email_logs_id_seq OWNED BY multi_tenant_system.email_logs.id;


--
-- Name: email_templates; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.email_templates (
    email_template_id integer NOT NULL,
    label character varying(255) NOT NULL,
    type integer NOT NULL,
    tenant_id integer NOT NULL,
    admin_id integer NOT NULL,
    is_primary integer NOT NULL,
    dynamic_data jsonb NOT NULL,
    template_code jsonb NOT NULL,
    is_default boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.email_templates OWNER TO postgres;

--
-- Name: email_templates_email_template_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.email_templates_email_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.email_templates_email_template_id_seq OWNER TO postgres;

--
-- Name: email_templates_email_template_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.email_templates_email_template_id_seq OWNED BY multi_tenant_system.email_templates.email_template_id;


--
-- Name: hub88_prepaids; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.hub88_prepaids (
    id bigint NOT NULL,
    name character varying(255),
    prepaid_uuid character varying(255) NOT NULL,
    game_code character varying(255) NOT NULL,
    bet_count bigint,
    bet_value bigint,
    tenant_id integer NOT NULL,
    currency character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    master_casino_game_id bigint
);


ALTER TABLE multi_tenant_system.hub88_prepaids OWNER TO postgres;

--
-- Name: hub88_prepaids_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.hub88_prepaids_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.hub88_prepaids_id_seq OWNER TO postgres;

--
-- Name: hub88_prepaids_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.hub88_prepaids_id_seq OWNED BY multi_tenant_system.hub88_prepaids.id;


--
-- Name: kpi_summary; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.kpi_summary (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    withdrawal_data jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    withdrawal_currency_wise jsonb
);


ALTER TABLE multi_tenant_system.kpi_summary OWNER TO postgres;

--
-- Name: kpi_summary_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.kpi_summary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.kpi_summary_id_seq OWNER TO postgres;

--
-- Name: kpi_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.kpi_summary_id_seq OWNED BY multi_tenant_system.kpi_summary.id;


--
-- Name: limits; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.limits (
    limit_id integer NOT NULL,
    user_id integer NOT NULL,
    time_limit integer,
    time_limit_expiry timestamp with time zone,
    time_limit_updated_at timestamp with time zone,
    daily_bet_limit integer,
    daily_bet_expiry timestamp with time zone,
    daily_bet_updated_at timestamp with time zone,
    weekly_bet_limit integer,
    weekly_bet_expiry timestamp with time zone,
    weekly_bet_updated_at timestamp with time zone,
    monthly_bet_limit integer,
    monthly_bet_expiry timestamp with time zone,
    monthly_bet_updated_at timestamp with time zone,
    daily_loss_limit integer,
    daily_loss_expiry timestamp with time zone,
    daily_loss_updated_at timestamp with time zone,
    weekly_loss_limit integer,
    weekly_loss_expiry timestamp with time zone,
    weekly_loss_updated_at timestamp with time zone,
    monthly_loss_limit integer,
    monthly_loss_expiry timestamp with time zone,
    monthly_loss_updated_at timestamp with time zone,
    daily_deposit_limit integer,
    daily_deposit_expiry timestamp with time zone,
    daily_deposit_updated_at timestamp with time zone,
    weekly_deposit_limit integer,
    weekly_deposit_expiry timestamp with time zone,
    weekly_deposit_updated_at timestamp with time zone,
    monthly_deposit_limit integer,
    monthly_deposit_expiry timestamp with time zone,
    monthly_deposit_updated_at timestamp with time zone,
    self_exclusion timestamp with time zone,
    is_self_exclusion_permanent boolean,
    self_exclusion_type character varying(255),
    self_exclusion_updated_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    reality_limit integer
);


ALTER TABLE multi_tenant_system.limits OWNER TO postgres;

--
-- Name: limits_limit_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.limits_limit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.limits_limit_id_seq OWNER TO postgres;

--
-- Name: limits_limit_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.limits_limit_id_seq OWNED BY multi_tenant_system.limits.limit_id;


--
-- Name: notification_receivers; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.notification_receivers (
    notification_receiver_id integer NOT NULL,
    receiver_type character varying(255) NOT NULL,
    receiver_id integer NOT NULL,
    notification_id integer NOT NULL,
    is_read boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.notification_receivers OWNER TO postgres;

--
-- Name: COLUMN notification_receivers.receiver_type; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.notification_receivers.receiver_type IS 'user adminUser';


--
-- Name: notification_receivers_notification_receiver_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.notification_receivers_notification_receiver_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.notification_receivers_notification_receiver_id_seq OWNER TO postgres;

--
-- Name: notification_receivers_notification_receiver_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.notification_receivers_notification_receiver_id_seq OWNED BY multi_tenant_system.notification_receivers.notification_receiver_id;


--
-- Name: notifications; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.notifications (
    notification_id integer NOT NULL,
    sender_type character varying(255) NOT NULL,
    sender_id integer NOT NULL,
    reference_type character varying(255) NOT NULL,
    reference_id integer NOT NULL,
    notification_message character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.notifications OWNER TO postgres;

--
-- Name: COLUMN notifications.sender_type; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.notifications.sender_type IS 'user adminUser';


--
-- Name: COLUMN notifications.reference_type; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.notifications.reference_type IS 'For Withdrawal request, deposit etc';


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.notifications_notification_id_seq OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.notifications_notification_id_seq OWNED BY multi_tenant_system.notifications.notification_id;


--
-- Name: nusers; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.nusers (
    user_id integer,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    is_email_verified boolean,
    password character varying(255),
    phone character varying(255),
    date_of_birth timestamp with time zone,
    gender character varying(255),
    locale character varying(255),
    sign_in_count integer,
    sign_in_ip inet,
    parent_id integer,
    username character varying(255),
    country_code character varying(255),
    tenant_id integer,
    is_active boolean,
    last_login_date timestamp with time zone,
    self_exclusion timestamp with time zone,
    self_exclusion_updated_at timestamp with time zone,
    disabled_at timestamp with time zone,
    disabled_by_type character varying(255),
    disabled_by_id integer,
    disable_reason character varying(255),
    unique_id uuid,
    phone_code character varying(255),
    new_password_key character varying(255),
    new_password_requested timestamp with time zone,
    email_token character varying(255),
    city character varying(255),
    zip_code character varying(255),
    affiliate_id integer,
    profile_image character varying(255),
    currency_code character varying(255),
    kyc_status character varying(255),
    document_labels jsonb,
    requested_documents jsonb,
    logged_in integer,
    device_type character varying(255),
    address character varying(255),
    level integer,
    loyalty_points double precision,
    tags jsonb,
    is_internal_user boolean,
    affiliate_status boolean,
    tracking_token character varying(255),
    is_affiliate_updated boolean,
    applicant_id character varying(255),
    kyc_method integer,
    sumsub_kyc_status character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    default_disable_reason character varying(255),
    banner_text jsonb,
    other jsonb,
    is_phone_verified boolean,
    license_id integer
);


ALTER TABLE multi_tenant_system.nusers OWNER TO postgres;

--
-- Name: page_banners; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.page_banners (
    page_banner_id integer NOT NULL,
    name character varying(255),
    image_url character varying(255),
    redirect_url character varying(255),
    banner_type character varying(255),
    "order" integer,
    is_active boolean,
    tenant_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.page_banners OWNER TO postgres;

--
-- Name: page_banners_page_banner_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.page_banners_page_banner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.page_banners_page_banner_id_seq OWNER TO postgres;

--
-- Name: page_banners_page_banner_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.page_banners_page_banner_id_seq OWNED BY multi_tenant_system.page_banners.page_banner_id;


--
-- Name: player_liabilty; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.player_liabilty (
    player_liabilty_id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    user_liability_data jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deposit_data jsonb,
    conversion_rates jsonb
);


ALTER TABLE multi_tenant_system.player_liabilty OWNER TO postgres;

--
-- Name: player_liabilty_player_liabilty_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.player_liabilty_player_liabilty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.player_liabilty_player_liabilty_id_seq OWNER TO postgres;

--
-- Name: player_liabilty_player_liabilty_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.player_liabilty_player_liabilty_id_seq OWNED BY multi_tenant_system.player_liabilty.player_liabilty_id;


--
-- Name: reviews; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.reviews (
    review_id integer NOT NULL,
    user_name character varying(255) NOT NULL,
    description text NOT NULL,
    rating double precision NOT NULL,
    status boolean NOT NULL,
    tenant_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.reviews OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.reviews_review_id_seq OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.reviews_review_id_seq OWNED BY multi_tenant_system.reviews.review_id;


--
-- Name: tenant_configurations; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tenant_configurations (
    tenant_configuration_id integer NOT NULL,
    tenant_id integer,
    allowed_currencies jsonb,
    loyalty_level jsonb,
    loyalty_point jsonb,
    allowed_languages jsonb,
    banner_url jsonb,
    logo_url character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    banned_games_list_id integer DEFAULT 1,
    payment_categories jsonb DEFAULT '{"deposit": ["CREDITCARD", "WALLET", "CRYPTO", "OTHER", "INSTANTBANKING", "VOUCHER"], "withdraw": ["CREDITCARD", "WALLET", "CRYPTO", "OTHER", "INSTANTBANKING", "VOUCHER"]}'::jsonb NOT NULL,
    banners jsonb,
    aml_settings jsonb,
    rg_details jsonb,
    reality_setting jsonb,
    aggregator_ids jsonb,
    exchange_rates jsonb,
    affiliate_integrated character varying(255),
    affiliate_keys jsonb,
    sumsub_countries jsonb,
    in_active_countries jsonb,
    phone_verification boolean DEFAULT false,
    in_active_aggregators jsonb,
    piq_errors jsonb,
    ban_player_setting boolean DEFAULT false,
    kyc_settings jsonb,
    duplicate_user boolean DEFAULT false NOT NULL,
    country_names jsonb,
    redirection_config jsonb
);


ALTER TABLE multi_tenant_system.tenant_configurations OWNER TO postgres;

--
-- Name: tenant_configurations_tenant_configuration_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tenant_configurations_tenant_configuration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tenant_configurations_tenant_configuration_id_seq OWNER TO postgres;

--
-- Name: tenant_configurations_tenant_configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tenant_configurations_tenant_configuration_id_seq OWNED BY multi_tenant_system.tenant_configurations.tenant_configuration_id;


--
-- Name: tenant_gallery; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tenant_gallery (
    tenant_image_id integer NOT NULL,
    tenant_id integer NOT NULL,
    name character varying(255) NOT NULL,
    image_url character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    image_bucket_type character varying(255) DEFAULT 'admin'::character varying NOT NULL
);


ALTER TABLE multi_tenant_system.tenant_gallery OWNER TO postgres;

--
-- Name: tenant_gallery_tenant_image_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tenant_gallery_tenant_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tenant_gallery_tenant_image_id_seq OWNER TO postgres;

--
-- Name: tenant_gallery_tenant_image_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tenant_gallery_tenant_image_id_seq OWNED BY multi_tenant_system.tenant_gallery.tenant_image_id;


--
-- Name: tenant_multi_licenses; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tenant_multi_licenses (
    id integer NOT NULL,
    license_no character varying(255),
    tenant_id integer NOT NULL,
    name character varying(255),
    cred_details jsonb,
    description character varying(255),
    is_active boolean DEFAULT true,
    country_codes jsonb,
    html text,
    script text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    parent_license_id integer,
    is_default boolean
);


ALTER TABLE multi_tenant_system.tenant_multi_licenses OWNER TO postgres;

--
-- Name: tenant_multi_licenses_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tenant_multi_licenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tenant_multi_licenses_id_seq OWNER TO postgres;

--
-- Name: tenant_multi_licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tenant_multi_licenses_id_seq OWNED BY multi_tenant_system.tenant_multi_licenses.id;


--
-- Name: tenant_registrations; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tenant_registrations (
    tenant_registration_id integer NOT NULL,
    tenant_id integer NOT NULL,
    email integer DEFAULT 2 NOT NULL,
    password integer DEFAULT 2 NOT NULL,
    confirm_password integer DEFAULT 2 NOT NULL,
    username integer DEFAULT 0 NOT NULL,
    first_name integer DEFAULT 2 NOT NULL,
    last_name integer DEFAULT 2 NOT NULL,
    date_of_birth integer DEFAULT 2 NOT NULL,
    address integer DEFAULT 2 NOT NULL,
    phone integer DEFAULT 0 NOT NULL,
    gender integer DEFAULT 2 NOT NULL,
    preferred_language integer DEFAULT 0 NOT NULL,
    country_code integer DEFAULT 2 NOT NULL,
    news_letter integer DEFAULT 0 NOT NULL,
    currency_code integer DEFAULT 2 NOT NULL,
    sms integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    newsletter_and_sms integer DEFAULT 0 NOT NULL
);


ALTER TABLE multi_tenant_system.tenant_registrations OWNER TO postgres;

--
-- Name: tenant_registrations_tenant_registration_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tenant_registrations_tenant_registration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tenant_registrations_tenant_registration_id_seq OWNER TO postgres;

--
-- Name: tenant_registrations_tenant_registration_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tenant_registrations_tenant_registration_id_seq OWNED BY multi_tenant_system.tenant_registrations.tenant_registration_id;


--
-- Name: tenant_theme_settings; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tenant_theme_settings (
    tenant_theme_setting_id integer NOT NULL,
    tenant_id integer NOT NULL,
    language_id integer,
    theme_attr jsonb,
    logo_url character varying(255),
    theme_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.tenant_theme_settings OWNER TO postgres;

--
-- Name: COLUMN tenant_theme_settings.theme_attr; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.tenant_theme_settings.theme_attr IS 'custom parameters for theme(if any)';


--
-- Name: COLUMN tenant_theme_settings.theme_id; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.tenant_theme_settings.theme_id IS 'if use predefined theme, then id will store else null';


--
-- Name: tenant_theme_settings_tenant_theme_setting_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tenant_theme_settings_tenant_theme_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tenant_theme_settings_tenant_theme_setting_id_seq OWNER TO postgres;

--
-- Name: tenant_theme_settings_tenant_theme_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tenant_theme_settings_tenant_theme_setting_id_seq OWNED BY multi_tenant_system.tenant_theme_settings.tenant_theme_setting_id;


--
-- Name: tenants; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tenants (
    tenant_id integer NOT NULL,
    name character varying(255),
    domain character varying(255),
    is_active boolean DEFAULT true,
    primary_currency character varying(255),
    super_admin_user_id integer,
    admin_user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.tenants OWNER TO postgres;

--
-- Name: COLUMN tenants.primary_currency; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.tenants.primary_currency IS 'currency code';


--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tenants_tenant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tenants_tenant_id_seq OWNER TO postgres;

--
-- Name: tenants_tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tenants_tenant_id_seq OWNED BY multi_tenant_system.tenants.tenant_id;


--
-- Name: tournament; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.tournament (
    tournament_id integer NOT NULL,
    title character varying(255) NOT NULL,
    start_at timestamp with time zone NOT NULL,
    end_at timestamp with time zone NOT NULL,
    prizes jsonb,
    currency character varying(255) NOT NULL,
    banner_url character varying(255),
    is_active boolean DEFAULT true,
    description text NOT NULL,
    games jsonb NOT NULL,
    leader_board_url character varying(255),
    countries jsonb,
    min_bet_amount double precision,
    payouts character varying(255),
    tournament_mechanics character varying(255),
    accepted_currencies jsonb NOT NULL,
    leader_board_id character varying(255) NOT NULL,
    rules text NOT NULL,
    prize_pool jsonb,
    prize_places character varying(255),
    admin_id integer NOT NULL,
    tenant_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.tournament OWNER TO postgres;

--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.tournament_tournament_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.tournament_tournament_id_seq OWNER TO postgres;

--
-- Name: tournament_tournament_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.tournament_tournament_id_seq OWNED BY multi_tenant_system.tournament.tournament_id;


--
-- Name: transaction_affiliates; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.transaction_affiliates (
    transaction_affiliate_id integer NOT NULL,
    affiliate_id integer NOT NULL,
    currency_code character varying(255) NOT NULL,
    amount double precision NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    admin_user_id integer NOT NULL,
    payment_details jsonb,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.transaction_affiliates OWNER TO postgres;

--
-- Name: transaction_affiliates_transaction_affiliate_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.transaction_affiliates_transaction_affiliate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.transaction_affiliates_transaction_affiliate_id_seq OWNER TO postgres;

--
-- Name: transaction_affiliates_transaction_affiliate_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.transaction_affiliates_transaction_affiliate_id_seq OWNED BY multi_tenant_system.transaction_affiliates.transaction_affiliate_id;


--
-- Name: transaction_bankings; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.transaction_bankings (
    transaction_banking_id integer NOT NULL,
    actionee_type character varying(255),
    actionee_id integer,
    actionee_email character varying(255),
    actionee_name character varying(255),
    target_id integer,
    wallet_id integer,
    currency_code character varying(255),
    conversion_rate double precision,
    primary_currency_amount double precision,
    amount_type integer,
    amount double precision,
    before_balance double precision,
    payment_provider character varying(255),
    status integer,
    tenant_id integer,
    country_code character varying(255) NOT NULL,
    admin_id integer NOT NULL,
    transaction_id uuid,
    transaction_date_time character varying(255),
    transaction_type character varying(255),
    is_success boolean,
    error_description character varying(255),
    payment_method character varying(255),
    payment_transaction_id character varying(255),
    payment_transaction_name character varying(255),
    more_details jsonb,
    is_first_deposit boolean DEFAULT false NOT NULL,
    elastic_updated boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.transaction_bankings OWNER TO postgres;

--
-- Name: transaction_bankings_transaction_banking_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.transaction_bankings_transaction_banking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.transaction_bankings_transaction_banking_id_seq OWNER TO postgres;

--
-- Name: transaction_bankings_transaction_banking_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.transaction_bankings_transaction_banking_id_seq OWNED BY multi_tenant_system.transaction_bankings.transaction_banking_id;


--
-- Name: unique_user_identification; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.unique_user_identification (
    unique_user_identification_id integer NOT NULL,
    tenant_id integer NOT NULL,
    admin_id integer NOT NULL,
    unique_key character varying(255) NOT NULL,
    user_id integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.unique_user_identification OWNER TO postgres;

--
-- Name: unique_user_identification_unique_user_identification_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.unique_user_identification_unique_user_identification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.unique_user_identification_unique_user_identification_id_seq OWNER TO postgres;

--
-- Name: unique_user_identification_unique_user_identification_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.unique_user_identification_unique_user_identification_id_seq OWNED BY multi_tenant_system.unique_user_identification.unique_user_identification_id;


--
-- Name: user_action_trail; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.user_action_trail (
    id integer NOT NULL,
    user_id integer,
    admin_id integer,
    name character varying(255) NOT NULL,
    role integer DEFAULT 1 NOT NULL,
    action character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    before_value text,
    after_value text
);


ALTER TABLE multi_tenant_system.user_action_trail OWNER TO postgres;

--
-- Name: user-action-trail_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system."user-action-trail_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system."user-action-trail_id_seq" OWNER TO postgres;

--
-- Name: user-action-trail_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system."user-action-trail_id_seq" OWNED BY multi_tenant_system.user_action_trail.id;


--
-- Name: user_affiliates; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.user_affiliates (
    id integer NOT NULL,
    user_id integer NOT NULL,
    fields jsonb,
    is_checked boolean NOT NULL,
    tenant_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.user_affiliates OWNER TO postgres;

--
-- Name: user_affiliates_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.user_affiliates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.user_affiliates_id_seq OWNER TO postgres;

--
-- Name: user_affiliates_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.user_affiliates_id_seq OWNED BY multi_tenant_system.user_affiliates.id;


--
-- Name: user_bonus; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.user_bonus (
    user_bonus_id integer NOT NULL,
    bonus_id integer NOT NULL,
    user_id integer NOT NULL,
    bonus_type character varying(255) NOT NULL,
    free_spins_qty integer,
    bonus_amount double precision DEFAULT '0'::double precision,
    amount_to_wager double precision,
    wagered_amount double precision,
    wagering_status character varying(255),
    transaction_id character varying(255),
    status character varying(255),
    claimed_at timestamp with time zone,
    expire_at timestamp with time zone,
    issuer_id integer,
    issuer_role character varying(255),
    games jsonb,
    cash_amount double precision,
    amount_converted double precision,
    primary_currency_amount double precision DEFAULT '0'::double precision,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    unique_id uuid,
    bet_level integer,
    cancelled_by character varying(255),
    other jsonb
);


ALTER TABLE multi_tenant_system.user_bonus OWNER TO postgres;

--
-- Name: user_bonus_user_bonus_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.user_bonus_user_bonus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.user_bonus_user_bonus_id_seq OWNER TO postgres;

--
-- Name: user_bonus_user_bonus_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.user_bonus_user_bonus_id_seq OWNED BY multi_tenant_system.user_bonus.user_bonus_id;


--
-- Name: user_documents; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.user_documents (
    user_document_id integer NOT NULL,
    user_id integer,
    document_url jsonb,
    document_name character varying(255),
    status smallint DEFAULT 0 NOT NULL,
    actionee character varying(255),
    action_performed_at timestamp with time zone,
    reason text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    actionee_type character varying(255)
);


ALTER TABLE multi_tenant_system.user_documents OWNER TO postgres;

--
-- Name: COLUMN user_documents.document_url; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.user_documents.document_url IS 's3 urls';


--
-- Name: COLUMN user_documents.status; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.user_documents.status IS '0- pending, 1-Approved, 2-Rejected';


--
-- Name: COLUMN user_documents.reason; Type: COMMENT; Schema: multi_tenant_system; Owner: postgres
--

COMMENT ON COLUMN multi_tenant_system.user_documents.reason IS 'reason for rejection if rejected';


--
-- Name: user_documents_user_document_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.user_documents_user_document_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.user_documents_user_document_id_seq OWNER TO postgres;

--
-- Name: user_documents_user_document_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.user_documents_user_document_id_seq OWNED BY multi_tenant_system.user_documents.user_document_id;


--
-- Name: user_login_session; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.user_login_session (
    id integer NOT NULL,
    user_id integer NOT NULL,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    session_end_reason character varying(255),
    start_cash_balance double precision,
    end_cash_balance double precision,
    start_non_cash_balance double precision,
    end_non_cash_balance double precision,
    game_round integer,
    game_sessions integer,
    total_bet_amount double precision,
    total_win_amount double precision,
    max_bet_cash_amount double precision,
    max_bet_non_cash_amount double precision,
    browser_type character varying(255),
    os_type character varying(255),
    device_type character varying(255),
    ip inet,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.user_login_session OWNER TO postgres;

--
-- Name: user_login_session_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.user_login_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.user_login_session_id_seq OWNER TO postgres;

--
-- Name: user_login_session_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.user_login_session_id_seq OWNED BY multi_tenant_system.user_login_session.id;


--
-- Name: users; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.users (
    user_id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    is_email_verified boolean DEFAULT false,
    password character varying(255) NOT NULL,
    phone character varying(255),
    date_of_birth timestamp with time zone NOT NULL,
    gender character varying(255),
    locale character varying(255),
    sign_in_count integer DEFAULT 0 NOT NULL,
    sign_in_ip inet,
    parent_id integer,
    username character varying(255) NOT NULL,
    country_code character varying(255) NOT NULL,
    tenant_id integer NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    last_login_date timestamp with time zone,
    self_exclusion timestamp with time zone,
    self_exclusion_updated_at timestamp with time zone,
    disabled_at timestamp with time zone,
    disabled_by_type character varying(255),
    disabled_by_id integer,
    disable_reason character varying(255),
    unique_id uuid,
    phone_code character varying(255),
    new_password_key character varying(255),
    new_password_requested timestamp with time zone,
    email_token character varying(255),
    city character varying(255),
    zip_code character varying(255),
    affiliate_id integer,
    profile_image character varying(255),
    currency_code character varying(255) NOT NULL,
    kyc_status character varying(255),
    document_labels jsonb,
    requested_documents jsonb,
    logged_in integer DEFAULT 0 NOT NULL,
    device_type character varying(255),
    address character varying(255) NOT NULL,
    level integer DEFAULT 1 NOT NULL,
    loyalty_points double precision DEFAULT '0'::double precision NOT NULL,
    tags jsonb,
    is_internal_user boolean DEFAULT false NOT NULL,
    affiliate_status boolean DEFAULT false NOT NULL,
    tracking_token character varying(255) DEFAULT NULL::character varying,
    is_affiliate_updated boolean,
    applicant_id character varying(255),
    kyc_method integer,
    sumsub_kyc_status character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    default_disable_reason character varying(255),
    banner_text jsonb,
    other jsonb,
    is_phone_verified boolean DEFAULT false,
    license_id integer,
    is_streamer_user boolean DEFAULT false
);


ALTER TABLE multi_tenant_system.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.users_user_id_seq OWNED BY multi_tenant_system.users.user_id;


--
-- Name: wagering_templates; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.wagering_templates (
    wagering_template_id integer NOT NULL,
    name character varying(255) NOT NULL,
    parent_type character varying(255),
    parent_id integer,
    game_contribution jsonb,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.wagering_templates OWNER TO postgres;

--
-- Name: wagering_templates_wagering_template_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.wagering_templates_wagering_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.wagering_templates_wagering_template_id_seq OWNER TO postgres;

--
-- Name: wagering_templates_wagering_template_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.wagering_templates_wagering_template_id_seq OWNED BY multi_tenant_system.wagering_templates.wagering_template_id;


--
-- Name: wallets; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.wallets (
    wallet_id integer NOT NULL,
    amount double precision DEFAULT '0'::double precision,
    currency_code character varying(255) NOT NULL,
    owner_id integer,
    non_cash_amount double precision DEFAULT '0'::double precision,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE multi_tenant_system.wallets OWNER TO postgres;

--
-- Name: wallets_wallet_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.wallets_wallet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.wallets_wallet_id_seq OWNER TO postgres;

--
-- Name: wallets_wallet_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.wallets_wallet_id_seq OWNED BY multi_tenant_system.wallets.wallet_id;


--
-- Name: withdraw_requests; Type: TABLE; Schema: multi_tenant_system; Owner: postgres
--

CREATE TABLE multi_tenant_system.withdraw_requests (
    withdraw_request_id integer NOT NULL,
    user_id integer,
    status integer,
    name character varying(255),
    email character varying(255) NOT NULL,
    amount double precision,
    transaction_id character varying(255),
    actionable_type character varying(255),
    actionable_id integer,
    actioned_at timestamp with time zone,
    tenant_id integer NOT NULL,
    payment_provider character varying(255) NOT NULL,
    payment_aggregator character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    more_details jsonb
);


ALTER TABLE multi_tenant_system.withdraw_requests OWNER TO postgres;

--
-- Name: withdraw_requests_withdraw_request_id_seq; Type: SEQUENCE; Schema: multi_tenant_system; Owner: postgres
--

CREATE SEQUENCE multi_tenant_system.withdraw_requests_withdraw_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE multi_tenant_system.withdraw_requests_withdraw_request_id_seq OWNER TO postgres;

--
-- Name: withdraw_requests_withdraw_request_id_seq; Type: SEQUENCE OWNED BY; Schema: multi_tenant_system; Owner: postgres
--

ALTER SEQUENCE multi_tenant_system.withdraw_requests_withdraw_request_id_seq OWNED BY multi_tenant_system.withdraw_requests.withdraw_request_id;


--
-- Name: template_casino_system_casino_transactions; Type: TABLE; Schema: partman; Owner: postgres
--

CREATE TABLE partman.template_casino_system_casino_transactions (
    casino_transaction_id bigint NOT NULL,
    transaction_id uuid,
    tenant_id integer,
    user_id integer NOT NULL,
    action_type character varying(255),
    action_id character varying(255),
    amount double precision,
    game_identifier character varying(255),
    game_id character varying(255),
    wallet_id integer,
    non_cash_amount double precision,
    status integer,
    admin_id integer,
    currency_code character varying(255) NOT NULL,
    before_balance double precision,
    after_balance double precision,
    primary_currency_amount double precision,
    amount_type integer,
    elastic_updated boolean NOT NULL,
    conversion_rate double precision,
    is_sticky boolean,
    user_bonus_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE partman.template_casino_system_casino_transactions OWNER TO postgres;

--
-- Name: banned_games_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banned_games_list (
    banned_games_list_id integer NOT NULL,
    name character varying(255) NOT NULL,
    parent_type character varying(255) NOT NULL,
    parent_id integer NOT NULL,
    games text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    affiliate_ids jsonb,
    max_bet_allowed integer,
    tenant_id integer,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.banned_games_list OWNER TO postgres;

--
-- Name: banned_games_list_banned_games_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banned_games_list_banned_games_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banned_games_list_banned_games_list_id_seq OWNER TO postgres;

--
-- Name: banned_games_list_banned_games_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banned_games_list_banned_games_list_id_seq OWNED BY public.banned_games_list.banned_games_list_id;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_id integer NOT NULL,
    code character varying(255) NOT NULL,
    name jsonb NOT NULL,
    status boolean DEFAULT true,
    kyc_method integer DEFAULT 0 NOT NULL,
    restricted_providers jsonb,
    restricted_games jsonb,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    language_id integer
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.countries_country_id_seq OWNER TO postgres;

--
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_country_id_seq OWNED BY public.countries.country_id;


--
-- Name: credentials_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credentials_keys (
    credential_key_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.credentials_keys OWNER TO postgres;

--
-- Name: credentials_keys_credential_key_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credentials_keys_credential_key_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credentials_keys_credential_key_id_seq OWNER TO postgres;

--
-- Name: credentials_keys_credential_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credentials_keys_credential_key_id_seq OWNED BY public.credentials_keys.credential_key_id;


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currencies (
    currency_id integer NOT NULL,
    name character varying(255) NOT NULL,
    type integer NOT NULL,
    code character varying(255) NOT NULL,
    is_primary boolean DEFAULT false,
    exchange_rate numeric NOT NULL,
    symbol character varying(255) NOT NULL,
    loyalty_point double precision NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.currencies OWNER TO postgres;

--
-- Name: currencies_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.currencies_currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currencies_currency_id_seq OWNER TO postgres;

--
-- Name: currencies_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.currencies_currency_id_seq OWNED BY public.currencies.currency_id;


--
-- Name: document_labels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_labels (
    document_label_id integer NOT NULL,
    name jsonb NOT NULL,
    is_required boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.document_labels OWNER TO postgres;

--
-- Name: document_labels_document_label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.document_labels_document_label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_labels_document_label_id_seq OWNER TO postgres;

--
-- Name: document_labels_document_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.document_labels_document_label_id_seq OWNED BY public.document_labels.document_label_id;


--
-- Name: global_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.global_settings (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.global_settings OWNER TO postgres;

--
-- Name: group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_permissions (
    id integer NOT NULL,
    admin_id integer,
    role integer DEFAULT 1 NOT NULL,
    group_name character varying(255) NOT NULL,
    permissions jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    parent_group_id integer
);


ALTER TABLE public.group_permissions OWNER TO postgres;

--
-- Name: group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_permissions_id_seq OWNER TO postgres;

--
-- Name: group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.group_permissions_id_seq OWNED BY public.group_permissions.id;


--
-- Name: languages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.languages (
    language_id integer NOT NULL,
    code character varying(255) NOT NULL,
    language_name character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.languages OWNER TO postgres;

--
-- Name: languages_language_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.languages_language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.languages_language_id_seq OWNER TO postgres;

--
-- Name: languages_language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.languages_language_id_seq OWNED BY public.languages.language_id;


--
-- Name: licenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.licenses (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    deposit_limit_exclusion boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.licenses OWNER TO postgres;

--
-- Name: licenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.licenses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.licenses_id_seq OWNER TO postgres;

--
-- Name: licenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.licenses_id_seq OWNED BY public.licenses.id;


--
-- Name: multi_language_support; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.multi_language_support (
    multi_language_support_id integer NOT NULL,
    tenant_id integer,
    language character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    data jsonb,
    license_id integer
);


ALTER TABLE public.multi_language_support OWNER TO postgres;

--
-- Name: multi_language_support_multi_language_support_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.multi_language_support_multi_language_support_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.multi_language_support_multi_language_support_id_seq OWNER TO postgres;

--
-- Name: multi_language_support_multi_language_support_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.multi_language_support_multi_language_support_id_seq OWNED BY public.multi_language_support.multi_language_support_id;


--
-- Name: new_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.new_users (
    user_id integer,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    is_email_verified boolean,
    password character varying(255),
    phone character varying(255),
    date_of_birth timestamp with time zone,
    gender character varying(255),
    locale character varying(255),
    sign_in_count integer,
    sign_in_ip inet,
    parent_id integer,
    username character varying(255),
    country_code character varying(255),
    tenant_id integer,
    is_active boolean,
    last_login_date timestamp with time zone,
    self_exclusion timestamp with time zone,
    self_exclusion_updated_at timestamp with time zone,
    disabled_at timestamp with time zone,
    disabled_by_type character varying(255),
    disabled_by_id integer,
    disable_reason character varying(255),
    unique_id uuid,
    phone_code character varying(255),
    new_password_key character varying(255),
    new_password_requested timestamp with time zone,
    email_token character varying(255),
    city character varying(255),
    zip_code character varying(255),
    affiliate_id integer,
    profile_image character varying(255),
    currency_code character varying(255),
    kyc_status character varying(255),
    document_labels jsonb,
    requested_documents jsonb,
    logged_in integer,
    device_type character varying(255),
    address character varying(255),
    level integer,
    loyalty_points double precision,
    tags jsonb,
    is_internal_user boolean,
    affiliate_status boolean,
    tracking_token character varying(255),
    is_affiliate_updated boolean,
    applicant_id character varying(255),
    kyc_method integer,
    sumsub_kyc_status character varying(255),
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    default_disable_reason character varying(255),
    banner_text jsonb,
    other jsonb,
    is_phone_verified boolean,
    license_id integer,
    is_streamer_user boolean
);


ALTER TABLE public.new_users OWNER TO postgres;

--
-- Name: parent_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parent_groups (
    id integer NOT NULL,
    parent_group_name character varying(255) NOT NULL,
    admin_id integer,
    role integer DEFAULT 1 NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.parent_groups OWNER TO postgres;

--
-- Name: parent_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parent_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parent_groups_id_seq OWNER TO postgres;

--
-- Name: parent_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parent_groups_id_seq OWNED BY public.parent_groups.id;


--
-- Name: payment_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_providers (
    payment_provider_id integer NOT NULL,
    display_name character varying(255),
    name character varying(255),
    "group" character varying(255),
    settings jsonb,
    supports_deposit boolean,
    supports_withdrawal boolean,
    regions jsonb,
    aggregator character varying(255),
    deposit_is_active boolean,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    category character varying(255),
    amount_keys jsonb DEFAULT '"{\"button1\":20,\"button2\":50,\"button3\":100,\"button4\":500,\"button5\":1000,\"button6\":\"Other\"}"'::jsonb,
    kyc_countries jsonb,
    reporting_name character varying(255),
    tenant_id integer DEFAULT 1,
    withdraw_order_id integer,
    deposit_order_id integer,
    withdraw_is_active boolean DEFAULT false NOT NULL,
    currencies jsonb,
    aggregator_status boolean DEFAULT true NOT NULL,
    provider_order jsonb,
    affiliate_ids jsonb
);


ALTER TABLE public.payment_providers OWNER TO postgres;

--
-- Name: payment_providers_payment_provider_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_providers_payment_provider_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_providers_payment_provider_id_seq OWNER TO postgres;

--
-- Name: payment_providers_payment_provider_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_providers_payment_provider_id_seq OWNED BY public.payment_providers.payment_provider_id;


--
-- Name: sequelize_migration_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sequelize_migration_meta (
    name character varying(255) NOT NULL
);


ALTER TABLE public.sequelize_migration_meta OWNER TO postgres;

--
-- Name: sequelize_seed_meta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sequelize_seed_meta (
    name character varying(255) NOT NULL
);


ALTER TABLE public.sequelize_seed_meta OWNER TO postgres;

--
-- Name: super_admin_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.super_admin_roles (
    super_role_id integer NOT NULL,
    name character varying(255),
    abbr character varying(255),
    level smallint,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.super_admin_roles OWNER TO postgres;

--
-- Name: super_admin_roles_super_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.super_admin_roles_super_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.super_admin_roles_super_role_id_seq OWNER TO postgres;

--
-- Name: super_admin_roles_super_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.super_admin_roles_super_role_id_seq OWNED BY public.super_admin_roles.super_role_id;


--
-- Name: super_admin_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.super_admin_user_permissions (
    super_admin_user_permission_id integer NOT NULL,
    super_admin_user_id integer NOT NULL,
    permission jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.super_admin_user_permissions OWNER TO postgres;

--
-- Name: super_admin_user_permissions_super_admin_user_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.super_admin_user_permissions_super_admin_user_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.super_admin_user_permissions_super_admin_user_permission_id_seq OWNER TO postgres;

--
-- Name: super_admin_user_permissions_super_admin_user_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.super_admin_user_permissions_super_admin_user_permission_id_seq OWNED BY public.super_admin_user_permissions.super_admin_user_permission_id;


--
-- Name: super_admin_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.super_admin_users (
    super_admin_user_id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp with time zone,
    super_role_id integer NOT NULL,
    parent_id integer,
    is_active boolean,
    super_admin_username character varying(255) NOT NULL,
    "group" character varying(255),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    auth_secret character varying(255),
    auth_url character varying(255),
    auth_enable boolean
);


ALTER TABLE public.super_admin_users OWNER TO postgres;

--
-- Name: super_admin_users_super_admin_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.super_admin_users_super_admin_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.super_admin_users_super_admin_user_id_seq OWNER TO postgres;

--
-- Name: super_admin_users_super_admin_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.super_admin_users_super_admin_user_id_seq OWNED BY public.super_admin_users.super_admin_user_id;


--
-- Name: themes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.themes (
    theme_id integer NOT NULL,
    theme_name character varying(255),
    theme_mode character varying(255) NOT NULL,
    primary_color character varying(255) NOT NULL,
    secondary_color character varying(255) NOT NULL,
    theme_options jsonb,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.themes OWNER TO postgres;

--
-- Name: themes_theme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.themes_theme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.themes_theme_id_seq OWNER TO postgres;

--
-- Name: themes_theme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.themes_theme_id_seq OWNED BY public.themes.theme_id;


--
-- Name: whitelisted_domains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.whitelisted_domains (
    id integer NOT NULL,
    domains json DEFAULT '[]'::json NOT NULL,
    admin_id integer,
    role integer,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.whitelisted_domains OWNER TO postgres;

--
-- Name: whitelisted_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.whitelisted_domains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.whitelisted_domains_id_seq OWNER TO postgres;

--
-- Name: whitelisted_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.whitelisted_domains_id_seq OWNED BY public.whitelisted_domains.id;


--
-- Name: casino_transactions_a casino_transaction_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.casino_transactions_a ALTER COLUMN casino_transaction_id SET DEFAULT nextval('casino_system.casino_transactions_casino_transaction_id_seq'::regclass);


--
-- Name: category_games category_game_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.category_games ALTER COLUMN category_game_id SET DEFAULT nextval('casino_system.category_games_category_game_id_seq'::regclass);


--
-- Name: daily_cumulative_report daily_cumulative_report_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.daily_cumulative_report ALTER COLUMN daily_cumulative_report_id SET DEFAULT nextval('casino_system.daily_cumulative_report_daily_cumulative_report_id_seq'::regclass);


--
-- Name: favorite_games favorite_game_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.favorite_games ALTER COLUMN favorite_game_id SET DEFAULT nextval('casino_system.favorite_games_favorite_game_id_seq'::regclass);


--
-- Name: game_aggregator_categories game_aggregator_category_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.game_aggregator_categories ALTER COLUMN game_aggregator_category_id SET DEFAULT nextval('casino_system.game_aggregator_categories_game_aggregator_category_id_seq'::regclass);


--
-- Name: master_casino_games master_casino_game_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_casino_games ALTER COLUMN master_casino_game_id SET DEFAULT nextval('casino_system.master_casino_games_master_casino_game_id_seq'::regclass);


--
-- Name: master_casino_providers master_casino_provider_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_casino_providers ALTER COLUMN master_casino_provider_id SET DEFAULT nextval('casino_system.master_casino_providers_master_casino_provider_id_seq'::regclass);


--
-- Name: master_game_aggregators master_game_aggregator_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_game_aggregators ALTER COLUMN master_game_aggregator_id SET DEFAULT nextval('casino_system.master_game_aggregators_master_game_aggregator_id_seq'::regclass);


--
-- Name: master_game_categories master_game_category_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_game_categories ALTER COLUMN master_game_category_id SET DEFAULT nextval('casino_system.master_game_categories_master_game_category_id_seq'::regclass);


--
-- Name: master_game_sub_categories master_game_sub_category_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_game_sub_categories ALTER COLUMN master_game_sub_category_id SET DEFAULT nextval('casino_system.master_game_sub_categories_master_game_sub_category_id_seq'::regclass);


--
-- Name: tenant_casino_providers tenant_casino_provider_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_casino_providers ALTER COLUMN tenant_casino_provider_id SET DEFAULT nextval('casino_system.tenant_casino_providers_tenant_casino_provider_id_seq'::regclass);


--
-- Name: tenant_game_categories tenant_game_category_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_game_categories ALTER COLUMN tenant_game_category_id SET DEFAULT nextval('casino_system.tenant_game_categories_tenant_game_category_id_seq'::regclass);


--
-- Name: tenant_game_sub_categories tenant_game_sub_category_id; Type: DEFAULT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_game_sub_categories ALTER COLUMN tenant_game_sub_category_id SET DEFAULT nextval('casino_system.tenant_game_sub_categories_tenant_game_sub_category_id_seq'::regclass);


--
-- Name: admin_roles admin_role_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_roles ALTER COLUMN admin_role_id SET DEFAULT nextval('multi_tenant_system.admin_roles_admin_role_id_seq'::regclass);


--
-- Name: admin_user_permissions admin_user_permission_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_user_permissions ALTER COLUMN admin_user_permission_id SET DEFAULT nextval('multi_tenant_system.admin_user_permissions_admin_user_permission_id_seq'::regclass);


--
-- Name: admin_user_settings admin_user_setting_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_user_settings ALTER COLUMN admin_user_setting_id SET DEFAULT nextval('multi_tenant_system.admin_user_settings_admin_user_setting_id_seq'::regclass);


--
-- Name: admin_users admin_user_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_users ALTER COLUMN admin_user_id SET DEFAULT nextval('multi_tenant_system.admin_users_admin_user_id_seq'::regclass);


--
-- Name: affiliates affiliate_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.affiliates ALTER COLUMN affiliate_id SET DEFAULT nextval('multi_tenant_system.affiliates_affiliate_id_seq'::regclass);


--
-- Name: banned_players id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.banned_players ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.banned_players_id_seq'::regclass);


--
-- Name: bonus bonus_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.bonus ALTER COLUMN bonus_id SET DEFAULT nextval('multi_tenant_system.bonus_bonus_id_seq'::regclass);


--
-- Name: cms_pages cms_page_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.cms_pages ALTER COLUMN cms_page_id SET DEFAULT nextval('multi_tenant_system.cms_pages_cms_page_id_seq'::regclass);


--
-- Name: comments comment_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.comments ALTER COLUMN comment_id SET DEFAULT nextval('multi_tenant_system.comments_comment_id_seq'::regclass);


--
-- Name: credentials credential_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.credentials ALTER COLUMN credential_id SET DEFAULT nextval('multi_tenant_system.credentials_credential_id_seq'::regclass);


--
-- Name: deposit_ggr_reports id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.deposit_ggr_reports ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.deposit_ggr_reports_id_seq'::regclass);


--
-- Name: email_logs id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.email_logs ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.email_logs_id_seq'::regclass);


--
-- Name: email_templates email_template_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.email_templates ALTER COLUMN email_template_id SET DEFAULT nextval('multi_tenant_system.email_templates_email_template_id_seq'::regclass);


--
-- Name: hub88_prepaids id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.hub88_prepaids ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.hub88_prepaids_id_seq'::regclass);


--
-- Name: kpi_summary id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.kpi_summary ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.kpi_summary_id_seq'::regclass);


--
-- Name: limits limit_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.limits ALTER COLUMN limit_id SET DEFAULT nextval('multi_tenant_system.limits_limit_id_seq'::regclass);


--
-- Name: notification_receivers notification_receiver_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.notification_receivers ALTER COLUMN notification_receiver_id SET DEFAULT nextval('multi_tenant_system.notification_receivers_notification_receiver_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.notifications ALTER COLUMN notification_id SET DEFAULT nextval('multi_tenant_system.notifications_notification_id_seq'::regclass);


--
-- Name: page_banners page_banner_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.page_banners ALTER COLUMN page_banner_id SET DEFAULT nextval('multi_tenant_system.page_banners_page_banner_id_seq'::regclass);


--
-- Name: player_liabilty player_liabilty_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.player_liabilty ALTER COLUMN player_liabilty_id SET DEFAULT nextval('multi_tenant_system.player_liabilty_player_liabilty_id_seq'::regclass);


--
-- Name: reviews review_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.reviews ALTER COLUMN review_id SET DEFAULT nextval('multi_tenant_system.reviews_review_id_seq'::regclass);


--
-- Name: tenant_configurations tenant_configuration_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_configurations ALTER COLUMN tenant_configuration_id SET DEFAULT nextval('multi_tenant_system.tenant_configurations_tenant_configuration_id_seq'::regclass);


--
-- Name: tenant_gallery tenant_image_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_gallery ALTER COLUMN tenant_image_id SET DEFAULT nextval('multi_tenant_system.tenant_gallery_tenant_image_id_seq'::regclass);


--
-- Name: tenant_multi_licenses id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_multi_licenses ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.tenant_multi_licenses_id_seq'::regclass);


--
-- Name: tenant_registrations tenant_registration_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_registrations ALTER COLUMN tenant_registration_id SET DEFAULT nextval('multi_tenant_system.tenant_registrations_tenant_registration_id_seq'::regclass);


--
-- Name: tenant_theme_settings tenant_theme_setting_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_theme_settings ALTER COLUMN tenant_theme_setting_id SET DEFAULT nextval('multi_tenant_system.tenant_theme_settings_tenant_theme_setting_id_seq'::regclass);


--
-- Name: tenants tenant_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenants ALTER COLUMN tenant_id SET DEFAULT nextval('multi_tenant_system.tenants_tenant_id_seq'::regclass);


--
-- Name: tournament tournament_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tournament ALTER COLUMN tournament_id SET DEFAULT nextval('multi_tenant_system.tournament_tournament_id_seq'::regclass);


--
-- Name: transaction_affiliates transaction_affiliate_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.transaction_affiliates ALTER COLUMN transaction_affiliate_id SET DEFAULT nextval('multi_tenant_system.transaction_affiliates_transaction_affiliate_id_seq'::regclass);


--
-- Name: transaction_bankings transaction_banking_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.transaction_bankings ALTER COLUMN transaction_banking_id SET DEFAULT nextval('multi_tenant_system.transaction_bankings_transaction_banking_id_seq'::regclass);


--
-- Name: unique_user_identification unique_user_identification_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.unique_user_identification ALTER COLUMN unique_user_identification_id SET DEFAULT nextval('multi_tenant_system.unique_user_identification_unique_user_identification_id_seq'::regclass);


--
-- Name: user_action_trail id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_action_trail ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system."user-action-trail_id_seq"'::regclass);


--
-- Name: user_affiliates id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_affiliates ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.user_affiliates_id_seq'::regclass);


--
-- Name: user_bonus user_bonus_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_bonus ALTER COLUMN user_bonus_id SET DEFAULT nextval('multi_tenant_system.user_bonus_user_bonus_id_seq'::regclass);


--
-- Name: user_documents user_document_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_documents ALTER COLUMN user_document_id SET DEFAULT nextval('multi_tenant_system.user_documents_user_document_id_seq'::regclass);


--
-- Name: user_login_session id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_login_session ALTER COLUMN id SET DEFAULT nextval('multi_tenant_system.user_login_session_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.users ALTER COLUMN user_id SET DEFAULT nextval('multi_tenant_system.users_user_id_seq'::regclass);


--
-- Name: wagering_templates wagering_template_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.wagering_templates ALTER COLUMN wagering_template_id SET DEFAULT nextval('multi_tenant_system.wagering_templates_wagering_template_id_seq'::regclass);


--
-- Name: wallets wallet_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.wallets ALTER COLUMN wallet_id SET DEFAULT nextval('multi_tenant_system.wallets_wallet_id_seq'::regclass);


--
-- Name: withdraw_requests withdraw_request_id; Type: DEFAULT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.withdraw_requests ALTER COLUMN withdraw_request_id SET DEFAULT nextval('multi_tenant_system.withdraw_requests_withdraw_request_id_seq'::regclass);


--
-- Name: banned_games_list banned_games_list_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banned_games_list ALTER COLUMN banned_games_list_id SET DEFAULT nextval('public.banned_games_list_banned_games_list_id_seq'::regclass);


--
-- Name: countries country_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN country_id SET DEFAULT nextval('public.countries_country_id_seq'::regclass);


--
-- Name: credentials_keys credential_key_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials_keys ALTER COLUMN credential_key_id SET DEFAULT nextval('public.credentials_keys_credential_key_id_seq'::regclass);


--
-- Name: currencies currency_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies ALTER COLUMN currency_id SET DEFAULT nextval('public.currencies_currency_id_seq'::regclass);


--
-- Name: document_labels document_label_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_labels ALTER COLUMN document_label_id SET DEFAULT nextval('public.document_labels_document_label_id_seq'::regclass);


--
-- Name: group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_permissions ALTER COLUMN id SET DEFAULT nextval('public.group_permissions_id_seq'::regclass);


--
-- Name: languages language_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages ALTER COLUMN language_id SET DEFAULT nextval('public.languages_language_id_seq'::regclass);


--
-- Name: licenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenses ALTER COLUMN id SET DEFAULT nextval('public.licenses_id_seq'::regclass);


--
-- Name: multi_language_support multi_language_support_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multi_language_support ALTER COLUMN multi_language_support_id SET DEFAULT nextval('public.multi_language_support_multi_language_support_id_seq'::regclass);


--
-- Name: parent_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parent_groups ALTER COLUMN id SET DEFAULT nextval('public.parent_groups_id_seq'::regclass);


--
-- Name: payment_providers payment_provider_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_providers ALTER COLUMN payment_provider_id SET DEFAULT nextval('public.payment_providers_payment_provider_id_seq'::regclass);


--
-- Name: super_admin_roles super_role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_roles ALTER COLUMN super_role_id SET DEFAULT nextval('public.super_admin_roles_super_role_id_seq'::regclass);


--
-- Name: super_admin_user_permissions super_admin_user_permission_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_user_permissions ALTER COLUMN super_admin_user_permission_id SET DEFAULT nextval('public.super_admin_user_permissions_super_admin_user_permission_id_seq'::regclass);


--
-- Name: super_admin_users super_admin_user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_users ALTER COLUMN super_admin_user_id SET DEFAULT nextval('public.super_admin_users_super_admin_user_id_seq'::regclass);


--
-- Name: themes theme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes ALTER COLUMN theme_id SET DEFAULT nextval('public.themes_theme_id_seq'::regclass);


--
-- Name: whitelisted_domains id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.whitelisted_domains ALTER COLUMN id SET DEFAULT nextval('public.whitelisted_domains_id_seq'::regclass);


--
-- Name: casino_transactions_copy casino_transactions_copy_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.casino_transactions_copy
    ADD CONSTRAINT casino_transactions_copy_pkey PRIMARY KEY (casino_transaction_id, created_at);


--
-- Name: casino_transactions casino_transactions_new_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.casino_transactions
    ADD CONSTRAINT casino_transactions_new_pkey PRIMARY KEY (casino_transaction_id, created_at);


--
-- Name: casino_transactions_a casino_transactions_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.casino_transactions_a
    ADD CONSTRAINT casino_transactions_pkey PRIMARY KEY (casino_transaction_id);


--
-- Name: category_games category_games_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.category_games
    ADD CONSTRAINT category_games_pkey PRIMARY KEY (category_game_id);


--
-- Name: daily_cumulative_report daily_cumulative_report_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.daily_cumulative_report
    ADD CONSTRAINT daily_cumulative_report_pkey PRIMARY KEY (daily_cumulative_report_id);


--
-- Name: favorite_games favorite_games_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.favorite_games
    ADD CONSTRAINT favorite_games_pkey PRIMARY KEY (favorite_game_id);


--
-- Name: game_aggregator_categories game_aggregator_categories_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.game_aggregator_categories
    ADD CONSTRAINT game_aggregator_categories_pkey PRIMARY KEY (game_aggregator_category_id);


--
-- Name: master_casino_games master_casino_games_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_casino_games
    ADD CONSTRAINT master_casino_games_pkey PRIMARY KEY (master_casino_game_id);


--
-- Name: master_casino_providers master_casino_providers_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_casino_providers
    ADD CONSTRAINT master_casino_providers_pkey PRIMARY KEY (master_casino_provider_id);


--
-- Name: master_game_aggregators master_game_aggregators_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_game_aggregators
    ADD CONSTRAINT master_game_aggregators_pkey PRIMARY KEY (master_game_aggregator_id);


--
-- Name: master_game_categories master_game_categories_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_game_categories
    ADD CONSTRAINT master_game_categories_pkey PRIMARY KEY (master_game_category_id);


--
-- Name: master_game_sub_categories master_game_sub_categories_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.master_game_sub_categories
    ADD CONSTRAINT master_game_sub_categories_pkey PRIMARY KEY (master_game_sub_category_id);


--
-- Name: tenant_casino_providers tenant_casino_providers_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_casino_providers
    ADD CONSTRAINT tenant_casino_providers_pkey PRIMARY KEY (tenant_casino_provider_id);


--
-- Name: tenant_game_categories tenant_game_categories_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_game_categories
    ADD CONSTRAINT tenant_game_categories_pkey PRIMARY KEY (tenant_game_category_id);


--
-- Name: tenant_game_sub_categories tenant_game_sub_categories_pkey; Type: CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_game_sub_categories
    ADD CONSTRAINT tenant_game_sub_categories_pkey PRIMARY KEY (tenant_game_sub_category_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (admin_role_id);


--
-- Name: admin_user_permissions admin_user_permissions_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_user_permissions
    ADD CONSTRAINT admin_user_permissions_pkey PRIMARY KEY (admin_user_permission_id);


--
-- Name: admin_user_settings admin_user_settings_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_user_settings
    ADD CONSTRAINT admin_user_settings_pkey PRIMARY KEY (admin_user_setting_id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (admin_user_id);


--
-- Name: affiliates affiliates_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.affiliates
    ADD CONSTRAINT affiliates_pkey PRIMARY KEY (affiliate_id);


--
-- Name: banned_players banned_players_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.banned_players
    ADD CONSTRAINT banned_players_pkey PRIMARY KEY (id);


--
-- Name: bonus bonus_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.bonus
    ADD CONSTRAINT bonus_pkey PRIMARY KEY (bonus_id);


--
-- Name: cms_pages cms_pages_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.cms_pages
    ADD CONSTRAINT cms_pages_pkey PRIMARY KEY (cms_page_id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- Name: credentials credentials_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.credentials
    ADD CONSTRAINT credentials_pkey PRIMARY KEY (credential_id);


--
-- Name: deposit_ggr_reports deposit_ggr_reports_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.deposit_ggr_reports
    ADD CONSTRAINT deposit_ggr_reports_pkey PRIMARY KEY (id);


--
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- Name: email_templates email_templates_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.email_templates
    ADD CONSTRAINT email_templates_pkey PRIMARY KEY (email_template_id);


--
-- Name: hub88_prepaids hub88_prepaids_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.hub88_prepaids
    ADD CONSTRAINT hub88_prepaids_pkey PRIMARY KEY (id);


--
-- Name: kpi_summary kpi_summary_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.kpi_summary
    ADD CONSTRAINT kpi_summary_pkey PRIMARY KEY (id);


--
-- Name: limits limits_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.limits
    ADD CONSTRAINT limits_pkey PRIMARY KEY (limit_id);


--
-- Name: notification_receivers notification_receivers_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.notification_receivers
    ADD CONSTRAINT notification_receivers_pkey PRIMARY KEY (notification_receiver_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: page_banners page_banners_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.page_banners
    ADD CONSTRAINT page_banners_pkey PRIMARY KEY (page_banner_id);


--
-- Name: player_liabilty player_liabilty_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.player_liabilty
    ADD CONSTRAINT player_liabilty_pkey PRIMARY KEY (player_liabilty_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: tenant_configurations tenant_configurations_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_configurations
    ADD CONSTRAINT tenant_configurations_pkey PRIMARY KEY (tenant_configuration_id);


--
-- Name: tenant_gallery tenant_gallery_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_gallery
    ADD CONSTRAINT tenant_gallery_pkey PRIMARY KEY (tenant_image_id);


--
-- Name: tenant_multi_licenses tenant_multi_licenses_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_multi_licenses
    ADD CONSTRAINT tenant_multi_licenses_pkey PRIMARY KEY (id);


--
-- Name: tenant_registrations tenant_registrations_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_registrations
    ADD CONSTRAINT tenant_registrations_pkey PRIMARY KEY (tenant_registration_id);


--
-- Name: tenant_theme_settings tenant_theme_settings_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_theme_settings
    ADD CONSTRAINT tenant_theme_settings_pkey PRIMARY KEY (tenant_theme_setting_id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (tenant_id);


--
-- Name: tournament tournament_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tournament
    ADD CONSTRAINT tournament_pkey PRIMARY KEY (tournament_id);


--
-- Name: transaction_affiliates transaction_affiliates_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.transaction_affiliates
    ADD CONSTRAINT transaction_affiliates_pkey PRIMARY KEY (transaction_affiliate_id);


--
-- Name: transaction_bankings transaction_bankings_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.transaction_bankings
    ADD CONSTRAINT transaction_bankings_pkey PRIMARY KEY (transaction_banking_id);


--
-- Name: credentials unique_key_and_tenant_id_constraint; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.credentials
    ADD CONSTRAINT unique_key_and_tenant_id_constraint UNIQUE (key, tenant_id);


--
-- Name: hub88_prepaids unique_prepaid_game_currency; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.hub88_prepaids
    ADD CONSTRAINT unique_prepaid_game_currency UNIQUE (tenant_id, currency, game_code, prepaid_uuid);


--
-- Name: unique_user_identification unique_user_identification_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.unique_user_identification
    ADD CONSTRAINT unique_user_identification_pkey PRIMARY KEY (unique_user_identification_id);


--
-- Name: user_action_trail user-action-trail_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_action_trail
    ADD CONSTRAINT "user-action-trail_pkey" PRIMARY KEY (id);


--
-- Name: user_affiliates user_affiliates_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_affiliates
    ADD CONSTRAINT user_affiliates_pkey PRIMARY KEY (id);


--
-- Name: user_bonus user_bonus_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_bonus
    ADD CONSTRAINT user_bonus_pkey PRIMARY KEY (user_bonus_id);


--
-- Name: user_bonus user_bonus_unique_id_key; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_bonus
    ADD CONSTRAINT user_bonus_unique_id_key UNIQUE (unique_id);


--
-- Name: user_documents user_documents_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_documents
    ADD CONSTRAINT user_documents_pkey PRIMARY KEY (user_document_id);


--
-- Name: user_login_session user_login_session_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.user_login_session
    ADD CONSTRAINT user_login_session_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: wagering_templates wagering_templates_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.wagering_templates
    ADD CONSTRAINT wagering_templates_pkey PRIMARY KEY (wagering_template_id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (wallet_id);


--
-- Name: withdraw_requests withdraw_requests_pkey; Type: CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.withdraw_requests
    ADD CONSTRAINT withdraw_requests_pkey PRIMARY KEY (withdraw_request_id);


--
-- Name: banned_games_list banned_games_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banned_games_list
    ADD CONSTRAINT banned_games_list_pkey PRIMARY KEY (banned_games_list_id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- Name: credentials_keys credentials_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credentials_keys
    ADD CONSTRAINT credentials_keys_pkey PRIMARY KEY (credential_key_id);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (currency_id);


--
-- Name: document_labels document_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_labels
    ADD CONSTRAINT document_labels_pkey PRIMARY KEY (document_label_id);


--
-- Name: global_settings global_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings
    ADD CONSTRAINT global_settings_pkey PRIMARY KEY (key);


--
-- Name: group_permissions group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_permissions
    ADD CONSTRAINT group_permissions_pkey PRIMARY KEY (id);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (language_id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: multi_language_support multi_language_support_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.multi_language_support
    ADD CONSTRAINT multi_language_support_pkey PRIMARY KEY (multi_language_support_id);


--
-- Name: parent_groups parent_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parent_groups
    ADD CONSTRAINT parent_groups_pkey PRIMARY KEY (id);


--
-- Name: payment_providers payment_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_providers
    ADD CONSTRAINT payment_providers_pkey PRIMARY KEY (payment_provider_id);


--
-- Name: sequelize_migration_meta sequelize_migration_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequelize_migration_meta
    ADD CONSTRAINT sequelize_migration_meta_pkey PRIMARY KEY (name);


--
-- Name: sequelize_seed_meta sequelize_seed_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sequelize_seed_meta
    ADD CONSTRAINT sequelize_seed_meta_pkey PRIMARY KEY (name);


--
-- Name: super_admin_roles super_admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_roles
    ADD CONSTRAINT super_admin_roles_pkey PRIMARY KEY (super_role_id);


--
-- Name: super_admin_user_permissions super_admin_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_user_permissions
    ADD CONSTRAINT super_admin_user_permissions_pkey PRIMARY KEY (super_admin_user_permission_id);


--
-- Name: super_admin_users super_admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_users
    ADD CONSTRAINT super_admin_users_pkey PRIMARY KEY (super_admin_user_id);


--
-- Name: themes themes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.themes
    ADD CONSTRAINT themes_pkey PRIMARY KEY (theme_id);


--
-- Name: whitelisted_domains whitelisted_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.whitelisted_domains
    ADD CONSTRAINT whitelisted_domains_pkey PRIMARY KEY (id);


--
-- Name: casino_system_master_casino_games_identifier; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_system_master_casino_games_identifier ON casino_system.master_casino_games USING btree (identifier);


--
-- Name: casino_transactions_copy_action_id_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_action_id_idx ON casino_system.casino_transactions_copy USING btree (action_id);


--
-- Name: casino_transactions_copy_action_type_game_id_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_action_type_game_id_idx ON casino_system.casino_transactions_copy USING btree (action_type, game_id);


--
-- Name: casino_transactions_copy_action_type_status_user_id_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_action_type_status_user_id_idx ON casino_system.casino_transactions_copy USING btree (action_type, status, user_id);


--
-- Name: casino_transactions_copy_created_at_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_created_at_idx ON casino_system.casino_transactions_copy USING btree (created_at);


--
-- Name: casino_transactions_copy_tenant_id_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_tenant_id_idx ON casino_system.casino_transactions_copy USING btree (tenant_id);


--
-- Name: casino_transactions_copy_tenant_id_idx1; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_tenant_id_idx1 ON casino_system.casino_transactions_copy USING btree (tenant_id);


--
-- Name: casino_transactions_copy_user_id_status_action_type_created_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_user_id_status_action_type_created_idx ON casino_system.casino_transactions_copy USING btree (user_id, status, action_type, created_at);


--
-- Name: casino_transactions_copy_user_id_status_action_type_is_stic_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_copy_user_id_status_action_type_is_stic_idx ON casino_system.casino_transactions_copy USING btree (user_id, status, action_type, is_sticky, amount_type);


--
-- Name: casino_transactions_new_action_id_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_new_action_id_idx ON casino_system.casino_transactions USING btree (action_id);


--
-- Name: casino_transactions_new_tenant_id_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX casino_transactions_new_tenant_id_idx ON casino_system.casino_transactions USING btree (tenant_id);


--
-- Name: index_aggregator_category_on_aggregator_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_aggregator_category_on_aggregator_id ON casino_system.game_aggregator_categories USING btree (game_aggregator_id);


--
-- Name: index_casino_for_tenant_admin_status_date; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_for_tenant_admin_status_date ON casino_system.casino_transactions USING btree (tenant_id, admin_id, status, created_at);


--
-- Name: index_casino_games_for_status_provider_and_freespins; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_games_for_status_provider_and_freespins ON casino_system.master_casino_games USING btree (is_active, master_casino_provider_id, has_freespins);


--
-- Name: index_casino_transaction_on_action_type_and_status_and_user_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transaction_on_action_type_and_status_and_user_id ON casino_system.casino_transactions_a USING btree (action_type, status, user_id);


--
-- Name: index_casino_transaction_on_status; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transaction_on_status ON casino_system.casino_transactions_a USING btree (status);


--
-- Name: index_casino_transaction_on_tenant_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transaction_on_tenant_id ON casino_system.casino_transactions_a USING btree (tenant_id);


--
-- Name: index_casino_transactions_for_action_type_game_id_user_tenant; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transactions_for_action_type_game_id_user_tenant ON casino_system.casino_transactions USING btree (action_type, game_id, user_id, tenant_id);


--
-- Name: index_casino_transactions_for_date; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transactions_for_date ON casino_system.casino_transactions USING btree (updated_at, created_at);


--
-- Name: index_casino_transactions_for_game_identifier; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transactions_for_game_identifier ON casino_system.casino_transactions USING btree (game_identifier);


--
-- Name: index_casino_transactions_for_user_id_status_action_date_tenant; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transactions_for_user_id_status_action_date_tenant ON casino_system.casino_transactions USING btree (user_id, status, action_type, created_at, tenant_id);


--
-- Name: index_casino_transactions_for_user_id_status_action_sticky_amou; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_casino_transactions_for_user_id_status_action_sticky_amou ON casino_system.casino_transactions USING btree (user_id, status, action_type, is_sticky, amount_type, tenant_id);


--
-- Name: index_category_games_for_tenant_and_sub_category; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_category_games_for_tenant_and_sub_category ON casino_system.category_games USING btree (tenant_id, tenant_game_sub_category_id);


--
-- Name: index_category_games_on_is_active_and_tenant_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_category_games_on_is_active_and_tenant_id ON casino_system.category_games USING btree (is_active, tenant_id, tenant_game_sub_category_id, master_casino_game_id);


--
-- Name: index_category_games_on_master_casino_game_id_and_tenant_game_s; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_category_games_on_master_casino_game_id_and_tenant_game_s ON casino_system.category_games USING btree (master_casino_game_id, tenant_game_sub_category_id);


--
-- Name: index_category_games_on_master_casino_game_id_and_tenant_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_category_games_on_master_casino_game_id_and_tenant_id ON casino_system.category_games USING btree (tenant_id, master_casino_game_id);


--
-- Name: index_favorite_games_on_category_game_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_favorite_games_on_category_game_id ON casino_system.favorite_games USING btree (category_game_id);


--
-- Name: index_master_casino_games_on_identifier; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_casino_games_on_identifier ON casino_system.master_casino_games USING btree (identifier);


--
-- Name: index_master_casino_games_on_is_active_and_operator_status_and_; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_casino_games_on_is_active_and_operator_status_and_ ON casino_system.master_casino_games USING btree (is_active, operator_status, identifier);


--
-- Name: index_master_casino_games_on_master_casino_game_id_and_operator; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_casino_games_on_master_casino_game_id_and_operator ON casino_system.master_casino_games USING btree (operator_status, is_active, master_casino_game_id);


--
-- Name: index_master_casino_providers_for_aggregator_id_and_status; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_casino_providers_for_aggregator_id_and_status ON casino_system.master_casino_providers USING btree (master_game_aggregator_id, is_active);


--
-- Name: index_master_casino_providers_for_name; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_casino_providers_for_name ON casino_system.master_casino_providers USING btree (name);


--
-- Name: index_master_casino_providers_on_is_active; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_casino_providers_on_is_active ON casino_system.master_casino_providers USING btree (is_active);


--
-- Name: index_master_game_categories_on_name; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_game_categories_on_name ON casino_system.master_game_categories USING btree (name);


--
-- Name: index_master_game_sub_categories_on_name_and_master_game_catego; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_master_game_sub_categories_on_name_and_master_game_catego ON casino_system.master_game_sub_categories USING btree (name, master_game_category_id);


--
-- Name: index_tenant_casino_providers_on_tenant_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_tenant_casino_providers_on_tenant_id ON casino_system.tenant_casino_providers USING btree (tenant_id);


--
-- Name: index_tenant_game_categories_on_name; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_tenant_game_categories_on_name ON casino_system.tenant_game_categories USING btree (name);


--
-- Name: index_tenant_game_categories_on_tenant_id; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_tenant_game_categories_on_tenant_id ON casino_system.tenant_game_categories USING btree (tenant_id);


--
-- Name: index_tenant_game_categories_on_tenant_id_and_is_active; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX index_tenant_game_categories_on_tenant_id_and_is_active ON casino_system.tenant_game_categories USING btree (tenant_id, is_active);


--
-- Name: more_details_is_banned_game_bet_idx; Type: INDEX; Schema: casino_system; Owner: postgres
--

CREATE INDEX more_details_is_banned_game_bet_idx ON casino_system.casino_transactions USING gin (more_details);


--
-- Name: index_admin_user_settings_on_key; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_admin_user_settings_on_key ON multi_tenant_system.admin_user_settings USING btree (key);


--
-- Name: index_admin_users_for_owner_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_admin_users_for_owner_id ON multi_tenant_system.admin_users USING btree (owner_id);


--
-- Name: index_affiliate_on_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_affiliate_on_tenant_id ON multi_tenant_system.affiliates USING btree (tenant_id);


--
-- Name: index_affiliate_on_user_affiliate_id_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_affiliate_on_user_affiliate_id_and_tenant_id ON multi_tenant_system.affiliates USING btree (user_id_affiliate, tenant_id);


--
-- Name: index_affiliates_for_tenant_id_and_names; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_affiliates_for_tenant_id_and_names ON multi_tenant_system.affiliates USING btree (tenant_id, user_id_affiliate, parent_name, username);


--
-- Name: index_bankings_for_tenant_admin_status_date; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_bankings_for_tenant_admin_status_date ON multi_tenant_system.transaction_bankings USING btree (tenant_id, admin_id, status, updated_at);


--
-- Name: index_banned_players_admin_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_banned_players_admin_id ON multi_tenant_system.banned_players USING btree (admin_id);


--
-- Name: index_banned_players_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_banned_players_tenant_id ON multi_tenant_system.banned_players USING btree (tenant_id);


--
-- Name: index_bonus_on_bonus_type_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_bonus_on_bonus_type_and_tenant_id ON multi_tenant_system.bonus USING btree (bonus_type, tenant_id, is_active, visible_in_promotions);


--
-- Name: index_bonus_on_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_bonus_on_tenant_id ON multi_tenant_system.bonus USING btree (tenant_id);


--
-- Name: index_cms_pages_on_global_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_cms_pages_on_global_and_tenant_id ON multi_tenant_system.cms_pages USING btree (tenant_id, global);


--
-- Name: index_cms_pages_on_global_and_tenant_id_and_is_active; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_cms_pages_on_global_and_tenant_id_and_is_active ON multi_tenant_system.cms_pages USING btree (global, tenant_id, is_active);


--
-- Name: index_cms_pages_on_slug_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_cms_pages_on_slug_and_tenant_id ON multi_tenant_system.cms_pages USING btree (tenant_id, slug);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_comments_on_user_id ON multi_tenant_system.comments USING btree (user_id);


--
-- Name: index_credentials_on_tenant_id_and_key; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_credentials_on_tenant_id_and_key ON multi_tenant_system.credentials USING btree (tenant_id, key);


--
-- Name: index_email_logs_on_user_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_email_logs_on_user_id ON multi_tenant_system.email_logs USING btree (user_id);


--
-- Name: index_email_templates_on_type_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_email_templates_on_type_and_tenant_id ON multi_tenant_system.email_templates USING btree (tenant_id, type);


--
-- Name: index_hub88_prepaids_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_hub88_prepaids_tenant_id ON multi_tenant_system.hub88_prepaids USING btree (tenant_id);


--
-- Name: index_hub88_prepaids_tenant_id_currency; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_hub88_prepaids_tenant_id_currency ON multi_tenant_system.hub88_prepaids USING btree (tenant_id, currency);


--
-- Name: index_limits_for_user_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_limits_for_user_id ON multi_tenant_system.limits USING btree (user_id);


--
-- Name: index_reviews_on_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_reviews_on_tenant_id ON multi_tenant_system.reviews USING btree (tenant_id);


--
-- Name: index_tenant_configurations_on_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tenant_configurations_on_tenant_id ON multi_tenant_system.tenant_configurations USING btree (tenant_id);


--
-- Name: index_tenant_deposit_ggr_report_date; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tenant_deposit_ggr_report_date ON multi_tenant_system.deposit_ggr_reports USING btree (date);


--
-- Name: index_tenant_deposit_ggr_report_on_license_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tenant_deposit_ggr_report_on_license_id ON multi_tenant_system.deposit_ggr_reports USING btree (license_id);


--
-- Name: index_tenant_deposit_ggr_report_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tenant_deposit_ggr_report_tenant_id ON multi_tenant_system.deposit_ggr_reports USING btree (tenant_id);


--
-- Name: index_tenant_gallery_on_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tenant_gallery_on_tenant_id ON multi_tenant_system.tenant_gallery USING btree (tenant_id);


--
-- Name: index_tenant_multi_licenses_on_tenant_id_and_name; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE UNIQUE INDEX index_tenant_multi_licenses_on_tenant_id_and_name ON multi_tenant_system.tenant_multi_licenses USING btree (tenant_id, name);


--
-- Name: index_tenant_registrations_on_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tenant_registrations_on_tenant_id ON multi_tenant_system.tenant_registrations USING btree (tenant_id);


--
-- Name: index_tournament_on_tournament_id_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_tournament_on_tournament_id_and_tenant_id ON multi_tenant_system.tournament USING btree (tournament_id, tenant_id);


--
-- Name: index_transaction_bankings_for_ftd; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_transaction_bankings_for_ftd ON multi_tenant_system.transaction_bankings USING btree (transaction_type, status, actionee_type, is_first_deposit, is_success);


--
-- Name: index_transaction_bankings_for_target_amount_status_date; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_transaction_bankings_for_target_amount_status_date ON multi_tenant_system.transaction_bankings USING btree (target_id, amount_type, status, transaction_type, created_at);


--
-- Name: index_transaction_bankings_on_actionee_id_and_actionee_type; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_transaction_bankings_on_actionee_id_and_actionee_type ON multi_tenant_system.transaction_bankings USING btree (actionee_id, actionee_type, amount_type, status, transaction_type);


--
-- Name: index_transaction_bankings_on_status; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_transaction_bankings_on_status ON multi_tenant_system.transaction_bankings USING btree (status);


--
-- Name: index_transaction_bankings_on_target_id_and_transaction_type_an; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_transaction_bankings_on_target_id_and_transaction_type_an ON multi_tenant_system.transaction_bankings USING btree (target_id, transaction_type, status);


--
-- Name: index_unique_user_identification_for_admin_id_and_unique_key; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_unique_user_identification_for_admin_id_and_unique_key ON multi_tenant_system.unique_user_identification USING btree (admin_id, unique_key);


--
-- Name: index_unique_user_identification_on_admin_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_unique_user_identification_on_admin_id ON multi_tenant_system.unique_user_identification USING btree (admin_id);


--
-- Name: index_unique_user_identification_on_unique_key_and_tenant_id_an; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_unique_user_identification_on_unique_key_and_tenant_id_an ON multi_tenant_system.unique_user_identification USING btree (unique_key, tenant_id, admin_id);


--
-- Name: index_user-action-trail_on_user_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX "index_user-action-trail_on_user_id" ON multi_tenant_system.user_action_trail USING btree (user_id);


--
-- Name: index_user_affiliates_on_user_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_user_affiliates_on_user_id ON multi_tenant_system.user_affiliates USING btree (user_id);


--
-- Name: index_user_bonus_on_user_id_and_bonus_type_and_status; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_user_bonus_on_user_id_and_bonus_type_and_status ON multi_tenant_system.user_bonus USING btree (user_id, bonus_type, status);


--
-- Name: index_user_bonus_on_user_id_and_status; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_user_bonus_on_user_id_and_status ON multi_tenant_system.user_bonus USING btree (user_id, status);


--
-- Name: index_user_documents_on_user_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_user_documents_on_user_id ON multi_tenant_system.user_documents USING btree (user_id);


--
-- Name: index_user_on_affiliate_status_and_internal_user; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_user_on_affiliate_status_and_internal_user ON multi_tenant_system.users USING btree (affiliate_status, is_internal_user);


--
-- Name: index_users_for_parent_id_and_tenant_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_users_for_parent_id_and_tenant_id ON multi_tenant_system.users USING btree (parent_id, tenant_id);


--
-- Name: index_users_for_tenant_id_and_is_active; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_users_for_tenant_id_and_is_active ON multi_tenant_system.users USING btree (tenant_id, is_active);


--
-- Name: index_users_for_user_id_and_bonus_type; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_users_for_user_id_and_bonus_type ON multi_tenant_system.user_bonus USING btree (user_id, bonus_type);


--
-- Name: index_users_for_user_id_and_deleted_at; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_users_for_user_id_and_deleted_at ON multi_tenant_system.users USING btree (user_id, deleted_at);


--
-- Name: index_wallets_on_owner_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_wallets_on_owner_id ON multi_tenant_system.wallets USING btree (owner_id);


--
-- Name: index_withdraw_requests_on_user_id_and_status; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_withdraw_requests_on_user_id_and_status ON multi_tenant_system.withdraw_requests USING btree (user_id, status);


--
-- Name: index_withdraw_requests_on_user_id_and_transaction_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX index_withdraw_requests_on_user_id_and_transaction_id ON multi_tenant_system.withdraw_requests USING btree (user_id, transaction_id);


--
-- Name: multi_tenant_system_admin_users_email_agent_name; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX multi_tenant_system_admin_users_email_agent_name ON multi_tenant_system.admin_users USING btree (email, agent_name);


--
-- Name: multi_tenant_system_tenants_domain; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX multi_tenant_system_tenants_domain ON multi_tenant_system.tenants USING btree (domain);


--
-- Name: multi_tenant_system_users_email_username_unique_id; Type: INDEX; Schema: multi_tenant_system; Owner: postgres
--

CREATE INDEX multi_tenant_system_users_email_username_unique_id ON multi_tenant_system.users USING btree (email, username, unique_id);


--
-- Name: index_countries_on_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_countries_on_code ON public.countries USING btree (code);


--
-- Name: index_credentials_keys_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_credentials_keys_on_name ON public.credentials_keys USING btree (name);


--
-- Name: index_currencies_keys_on_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_currencies_keys_on_code ON public.currencies USING btree (code, is_primary);


--
-- Name: index_currencies_keys_on_is_primary; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_currencies_keys_on_is_primary ON public.currencies USING btree (is_primary);


--
-- Name: index_document_labels_on_is_required; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_document_labels_on_is_required ON public.document_labels USING btree (is_required);


--
-- Name: index_group_permissions_on_group_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_group_permissions_on_group_name ON public.group_permissions USING btree (group_name);


--
-- Name: index_multi_language_support_on_tenant_id_and_language; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_multi_language_support_on_tenant_id_and_language ON public.multi_language_support USING btree (tenant_id, language);


--
-- Name: index_payment_providers_for_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_payment_providers_for_tenant_id ON public.payment_providers USING btree (tenant_id);


--
-- Name: index_payment_providers_on_aggregator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_payment_providers_on_aggregator ON public.payment_providers USING btree (aggregator);


--
-- Name: index_super_admin_roles_on_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_super_admin_roles_on_name ON public.super_admin_roles USING btree (name);


--
-- Name: index_super_admin_user_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_super_admin_user_on_email ON public.super_admin_users USING btree (email);


--
-- Name: super_admin_users_email_super_admin_username; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX super_admin_users_email_super_admin_username ON public.super_admin_users USING btree (email, super_admin_username);


--
-- Name: category_games category_games_tenant_game_sub_category_id_fkey; Type: FK CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.category_games
    ADD CONSTRAINT category_games_tenant_game_sub_category_id_fkey FOREIGN KEY (tenant_game_sub_category_id) REFERENCES casino_system.tenant_game_sub_categories(tenant_game_sub_category_id) ON DELETE CASCADE;


--
-- Name: tenant_game_sub_categories tenant_game_sub_categories_tenant_game_category_id_fkey; Type: FK CONSTRAINT; Schema: casino_system; Owner: postgres
--

ALTER TABLE ONLY casino_system.tenant_game_sub_categories
    ADD CONSTRAINT tenant_game_sub_categories_tenant_game_category_id_fkey FOREIGN KEY (tenant_game_category_id) REFERENCES casino_system.tenant_game_categories(tenant_game_category_id) ON DELETE CASCADE;


--
-- Name: cms_pages cms_pages_license_id_fkey; Type: FK CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.cms_pages
    ADD CONSTRAINT cms_pages_license_id_fkey FOREIGN KEY (license_id) REFERENCES multi_tenant_system.tenant_multi_licenses(id);


--
-- Name: users fk_users_license_id; Type: FK CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.users
    ADD CONSTRAINT fk_users_license_id FOREIGN KEY (license_id) REFERENCES multi_tenant_system.tenant_multi_licenses(id) ON DELETE SET NULL;


--
-- Name: tenant_multi_licenses tenant_multi_licenses_parent_license_id_fkey; Type: FK CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_multi_licenses
    ADD CONSTRAINT tenant_multi_licenses_parent_license_id_fkey FOREIGN KEY (parent_license_id) REFERENCES public.licenses(id);


--
-- Name: tenant_multi_licenses tenant_multi_licenses_tenant_id_fkey; Type: FK CONSTRAINT; Schema: multi_tenant_system; Owner: postgres
--

ALTER TABLE ONLY multi_tenant_system.tenant_multi_licenses
    ADD CONSTRAINT tenant_multi_licenses_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES multi_tenant_system.tenants(tenant_id) ON DELETE CASCADE;


--
-- Name: super_admin_user_permissions super_admin_user_permissions_super_admin_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.super_admin_user_permissions
    ADD CONSTRAINT super_admin_user_permissions_super_admin_user_id_fkey FOREIGN KEY (super_admin_user_id) REFERENCES public.super_admin_users(super_admin_user_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

