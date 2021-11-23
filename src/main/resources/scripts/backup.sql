--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

-- Started on 2021-11-23 14:50:53

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

DROP DATABASE "BatchReports";
--
-- TOC entry 3417 (class 1262 OID 16561)
-- Name: BatchReports; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "BatchReports" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';


ALTER DATABASE "BatchReports" OWNER TO postgres;

\connect "BatchReports"

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
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 3417
-- Name: DATABASE "BatchReports"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE "BatchReports" IS 'This is database for freelance reporting tool';


--
-- TOC entry 221 (class 1259 OID 33179)
-- Name: seq_customer; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_customer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_customer OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 33180)
-- Name: mst_customer_vendor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_customer_vendor (
    cust_vendor_id numeric(7,0) DEFAULT nextval('public.seq_customer'::regclass) NOT NULL,
    cust_vendor_name character varying(100) NOT NULL,
    cust_vendor_addr character varying(250) DEFAULT '-'::character varying NOT NULL,
    cust_vendor_lat numeric(10,7),
    cust_vendor_long numeric(10,7),
    cust_vendor_city character varying(50) DEFAULT '-'::character varying NOT NULL,
    cust_vendor_state_id numeric(2,0) DEFAULT 1 NOT NULL,
    pin_code character varying(6) DEFAULT 0 NOT NULL,
    ll_no1 character varying(15) DEFAULT NULL::character varying,
    ll_no2 character varying(15) DEFAULT NULL::character varying,
    mob_no1 character varying(15) DEFAULT NULL::character varying,
    mob_no2 character varying(15) DEFAULT NULL::character varying,
    wa_no1 character varying(15) DEFAULT NULL::character varying,
    wa_no2 character varying(15) DEFAULT NULL::character varying,
    email_id1 character varying(50) DEFAULT NULL::character varying,
    email_id2 character varying(50) DEFAULT NULL::character varying,
    cust_vendor_url character varying(100) DEFAULT NULL::character varying,
    fb_handle character varying(100) DEFAULT NULL::character varying,
    twr_handle character varying(100) DEFAULT NULL::character varying,
    pan_no character varying(10) DEFAULT NULL::character varying,
    gst_no character varying(15) DEFAULT NULL::character varying,
    ifsc_code character varying(15) DEFAULT NULL::character varying,
    bank_acc_no character varying(15) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0),
    bank_name character varying(50) DEFAULT NULL::character varying,
    cust_vendor_code character varying(15),
    cust_vendor_firm_name character varying(100),
    cust_vendor_firm_addr character varying(250),
    credit_limit numeric(13,2) DEFAULT 0,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text,
    is_customer smallint
);


ALTER TABLE public.mst_customer_vendor OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 33212)
-- Name: seq_name_setup; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_name_setup
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;


ALTER TABLE public.seq_name_setup OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 33213)
-- Name: mst_name_setup; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_name_setup (
    trans_id numeric(9,0) DEFAULT nextval('public.seq_name_setup'::regclass) NOT NULL,
    int_id numeric NOT NULL,
    hc_id numeric NOT NULL,
    plant_id numeric NOT NULL,
    agg1_name character varying(10) DEFAULT '-'::character varying,
    agg1_item_id numeric,
    agg2_name character varying(10) DEFAULT '-'::character varying,
    agg2_item_id numeric,
    agg3_name character varying(10) DEFAULT '-'::character varying,
    agg3_item_id numeric,
    agg4_name character varying(10) DEFAULT '-'::character varying,
    agg4_item_id numeric,
    agg5_name character varying(10) DEFAULT '-'::character varying,
    agg5_item_id numeric,
    cement1_name character varying(10) DEFAULT '-'::character varying,
    cement1_item_id numeric,
    cement2_name character varying(10) DEFAULT '-'::character varying,
    cement2_item_id numeric,
    fill_name character varying(10) DEFAULT '-'::character varying,
    fill_item_id numeric,
    water1_name character varying(10) DEFAULT '-'::character varying,
    water1_item_id numeric,
    water2_name character varying(10) DEFAULT '-'::character varying,
    water2_item_id numeric,
    admix1_name character varying(10) DEFAULT '-'::character varying,
    admix1_item_id numeric,
    admix12_name character varying(10) DEFAULT '-'::character varying,
    admix12_item_id numeric,
    admix2_name character varying(10) DEFAULT '-'::character varying,
    admix2_item_id numeric,
    admix22_name character varying(10) DEFAULT '-'::character varying,
    admix22_item_id numeric,
    silica_name character varying(10) DEFAULT '-'::character varying,
    silica_item_id numeric,
    slurry_name character varying(10) DEFAULT '-'::character varying,
    slurry_item_id numeric,
    pigname character varying(10) DEFAULT '-'::character varying,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    rec_status integer DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);


ALTER TABLE public.mst_name_setup OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 33160)
-- Name: seq_plant; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_plant
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_plant OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 33161)
-- Name: mst_plant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mst_plant (
    plant_id numeric(7,0) DEFAULT nextval('public.seq_plant'::regclass) NOT NULL,
    con_id numeric(5,0) NOT NULL,
    int_id numeric(3,0) NOT NULL,
    plant_name character varying(100),
    plant_reg_no character varying(50),
    plant_reg_date date,
    plant_address character varying(255) NOT NULL,
    plant_details character varying(255),
    plant_install_date date,
    plant_contact_person character varying(100),
    plant_latitude numeric NOT NULL,
    plant_longitude numeric NOT NULL,
    plant_contact_mobile_no character varying(15),
    plant_type numeric(2,0) NOT NULL,
    plant_subtype numeric(2,0) DEFAULT NULL::numeric,
    plant_capacity character varying(100),
    plant_valid_from date,
    plant_valid_to date,
    plant_status numeric(1,0) DEFAULT 1 NOT NULL,
    geofence numeric(3,0) DEFAULT NULL::numeric,
    comp_location_id numeric(5,0),
    device_imei_no character varying(20) NOT NULL,
    rec_status numeric(1,0),
    created_by numeric(5,0) NOT NULL,
    created_on timestamp without time zone DEFAULT now() NOT NULL,
    modified_by numeric(5,0) DEFAULT NULL::numeric,
    modified_on timestamp without time zone,
    sync_status numeric(1,0) DEFAULT 0 NOT NULL,
    register_mob_no character varying(15)
);


ALTER TABLE public.mst_plant OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16604)
-- Name: seq_rmc_batch_detail_devicetransmission; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_rmc_batch_detail_devicetransmission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_rmc_batch_detail_devicetransmission OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16562)
-- Name: seq_rmc_batch_devicetransmission; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_rmc_batch_devicetransmission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_rmc_batch_devicetransmission OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17015)
-- Name: trn_rmc_batch; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trn_rmc_batch (
    trans_id integer NOT NULL,
    adm1_target1 numeric(999,0),
    adm1_target2 numeric(999,0),
    adm2_target1 numeric(999,0),
    adm2_target2 numeric(999,0),
    batch_date date,
    batch_end_time character varying(255),
    batch_index numeric(11,0),
    batch_no numeric(999,0),
    batch_size numeric(999,0),
    batch_start_time character varying(255),
    batch_time time without time zone,
    batch_time_text character varying(255),
    batch_year numeric(11,0),
    batcher_name character varying(255),
    batcher_user_level character varying(255),
    cement1_target numeric(11,0),
    cement2_target numeric(11,0),
    cement3_target numeric(11,0),
    cement4_target numeric(11,0),
    cust_id numeric(5,0) NOT NULL,
    customer_code character varying(255),
    filler_target numeric(11,0),
    gate1_target numeric(11,0),
    gate2_target numeric(11,0),
    gate3_target numeric(11,0),
    gate4_target numeric(11,0),
    gate5_target numeric(11,0),
    gate6_target numeric(11,0),
    int_id numeric(3,0) NOT NULL,
    mixer_capacity numeric(999,0),
    mixing_time numeric(999,0),
    order_no character varying(255),
    ordered_qty numeric(999,0),
    plant_id numeric(7,0) NOT NULL,
    production_qty numeric(999,0),
    recipe_code character varying(255),
    recipe_name character varying(255),
    returned_qty numeric(999,0),
    schedule_id character varying(255),
    silica_target numeric(11,0),
    site character varying(255),
    slurry_target numeric(11,0),
    truck_driver character varying(255),
    truck_no character varying(255),
    water1_target numeric(11,0),
    water2_target numeric(11,0),
    withthisload numeric(999,0),
    wo_id numeric(11,0) NOT NULL
);


ALTER TABLE public.trn_rmc_batch OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17024)
-- Name: trn_rmc_batch_detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trn_rmc_batch_detail (
    trans_id integer NOT NULL,
    adm1_actual1 numeric(999,0),
    adm1_actual2 numeric(999,0),
    adm1_correction1 numeric(999,0),
    adm1_correction2 numeric(999,0),
    adm1_target1 numeric(999,0),
    adm1_target2 numeric(999,0),
    adm2_actual1 numeric(999,0),
    adm2_actual2 numeric(999,0),
    adm2_correction1 numeric(999,0),
    adm2_correction2 numeric(999,0),
    adm2_target1 numeric(999,0),
    adm2_target2 numeric(999,0),
    batch_date date,
    batch_end_flag numeric(999,0),
    batch_index numeric(11,0),
    batch_no numeric(999,0),
    batch_size numeric(999,0),
    batch_time time without time zone,
    batch_time_text character varying(255),
    batch_year numeric(11,0),
    cement1_actual numeric(11,0),
    cement1_correction numeric(999,0),
    cement1_target numeric(11,0),
    cement2_actual numeric(11,0),
    cement2_correction numeric(999,0),
    cement2_target numeric(11,0),
    cement3_actual numeric(11,0),
    cement3_correction numeric(999,0),
    cement3_target numeric(11,0),
    cement4_actual numeric(11,0),
    cement4_correction numeric(999,0),
    cement4_target numeric(11,0),
    con_id numeric(5,0) NOT NULL,
    consistancy numeric(11,0),
    filler1_actual numeric(11,0),
    filler1_correction numeric(999,0),
    filler1_target numeric(11,0),
    gate1_actual numeric(11,0),
    gate1_moisture numeric(999,0),
    gate1_target numeric(11,0),
    gate2_actual numeric(11,0),
    gate2_moisture numeric(999,0),
    gate2_target numeric(11,0),
    gate3_actual numeric(11,0),
    gate3_moisture numeric(999,0),
    gate3_target numeric(11,0),
    gate4_actual numeric(11,0),
    gate4_moisture numeric(999,0),
    gate4_target numeric(11,0),
    gate5_actual numeric(11,0),
    gate5_moisture numeric(999,0),
    gate5_target numeric(11,0),
    gate6_actual numeric(11,0),
    gate6_moisture numeric(999,0),
    gate6_target numeric(11,0),
    int_id numeric(3,0) NOT NULL,
    ordered_qty numeric(999,0),
    pigment_actual numeric(999,0),
    pigment_target numeric(999,0),
    plant_id numeric(7,0) NOT NULL,
    production_qty numeric(999,0),
    returned_qty numeric(999,0),
    silica_actual numeric(11,0),
    silica_correction numeric(999,0),
    silica_target numeric(11,0),
    slurry_actual numeric(11,0),
    slurry_correction numeric(999,0),
    slurry_target numeric(11,0),
    water1_actual numeric(11,0),
    water1_correction numeric(999,0),
    water1_target numeric(11,0),
    water2_actual numeric(11,0),
    water2_correction numeric(999,0),
    water2_target numeric(11,0),
    withthisload numeric(999,0),
    wo_id numeric(11,0) NOT NULL
);


ALTER TABLE public.trn_rmc_batch_detail OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17023)
-- Name: trn_rmc_batch_detail_trans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trn_rmc_batch_detail_trans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trn_rmc_batch_detail_trans_id_seq OWNER TO postgres;

--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 217
-- Name: trn_rmc_batch_detail_trans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trn_rmc_batch_detail_trans_id_seq OWNED BY public.trn_rmc_batch_detail.trans_id;


--
-- TOC entry 215 (class 1259 OID 17014)
-- Name: trn_rmc_batch_trans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.trn_rmc_batch_trans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trn_rmc_batch_trans_id_seq OWNER TO postgres;

--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 215
-- Name: trn_rmc_batch_trans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.trn_rmc_batch_trans_id_seq OWNED BY public.trn_rmc_batch.trans_id;


--
-- TOC entry 3194 (class 2604 OID 17018)
-- Name: trn_rmc_batch trans_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trn_rmc_batch ALTER COLUMN trans_id SET DEFAULT nextval('public.trn_rmc_batch_trans_id_seq'::regclass);


--
-- TOC entry 3195 (class 2604 OID 17027)
-- Name: trn_rmc_batch_detail trans_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trn_rmc_batch_detail ALTER COLUMN trans_id SET DEFAULT nextval('public.trn_rmc_batch_detail_trans_id_seq'::regclass);


--
-- TOC entry 3409 (class 0 OID 33180)
-- Dependencies: 222
-- Data for Name: mst_customer_vendor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mst_customer_vendor (cust_vendor_id, cust_vendor_name, cust_vendor_addr, cust_vendor_lat, cust_vendor_long, cust_vendor_city, cust_vendor_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, cust_vendor_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, hc_id, bank_name, cust_vendor_code, cust_vendor_firm_name, cust_vendor_firm_addr, credit_limit, int_id, sap_code, sap_id, plant_id, insertion_type, file_path, is_customer) VALUES (5, 'ddsdfd', 'sfsfdff', NULL, NULL, 'fsfsdf', 1, '411058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, 1, '2021-03-01 17:25:07', 1, NULL, '123', 'ffsdf', NULL, NULL, 1, NULL, NULL, NULL, 'M', NULL, NULL);
INSERT INTO public.mst_customer_vendor (cust_vendor_id, cust_vendor_name, cust_vendor_addr, cust_vendor_lat, cust_vendor_long, cust_vendor_city, cust_vendor_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, cust_vendor_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, hc_id, bank_name, cust_vendor_code, cust_vendor_firm_name, cust_vendor_firm_addr, credit_limit, int_id, sap_code, sap_id, plant_id, insertion_type, file_path, is_customer) VALUES (4, 'aaa', 'aaa', NULL, NULL, 'pune', 1, '411058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 9, 1, '2021-03-01 17:31:10', 1, NULL, 'wrwerwer', 'aaa', NULL, NULL, 1, NULL, NULL, NULL, 'M', NULL, NULL);


--
-- TOC entry 3411 (class 0 OID 33213)
-- Dependencies: 224
-- Data for Name: mst_name_setup; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mst_name_setup (trans_id, int_id, hc_id, plant_id, agg1_name, agg1_item_id, agg2_name, agg2_item_id, agg3_name, agg3_item_id, agg4_name, agg4_item_id, agg5_name, agg5_item_id, cement1_name, cement1_item_id, cement2_name, cement2_item_id, fill_name, fill_item_id, water1_name, water1_item_id, water2_name, water2_item_id, admix1_name, admix1_item_id, admix12_name, admix12_item_id, admix2_name, admix2_item_id, admix22_name, admix22_item_id, silica_name, silica_item_id, slurry_name, slurry_item_id, pigname, action_on, rec_status, insertion_type) VALUES (2, 1, 1, 657, '10MM', 4, '20MM', 5, '30MM', NULL, NULL, NULL, NULL, NULL, 'CEM1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-03-01 00:26:40', 1, 'M');


--
-- TOC entry 3407 (class 0 OID 33161)
-- Dependencies: 220
-- Data for Name: mst_plant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mst_plant (plant_id, con_id, int_id, plant_name, plant_reg_no, plant_reg_date, plant_address, plant_details, plant_install_date, plant_contact_person, plant_latitude, plant_longitude, plant_contact_mobile_no, plant_type, plant_subtype, plant_capacity, plant_valid_from, plant_valid_to, plant_status, geofence, comp_location_id, device_imei_no, rec_status, created_by, created_on, modified_by, modified_on, sync_status, register_mob_no) VALUES (657, 1, 1, 'READYMIX CONCRETE', 'CP-45', NULL, 'Pune', NULL, NULL, NULL, 0, 0, NULL, 1, NULL, NULL, NULL, NULL, 1, NULL, NULL, '12345', 1, 1, '2021-03-01 00:37:21', NULL, NULL, 0, NULL);


--
-- TOC entry 3403 (class 0 OID 17015)
-- Dependencies: 216
-- Data for Name: trn_rmc_batch; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.trn_rmc_batch (trans_id, adm1_target1, adm1_target2, adm2_target1, adm2_target2, batch_date, batch_end_time, batch_index, batch_no, batch_size, batch_start_time, batch_time, batch_time_text, batch_year, batcher_name, batcher_user_level, cement1_target, cement2_target, cement3_target, cement4_target, cust_id, customer_code, filler_target, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, int_id, mixer_capacity, mixing_time, order_no, ordered_qty, plant_id, production_qty, recipe_code, recipe_name, returned_qty, schedule_id, silica_target, site, slurry_target, truck_driver, truck_no, water1_target, water2_target, withthisload, wo_id) VALUES (83523, 3150, 0, 0, 0, '2021-08-05', '14:25:48', 1, 607, 0, NULL, '14:19:22', NULL, NULL, 'Batcher', 'User', 230, 85, 0, 0, 558, '1', 0, 540, 880, 660, 0, 0, 0, 1, 0, 0, NULL, NULL, 657, 2, 'M25', 'M25', NULL, NULL, 0, NULL, NULL, 'dagdu', 'MH24F8867', 150, 0, 0, 443);
INSERT INTO public.trn_rmc_batch (trans_id, adm1_target1, adm1_target2, adm2_target1, adm2_target2, batch_date, batch_end_time, batch_index, batch_no, batch_size, batch_start_time, batch_time, batch_time_text, batch_year, batcher_name, batcher_user_level, cement1_target, cement2_target, cement3_target, cement4_target, cust_id, customer_code, filler_target, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, int_id, mixer_capacity, mixing_time, order_no, ordered_qty, plant_id, production_qty, recipe_code, recipe_name, returned_qty, schedule_id, silica_target, site, slurry_target, truck_driver, truck_no, water1_target, water2_target, withthisload, wo_id) VALUES (83522, 3150, 0, 0, 0, '2021-08-05', '12:06:09', 1, 606, 0, NULL, '11:56:36', NULL, NULL, 'Batcher', 'User', 230, 85, 0, 0, 558, '1', 0, 540, 880, 660, 0, 0, 0, 1, 0, 0, NULL, NULL, 657, 2, 'M25', 'M25', NULL, NULL, 0, NULL, NULL, 'dagdu', 'MH24F8867', 150, 0, 0, 443);
INSERT INTO public.trn_rmc_batch (trans_id, adm1_target1, adm1_target2, adm2_target1, adm2_target2, batch_date, batch_end_time, batch_index, batch_no, batch_size, batch_start_time, batch_time, batch_time_text, batch_year, batcher_name, batcher_user_level, cement1_target, cement2_target, cement3_target, cement4_target, cust_id, customer_code, filler_target, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, int_id, mixer_capacity, mixing_time, order_no, ordered_qty, plant_id, production_qty, recipe_code, recipe_name, returned_qty, schedule_id, silica_target, site, slurry_target, truck_driver, truck_no, water1_target, water2_target, withthisload, wo_id) VALUES (83521, 3, 0, 0, 0, '2021-08-05', '13:02:33', 1, 4967, 1, NULL, '12:59:33', NULL, NULL, 'NA', 'NA', 0, 345, 0, 0, 474, '1', 0, 880, 250, 369, 1485, 0, 0, 1, 0, 0, NULL, NULL, 586, 2, 'M25 DALMIA', 'M25 DALMIA', NULL, NULL, 0, NULL, NULL, 'NA', 'MANUAL', 162, 0, 2, 262);
INSERT INTO public.trn_rmc_batch (trans_id, adm1_target1, adm1_target2, adm2_target1, adm2_target2, batch_date, batch_end_time, batch_index, batch_no, batch_size, batch_start_time, batch_time, batch_time_text, batch_year, batcher_name, batcher_user_level, cement1_target, cement2_target, cement3_target, cement4_target, cust_id, customer_code, filler_target, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, int_id, mixer_capacity, mixing_time, order_no, ordered_qty, plant_id, production_qty, recipe_code, recipe_name, returned_qty, schedule_id, silica_target, site, slurry_target, truck_driver, truck_no, water1_target, water2_target, withthisload, wo_id) VALUES (83520, 3, 0, 0, 0, '2021-08-05', '10:21:52', 1, 4966, 1, NULL, '10:14:52', NULL, NULL, 'NA', 'NA', 0, 345, 0, 0, 474, '1', 0, 880, 250, 369, 1485, 0, 0, 1, 0, 0, NULL, NULL, 586, 4, 'M25 DALMIA', 'M25 DALMIA', NULL, NULL, 0, NULL, NULL, 'NA', 'MANUAL', 162, 0, 4, 262);
INSERT INTO public.trn_rmc_batch (trans_id, adm1_target1, adm1_target2, adm2_target1, adm2_target2, batch_date, batch_end_time, batch_index, batch_no, batch_size, batch_start_time, batch_time, batch_time_text, batch_year, batcher_name, batcher_user_level, cement1_target, cement2_target, cement3_target, cement4_target, cust_id, customer_code, filler_target, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, int_id, mixer_capacity, mixing_time, order_no, ordered_qty, plant_id, production_qty, recipe_code, recipe_name, returned_qty, schedule_id, silica_target, site, slurry_target, truck_driver, truck_no, water1_target, water2_target, withthisload, wo_id) VALUES (83519, 3, 0, 0, 0, '2021-08-05', '17:29:25', 1, 4965, 1, NULL, '17:23:25', NULL, NULL, 'NA', 'NA', 0, 345, 0, 0, 474, '1', 0, 880, 250, 369, 1485, 0, 0, 1, 0, 0, NULL, NULL, 586, 4, 'M25 DALMIA', 'M25 DALMIA', NULL, NULL, 0, NULL, NULL, 'NA', 'MANUAL', 162, 0, 4, 262);


--
-- TOC entry 3405 (class 0 OID 17024)
-- Dependencies: 218
-- Data for Name: trn_rmc_batch_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411258, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 6, 607, 0, '14:24:51', NULL, NULL, 66, NULL, 230, 25, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 121, NULL, 540, 234, NULL, 880, 161, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 57, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411257, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 5, 607, 0, '14:23:55', NULL, NULL, 67, NULL, 230, 27, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 172, NULL, 540, 251, NULL, 880, 197, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 52, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411256, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 4, 607, 0, '14:22:17', NULL, NULL, 64, NULL, 230, 18, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 134, NULL, 540, 241, NULL, 880, 209, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 57, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411255, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 3, 607, 0, '14:21:19', NULL, NULL, 64, NULL, 230, 25, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 158, NULL, 540, 252, NULL, 880, 159, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 54, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411254, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 2, 607, 0, '14:20:23', NULL, NULL, 69, NULL, 230, 25, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 185, NULL, 540, 243, NULL, 880, 197, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 54, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411253, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 1, 607, 0, '14:19:22', NULL, NULL, 74, NULL, 230, 27, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 130, NULL, 540, 250, NULL, 880, 199, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 55, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411252, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 1, 5, 606, 0, '12:06:09', NULL, NULL, 70, NULL, 230, 26, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 171, NULL, 540, 256, NULL, 880, 211, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 61, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411251, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 4, 606, 0, '12:05:08', NULL, NULL, 64, NULL, 230, 28, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 172, NULL, 540, 255, NULL, 880, 188, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 60, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411250, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 3, 606, 0, '12:03:49', NULL, NULL, 73, NULL, 230, 28, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 170, NULL, 540, 269, NULL, 880, 192, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 56, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411249, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 2, 606, 0, '11:57:42', NULL, NULL, 68, NULL, 230, 20, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 135, NULL, 540, 279, NULL, 880, 186, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 53, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411248, 1, 0, NULL, NULL, 3150, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 1, 606, 0, '11:56:36', NULL, NULL, 79, NULL, 230, 29, NULL, 85, 0, NULL, 0, 0, NULL, 0, 558, NULL, 0, NULL, 0, 171, NULL, 540, 250, NULL, 880, 211, NULL, 0, 0, NULL, 0, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 657, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 44, NULL, 150, 0, NULL, 0, 0, 443);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411247, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 4, 4967, 1, '13:02:33', NULL, NULL, 169, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 426, NULL, 880, 235, NULL, 250, 181, NULL, 369, 136, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 81, NULL, 162, 0, NULL, 0, 2, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411246, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 3, 4967, 1, '13:01:33', NULL, NULL, 170, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 433, NULL, 880, 244, NULL, 250, 185, NULL, 369, 173, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 2, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411245, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 2, 4967, 1, '13:00:33', NULL, NULL, 167, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 434, NULL, 880, 250, NULL, 250, 182, NULL, 369, 136, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 87, NULL, 162, 0, NULL, 0, 2, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411244, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 1, 4967, 1, '12:59:33', NULL, NULL, 167, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 423, NULL, 880, 249, NULL, 250, 186, NULL, 369, 166, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 2, NULL, 0, NULL, NULL, NULL, NULL, NULL, 81, NULL, 162, 0, NULL, 0, 2, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411243, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 8, 4966, 1, '10:21:52', NULL, NULL, 171, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 437, NULL, 880, 246, NULL, 250, 185, NULL, 369, 135, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 82, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411242, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 7, 4966, 1, '10:20:52', NULL, NULL, 168, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 435, NULL, 880, 241, NULL, 250, 182, NULL, 369, 144, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 81, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411241, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 6, 4966, 1, '10:19:52', NULL, NULL, 168, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 424, NULL, 880, 237, NULL, 250, 187, NULL, 369, 137, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 83, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411240, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 5, 4966, 1, '10:18:52', NULL, NULL, 167, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 427, NULL, 880, 240, NULL, 250, 186, NULL, 369, 136, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411239, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 4, 4966, 1, '10:17:52', NULL, NULL, 168, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 436, NULL, 880, 243, NULL, 250, 187, NULL, 369, 136, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411238, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 3, 4966, 1, '10:16:52', NULL, NULL, 169, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 433, NULL, 880, 238, NULL, 250, 182, NULL, 369, 134, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 81, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411237, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 2, 4966, 1, '10:15:52', NULL, NULL, 182, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 428, NULL, 880, 235, NULL, 250, 186, NULL, 369, 137, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411236, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-05-08', 0, 1, 4966, 1, '10:14:52', NULL, NULL, 167, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 426, NULL, 880, 312, NULL, 250, 186, NULL, 369, 134, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411235, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 7, 4965, 1, '17:29:25', NULL, NULL, 167, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 423, NULL, 880, 235, NULL, 250, 219, NULL, 369, 179, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 79, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411234, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 6, 4965, 1, '17:28:25', NULL, NULL, 168, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 426, NULL, 880, 236, NULL, 250, 180, NULL, 369, 139, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411233, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 5, 4965, 1, '17:27:25', NULL, NULL, 168, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 422, NULL, 880, 248, NULL, 250, 179, NULL, 369, 135, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 81, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411232, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 4, 4965, 1, '17:26:25', NULL, NULL, 170, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 428, NULL, 880, 246, NULL, 250, 186, NULL, 369, 145, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411231, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 3, 4965, 1, '17:25:25', NULL, NULL, 169, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 426, NULL, 880, 244, NULL, 250, 181, NULL, 369, 140, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411230, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 2, 4965, 1, '17:24:25', NULL, NULL, 170, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 448, NULL, 880, 242, NULL, 250, 181, NULL, 369, 140, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 82, NULL, 162, 0, NULL, 0, 4, 262);
INSERT INTO public.trn_rmc_batch_detail (trans_id, adm1_actual1, adm1_actual2, adm1_correction1, adm1_correction2, adm1_target1, adm1_target2, adm2_actual1, adm2_actual2, adm2_correction1, adm2_correction2, adm2_target1, adm2_target2, batch_date, batch_end_flag, batch_index, batch_no, batch_size, batch_time, batch_time_text, batch_year, cement1_actual, cement1_correction, cement1_target, cement2_actual, cement2_correction, cement2_target, cement3_actual, cement3_correction, cement3_target, cement4_actual, cement4_correction, cement4_target, con_id, consistancy, filler1_actual, filler1_correction, filler1_target, gate1_actual, gate1_moisture, gate1_target, gate2_actual, gate2_moisture, gate2_target, gate3_actual, gate3_moisture, gate3_target, gate4_actual, gate4_moisture, gate4_target, gate5_actual, gate5_moisture, gate5_target, gate6_actual, gate6_moisture, gate6_target, int_id, ordered_qty, pigment_actual, pigment_target, plant_id, production_qty, returned_qty, silica_actual, silica_correction, silica_target, slurry_actual, slurry_correction, slurry_target, water1_actual, water1_correction, water1_target, water2_actual, water2_correction, water2_target, withthisload, wo_id) VALUES (411229, 2, 0, NULL, NULL, 3, 0, 0, 0, NULL, NULL, 0, 0, '2021-04-08', 0, 1, 4965, 1, '17:23:25', NULL, NULL, 166, NULL, 0, 0, NULL, 345, 0, NULL, 0, 0, NULL, 0, 474, NULL, 0, NULL, 0, 422, NULL, 880, 243, NULL, 250, 179, NULL, 369, 136, NULL, 1485, 0, NULL, 0, 0, NULL, 0, 1, NULL, NULL, NULL, 586, 4, NULL, 0, NULL, NULL, NULL, NULL, NULL, 80, NULL, 162, 0, NULL, 0, 4, 262);


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 221
-- Name: seq_customer; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_customer', 1, false);


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 223
-- Name: seq_name_setup; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_name_setup', 1, false);


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 219
-- Name: seq_plant; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_plant', 1, false);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 210
-- Name: seq_rmc_batch_detail_devicetransmission; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_rmc_batch_detail_devicetransmission', 1, false);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 209
-- Name: seq_rmc_batch_devicetransmission; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_rmc_batch_devicetransmission', 1, false);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 217
-- Name: trn_rmc_batch_detail_trans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trn_rmc_batch_detail_trans_id_seq', 1, false);


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 215
-- Name: trn_rmc_batch_trans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.trn_rmc_batch_trans_id_seq', 1, false);


--
-- TOC entry 3256 (class 2606 OID 33174)
-- Name: mst_plant pk_plant_plantid; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_plant
    ADD CONSTRAINT pk_plant_plantid PRIMARY KEY (plant_id);


--
-- TOC entry 3254 (class 2606 OID 17031)
-- Name: trn_rmc_batch_detail trn_rmc_batch_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trn_rmc_batch_detail
    ADD CONSTRAINT trn_rmc_batch_detail_pkey PRIMARY KEY (trans_id);


--
-- TOC entry 3252 (class 2606 OID 17022)
-- Name: trn_rmc_batch trn_rmc_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trn_rmc_batch
    ADD CONSTRAINT trn_rmc_batch_pkey PRIMARY KEY (trans_id);


--
-- TOC entry 3258 (class 2606 OID 33176)
-- Name: mst_plant uk_plant_plantname; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_plant
    ADD CONSTRAINT uk_plant_plantname UNIQUE (plant_name);


--
-- TOC entry 3260 (class 2606 OID 33178)
-- Name: mst_plant uk_plant_plantregno; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mst_plant
    ADD CONSTRAINT uk_plant_plantregno UNIQUE (plant_reg_no);


-- Completed on 2021-11-23 14:50:55

--
-- PostgreSQL database dump complete
--

