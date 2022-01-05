CREATE SEQUENCE seq_rmc_batch_devicetransmission
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


CREATE TABLE trn_rmc_batch
(
    trans_id numeric(20,0) NOT NULL DEFAULT nextval('seq_rmc_batch_devicetransmission'::regclass),
    int_id numeric(3,0) NOT NULL DEFAULT 0,
    cust_id numeric(5,0) NOT NULL DEFAULT 0,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) NOT NULL DEFAULT 0,
    batch_no numeric,
    batch_index numeric(11,0) DEFAULT NULL::numeric,
    batch_date date,
    batch_time time without time zone,
    batch_time_text character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    batch_start_time character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    batch_end_time character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    batch_year numeric(11,0) DEFAULT NULL::numeric,
    batcher_name character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    batcher_user_level character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    customer_code character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    recipe_code character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    recipe_name character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    mixing_time numeric,
    mixer_capacity numeric,
    site character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    truck_no character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    truck_driver character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    production_qty numeric,
    ordered_qty numeric,
    returned_qty numeric,
    withthisload numeric,
    batch_size numeric,
    order_no character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    schedule_id character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    gate1_target numeric(11,0) DEFAULT NULL::numeric,
    gate2_target numeric(11,0) DEFAULT NULL::numeric,
    gate3_target numeric(11,0) DEFAULT NULL::numeric,
    gate4_target numeric(11,0) DEFAULT NULL::numeric,
    gate5_target numeric(11,0) DEFAULT NULL::numeric,
    gate6_target numeric(11,0) DEFAULT NULL::numeric,
    cement1_target numeric(11,0) DEFAULT NULL::numeric,
    cement2_target numeric(11,0) DEFAULT NULL::numeric,
    cement3_target numeric(11,0) DEFAULT NULL::numeric,
    cement4_target numeric(11,0) DEFAULT NULL::numeric,
    filler_target numeric(11,0) DEFAULT NULL::numeric,
    water1_target numeric(11,0) DEFAULT NULL::numeric,
    slurry_target numeric(11,0) DEFAULT NULL::numeric,
    water2_target numeric(11,0) DEFAULT NULL::numeric,
    silica_target numeric(11,0) DEFAULT NULL::numeric,
    adm1_target1 numeric,
    adm1_target2 numeric,
    adm2_target1 numeric,
    adm2_target2 numeric,
    CONSTRAINT pk_rmc_batch_devicetransmission_transid PRIMARY KEY (trans_id)
)

-- Batch Details

CREATE SEQUENCE seq_rmc_batch_detail_devicetransmission
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE trn_rmc_batch_detail
(
    trans_id numeric(20,0) NOT NULL DEFAULT nextval('seq_rmc_batch_detail_devicetransmission'::regclass),
    int_id numeric(3,0) NOT NULL DEFAULT 0,
    con_id numeric(5,0) NOT NULL DEFAULT 0,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) NOT NULL DEFAULT 0,
    batch_no numeric,
    batch_index numeric(11,0) DEFAULT NULL::numeric,
    batch_date date,
    batch_time time without time zone,
    batch_time_text character varying(255) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    batch_year numeric(11,0) DEFAULT NULL::numeric,
    consistancy numeric(11,0) DEFAULT NULL::numeric,
    production_qty numeric,
    ordered_qty numeric,
    returned_qty numeric,
    withthisload numeric,
    batch_size numeric,
    gate1_actual numeric(11,0) DEFAULT NULL::numeric,
    gate1_target numeric(11,0) DEFAULT NULL::numeric,
    gate1_moisture numeric,
    gate2_actual numeric(11,0) DEFAULT NULL::numeric,
    gate2_target numeric(11,0) DEFAULT NULL::numeric,
    gate2_moisture numeric,
    gate3_actual numeric(11,0) DEFAULT NULL::numeric,
    gate3_target numeric(11,0) DEFAULT NULL::numeric,
    gate3_moisture numeric,
    gate4_actual numeric(11,0) DEFAULT NULL::numeric,
    gate4_target numeric(11,0) DEFAULT NULL::numeric,
    gate4_moisture numeric,
    gate5_actual numeric(11,0) DEFAULT NULL::numeric,
    gate5_target numeric(11,0) DEFAULT NULL::numeric,
    gate5_moisture numeric,
    gate6_actual numeric(11,0) DEFAULT NULL::numeric,
    gate6_target numeric(11,0) DEFAULT NULL::numeric,
    gate6_moisture numeric,
    cement1_actual numeric(11,0) DEFAULT NULL::numeric,
    cement1_target numeric(11,0) DEFAULT NULL::numeric,
    cement1_correction numeric,
    cement2_actual numeric(11,0) DEFAULT NULL::numeric,
    cement2_target numeric(11,0) DEFAULT NULL::numeric,
    cement2_correction numeric,
    cement3_actual numeric(11,0) DEFAULT NULL::numeric,
    cement3_target numeric(11,0) DEFAULT NULL::numeric,
    cement3_correction numeric,
    cement4_actual numeric(11,0) DEFAULT NULL::numeric,
    cement4_target numeric(11,0) DEFAULT NULL::numeric,
    cement4_correction numeric,
    filler1_actual numeric(11,0) DEFAULT NULL::numeric,
    filler1_target numeric(11,0) DEFAULT NULL::numeric,
    filler1_correction numeric,
    water1_actual numeric(11,0) DEFAULT NULL::numeric,
    water1_target numeric(11,0) DEFAULT NULL::numeric,
    water1_correction numeric,
    water2_actual numeric(11,0) DEFAULT NULL::numeric,
    water2_target numeric(11,0) DEFAULT NULL::numeric,
    water2_correction numeric,
    silica_actual numeric(11,0) DEFAULT NULL::numeric,
    silica_target numeric(11,0) DEFAULT NULL::numeric,
    silica_correction numeric,
    slurry_actual numeric(11,0) DEFAULT NULL::numeric,
    slurry_target numeric(11,0) DEFAULT NULL::numeric,
    slurry_correction numeric,
    adm1_actual1 numeric,
    adm1_target1 numeric,
    adm1_correction1 numeric,
    adm1_actual2 numeric,
    adm1_target2 numeric,
    adm1_correction2 numeric,
    adm2_actual1 numeric,
    adm2_target1 numeric,
    adm2_correction1 numeric,
    adm2_actual2 numeric,
    adm2_target2 numeric,
    adm2_correction2 numeric,
    pigment_actual numeric,
    pigment_target numeric,
    batch_end_flag numeric DEFAULT 0,
    CONSTRAINT pk_rmc_batch_detail_devicetransmission_transid PRIMARY KEY (trans_id)
)


-------------------- Insert queries ------------------------------


INSERT INTO trn_rmc_batch(
	trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2)
	VALUES (83523, 1, 558, 657, 443, 607, 1, '8/5/2021', '14:19:22', NULL, NULL, '14:25:48', NULL, 'Batcher', 'User', 1, 'M25', 'M25', 0,0,NULL, 'MH24F8867', 'dagdu', 2.03, NULL, NULL, 0, 0.29, NULL, NULL, 540, 880, 660, 0, 0, 0, 230, 85, 0, 0, 0, 150, NULL, 0, NULL, 3150, 0, 0, 0);

INSERT INTO trn_rmc_batch(
	trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2)
	VALUES (83522, 1, 558, 657, 443, 606, 1, '8/5/2021', '11:56:36', NULL, NULL, '12:06:09', NULL, 'Batcher', 'User', 1, 'M25', 'M25', 0,0,NULL, 'MH24F8867', 'dagdu', 1.5, NULL, NULL, 0, 0.3, NULL, NULL, 540, 880, 660, 0, 0, 0, 230, 85, 0, 0, 0, 150, NULL, 0, NULL, 3150, 0, 0, 0);

INSERT INTO trn_rmc_batch(
	trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2)
	VALUES (83521, 1, 474, 586, 262, 4967, 1, '8/5/2021', '12:59:33', NULL, NULL, '13:02:33', NULL, 'NA', 'NA', 1, 'M25 DALMIA', 'M25 DALMIA', 0,0,NULL, 'MANUAL', 'NA', 2, NULL, NULL, 2, 0.5, NULL, NULL, 880, 250, 369, 1485, 0, 0, 0, 345, 0, 0, 0, 162, NULL, 0, NULL, 3.403, 0, 0, 0);

INSERT INTO trn_rmc_batch(
	trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2)
	VALUES (83520, 1, 474, 586, 262, 4966, 1, '8/5/2021', '10:14:52', NULL, NULL, '10:21:52', NULL, 'NA', 'NA', 1, 'M25 DALMIA', 'M25 DALMIA', 0,0,NULL, 'MANUAL', 'NA', 4, NULL, NULL, 4, 0.5, NULL, NULL, 880, 250, 369, 1485, 0, 0, 0, 345, 0, 0, 0, 162, NULL, 0, NULL, 3.403, 0, 0, 0);

INSERT INTO trn_rmc_batch(
	trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2)
	VALUES (83519, 1, 474, 586, 262, 4965, 1, '8/5/2021', '17:23:25', NULL, NULL, '17:29:25', NULL, 'NA', 'NA', 1, 'M25 DALMIA', 'M25 DALMIA', 0,0,NULL, 'MANUAL', 'NA', 3.5, NULL, NULL, 3.5, 0.5, NULL, NULL, 880, 250, 369, 1485, 0, 0, 0, 345, 0, 0, 0, 162, NULL, 0, NULL, 3.403, 0, 0, 0);



-------------------------------------------------   batchDetail Inserts -------------------------------------------------


INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411259,	1,	558,	657,	443,	607,	7,	'5/8/2021',	'14:25:48',	NULL,	NULL,NULL,2.03,	NULL,	NULL,	0,	0.29,	190,540,	NULL,	275,880,NULL,197,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,65,230,NULL,18,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,54,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.827,3150,NULL,0,0,NULL,0,0,NULL,0,NULL,NULL,NULL,1);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411258,	1,	558,	657,	443,	607,	6,	'5/8/2021',	'14:24:51',	NULL,	NULL,NULL,2.03,	NULL,	NULL,	0,	0.29,	121,	540,	NULL,	234,880,NULL,161,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,66,230,NULL,25,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,57,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.954,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411257,	1,	558,	657,	443	,607,	5,	'5/8/2021',	'14:23:55',	NULL,NULL,NULL,2.03,	NULL,	NULL,	0,	0.29,	172,	540,	NULL,	251,880,NULL,197,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,67,230,NULL,27,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,52,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.941,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411256	,1,	558,	657,	443	,607,	4,	'5/8/2021',	'14:22:17',	NULL,	NULL,NULL,2.03,	NULL,	NULL,	0,	0.29,	134,	540,	NULL,	241,880,NULL,209,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,64,230,NULL,18,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,57,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.942,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411255,	1	,558,	657,	443	,607,	3,	'5/8/2021',	'14:21:19',	NULL,	NULL,NULL,2.03,	NULL,	NULL,	0,	0.29,	158,	540,	NULL,	252,880,NULL,159,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,64,230,NULL,25,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,54,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.796,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411254,	1	,558,	657,	443	,607,	2,	'5/8/2021',	'14:20:23',	NULL,	NULL,	NULL,	2.03,	NULL,	NULL,	0,	0.29,	185,	540,	NULL,	243,880,NULL,197,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,69,230,NULL,25,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,54,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.916,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411253,	1	,558,	657,	443,	607,	1,	'5/8/2021',	'14:19:22',	NULL,	NULL,	NULL,	2.03,	NULL,	NULL,	0,	0.29,	130,	540,	NULL,	250,880,NULL,199,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,74,230,NULL,27,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,55,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.93,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411252,	1	,558,	657,	443,	606,	5,	'5/8/2021',	'12:06:09',	NULL,	NULL,	NULL,	1.5,	NULL,	NULL,	0,	0.3,	171,	540,	NULL,	256,880,NULL,211,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,70,230,NULL,26,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,61,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.94,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,1);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411251,	1	,558,	657,	443,	606,	4,	'5/8/2021',	'12:05:08',	NULL,	NULL,	NULL,	1.5,	NULL,	NULL,	0,	0.3,	172,	540,	NULL,	255,880,NULL,188,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,64,230,NULL,28,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,60,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.927,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411250,	1	,558,	657,	443,	606,	3,	'5/8/2021',	'12:03:49',	NULL,	NULL,	NULL,	1.5,	NULL,	NULL,	0,	0.3,	170,	540,	NULL,	269,880,NULL,192,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,73,230,NULL,28,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,56,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.95,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411249,	1	,558,	657,	443,	606,	2,	'5/8/2021',	'11:57:42',	NULL,	NULL,	NULL,	1.5	,NULL,	NULL,	0,	0.3,	135,	540,	NULL,	279,880,NULL,186,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,68,230,NULL,20,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,53,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.006,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411248,	1	,558,	657,	443,	606,	1,	'5/8/2021',	'11:56:36',	NULL,	NULL,	NULL,	1.5,	NULL,	NULL,	0,	0.3,	171,	540,	NULL,	250,880,NULL,211,0,NULL,0,0,NULL,0,0,NULL,0,0,NULL,79,230,NULL,29,85,NULL,0,0,NULL,0,0,NULL,0,0,NULL,44,150,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.947,3150,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411247,	1	,474,	586,	262,	4967,	4,	'5/8/2021',	'13:02:33',	NULL,	NULL,	NULL,	2,	NULL,	NULL,	2,	0.5,	426,	880,	NULL,	235,250,NULL,181,369,NULL,136,1485,NULL,0,0,NULL,0,0,NULL,169,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,81,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.04,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411246	,1	,474,	586,	262,	4967,	3,	'5/8/2021',	'13:01:33',	NULL,	NULL,	NULL,	2,	NULL,	NULL,	2,	0.5,	433,	880,	NULL,	244,250,NULL,185,369,NULL,173,1485,NULL,0,0,	NULL,0,0,NULL,170,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.13,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411245	,1	,474,	586,	262,	4967,	2,	'5/8/2021',	'13:00:33',	NULL,	NULL,	NULL,	2,	NULL,	NULL,	2,	0.5,	434,	880,	NULL,	250,	250,NULL,182,369,NULL,136,1485,NULL,0,0,	NULL,0,0,NULL,167,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,87,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.07,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,	NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411244	,1	,474,	586,	262,	4967,	1,	'5/8/2021',	'12:59:33',	NULL,	NULL,	NULL,	2,	NULL,	NULL,	2,	0.5,	423,	880,	NULL,	249,	250,NULL,186,369,NULL,166,1485,NULL,0,0,	NULL,0,0,NULL,167,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,81,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.85,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411243	,1	,474,	586,	262,	4966,	8,	'5/8/2021',	'10:21:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	437,	880,	NULL,	246,	250,NULL,185,369,NULL,135,1485,NULL,0,0,	NULL,0,0,NULL,171,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,82,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.98,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411242	,1	,474,	586,	262,	4966,	7,	'5/8/2021',	'10:20:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	435,	880,	NULL,	241,	250,NULL,182,369,NULL,144,1485,NULL,0,0,	NULL,0,0,NULL,168,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,81,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.09,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411241	,1	,474,	586,	262,	4966,	6,	'5/8/2021',	'10:19:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	424,	880,	NULL,	237,	250,NULL,187,369,NULL,137,1485,NULL,0,0,	NULL,0,0,NULL,168,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,83,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.08,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411240	,1	,474,	586,	262,	4966,	5,	'5/8/2021',	'10:18:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	427,	880,	NULL,	240,	250,NULL,186,369,NULL,136,1485,NULL,0,0,	NULL,0,0,NULL,167,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.25,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411239	,1	,474,	586,	262,	4966,	4,	'5/8/2021',	'10:17:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	436,	880,	NULL,	243,	250,NULL,187,369,NULL,136,1485,NULL,0,0,	NULL,0,0,NULL,168,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.1,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411238	,1	,474,	586,	262,	4966,	3,	'5/8/2021',	'10:16:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	433,	880,	NULL,	238,	250,NULL,182,369,NULL,134,1485,NULL,0,0,	NULL,0,0,NULL,169,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,81,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.16,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411237	,1	,474,	586,	262,	4966,	2,	'5/8/2021',	'10:15:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	428,	880,	NULL,	235,	250,NULL,186,369,NULL,137,1485,NULL,0,0,	NULL,0,0,NULL,182,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.01,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411236	,1	,474,	586,	262,	4966,	1,	'5/8/2021',	'10:14:52',	NULL,	NULL,	NULL,	4,	NULL,	NULL,	4,	0.5,	426,	880,	NULL,	312,	250,NULL,186,369,NULL,134,1485,NULL,0,0,	NULL,0,0,NULL,167,0,NULL,0,345,NULL,0,0,	NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.9,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411235	,1	,474,	586,	262,	4965,	7,	'4/8/2021',	'17:29:25',	NULL,	NULL,	NULL,	3.5,	NULL,	NULL,	3.5,	0.5,	423,	880,	NULL,	235,	250,NULL,219,369,NULL,179,1485,NULL,0,0,NULL,0,0,NULL,167,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,79,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.05,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411234	,1	,474,	586,	262,	4965,	6,	'4/8/2021',	'17:28:25',	NULL,	NULL,	NULL,	3.5,	NULL,	NULL,	3.5,	0.5,	426,	880,	NULL,	236,	250,NULL,180,369,NULL,139,1485,NULL,0,0,NULL,0,0,NULL,168,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.01,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411233	,1	,474,	586,	262,	4965,	5,	'4/8/2021',	'17:27:25',	NULL,	NULL,	NULL,	3.5,	NULL,	NULL,	3.5,	0.5,	422,	880,	NULL,	248,	250,NULL,179,369,NULL,135,1485,NULL,0,0,NULL,0,0,NULL,168,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,81,162,NULL,0,0,NULL,	NULL,NULL,NULL,NULL,NULL,NULL,2,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411232	,1	,474,	586,	262,	4965,	4,	'4/8/2021',	'17:26:25',	NULL,	NULL,	NULL,	3.5,	NULL,	NULL,	3.5,	0.5,	428,	880,	NULL,	246,	250,NULL,186,369,NULL,145,1485,NULL,0,0,NULL,0,0,NULL,170,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,	NULL,NULL,NULL,NULL,NULL,NULL,2.07,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411231	,1	,474,	586,	262,	4965,	3,	'4/8/2021',	'17:25:25',	NULL,	NULL,	NULL,	3.5,	NULL,	NULL,	3.5,	0.5,	426,	880,	NULL,	244,	250,NULL,181,369,NULL,140,1485,NULL,0,0,NULL,0,0,NULL,169,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,	NULL,NULL,NULL,NULL,NULL,NULL,2.04,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,	NULL,	0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411230	,1	,474,	586,	262,4965	,2,	'4/8/2021',	'17:24:25',	NULL,	NULL,	NULL,	3.5	,NULL,	NULL,	3.5,	0.5,	448,	880,	NULL,	242,	250,NULL,181,369,NULL,140,1485,NULL,0,0,NULL,0,0,NULL,170,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,82,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2.05,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,NULL,0);
INSERT INTO trn_rmc_batch_detail(trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag)VALUES (411229	,1	,474,	586,	262,	4965,	1,'4/8/2021',	'17:23:25',NULL,NULL,NULL,3.5,NULL,NULL,3.5,0.5,422,880,NULL,243,250,NULL,179,369,NULL,136,1485,NULL,0,0,NULL,0,0,NULL,166,0,NULL,0,345,NULL,0,0,NULL,0,0,NULL,0,0,NULL,80,162,NULL,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.75,3.403,NULL,0,0,NULL,0,0,NULL,0,0,NULL,NULL,	NULL,	0);


CREATE SEQUENCE seq_plant
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


CREATE TABLE mst_plant
(
    plant_id numeric(7,0) NOT NULL DEFAULT nextval('seq_plant'::regclass),
    con_id numeric(5,0) NOT NULL,
    int_id numeric(3,0) NOT NULL,
    plant_name character varying(100) COLLATE pg_catalog."default",
    plant_sr_no character varying(50) COLLATE pg_catalog."default",
    plant_reg_no character varying(50) COLLATE pg_catalog."default",
    plant_reg_date date,
    plant_address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    plant_details character varying(255) COLLATE pg_catalog."default",
    plant_install_date date,
    plant_contact_person character varying(100) COLLATE pg_catalog."default",
    plant_latitude numeric NOT NULL,
    plant_longitude numeric NOT NULL,
    plant_contact_mobile_no character varying(15) COLLATE pg_catalog."default",
    plant_type numeric(2,0) NOT NULL,
    plant_subtype numeric(2,0) DEFAULT NULL::numeric,
    plant_capacity character varying(100) COLLATE pg_catalog."default",
    plant_valid_from date,
    plant_valid_to date,
    plant_status numeric(1,0) NOT NULL DEFAULT 1,
    geofence numeric(3,0) DEFAULT NULL::numeric,
    comp_location_id numeric(5,0),
    device_imei_no character varying(20) COLLATE pg_catalog."default" NOT NULL,
    rec_status numeric(1,0),
    created_by numeric(5,0) NOT NULL,
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    modified_by numeric(5,0) DEFAULT NULL::numeric,
    modified_on timestamp without time zone,
    sync_status numeric(1,0) NOT NULL DEFAULT 0,
    register_mob_no character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT pk_plant_plantid PRIMARY KEY (plant_id),
    CONSTRAINT uk_plant_plantname UNIQUE (plant_name),
    CONSTRAINT uk_plant_plantregno UNIQUE (plant_reg_no),
    CONSTRAINT uk_plant_plantsrno UNIQUE (plant_sr_no)
)


--------------------------------------
CREATE SEQUENCE seq_customer
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999999
    CACHE 1;


CREATE TABLE mst_customer_vendor
(
    cust_vendor_id numeric(7,0) NOT NULL DEFAULT nextval('seq_customer'::regclass),
    cust_vendor_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    cust_vendor_addr character varying(250) COLLATE pg_catalog."default" NOT NULL DEFAULT '-'::character varying,
    cust_vendor_lat numeric(10,7),
    cust_vendor_long numeric(10,7),
    cust_vendor_city character varying(50) COLLATE pg_catalog."default" NOT NULL DEFAULT '-'::character varying,
    cust_vendor_state_id numeric(2,0) NOT NULL DEFAULT 1,
    pin_code character varying(6) COLLATE pg_catalog."default" NOT NULL DEFAULT 0,
    ll_no1 character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    ll_no2 character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    mob_no1 character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    mob_no2 character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    wa_no1 character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    wa_no2 character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    email_id1 character varying(50) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    email_id2 character varying(50) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    cust_vendor_url character varying(100) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    fb_handle character varying(100) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    twr_handle character varying(100) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    pan_no character varying(10) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    gst_no character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    ifsc_code character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    bank_acc_no character varying(15) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    rec_status numeric(1,0) NOT NULL DEFAULT 1,
    action_by numeric(3,0) NOT NULL DEFAULT 1,
    action_on timestamp without time zone NOT NULL DEFAULT now(),
    hc_id numeric(2,0),
    bank_name character varying(50) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    cust_vendor_code character varying(15) COLLATE pg_catalog."default",
    cust_vendor_firm_name character varying(100) COLLATE pg_catalog."default",
    cust_vendor_firm_addr character varying(250) COLLATE pg_catalog."default",
    credit_limit numeric(13,2) DEFAULT 0,
    int_id numeric(2,0) NOT NULL DEFAULT 1,
    sap_code character varying(20) COLLATE pg_catalog."default",
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) COLLATE pg_catalog."default" DEFAULT 'M'::bpchar,
    file_path text COLLATE pg_catalog."default",
    is_customer smallint

)

insert into mst_customer_vendor values(5,'ddsdfd','sfsfdff',null,null,'fsfsdf',1,'411058',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,9,1,'3/1/2021  5:25:07 PM',1,null,'123','ffsdf',null,null,1,null,null,null,'M',null,null)
insert into mst_customer_vendor values(4,'aaa','aaa',null,null,'pune',1,'411058',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,9,1,'3/1/2021  5:31:10 PM',1,null,'wrwerwer','aaa',null,null,1,null,null,null,'M',null,null)



CREATE SEQUENCE seq_name_setup
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9999999999
    CACHE 1;


CREATE TABLE mst_name_setup
(
    trans_id numeric(9,0) NOT NULL DEFAULT nextval('seq_name_setup'::regclass),
    int_id numeric NOT NULL,
    hc_id numeric NOT NULL,
    plant_id numeric NOT NULL,
    agg1_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    agg1_item_id numeric,
    agg2_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    agg2_item_id numeric,
    agg3_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    agg3_item_id numeric,
    agg4_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    agg4_item_id numeric,
    agg5_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    agg5_item_id numeric,
    cement1_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    cement1_item_id numeric,
    cement2_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    cement2_item_id numeric,
    fill_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    fill_item_id numeric,
    water1_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    water1_item_id numeric,
    water2_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    water2_item_id numeric,
    admix1_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    admix1_item_id numeric,
    admix12_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    admix12_item_id numeric,
    admix2_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    admix2_item_id numeric,
    admix22_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    admix22_item_id numeric,
    silica_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    silica_item_id numeric,
    slurry_name character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    slurry_item_id numeric,
    pigname character varying(10) COLLATE pg_catalog."default" DEFAULT '-'::character varying,
    action_on timestamp without time zone NOT NULL DEFAULT now(),
    rec_status integer NOT NULL DEFAULT 1,
    insertion_type character(1) COLLATE pg_catalog."default" DEFAULT 'M'::bpchar
)

insert into mst_plant values(
657,1,1,'READYMIX CONCRETE','CP-45',null,'Pune',null,null,null,0,0,null,1,null,null,null,
null,1,null,null,'12345',1,1,'3/1/2021 12:37:21 AM',null,null,0,null

);