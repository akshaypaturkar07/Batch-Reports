PGDMP                          y            rmc_erp_16Dec    12.6    12.6 /   ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    211679    rmc_erp_16Dec    DATABASE     ?   CREATE DATABASE "rmc_erp_16Dec" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
    DROP DATABASE "rmc_erp_16Dec";
                postgres    false                        2615    211680    erp    SCHEMA        CREATE SCHEMA erp;
    DROP SCHEMA erp;
                postgres    false            v           1247    211684    udt_get_all_user    TYPE     N  CREATE TYPE erp.udt_get_all_user AS (
	user_id integer,
	user_name character varying(20),
	user_type integer,
	enity_name character varying(50),
	user_mobile_no numeric(20,0),
	user_email_id character varying(50),
	user_general_id integer,
	user_type_name character varying(20),
	"User_Desc" character varying(100),
	hc_id integer
);
     DROP TYPE erp.udt_get_all_user;
       erp          postgres    false    6            y           1247    211687    udt_invoice_so_items    TYPE     q   CREATE TYPE erp.udt_invoice_so_items AS (
	so_id numeric,
	item_id numeric,
	item_name character varying(100)
);
 $   DROP TYPE erp.udt_invoice_so_items;
       erp          postgres    false    6            ?           1247    211690    udt_poi_details_grn    TYPE       CREATE TYPE erp.udt_poi_details_grn AS (
	po_iw_id numeric(10,0),
	item_id numeric(10,0),
	item_name character varying(100),
	hsn_code numeric(6,0),
	item_code character varying(9),
	plant_id numeric(7,0),
	plant_name character varying(100),
	poi_no numeric(10,0)
);
 #   DROP TYPE erp.udt_poi_details_grn;
       erp          postgres    false    6                       1255    211707 K   get_presetdata_key(character varying, character varying, character varying)    FUNCTION     ?  CREATE FUNCTION erp.get_presetdata_key(dbtablename character varying, dbcolumnname character varying, presetdatavalue character varying) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE
	var_presetdata_key numeric(3) DEFAULT NULL;
BEGIN
	select presetdata_key into var_presetdata_key
	from erp.mst_presetdata 
	where lower(dbtable_name) = lower(dbtablename)
		and lower(dbcolumn_name) = lower(dbcolumnname)
		and lower(presetdata_value) = lower(presetdatavalue);

	RETURN var_presetdata_key;
END;
$$;
 ?   DROP FUNCTION erp.get_presetdata_key(dbtablename character varying, dbcolumnname character varying, presetdatavalue character varying);
       erp          postgres    false    6                       1255    211726    getfy(character varying)    FUNCTION     B  CREATE FUNCTION erp.getfy(paramdate character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$

DECLARE
    startYY numeric;
    prevYY numeric;
    mon numeric;
    yrFormat character varying;
    
BEGIN  

    -- SELECT DATE_PART('month', DATE_TRUNC('month', paramDate::date)), DATE_PART('year', DATE_TRUNC('year', paramDate::date)) into mon, startYY;
    SELECT DATE_PART('month', DATE_TRUNC('month', to_date(paramdate,'dd-mm-yyyy'))), DATE_PART('year', DATE_TRUNC('year', to_date(paramdate,'dd-mm-yyyy'))) into mon, startYY;
    
     if mon > 3 then
    	prevYY := startYY + 1;
        yrFormat := startYY::text || '-' || substring(prevYY::text,3,4);
    else
    	prevYY := startYY - 1;
        yrFormat := prevYY::text || '-' || substring(startYY::text,3,4);
      end if; 
    
    return yrFormat;
END;

$$;
 6   DROP FUNCTION erp.getfy(paramdate character varying);
       erp          postgres    false    6                       1255    211727    log_ad_mtn_emp_bioprofile()    FUNCTION     ?  CREATE FUNCTION erp.log_ad_mtn_emp_bioprofile() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN			
		INSERT INTO erp.mtn_emp_bioprofile_log
			(bioprof_id, emp_id, bio_id_type, scan_img_file_name, fp_rescan_reason, rec_status, action_type, action_by,  action_on)
		VALUES
			(OLD.bioprof_id, OLD.emp_id, OLD.bio_id_type, OLD.scan_img_file_name, OLD.fp_rescan_reason, OLD.rec_status, 3, OLD.action_by,  OLD.action_on); -- 3:Delete.
	RETURN NEW;	
END;
$$;
 /   DROP FUNCTION erp.log_ad_mtn_emp_bioprofile();
       erp          postgres    false    6            	           1255    211728    log_ai_mtn_emp_bioprofile()    FUNCTION     ?  CREATE FUNCTION erp.log_ai_mtn_emp_bioprofile() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN						
        INSERT INTO erp.mtn_emp_bioprofile_log
			(bioprof_id, emp_id, bio_id_type, scan_img_file_name, fp_rescan_reason, rec_status, action_type, action_by,  action_on)
		VALUES
			(NEW.bioprof_id, NEW.emp_id, NEW.bio_id_type, NEW.scan_img_file_name, NEW.fp_rescan_reason, NEW.rec_status, 1, NEW.action_by,  NEW.action_on); -- 1:Insert.
	RETURN NEW;	
END;
$$;
 /   DROP FUNCTION erp.log_ai_mtn_emp_bioprofile();
       erp          postgres    false    6            
           1255    211729    log_au_mtn_emp_bioprofile()    FUNCTION     ?  CREATE FUNCTION erp.log_au_mtn_emp_bioprofile() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN			
		INSERT INTO erp.mtn_emp_bioprofile_log
			(bioprof_id, emp_id, bio_id_type, scan_img_file_name, fp_rescan_reason, rec_status, action_type, action_by, action_on)
		VALUES
			(NEW.bioprof_id, NEW.emp_id, NEW.bio_id_type, NEW.scan_img_file_name, NEW.fp_rescan_reason, NEW.rec_status, 2, NEW.action_by,  NEW.action_on); -- 2:Update.
	RETURN NEW;	
END;
$$;
 /   DROP FUNCTION erp.log_au_mtn_emp_bioprofile();
       erp          postgres    false    6                       1255    211730    log_bu_file_detail()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_file_detail() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.file_detail_log
(file_id,file_path,page_name,page_id,rec_status,action_by,action_on ,hc_id ,int_id ,plant_id ,file_name ,insertion_type )
VALUES
(OLD.file_id,OLD.file_path,OLD.page_name,OLD.page_id,OLD.rec_status,OLD.action_by,now(),OLD.hc_id ,OLD.int_id ,OLD.plant_id ,OLD.file_name ,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 (   DROP FUNCTION erp.log_bu_file_detail();
       erp          postgres    false    6            ?           1255    211731    log_bu_mst_card()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_card() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_card_log
(card_id, card_name, card_type, card_access_string, rec_status, action_by, action_on, hc_id, int_id, plant_id, is_allocated, insertion_type )
VALUES
(OLD.card_id, OLD.card_name, OLD.card_type, OLD.card_access_string, OLD.rec_status, OLD.action_by, now(), OLD.hc_id, OLD.int_id, OLD.plant_id, OLD.is_allocated, OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 %   DROP FUNCTION erp.log_bu_mst_card();
       erp          postgres    false    6            ?           1255    211732     log_bu_mst_cust_vendor_contact()    FUNCTION     O  CREATE FUNCTION erp.log_bu_mst_cust_vendor_contact() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_cust_vendor_contact_log(
	con_id, cust_vendor_id, con_name, con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type)
	VALUES
(OLD.con_id,OLD.cust_vendor_id,OLD.con_name,OLD.con_designation,OLD.mob_no1,OLD.wa_no1,OLD.email_id1,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.int_id,OLD.sap_code,OLD.sap_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 4   DROP FUNCTION erp.log_bu_mst_cust_vendor_contact();
       erp          postgres    false    6                       1255    211733    log_bu_mst_general_ledger()    FUNCTION       CREATE FUNCTION erp.log_bu_mst_general_ledger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_general_ledger_log(
	trans_id, gen_led_no, gen_led_name, gn_no, trans_date, credit_amt, debit_amt, op_bal, br_id, is_inventory, is_tds_apply, depriciation, drcr_limit, ap_name, acp_name, address, state_name, pincode, mobile_no, email_id, pancard_no, salestax_no, ref_ac_type, ref_ac_no1, ref_ac_no2, ref_ac_name1, ref_ac_name2, ref_ac_details, ref_ac_address2, ref_ac_sitedistance2, gm_no, import_status, firm_add, phone_noo1, phone_noo2, phone_no_f1, phone_no_f2, ecc_no, tin_no, cgst_no, igst_no, gl_alias, drcr_limit_period, upload_status, lbt_no, hc_id, rec_status, action_by, action_on, int_id, plant_id, insertion_type)
	VALUES
(OLD.trans_id,OLD.gen_led_no,OLD.gen_led_name,OLD.gn_no,OLD.trans_date,OLD.credit_amt,OLD.debit_amt,OLD.op_bal,OLD.br_id,OLD.is_inventory,OLD.is_tds_apply,OLD.depriciation,OLD.drcr_limit,OLD.ap_name,OLD.acp_name,OLD.address,OLD.state_name,OLD.pincode,OLD.mobile_no,OLD.email_id,OLD.pancard_no,OLD.salestax_no,OLD.ref_ac_type,OLD.ref_ac_no1,OLD.ref_ac_no2,OLD.ref_ac_name1,OLD.ref_ac_name2,OLD.ref_ac_details,OLD.ref_ac_address2,OLD.ref_ac_sitedistance2,OLD.gm_no,OLD.import_status,OLD.firm_add,OLD.phone_noo1,OLD.phone_noo2,OLD.phone_no_f1,OLD.phone_no_f2,OLD.ecc_no,OLD.tin_no,OLD.cgst_no,OLD.igst_no,OLD.gl_alias,OLD.drcr_limit_period,OLD.upload_status,OLD.lbt_no,OLD.hc_id,OLD.rec_status,OLD.action_by,now(),OLD.int_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 /   DROP FUNCTION erp.log_bu_mst_general_ledger();
       erp          postgres    false    6                       1255    211734    log_bu_mst_host_company()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_host_company() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_host_company_log(
	hc_id, comp_name, comp_addr, comp_lat, comp_long, comp_city, comp_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, comp_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, comp_logo, bank_branch, int_id, insertion_type)
	VALUES 
(OLD.hc_id,OLD.comp_name,OLD.comp_addr,OLD.comp_lat,OLD.comp_long,OLD.comp_city,OLD.comp_state_id,OLD.pin_code,OLD.ll_no1,OLD.ll_no2,OLD.mob_no1,OLD.mob_no2,OLD.wa_no1,OLD.wa_no2,OLD.email_id1,OLD.email_id2,OLD.comp_url,OLD.fb_handle,OLD.twr_handle,OLD.pan_no,OLD.gst_no,OLD.ifsc_code,OLD.bank_acc_no,OLD.rec_status,OLD.action_by,now(),OLD.comp_logo,OLD.bank_branch,OLD.int_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 -   DROP FUNCTION erp.log_bu_mst_host_company();
       erp          postgres    false    6                       1255    211735    log_bu_mst_integrator()    FUNCTION     }  CREATE FUNCTION erp.log_bu_mst_integrator() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_integrator_log(
	int_id, int_name, int_shortname, int_address, int_phone1, int_phone2, int_mobile1, int_mobile2, int_email1, int_email2, int_logo_path, rec_status, action_by, action_on, plant_id, hc_id, insertion_type)
	VALUES 
(OLD.int_id,OLD.int_name,OLD.int_shortname,OLD.int_address,OLD.int_phone1,OLD.int_phone2,OLD.int_mobile1,OLD.int_mobile2,OLD.int_email1,OLD.int_email2,OLD.int_logo_path,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 +   DROP FUNCTION erp.log_bu_mst_integrator();
       erp          postgres    false    6                       1255    211736    log_bu_mst_item()    FUNCTION     =  CREATE FUNCTION erp.log_bu_mst_item() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO erp.mst_item_log
(item_id,ic_id,item_name,item_desc,make,sr_no,item_size,item_type,
min_stock_qty,unit_id,unit_rate,cgst_rate,sgst_rate,igst_rate,hsn_code,
item_rate_effective_from,item_code, rec_status, action_by, action_on,
hc_id,action_type,int_id,consumable,maintenance,insurance,item_display_criteria)
VALUES
(OLD.item_id,OLD.ic_id,OLD.item_name,OLD.item_desc,OLD.make,OLD.sr_no,
OLD.item_size,OLD.item_type,OLD.min_stock_qty,OLD.unit_id,OLD.unit_rate,
OLD.cgst_rate,OLD.sgst_rate,OLD.igst_rate,OLD.hsn_code,OLD.item_rate_effective_from,
OLD.item_code, OLD.rec_status, OLD.action_by, now(),OLD.hc_id,2,
OLD.int_id,OLD.consumable,OLD.maintenance,OLD.insurance,OLD.item_display_criteria); -- 2:Update.
RETURN NEW;
END;
$$;
 %   DROP FUNCTION erp.log_bu_mst_item();
       erp          postgres    false    6                       1255    211737    log_bu_mst_item_category()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_item_category() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_item_category_log(
	ic_id, cat_name, cat_desc, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type)
	VALUES  
(OLD.ic_id,OLD.cat_name,OLD.cat_desc,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.int_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 .   DROP FUNCTION erp.log_bu_mst_item_category();
       erp          postgres    false    6                       1255    211738     log_bu_mst_mst_customer_vendor()    FUNCTION     "  CREATE FUNCTION erp.log_bu_mst_mst_customer_vendor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_customer_vendor_log(
	cust_vendor_id, cust_vendor_name, cust_vendor_addr, cust_vendor_lat, cust_vendor_long, cust_vendor_city, cust_vendor_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, cust_vendor_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, hc_id, bank_name, cust_vendor_code, cust_vendor_firm_name, cust_vendor_firm_addr, credit_limit, int_id, sap_code, sap_id, plant_id, insertion_type, is_customer, import_trans_id)
	VALUES
(OLD.cust_vendor_id,OLD.cust_vendor_name,OLD.cust_vendor_addr,OLD.cust_vendor_lat,OLD.cust_vendor_long,OLD.cust_vendor_city,OLD.cust_vendor_state_id,OLD.pin_code,OLD.ll_no1,OLD.ll_no2,OLD.mob_no1,OLD.mob_no2,OLD.wa_no1,OLD.wa_no2,OLD.email_id1,OLD.email_id2,OLD.cust_vendor_url,OLD.fb_handle,OLD.twr_handle,OLD.pan_no,OLD.gst_no,OLD.ifsc_code,OLD.bank_acc_no,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.bank_name,OLD.cust_vendor_code,OLD.cust_vendor_firm_name,OLD.cust_vendor_firm_addr,OLD.credit_limit,OLD.int_id,OLD.sap_code,OLD.sap_id,OLD.plant_id,OLD.insertion_type,OLD.is_customer,OLD.import_trans_id); -- 1:Insert.
RETURN NEW;
END;
$$;
 4   DROP FUNCTION erp.log_bu_mst_mst_customer_vendor();
       erp          postgres    false    6                       1255    211739    log_bu_mst_name_setup()    FUNCTION     T  CREATE FUNCTION erp.log_bu_mst_name_setup() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_name_setup_log(
	trans_id, int_id, hc_id, plant_id, agg1_name, agg1_item_id, agg2_name, agg2_item_id, agg3_name, agg3_item_id, agg4_name, agg4_item_id, agg5_name, agg5_item_id, cement1_name, cement1_item_id, cement2_name, cement2_item_id, fill_name, fill_item_id, water1_name, water1_item_id, water2_name, water2_item_id, admix1_name, admix1_item_id, admix12_name, admix12_item_id, admix2_name, admix2_item_id, admix22_name, admix22_item_id, silica_name, silica_item_id, slurry_name, slurry_item_id, pigname, action_on, rec_status, insertion_type)
	VALUES 
(OLD.trans_id,OLD.int_id,OLD.hc_id,OLD.plant_id,OLD.agg1_name,OLD.agg1_item_id,OLD.agg2_name,OLD.agg2_item_id,OLD.agg3_name,OLD.agg3_item_id,OLD.agg4_name,OLD.agg4_item_id,OLD.agg5_name,OLD.agg5_item_id,OLD.cement1_name,OLD.cement1_item_id,OLD.cement2_name,OLD.cement2_item_id,OLD.fill_name,OLD.fill_item_id,OLD.water1_name,OLD.water1_item_id,OLD.water2_name,OLD.water2_item_id,OLD.admix1_name,OLD.admix1_item_id,OLD.admix12_name,OLD.admix12_item_id,OLD.admix2_name,OLD.admix2_item_id,OLD.admix22_name,OLD.admix22_item_id,OLD.silica_name,OLD.silica_item_id,OLD.slurry_name,OLD.slurry_item_id,OLD.pigname,now(),OLD.rec_status,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 +   DROP FUNCTION erp.log_bu_mst_name_setup();
       erp          postgres    false    6            ?           1255    211740 %   log_bu_mst_payment_other_conditions()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_payment_other_conditions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_payment_other_conditions_log(
	condition_id, condition_name, payment_condition, rec_status,  action_by, action_on, hc_id, int_id, plant_id, insertion_type)
	VALUES
(OLD.condition_id,OLD.condition_name,OLD.payment_condition,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.int_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 9   DROP FUNCTION erp.log_bu_mst_payment_other_conditions();
       erp          postgres    false    6                       1255    211741    log_bu_mst_plant()    FUNCTION     x  CREATE FUNCTION erp.log_bu_mst_plant() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_plant_log(
	plant_id, hc_id, int_id, plant_name, plant_reg_no, plant_reg_date, plant_address, plant_details, plant_install_date, plant_contact_person, plant_latitude, plant_longitude, plant_contact_mobile_no, plant_type, plant_subtype, plant_capacity, plant_valid_from, plant_valid_to, plant_status, geofence, comp_location_id, device_imei_no, rec_status, created_by, created_on, modified_by, modified_on, sync_status, sap_code, sap_id, insertion_type)
	VALUES
(OLD.plant_id,OLD.hc_id,OLD.int_id,OLD.plant_name,OLD.plant_reg_no,OLD.plant_reg_date,OLD.plant_address,OLD.plant_details,OLD.plant_install_date,OLD.plant_contact_person,OLD.plant_latitude,OLD.plant_longitude,OLD.plant_contact_mobile_no,OLD.plant_type,OLD.plant_subtype,OLD.plant_capacity,OLD.plant_valid_from,OLD.plant_valid_to,OLD.plant_status,OLD.geofence,OLD.comp_location_id,OLD.device_imei_no,OLD.rec_status,OLD.created_by,OLD.created_on,OLD.modified_by,now(),OLD.sync_status,OLD.sap_code,OLD.sap_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 &   DROP FUNCTION erp.log_bu_mst_plant();
       erp          postgres    false    6                       1255    211742    log_bu_mst_presetdata()    FUNCTION        CREATE FUNCTION erp.log_bu_mst_presetdata() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_presetdata_log(
	presetdata_id, dbtable_name, dbcolumn_name, presetdata_key, presetdata_value, presetdata_index, rec_status, action_by, action_on, hc_id, plant_id, insertion_type)
	VALUES 
(OLD.presetdata_id,OLD.dbtable_name,OLD.dbcolumn_name,OLD.presetdata_key,OLD.presetdata_value,OLD.presetdata_index,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 +   DROP FUNCTION erp.log_bu_mst_presetdata();
       erp          postgres    false    6                       1255    211743    log_bu_mst_role()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_role_log(
	role_id, role_name, role_desc, rec_status, action_by, action_on, hc_id, plant_id, insertion_type)
	VALUES
(OLD.role_id,OLD.role_name,OLD.role_desc,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 %   DROP FUNCTION erp.log_bu_mst_role();
       erp          postgres    false    6                       1255    211744    log_bu_mst_site()    FUNCTION     s  CREATE FUNCTION erp.log_bu_mst_site() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_site_log(
	site_id, hc_id, plant_id, site_name, site_type, rec_status, action_by, action_on, work_code, cust_id, site_distance, site_address, int_id, sap_code, sap_id, file_path, import_trans_id, insertion_type)
	VALUES  
(OLD.site_id,OLD.hc_id,OLD.plant_id,OLD.site_name,OLD.site_type,OLD.rec_status,OLD.action_by,now(),OLD.work_code,OLD.cust_id,OLD.site_distance,OLD.site_address,OLD.int_id,OLD.sap_code,OLD.sap_id,OLD.file_path,OLD.import_trans_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 %   DROP FUNCTION erp.log_bu_mst_site();
       erp          postgres    false    6                       1255    211745    log_bu_mst_site_contact()    FUNCTION     h  CREATE FUNCTION erp.log_bu_mst_site_contact() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_site_contact_log(
	site_con_id, cust_id, site_id, site_con_name, site_con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type)
	VALUES  
(OLD.site_con_id,OLD.cust_id,OLD.site_id,OLD.site_con_name,OLD.site_con_designation,OLD.mob_no1,OLD.wa_no1,OLD.email_id1,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.int_id,OLD.sap_code,OLD.sap_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 -   DROP FUNCTION erp.log_bu_mst_site_contact();
       erp          postgres    false    6                       1255    211746    log_bu_mst_unit()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_unit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_unit_log(
	unit_id, unit_name, unit_desc, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type)
	VALUES 
(OLD.unit_id,OLD.unit_name,OLD.unit_desc,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.int_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 %   DROP FUNCTION erp.log_bu_mst_unit();
       erp          postgres    false    6                       1255    211747    log_bu_mst_user()    FUNCTION     y  CREATE FUNCTION erp.log_bu_mst_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_user_log(
	user_id, user_name, user_security_string, user_desc, user_mobile_no, user_email_id, user_type, user_general_id, rec_status, action_by, action_on, is_restriction_free, hc_id, int_id, plant_id, insertion_type)
	VALUES
(OLD.user_id,OLD.user_name,OLD.user_security_string,OLD.user_desc,OLD.user_mobile_no,OLD.user_email_id,OLD.user_type,OLD.user_general_id,OLD.rec_status,OLD.action_by,now(),OLD.is_restriction_free,OLD.hc_id,OLD.int_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 %   DROP FUNCTION erp.log_bu_mst_user();
       erp          postgres    false    6                       1255    211748    log_bu_mst_vehicle()    FUNCTION       CREATE FUNCTION erp.log_bu_mst_vehicle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_vehicle_log(
	veh_id, hc_id, int_id, dev_sim_no, dev_imei_no, dev_install_on, veh_name, veh_no, veh_type, veh_make, veh_color, veh_chasis_no, veh_fuel_capacity, veh_status, correction_factor, full_voltage, empty_voltage, calibrated_voltage, rec_status, created_by, created_on, modified_by, modified_on, sync_status, sap_code, sap_id, allocated_card_id, plant_id, insertion_type, import_trans_id)
	VALUES
(OLD.veh_id,OLD.hc_id,OLD.int_id,OLD.dev_sim_no,OLD.dev_imei_no,OLD.dev_install_on,OLD.veh_name,OLD.veh_no,OLD.veh_type,OLD.veh_make,OLD.veh_color,OLD.veh_chasis_no,OLD.veh_fuel_capacity,OLD.veh_status,OLD.correction_factor,OLD.full_voltage,OLD.empty_voltage,OLD.calibrated_voltage,OLD.rec_status,OLD.created_by,now(),OLD.modified_by,OLD.modified_on,OLD.sync_status,OLD.sap_code,OLD.sap_id,OLD.allocated_card_id,OLD.plant_id,OLD.insertion_type,OLD.import_trans_id); -- 1:Insert.
RETURN NEW;
END;
$$;
 (   DROP FUNCTION erp.log_bu_mst_vehicle();
       erp          postgres    false    6                       1255    211749    log_bu_mst_vehicle_insurance()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_mst_vehicle_insurance() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.mst_vehicle_insurance_log(
	trans_id, veh_id, veh_no, insurance_no, from_date, to_date, premium_amt, insurance_type, owner_name, company_name, details_info, id_no, ide_value, vehicle_type_id, rec_status, action_by, action_on, plant_id, hc_id)
	VALUES 
(OLD.trans_id,OLD.veh_id,OLD.veh_no,OLD.insurance_no,OLD.from_date,OLD.to_date,OLD.premium_amt,OLD.insurance_type,OLD.owner_name,OLD.company_name,OLD.details_info,OLD.id_no,OLD.ide_value,OLD.vehicle_type_id,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id); -- 1:Insert.
RETURN NEW;
END;
$$;
 2   DROP FUNCTION erp.log_bu_mst_vehicle_insurance();
       erp          postgres    false    6                       1255    211750    log_bu_notification()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_notification() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.notification_log(
	sr_id, notification_date, notification_time, trans_info, error_qty, mobile_no1, mobile_no2)
	VALUES
(OLD.sr_id,OLD.notification_date,OLD.notification_time,OLD.trans_info,OLD.error_qty,OLD.mobile_no1,OLD.mobile_no2); -- 1:Insert.
RETURN NEW;
END;
$$;
 )   DROP FUNCTION erp.log_bu_notification();
       erp          postgres    false    6                       1255    211751    log_bu_trn_bpa_details()    FUNCTION       CREATE FUNCTION erp.log_bu_trn_bpa_details() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_bpa_details_log(
	bpa_dt_id, bpa_id, hc_id, plant_id, grn_id, item_qty, item_amt, quality_percentage, net_amt, rec_status, action_by, action_on, int_id, insertion_type)
	VALUES
(OLD.bpa_dt_id,OLD.bpa_id,OLD.hc_id,OLD.plant_id,OLD.grn_id,OLD.item_qty,OLD.item_amt,OLD.quality_percentage,OLD.net_amt,OLD.rec_status,OLD.action_by,now(),OLD.int_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 ,   DROP FUNCTION erp.log_bu_trn_bpa_details();
       erp          postgres    false    6                       1255    211752    log_bu_trn_bpa_info()    FUNCTION       CREATE FUNCTION erp.log_bu_trn_bpa_info() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_bpa_info_log(
	 bpa_id, bpa_no, bpa_date, bpa_code, fy_id, vendor_id, note, hc_id,  grand_tot_amt, rec_status, action_by, action_on,  int_id, plant_id, insertion_type)
	VALUES 
(OLD.bpa_id,OLD.bpa_no,OLD.bpa_date,OLD.bpa_code,OLD.fy_id,OLD.vendor_id,OLD.note,OLD.hc_id,OLD.grand_tot_amt,OLD.rec_status,OLD.action_by,now(),OLD.int_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 )   DROP FUNCTION erp.log_bu_trn_bpa_info();
       erp          postgres    false    6                       1255    211753    log_bu_trn_card_allocation()    FUNCTION     F  CREATE FUNCTION erp.log_bu_trn_card_allocation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_card_allocation_log(
	card_allocation_id, card_id, card_access_string, allocated_to_id, allocate_type, allocate_time, submit_time, rec_status, action_by, action_on, hc_id, plant_id, insertion_type)
	VALUES
(OLD.card_allocation_id,OLD.card_id,OLD.card_access_string,OLD.allocated_to_id,OLD.allocate_type,OLD.allocate_time,OLD.submit_time,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 0   DROP FUNCTION erp.log_bu_trn_card_allocation();
       erp          postgres    false    6                        1255    211754    log_bu_trn_dc_info()    FUNCTION     |  CREATE FUNCTION erp.log_bu_trn_dc_info() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_dc_info_log(
	 dc_id, dc_no, dc_date, dc_code, fy_id, cust_id, so_id, note, hc_id, rec_status, action_by, action_on, sap_code, sap_id, weg_bridge_id, batch_id, term_delivery, term_payment, plant_id, insertion_type)
	VALUES
(OLD.dc_id,OLD.dc_no,OLD.dc_date,OLD.dc_code,OLD.fy_id,OLD.cust_id,OLD.so_id,OLD.note,OLD.hc_id,OLD.rec_status,OLD.action_by,now(),OLD.sap_code,OLD.sap_id,OLD.weg_bridge_id,OLD.batch_id,OLD.term_delivery,OLD.term_payment,OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 (   DROP FUNCTION erp.log_bu_trn_dc_info();
       erp          postgres    false    6            !           1255    211755    log_bu_trn_dc_item()    FUNCTION     ~  CREATE FUNCTION erp.log_bu_trn_dc_item() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_dc_item_log(
	 dci_id, dc_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, dc_type,  insertion_type)
	VALUES
(OLD.dci_id,OLD.dc_id,OLD.item_id,OLD.item_qty,OLD.item_amt,OLD.disc_percent,OLD.rec_status,OLD.action_by,OLD.action_on,OLD.item_desc,OLD.unit_rate,OLD.cgst_rate,OLD.sgst_rate,OLD.igst_rate,OLD.hc_id,OLD.plant_id,OLD.dmix_id,OLD.dc_type,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 (   DROP FUNCTION erp.log_bu_trn_dc_item();
       erp          postgres    false    6            "           1255    211756    log_bu_trn_dc_summary()    FUNCTION       CREATE FUNCTION erp.log_bu_trn_dc_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_dc_summary_log(
	 dcs_id, dc_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type)
	VALUES
(OLD.dcs_id,OLD.dc_id,OLD.net_tot_amt,OLD.disc_percent,OLD.disc_amt,OLD.grand_tot_amt,OLD.remarks,OLD.rec_status,OLD.action_by,OLD.action_on,OLD.plant_id,OLD.hc_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 +   DROP FUNCTION erp.log_bu_trn_dc_summary();
       erp          postgres    false    6            #           1255    211757    log_bu_trn_designmix()    FUNCTION     m  CREATE FUNCTION erp.log_bu_trn_designmix() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_designmix_log(
	 dmix_id, design_mix_code, design_mix_name, item_id, is_close, agg1_name, agg1_item_id, agg1_qty, agg2_name, agg2_item_id, agg2_qty, agg3_name, agg3_item_id, agg3_qty, agg4_name, agg4_item_id, agg4_qty, agg5_name, agg5_item_id, agg5_qty, cement1_name, cement1_item_id, cement1_qty, cement2_name, cement2_item_id, cement2_qty, fill_name, fill_item_id, fill_qty, water1_name, water1_item_id, water1_qty, water2_name, water2_item_id, water2_qty, admix1_name, admix1_item_id, admix1_qty, admix12_name, admix12_item_id, admix12_qty, admix2_name, admix2_item_id, admix2_qty, admix22_name, admix22_item_id, admix22_qty, silica_name, silica_item_id, silica_qty, slurry_name, slurry_item_id, slurry_qty, pigname, hc_id, plant_id, rec_status, action_by, action_on,  insertion_type)
	VALUES
(OLD.dmix_id,OLD.design_mix_code,OLD.design_mix_name,OLD.item_id,OLD.is_close,OLD.agg1_name,OLD.agg1_item_id,OLD.agg1_qty,OLD.agg2_name,OLD.agg2_item_id,OLD.agg2_qty,OLD.agg3_name,OLD.agg3_item_id,OLD.agg3_qty,OLD.agg4_name,OLD.agg4_item_id,OLD.agg4_qty,OLD.agg5_name,OLD.agg5_item_id,OLD.agg5_qty,OLD.cement1_name,OLD.cement1_item_id,OLD.cement1_qty,OLD.cement2_name,OLD.cement2_item_id,OLD.cement2_qty,OLD.fill_name,OLD.fill_item_id,OLD.fill_qty,OLD.water1_name,OLD.water1_item_id,OLD.water1_qty,OLD.water2_name,OLD.water2_item_id,OLD.water2_qty,OLD.admix1_name,OLD.admix1_item_id,OLD.admix1_qty,OLD.admix12_name,OLD.admix12_item_id,OLD.admix12_qty,OLD.admix2_name,OLD.admix2_item_id,OLD.admix2_qty,OLD.admix22_name,OLD.admix22_item_id,OLD.admix22_qty,OLD.silica_name,OLD.silica_item_id,OLD.silica_qty,OLD.slurry_name,OLD.slurry_item_id,OLD.slurry_qty,OLD.pigname,OLD.hc_id,OLD.plant_id,OLD.rec_status,OLD.action_by,now(),OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 *   DROP FUNCTION erp.log_bu_trn_designmix();
       erp          postgres    false    6            $           1255    211758    log_bu_trn_grn_info()    FUNCTION       CREATE FUNCTION erp.log_bu_trn_grn_info() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_grn_info_log(
	 grn_id, grn_no, grn_date, grn_code, fy_id, vendor_id, po_id, note, hc_id, item_id, item_qty, item_amt, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, rec_status, action_by, action_on, quality_percentage, plant_id, ref_invoice_no, ref_invoice_date, ref_challan_no, ref_challan_date, po_iw_id, weg_bridge_id, insertion_type)
	VALUES
(OLD.grn_id,OLD.grn_no,OLD.grn_date,OLD.grn_code,OLD.fy_id,OLD.vendor_id,OLD.po_id,OLD.note,OLD.hc_id,OLD.item_id,OLD.item_qty,OLD.item_amt,OLD.item_desc,OLD.unit_rate,OLD.cgst_rate,OLD.sgst_rate,OLD.igst_rate,OLD.net_tot_amt,OLD.disc_percent,OLD.disc_amt,OLD.grand_tot_amt,OLD.rec_status,OLD.action_by,now(),OLD.quality_percentage,OLD.plant_id,OLD.ref_invoice_no,OLD.ref_invoice_date,OLD.ref_challan_no,OLD.ref_challan_date,OLD.po_iw_id,OLD.weg_bridge_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 )   DROP FUNCTION erp.log_bu_trn_grn_info();
       erp          postgres    false    6            %           1255    211759    log_bu_trn_invoice_info()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_invoice_info() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_invoice_info_log(
	 invoice_id, invoice_no, invoice_date, invoice_code, fy_id, cust_id, so_id, note, hc_id, sap_code, sap_id, weg_bridge_id, dc_id, batch_id, term_delivery, term_payment, rec_status, action_by, action_on, plant_id, insertion_type)
	VALUES
(OLD.invoice_id,OLD.invoice_no,OLD.invoice_date,OLD.invoice_code,OLD.fy_id,OLD.cust_id,OLD.so_id,OLD.note,OLD.hc_id,OLD.sap_code,OLD.sap_id,OLD.weg_bridge_id,OLD.dc_id,OLD.batch_id,OLD.term_delivery,OLD.term_payment,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 -   DROP FUNCTION erp.log_bu_trn_invoice_info();
       erp          postgres    false    6            &           1255    211760    log_bu_trn_invoice_item()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_invoice_item() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_invoice_item_log(
	inv_item_id, invoice_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, invoice_type, insertion_type)
	VALUES
(OLD.inv_item_id,OLD.invoice_id,OLD.item_id,OLD.item_qty,OLD.item_amt,OLD.disc_percent,OLD.rec_status,OLD.action_by,now(),OLD.item_desc,OLD.unit_rate,OLD.cgst_rate,OLD.sgst_rate,OLD.igst_rate,OLD.hc_id,OLD.plant_id,OLD.dmix_id,OLD.invoice_type,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 -   DROP FUNCTION erp.log_bu_trn_invoice_item();
       erp          postgres    false    6            '           1255    211761    log_bu_trn_invoice_summary()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_invoice_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_invoice_summary_log(
	 invoice_sum_id, invoice_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id)
	VALUES
(OLD.invoice_sum_id,OLD.invoice_id,OLD.net_tot_amt,OLD.disc_percent,OLD.disc_amt,OLD.grand_tot_amt,OLD.remarks,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id); -- 1:Insert.
RETURN NEW;
END;
$$;
 0   DROP FUNCTION erp.log_bu_trn_invoice_summary();
       erp          postgres    false    6            (           1255    211762    log_bu_trn_ledger_transcation()    FUNCTION     V  CREATE FUNCTION erp.log_bu_trn_ledger_transcation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_ledger_transcation_log(
	 led_trans_id, gen_led_no, gn_no, trans_date, credit_amt, debit_amt, op_bal, depriciation, ref_ac_no, ref_type, hc_id, rec_status, action_by, action_on, plant_id, insertion_type)
	VALUES
(OLD.trans_id,OLD.gen_led_no,OLD.gn_no,OLD.trans_date,OLD.credit_amt,OLD.debit_amt,OLD.op_bal,OLD.depriciation,OLD.ref_ac_no,OLD.ref_type,OLD.hc_id,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 3   DROP FUNCTION erp.log_bu_trn_ledger_transcation();
       erp          postgres    false    6            )           1255    211763     log_bu_trn_plant_office_inward()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_plant_office_inward() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_plant_office_inward_log(
	 po_iw_id, hc_id, plant_id, vendor_id, po_id, veh_no, item_id, inward_date, isqc_apply, isqc_accept_reject, poi_code, poi_no, fy_id, ref_invoice_no, ref_invoice_date, ref_challan_no, ref_challan_date, note, rec_status, action_by, action_on)
	VALUES
(OLD.po_iw_id,OLD.hc_id,OLD.plant_id,OLD.vendor_id,OLD.po_id,OLD.veh_no,OLD.item_id,OLD.inward_date,OLD.isqc_apply,OLD.isqc_accept_reject,OLD.poi_code,OLD.poi_no,OLD.fy_id,OLD.ref_invoice_no,OLD.ref_invoice_date,OLD.ref_challan_no,OLD.ref_challan_date,OLD.note,OLD.rec_status,OLD.action_by,now()); -- 1:Insert.
RETURN NEW;
END;
$$;
 4   DROP FUNCTION erp.log_bu_trn_plant_office_inward();
       erp          postgres    false    6            *           1255    211764 !   log_bu_trn_plant_office_outward()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_plant_office_outward() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_plant_office_outward_log(
	 po_ow_id, hc_id, plant_id, po_ow_code, po_ow_no, client_id, so_id, veh_no, item_id, outward_date, isqc_apply, isqc_accept_reject, rec_status, action_by, action_on, fy_id, ref_invoice_id, ref_dchallan_id, note, insertion_type)
	VALUES 
(OLD.po_ow_id,OLD.hc_id,OLD.plant_id,OLD.po_ow_code,OLD.po_ow_no,OLD.client_id,OLD.so_id,OLD.veh_no,OLD.item_id,OLD.outward_date,OLD.isqc_apply,OLD.isqc_accept_reject,OLD.rec_status,OLD.action_by,now(),OLD.fy_id,OLD.ref_invoice_id,OLD.ref_challan_id,OLD.note,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 5   DROP FUNCTION erp.log_bu_trn_plant_office_outward();
       erp          postgres    false    6            +           1255    211765    log_bu_trn_po()    FUNCTION     o  CREATE FUNCTION erp.log_bu_trn_po() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_po_log(
	 po_id, vendor_id, fy_id, po_date, po_code, po_finalized, note, po_finalized_date, rec_status, action_by, action_on, hc_id, po_no, po_version, con_id, plant_id, sap_po_code, sap_po_id, insertion_type)
	VALUES
(OLD.po_id,OLD.vendor_id,OLD.fy_id,OLD.po_date,OLD.po_code,OLD.po_finalized,OLD.note,OLD.po_finalized_date,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.po_no,OLD.po_version,OLD.con_id,OLD.plant_id,OLD.sap_po_code,OLD.sap_po_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 #   DROP FUNCTION erp.log_bu_trn_po();
       erp          postgres    false    6            ,           1255    211766    log_bu_trn_po_item()    FUNCTION     K  CREATE FUNCTION erp.log_bu_trn_po_item() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_po_item_log(
	 poi_id, po_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, plant_id, hc_id, insertion_type)
	VALUES
(OLD.poi_id,OLD.po_id,OLD.item_id,OLD.item_qty,OLD.item_amt,OLD.disc_percent,OLD.rec_status,OLD.action_by,now(),OLD.item_desc,OLD.unit_rate,OLD.cgst_rate,OLD.sgst_rate,OLD.igst_rate,OLD.plant_id,OLD.hc_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 (   DROP FUNCTION erp.log_bu_trn_po_item();
       erp          postgres    false    6            -           1255    211767 "   log_bu_trn_po_payment_conditions()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_po_payment_conditions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_po_payment_conditions_log(
	po_condition_id, po_id, condition_name, payment_condition, vendor_id, rec_status, action_by, action_on, plant_id, hc_id, insertion_type)
	VALUES
(OLD.po_condition_id,OLD.po_id,OLD.condition_name,OLD.payment_condition,OLD.vendor_id,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 6   DROP FUNCTION erp.log_bu_trn_po_payment_conditions();
       erp          postgres    false    6            .           1255    211768    log_bu_trn_po_summary()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_po_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_po_summary_log(
pos_id, po_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type)
	VALUES 
(OLD.pos_id,OLD.po_id,OLD.net_tot_amt,OLD.disc_percent,OLD.disc_amt,OLD.grand_tot_amt,OLD.remarks,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 +   DROP FUNCTION erp.log_bu_trn_po_summary();
       erp          postgres    false    6            /           1255    211769 0   log_bu_trn_rmc_batch_detail_devicetransmission()    FUNCTION       CREATE FUNCTION erp.log_bu_trn_rmc_batch_detail_devicetransmission() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_rmc_batch_detail_devicetransmission_log(
 int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag, hc_id, insertion_type,update_on)
VALUES 
(OLD.int_id,OLD.con_id,OLD.plant_id,OLD.wo_id,OLD.batch_no,OLD.batch_index,OLD.batch_date,OLD.batch_time,OLD.batch_time_text,OLD.batch_year,OLD.consistancy,OLD.production_qty,OLD.ordered_qty,OLD.returned_qty,OLD.withthisload,OLD.batch_size,OLD.gate1_actual,OLD.gate1_target,OLD.gate1_moisture,OLD.gate2_actual,OLD.gate2_target,OLD.gate2_moisture,OLD.gate3_actual,OLD.gate3_target,OLD.gate3_moisture,OLD.gate4_actual,OLD.gate4_target,OLD.gate4_moisture,OLD.gate5_actual,OLD.gate5_target,OLD.gate5_moisture,OLD.gate6_actual,OLD.gate6_target,OLD.gate6_moisture,OLD.cement1_actual,OLD.cement1_target,OLD.cement1_correction,OLD.cement2_actual,OLD.cement2_target,OLD.cement2_correction,OLD.cement3_actual,OLD.cement3_target,OLD.cement3_correction,OLD.cement4_actual,OLD.cement4_target,OLD.cement4_correction,OLD.filler1_actual,OLD.filler1_target,OLD.filler1_correction,OLD.water1_actual,OLD.water1_target,OLD.water1_correction,OLD.water2_actual,OLD.water2_target,OLD.water2_correction,OLD.silica_actual,OLD.silica_target,OLD.silica_correction,OLD.slurry_actual,OLD.slurry_target,OLD.slurry_correction,OLD.adm1_actual1,OLD.adm1_target1,OLD.adm1_correction1,OLD.adm1_actual2,OLD.adm1_target2,OLD.adm1_correction2,OLD.adm2_actual1,OLD.adm2_target1,OLD.adm2_correction1,OLD.adm2_actual2,OLD.adm2_target2,OLD.adm2_correction2,OLD.pigment_actual,OLD.pigment_target,OLD.batch_end_flag,OLD.hc_id,OLD.insertion_type,now()); -- 1:Insert.
RETURN NEW;
END;
$$;
 D   DROP FUNCTION erp.log_bu_trn_rmc_batch_detail_devicetransmission();
       erp          postgres    false    6            0           1255    211770 )   log_bu_trn_rmc_batch_devicetransmission()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_rmc_batch_devicetransmission() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_rmc_batch_devicetransmission_log(
	int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2, hc_id, so_id, insertion_type, update_on)
	VALUES
(OLD.int_id,OLD.cust_id,OLD.plant_id,OLD.wo_id,OLD.batch_no,OLD.batch_index,OLD.batch_date,OLD.batch_time,OLD.batch_time_text,OLD.batch_start_time,OLD.batch_end_time,OLD.batch_year,OLD.batcher_name,OLD.batcher_user_level,OLD.customer_code,OLD.recipe_code,OLD.recipe_name,OLD.mixing_time,OLD.mixer_capacity,OLD.site,OLD.truck_no,OLD.truck_driver,OLD.production_qty,OLD.ordered_qty,OLD.returned_qty,OLD.withthisload,OLD.batch_size,OLD.order_no,OLD.schedule_id,OLD.gate1_target,OLD.gate2_target,OLD.gate3_target,OLD.gate4_target,OLD.gate5_target,OLD.gate6_target,OLD.cement1_target,OLD.cement2_target,OLD.cement3_target,OLD.cement4_target,OLD.filler_target,OLD.water1_target,OLD.slurry_target,OLD.water2_target,OLD.silica_target,OLD.adm1_target1,OLD.adm1_target2,OLD.adm2_target1,OLD.adm2_target2,OLD.hc_id,OLD.so_id,OLD.insertion_type,now()); -- 1:Insert.
RETURN NEW;
END;
$$;
 =   DROP FUNCTION erp.log_bu_trn_rmc_batch_devicetransmission();
       erp          postgres    false    6            1           1255    211771    log_bu_trn_so()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_so() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_so_log(
	 so_id, cust_id, fy_id, so_date, so_code, so_finalized, note, so_finalized_date, rec_status, action_by, action_on, hc_id, so_no, con_id, sap_so_code, sap_so_id, plant_id, term_of_payment, term_of_delivery, site_id, ref_po_no, insertion_type)
	VALUES 
(OLD.so_id,OLD.cust_id,OLD.fy_id,OLD.so_date,OLD.so_code,OLD.so_finalized,OLD.note,OLD.so_finalized_date,OLD.rec_status,OLD.action_by,now(),OLD.hc_id,OLD.so_no,OLD.con_id,OLD.sap_so_code,OLD.sap_so_id,OLD.plant_id,OLD.term_of_payment,OLD.term_of_delivery,OLD.site_id,OLD.ref_po_no,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 #   DROP FUNCTION erp.log_bu_trn_so();
       erp          postgres    false    6            2           1255    211772    log_bu_trn_so_item()    FUNCTION     M  CREATE FUNCTION erp.log_bu_trn_so_item() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_so_item_log(
	 soi_id, so_id, item_id, item_qty, item_amt, disc_percent, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, rec_status, action_by, action_on,  plant_id, hc_id, insertion_type)
	VALUES 
(OLD.soi_id,OLD.so_id,OLD.item_id,OLD.item_qty,OLD.item_amt,OLD.disc_percent,OLD.item_desc,OLD.unit_rate,OLD.cgst_rate,OLD.sgst_rate,OLD.igst_rate,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id,OLD.insertion_type); -- 1:Insert.
RETURN NEW;
END;
$$;
 (   DROP FUNCTION erp.log_bu_trn_so_item();
       erp          postgres    false    6            3           1255    211773    log_bu_trn_so_summary()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_so_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_so_summary_log(
	 sos_id, so_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on,  plant_id, hc_id)
	VALUES
(OLD.sos_id,OLD.so_id,OLD.net_tot_amt,OLD.disc_percent,OLD.disc_amt,OLD.grand_tot_amt,OLD.remarks,OLD.rec_status,OLD.action_by,now(),OLD.plant_id,OLD.hc_id); -- 1:Insert.
RETURN NEW;
END;
$$;
 +   DROP FUNCTION erp.log_bu_trn_so_summary();
       erp          postgres    false    6            4           1255    211774    log_bu_trn_stock()    FUNCTION     ?  CREATE FUNCTION erp.log_bu_trn_stock() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare

BEGIN

INSERT INTO erp.trn_stock_log(
	stock_id, item_id, inward_quantity, outward_quantity, balance_quantity, note, rec_status, action_by, action_on)
	VALUES 
(OLD.stock_id,OLD.item_id,OLD.inward_quantity,OLD.outward_quantity,OLD.balance_quantity,OLD.note,OLD.rec_status,OLD.action_by,now()); -- 1:Insert.
RETURN NEW;
END;
$$;
 &   DROP FUNCTION erp.log_bu_trn_stock();
       erp          postgres    false    6            ?            1259    211817    seq_alert_config    SEQUENCE     w   CREATE SEQUENCE erp.seq_alert_config
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
 $   DROP SEQUENCE erp.seq_alert_config;
       erp          postgres    false    6            ?            1259    211819    mst_alert_config    TABLE     ?  CREATE TABLE erp.mst_alert_config (
    ac_id numeric(3,0) DEFAULT nextval('erp.seq_alert_config'::regclass) NOT NULL,
    ac_event_type numeric(1,0) DEFAULT 1 NOT NULL,
    ac_name character varying(100) NOT NULL,
    ac_desc character varying(250) DEFAULT NULL::character varying,
    sms_contents character varying(160) NOT NULL,
    email_subject character varying(200) NOT NULL,
    email_body character varying(1000) NOT NULL,
    email_signature character varying(150) NOT NULL,
    email_cc character varying(100) NOT NULL,
    email_bcc character varying(100) DEFAULT NULL::character varying,
    sms_active numeric(1,0) DEFAULT 0 NOT NULL,
    email_active numeric(1,0) DEFAULT 0 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0),
    hc_id numeric(5,0),
    plant_id numeric(7,0) DEFAULT 0,
    insert_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.mst_alert_config;
       erp         heap    postgres    false    209    6            ?           0    0 %   COLUMN mst_alert_config.ac_event_type    COMMENT     V   COMMENT ON COLUMN erp.mst_alert_config.ac_event_type IS 'Refer Mst_PresetData table';
          erp          postgres    false    210            ?           0    0 "   COLUMN mst_alert_config.sms_active    COMMENT     M   COMMENT ON COLUMN erp.mst_alert_config.sms_active IS '0:Deactive, 1:Active';
          erp          postgres    false    210            ?           0    0 $   COLUMN mst_alert_config.email_active    COMMENT     O   COMMENT ON COLUMN erp.mst_alert_config.email_active IS '0:Deactive, 1:Active';
          erp          postgres    false    210            ?           0    0 "   COLUMN mst_alert_config.rec_status    COMMENT     L   COMMENT ON COLUMN erp.mst_alert_config.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    210            ?            1259    211836    seq_mst_card    SEQUENCE     v   CREATE SEQUENCE erp.seq_mst_card
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999
    CACHE 1;
     DROP SEQUENCE erp.seq_mst_card;
       erp          postgres    false    6            ?            1259    211838    mst_card    TABLE     k  CREATE TABLE erp.mst_card (
    card_id numeric(5,0) DEFAULT nextval('erp.seq_mst_card'::regclass) NOT NULL,
    card_name character varying(50) NOT NULL,
    card_type integer NOT NULL,
    card_access_string character varying(50) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(5,0) DEFAULT 1 NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(7,0) DEFAULT 0,
    is_allocated smallint DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_card;
       erp         heap    postgres    false    211    6            ?           0    0    COLUMN mst_card.card_type    COMMENT     J   COMMENT ON COLUMN erp.mst_card.card_type IS 'Refer Mst_PresetData table';
          erp          postgres    false    212            ?            1259    211850    mst_card_log    TABLE       CREATE TABLE erp.mst_card_log (
    card_id numeric(5,0) DEFAULT NULL::numeric,
    card_name character varying(50),
    card_type integer,
    card_access_string character varying(50),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(5,0),
    int_id numeric(2,0),
    plant_id numeric(7,0) DEFAULT 0,
    is_allocated smallint DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_card_log;
       erp         heap    postgres    false    6            ?           0    0    COLUMN mst_card_log.card_type    COMMENT     N   COMMENT ON COLUMN erp.mst_card_log.card_type IS 'Refer Mst_PresetData table';
          erp          postgres    false    213            ?            1259    211860    seq_cust_vendor_contact    SEQUENCE     ?   CREATE SEQUENCE erp.seq_cust_vendor_contact
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;
 +   DROP SEQUENCE erp.seq_cust_vendor_contact;
       erp          postgres    false    6            ?            1259    211862    mst_cust_vendor_contact    TABLE     ?  CREATE TABLE erp.mst_cust_vendor_contact (
    con_id numeric(8,0) DEFAULT nextval('erp.seq_cust_vendor_contact'::regclass) NOT NULL,
    cust_vendor_id numeric(7,0) NOT NULL,
    con_name character varying(100) NOT NULL,
    con_designation numeric(2,0) NOT NULL,
    mob_no1 character varying(15) NOT NULL,
    wa_no1 character varying(15),
    email_id1 character varying(50),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 (   DROP TABLE erp.mst_cust_vendor_contact;
       erp         heap    postgres    false    214    6            ?           0    0 .   COLUMN mst_cust_vendor_contact.con_designation    COMMENT     a   COMMENT ON COLUMN erp.mst_cust_vendor_contact.con_designation IS 'Refer mst_preset_data table.';
          erp          postgres    false    215            ?           0    0 )   COLUMN mst_cust_vendor_contact.rec_status    COMMENT     S   COMMENT ON COLUMN erp.mst_cust_vendor_contact.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    215            ?            1259    211874    mst_cust_vendor_contact_log    TABLE     {  CREATE TABLE erp.mst_cust_vendor_contact_log (
    con_id numeric(8,0) DEFAULT NULL::numeric,
    cust_vendor_id numeric(7,0),
    con_name character varying(100),
    con_designation numeric(2,0),
    mob_no1 character varying(15),
    wa_no1 character varying(15),
    email_id1 character varying(50),
    rec_status numeric(1,0) DEFAULT 1,
    action_by numeric(3,0) DEFAULT 1,
    action_on timestamp without time zone DEFAULT now(),
    hc_id numeric,
    int_id numeric(2,0) DEFAULT 1,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 ,   DROP TABLE erp.mst_cust_vendor_contact_log;
       erp         heap    postgres    false    6            ?            1259    211886    seq_vendor_item    SEQUENCE     z   CREATE SEQUENCE erp.seq_vendor_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1;
 #   DROP SEQUENCE erp.seq_vendor_item;
       erp          postgres    false    6            ?            1259    211888    mst_cust_vendor_item    TABLE     &  CREATE TABLE erp.mst_cust_vendor_item (
    ven_item_id numeric(10,0) DEFAULT nextval('erp.seq_vendor_item'::regclass) NOT NULL,
    item_id numeric(3,0) NOT NULL,
    cust_id numeric(3,0) NOT NULL,
    cgst_rate numeric(5,2) DEFAULT NULL::numeric,
    sgst_rate numeric(5,2) DEFAULT NULL::numeric,
    igst_rate numeric(5,2) DEFAULT NULL::numeric,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    note character varying(150) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.mst_cust_vendor_item;
       erp         heap    postgres    false    217    6            ?           0    0 &   COLUMN mst_cust_vendor_item.rec_status    COMMENT     P   COMMENT ON COLUMN erp.mst_cust_vendor_item.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    218            ?            1259    211902 "   seq_cust_vendor_payment_conditions    SEQUENCE     ?   CREATE SEQUENCE erp.seq_cust_vendor_payment_conditions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1;
 6   DROP SEQUENCE erp.seq_cust_vendor_payment_conditions;
       erp          postgres    false    6            ?            1259    211904 "   mst_cust_vendor_payment_conditions    TABLE     ?  CREATE TABLE erp.mst_cust_vendor_payment_conditions (
    ven_condition_id numeric(3,0) DEFAULT nextval('erp.seq_cust_vendor_payment_conditions'::regclass) NOT NULL,
    condition_name character varying(100) DEFAULT NULL::character varying,
    payment_condition character varying(500) DEFAULT NULL::character varying,
    cust_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 3   DROP TABLE erp.mst_cust_vendor_payment_conditions;
       erp         heap    postgres    false    219    6            ?            1259    211918    seq_customer    SEQUENCE     w   CREATE SEQUENCE erp.seq_customer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1;
     DROP SEQUENCE erp.seq_customer;
       erp          postgres    false    6            ?            1259    211920    mst_customer_vendor    TABLE     ?  CREATE TABLE erp.mst_customer_vendor (
    cust_vendor_id numeric(7,0) DEFAULT nextval('erp.seq_customer'::regclass) NOT NULL,
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
    is_customer smallint,
    import_trans_id numeric(11,0) DEFAULT 0
);
 $   DROP TABLE erp.mst_customer_vendor;
       erp         heap    postgres    false    221    6            ?           0    0 !   COLUMN mst_customer_vendor.wa_no1    COMMENT     E   COMMENT ON COLUMN erp.mst_customer_vendor.wa_no1 IS 'WhatsApp No.1';
          erp          postgres    false    222            ?           0    0 !   COLUMN mst_customer_vendor.wa_no2    COMMENT     E   COMMENT ON COLUMN erp.mst_customer_vendor.wa_no2 IS 'WhatsApp No.2';
          erp          postgres    false    222            ?           0    0 %   COLUMN mst_customer_vendor.rec_status    COMMENT     O   COMMENT ON COLUMN erp.mst_customer_vendor.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    222            ?           0    0 &   COLUMN mst_customer_vendor.is_customer    COMMENT     \   COMMENT ON COLUMN erp.mst_customer_vendor.is_customer IS '1 if save customer, 0 if vendor';
          erp          postgres    false    222            ?           0    0 *   COLUMN mst_customer_vendor.import_trans_id    COMMENT     h   COMMENT ON COLUMN erp.mst_customer_vendor.import_trans_id IS 'Will store erp_import table primary key';
          erp          postgres    false    222            ?            1259    211954    mst_customer_vendor_log    TABLE        CREATE TABLE erp.mst_customer_vendor_log (
    cust_vendor_id numeric(7,0),
    cust_vendor_name character varying(100),
    cust_vendor_addr character varying(250),
    cust_vendor_lat numeric(10,7),
    cust_vendor_long numeric(10,7),
    cust_vendor_city character varying(50),
    cust_vendor_state_id numeric(2,0) DEFAULT 1 NOT NULL,
    pin_code character varying(6) DEFAULT 0,
    ll_no1 character varying(15),
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
    rec_status numeric(1,0) DEFAULT 1,
    action_by numeric(3,0) DEFAULT 1,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0),
    bank_name character varying(50) DEFAULT NULL::character varying,
    cust_vendor_code character varying(15),
    cust_vendor_firm_name character varying(100),
    cust_vendor_firm_addr character varying(250),
    credit_limit numeric(13,2) DEFAULT 0,
    int_id numeric(2,0) DEFAULT 1,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    is_customer smallint,
    import_trans_id numeric(11,0) DEFAULT 0
);
 (   DROP TABLE erp.mst_customer_vendor_log;
       erp         heap    postgres    false    6            ?            1259    211984    seq_department    SEQUENCE     t   CREATE SEQUENCE erp.seq_department
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1;
 "   DROP SEQUENCE erp.seq_department;
       erp          postgres    false    6            ?            1259    211986    mst_department    TABLE        CREATE TABLE erp.mst_department (
    dept_id numeric(2,0) DEFAULT nextval('erp.seq_department'::regclass) NOT NULL,
    dept_name character varying(50) NOT NULL,
    dept_location character varying(100) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_department;
       erp         heap    postgres    false    224    6            ?            1259    211996    seq_diesel_type    SEQUENCE     u   CREATE SEQUENCE erp.seq_diesel_type
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1;
 #   DROP SEQUENCE erp.seq_diesel_type;
       erp          postgres    false    6            ?            1259    211998    mst_diesel_type    TABLE       CREATE TABLE erp.mst_diesel_type (
    diesel_id numeric(5,0) DEFAULT nextval('erp.seq_diesel_type'::regclass) NOT NULL,
    diesel_name character varying(50) NOT NULL,
    diesel_type integer NOT NULL,
    diesel_qty character varying(50) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
     DROP TABLE erp.mst_diesel_type;
       erp         heap    postgres    false    226    6            ?            1259    212007    seq_employee    SEQUENCE     u   CREATE SEQUENCE erp.seq_employee
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    CACHE 1;
     DROP SEQUENCE erp.seq_employee;
       erp          postgres    false    6            ?            1259    212009    mst_employee    TABLE     ?  CREATE TABLE erp.mst_employee (
    emp_id numeric(5,0) DEFAULT nextval('erp.seq_employee'::regclass) NOT NULL,
    hc_id numeric NOT NULL,
    dept_id numeric(2,0) NOT NULL,
    ro1_id numeric(5,0) NOT NULL,
    ro2_id numeric(5,0) NOT NULL,
    employment_type numeric(1,0) NOT NULL,
    emp_code character varying(15) NOT NULL,
    emp_name character varying(100) NOT NULL,
    designation numeric(2,0) NOT NULL,
    joining_on date NOT NULL,
    exit_on date,
    ll_no1 character varying,
    ll_no2 character varying(15),
    mobile_no1 character varying(15) NOT NULL,
    mobile_no2 character varying(15),
    comp_email_id character varying(100) NOT NULL,
    personal_email_id character varying(100) NOT NULL,
    curr_addr character varying(250) NOT NULL,
    perm_addr character varying(250) NOT NULL,
    curr_resi_type numeric(1,0) NOT NULL,
    born_on date NOT NULL,
    marital_status numeric(1,0) DEFAULT 1 NOT NULL,
    blood_group numeric,
    alergic_to character varying(100),
    pan_no character varying(10),
    aadhaar_no character varying,
    esic_no character varying(20),
    other_info character varying(500),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    emp_gender numeric DEFAULT 2 NOT NULL,
    emp_img_path character varying(255),
    pf_no character varying(100),
    emp_first_name character varying NOT NULL,
    emp_middle_name character varying(50),
    emp_last_name character varying NOT NULL,
    emp_comp_mob_no character varying(15),
    plant_id numeric(7,0) DEFAULT 0,
    sap_code character varying(20),
    sap_id numeric(8,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_employee;
       erp         heap    postgres    false    228    6            ?           0    0 #   COLUMN mst_employee.employment_type    COMMENT     y   COMMENT ON COLUMN erp.mst_employee.employment_type IS '1:Probation, 2:Temporary, 3:Trainee, 4:On Contract, 5:Permanent';
          erp          postgres    false    229            ?           0    0    COLUMN mst_employee.designation    COMMENT     R   COMMENT ON COLUMN erp.mst_employee.designation IS 'Refer mst_preset_data table.';
          erp          postgres    false    229            ?           0    0 "   COLUMN mst_employee.curr_resi_type    COMMENT     }   COMMENT ON COLUMN erp.mst_employee.curr_resi_type IS '1:Owner, 2:Rental, 3:Hostel, 4:Paying Guest, 5:Relative, 6:Cot-basis';
          erp          postgres    false    229            ?           0    0 "   COLUMN mst_employee.marital_status    COMMENT     X   COMMENT ON COLUMN erp.mst_employee.marital_status IS '1:Single, 2:Married, 3:Divorced';
          erp          postgres    false    229            ?           0    0    COLUMN mst_employee.blood_group    COMMENT     f   COMMENT ON COLUMN erp.mst_employee.blood_group IS '1:A+, 2:A-, 3:B+, 4:B-, 5:O+, 6:O-, 7:AB+, 8:AB-';
          erp          postgres    false    229            ?           0    0    COLUMN mst_employee.rec_status    COMMENT     H   COMMENT ON COLUMN erp.mst_employee.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    229            ?            1259    212023    mst_employee_contact    TABLE     ?  CREATE TABLE erp.mst_employee_contact (
    con_id integer NOT NULL,
    emp_address1 character varying(100),
    emp_mobno1 character varying(100),
    email1 character varying(100),
    rec_status numeric(1,0),
    action_by numeric(3,0),
    action_on timestamp without time zone NOT NULL,
    emp_id integer,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.mst_employee_contact;
       erp         heap    postgres    false    6            ?            1259    212027    mst_employee_contact_con_id_seq    SEQUENCE     ?   CREATE SEQUENCE erp.mst_employee_contact_con_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE erp.mst_employee_contact_con_id_seq;
       erp          postgres    false    230    6            ?           0    0    mst_employee_contact_con_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE erp.mst_employee_contact_con_id_seq OWNED BY erp.mst_employee_contact.con_id;
          erp          postgres    false    231            ?            1259    212029    seq_finyear    SEQUENCE     q   CREATE SEQUENCE erp.seq_finyear
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1;
    DROP SEQUENCE erp.seq_finyear;
       erp          postgres    false    6            ?            1259    212031    mst_finyear    TABLE     p  CREATE TABLE erp.mst_finyear (
    fy_id numeric(2,0) DEFAULT nextval('erp.seq_finyear'::regclass) NOT NULL,
    fy_from date NOT NULL,
    fy_to date NOT NULL,
    fy_name character varying(10) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.mst_finyear;
       erp         heap    postgres    false    232    6            ?           0    0    COLUMN mst_finyear.rec_status    COMMENT     G   COMMENT ON COLUMN erp.mst_finyear.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    233            ?            1259    212038    seq_mst_general_ledger    SEQUENCE     ?   CREATE SEQUENCE erp.seq_mst_general_ledger
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1;
 *   DROP SEQUENCE erp.seq_mst_general_ledger;
       erp          postgres    false    6            ?            1259    212040    mst_general_ledger    TABLE     ?  CREATE TABLE erp.mst_general_ledger (
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_mst_general_ledger'::regclass) NOT NULL,
    gen_led_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    gen_led_name character varying(50) DEFAULT ''::character varying,
    gn_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    trans_date time without time zone NOT NULL,
    credit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    debit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    op_bal numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    br_id numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    is_inventory character varying(2) DEFAULT ''::character varying,
    is_tds_apply character varying(2) DEFAULT ''::character varying,
    depriciation character varying(45) DEFAULT ''::character varying,
    drcr_limit numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    ap_name character varying(70) DEFAULT ''::character varying,
    acp_name character varying(70) DEFAULT ''::character varying,
    address character varying(200) DEFAULT ''::character varying,
    state_name character varying(30) DEFAULT ''::character varying,
    pincode character varying(10) DEFAULT ''::character varying,
    mobile_no character varying(10) DEFAULT ''::character varying,
    email_id character varying(50) DEFAULT ''::character varying,
    pancard_no character varying(10) DEFAULT ''::character varying,
    salestax_no character varying(10) DEFAULT ''::character varying,
    ref_ac_type character varying(15) DEFAULT ''::character varying,
    ref_ac_no1 numeric(15,0) DEFAULT NULL::numeric,
    ref_ac_no2 numeric(15,0) DEFAULT NULL::numeric,
    ref_ac_name1 character varying(255) DEFAULT ''::character varying,
    ref_ac_name2 character varying(255) DEFAULT ''::character varying,
    ref_ac_details character varying(255) DEFAULT ''::character varying,
    ref_ac_address2 character varying(500) DEFAULT ''::character varying,
    ref_ac_sitedistance2 character varying(50) DEFAULT ''::character varying,
    gm_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    import_status character(1) DEFAULT NULL::bpchar,
    firm_add character varying(500) DEFAULT ''::character varying,
    phone_noo1 character varying(15) DEFAULT ''::character varying,
    phone_noo2 character varying(15) DEFAULT ''::character varying,
    phone_no_f1 character varying(15) DEFAULT ''::character varying,
    phone_no_f2 character varying(15) DEFAULT ''::character varying,
    ecc_no character varying(45) DEFAULT ''::character varying,
    tin_no character varying(45) DEFAULT ''::character varying,
    cgst_no character varying(45) DEFAULT ''::character varying,
    igst_no character varying(45) DEFAULT ''::character varying,
    gl_alias character varying(200) DEFAULT ''::character varying,
    drcr_limit_period numeric(11,0) DEFAULT NULL::numeric,
    upload_status character(1) DEFAULT 'N'::bpchar,
    lbt_no character varying(25) DEFAULT ''::character varying,
    hc_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.mst_general_ledger;
       erp         heap    postgres    false    234    6            ?           0    0 &   COLUMN mst_general_ledger.gen_led_name    COMMENT     ?   COMMENT ON COLUMN erp.mst_general_ledger.gen_led_name IS 'if GLName is Customer then format will be like JobSiteName(Customer Name) ';
          erp          postgres    false    235            ?           0    0 %   COLUMN mst_general_ledger.ref_ac_type    COMMENT     Q   COMMENT ON COLUMN erp.mst_general_ledger.ref_ac_type IS 'Sales/Purchase/Salary';
          erp          postgres    false    235                        0    0 $   COLUMN mst_general_ledger.ref_ac_no1    COMMENT     I   COMMENT ON COLUMN erp.mst_general_ledger.ref_ac_no1 IS 'Customer AC no';
          erp          postgres    false    235                       0    0 $   COLUMN mst_general_ledger.ref_ac_no2    COMMENT     D   COMMENT ON COLUMN erp.mst_general_ledger.ref_ac_no2 IS 'JobSiteNo';
          erp          postgres    false    235                       0    0 $   COLUMN mst_general_ledger.rec_status    COMMENT     N   COMMENT ON COLUMN erp.mst_general_ledger.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    235            ?            1259    212095    mst_general_ledger_log    TABLE     F  CREATE TABLE erp.mst_general_ledger_log (
    trans_id numeric(10,0),
    gen_led_no numeric(10,0),
    gen_led_name character varying(50) DEFAULT ''::character varying,
    gn_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    trans_date time without time zone,
    credit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    debit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    op_bal numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    br_id numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    is_inventory character varying(2) DEFAULT ''::character varying,
    is_tds_apply character varying(2) DEFAULT ''::character varying,
    depriciation character varying(45) DEFAULT ''::character varying,
    drcr_limit numeric(12,2) DEFAULT '0'::numeric NOT NULL,
    ap_name character varying(70) DEFAULT ''::character varying,
    acp_name character varying(70) DEFAULT ''::character varying,
    address character varying(200) DEFAULT ''::character varying,
    state_name character varying(30) DEFAULT ''::character varying,
    pincode character varying(10) DEFAULT ''::character varying,
    mobile_no character varying(10) DEFAULT ''::character varying,
    email_id character varying(50) DEFAULT ''::character varying,
    pancard_no character varying(10) DEFAULT ''::character varying,
    salestax_no character varying(10) DEFAULT ''::character varying,
    ref_ac_type character varying(15) DEFAULT ''::character varying,
    ref_ac_no1 numeric(15,0) DEFAULT NULL::numeric,
    ref_ac_no2 numeric(15,0) DEFAULT NULL::numeric,
    ref_ac_name1 character varying(255) DEFAULT ''::character varying,
    ref_ac_name2 character varying(255) DEFAULT ''::character varying,
    ref_ac_details character varying(255) DEFAULT ''::character varying,
    ref_ac_address2 character varying(500) DEFAULT ''::character varying,
    ref_ac_sitedistance2 character varying(50) DEFAULT ''::character varying,
    gm_no numeric(10,0) DEFAULT '0'::numeric,
    import_status character(1) DEFAULT NULL::bpchar,
    firm_add character varying(500) DEFAULT ''::character varying,
    phone_noo1 character varying(15) DEFAULT ''::character varying,
    phone_noo2 character varying(15) DEFAULT ''::character varying,
    phone_no_f1 character varying(15) DEFAULT ''::character varying,
    phone_no_f2 character varying(15) DEFAULT ''::character varying,
    ecc_no character varying(45) DEFAULT ''::character varying,
    tin_no character varying(45) DEFAULT ''::character varying,
    cgst_no character varying(45) DEFAULT ''::character varying,
    igst_no character varying(45) DEFAULT ''::character varying,
    gl_alias character varying(200) DEFAULT ''::character varying,
    drcr_limit_period numeric(11,0) DEFAULT NULL::numeric,
    upload_status character(1) DEFAULT 'N'::bpchar,
    lbt_no character varying(25) DEFAULT ''::character varying,
    hc_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1)
);
 '   DROP TABLE erp.mst_general_ledger_log;
       erp         heap    postgres    false    6            ?            1259    212147    seq_host_company    SEQUENCE     w   CREATE SEQUENCE erp.seq_host_company
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1;
 $   DROP SEQUENCE erp.seq_host_company;
       erp          postgres    false    6            ?            1259    212149    mst_host_company    TABLE     c  CREATE TABLE erp.mst_host_company (
    hc_id numeric(2,0) DEFAULT nextval('erp.seq_host_company'::regclass) NOT NULL,
    comp_name character varying(100) NOT NULL,
    comp_addr character varying(250) NOT NULL,
    comp_lat double precision,
    comp_long double precision,
    comp_city character varying(50),
    comp_state_id numeric(2,0) NOT NULL,
    pin_code character varying(6) NOT NULL,
    ll_no1 character varying(15),
    ll_no2 character varying(15),
    mob_no1 character varying(15),
    mob_no2 character varying(15),
    wa_no1 character varying(15),
    wa_no2 character varying(15),
    email_id1 character varying(50),
    email_id2 character varying(50),
    comp_url character varying(100),
    fb_handle character varying(100),
    twr_handle character varying(100),
    pan_no character varying(20),
    gst_no character varying(20),
    ifsc_code character varying(15),
    bank_acc_no character varying(15),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    comp_logo character varying(255),
    bank_branch character varying(50),
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar,
    comp_code character varying(30),
    hc_prefix character varying(7),
    prefix character varying(7)
);
 !   DROP TABLE erp.mst_host_company;
       erp         heap    postgres    false    237    6                       0    0 "   COLUMN mst_host_company.rec_status    COMMENT     L   COMMENT ON COLUMN erp.mst_host_company.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    238            ?            1259    212161    mst_host_company_log    TABLE     ?  CREATE TABLE erp.mst_host_company_log (
    hc_id numeric(2,0),
    comp_name character varying(100),
    comp_addr character varying(250),
    comp_lat double precision,
    comp_long double precision,
    comp_city character varying(50),
    comp_state_id numeric(2,0),
    pin_code character varying(6),
    ll_no1 character varying(15),
    ll_no2 character varying(15),
    mob_no1 character varying(15),
    mob_no2 character varying(15),
    wa_no1 character varying(15),
    wa_no2 character varying(15),
    email_id1 character varying(50),
    email_id2 character varying(50),
    comp_url character varying(100),
    fb_handle character varying(100),
    twr_handle character varying(100),
    pan_no character varying(20),
    gst_no character varying(20),
    ifsc_code character varying(15),
    bank_acc_no character varying(15),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    comp_logo character varying(255),
    bank_branch character varying(50),
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.mst_host_company_log;
       erp         heap    postgres    false    6            ?            1259    212172    seq_integrator    SEQUENCE     u   CREATE SEQUENCE erp.seq_integrator
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
 "   DROP SEQUENCE erp.seq_integrator;
       erp          postgres    false    6            ?            1259    212174    mst_integrator    TABLE     0  CREATE TABLE erp.mst_integrator (
    int_id numeric(3,0) DEFAULT nextval('erp.seq_integrator'::regclass) NOT NULL,
    int_name character varying(100) NOT NULL,
    int_shortname character varying(30) DEFAULT NULL::character varying,
    int_address character varying(250) DEFAULT NULL::character varying,
    int_phone1 character varying(15) DEFAULT NULL::character varying,
    int_phone2 character varying(15) DEFAULT NULL::character varying,
    int_mobile1 character varying(15) DEFAULT NULL::character varying,
    int_mobile2 character varying(15) DEFAULT NULL::character varying,
    int_email1 character varying(100) DEFAULT NULL::character varying,
    int_email2 character varying(100) DEFAULT NULL::character varying,
    int_logo_path character varying(500) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_integrator;
       erp         heap    postgres    false    240    6                       0    0     COLUMN mst_integrator.rec_status    COMMENT     J   COMMENT ON COLUMN erp.mst_integrator.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    241            ?            1259    212194    seq_integrator_config    SEQUENCE     |   CREATE SEQUENCE erp.seq_integrator_config
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
 )   DROP SEQUENCE erp.seq_integrator_config;
       erp          postgres    false    6            ?            1259    212196    mst_integrator_config    TABLE     ?  CREATE TABLE erp.mst_integrator_config (
    int_i_id numeric(5,0) DEFAULT nextval('erp.seq_integrator_config'::regclass) NOT NULL,
    int_id numeric(2,0) NOT NULL,
    config_param_key character varying(50) NOT NULL,
    config_param_val character varying(100) NOT NULL,
    value_datatype numeric(2,0) DEFAULT 1 NOT NULL,
    remarks character varying(255) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 &   DROP TABLE erp.mst_integrator_config;
       erp         heap    postgres    false    242    6                       0    0 -   COLUMN mst_integrator_config.config_param_key    COMMENT     ?   COMMENT ON COLUMN erp.mst_integrator_config.config_param_key IS 'COMPANY_LOGO, QT_PREFIX, SO_PREFIX, TI_PREFIX, PR_PREFIX, FINYEAR_FORMAT, PR_EVIDENCE_FILE_PATH';
          erp          postgres    false    243                       0    0 +   COLUMN mst_integrator_config.value_datatype    COMMENT     _   COMMENT ON COLUMN erp.mst_integrator_config.value_datatype IS '1:String, 2:Double, 3:Integer';
          erp          postgres    false    243                       0    0 '   COLUMN mst_integrator_config.rec_status    COMMENT     Q   COMMENT ON COLUMN erp.mst_integrator_config.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    243            ?            1259    212206    mst_integrator_log    TABLE     ?  CREATE TABLE erp.mst_integrator_log (
    int_id numeric(3,0),
    int_name character varying(100) NOT NULL,
    int_shortname character varying(30) DEFAULT NULL::character varying,
    int_address character varying(250) DEFAULT NULL::character varying,
    int_phone1 character varying(15) DEFAULT NULL::character varying,
    int_phone2 character varying(15) DEFAULT NULL::character varying,
    int_mobile1 character varying(15) DEFAULT NULL::character varying,
    int_mobile2 character varying(15) DEFAULT NULL::character varying,
    int_email1 character varying(100) DEFAULT NULL::character varying,
    int_email2 character varying(100) DEFAULT NULL::character varying,
    int_logo_path character varying(500) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.mst_integrator_log;
       erp         heap    postgres    false    6            ?            1259    212225    seq_item    SEQUENCE     v   CREATE SEQUENCE erp.seq_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
    DROP SEQUENCE erp.seq_item;
       erp          postgres    false    6            ?            1259    212227    mst_item    TABLE       CREATE TABLE erp.mst_item (
    item_id numeric(10,0) DEFAULT nextval('erp.seq_item'::regclass) NOT NULL,
    ic_id numeric(3,0) NOT NULL,
    item_name character varying(100) NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    make character varying(50) DEFAULT NULL::character varying,
    sr_no numeric(1,0) DEFAULT '0'::numeric NOT NULL,
    item_size numeric(1,0) DEFAULT '0'::numeric NOT NULL,
    item_type numeric(1,0) DEFAULT '0'::numeric NOT NULL,
    min_stock_qty numeric(5,0) DEFAULT 0 NOT NULL,
    unit_id numeric(3,0) NOT NULL,
    unit_rate numeric(9,2) DEFAULT 0 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT NULL::numeric,
    sgst_rate numeric(5,2) DEFAULT NULL::numeric,
    igst_rate numeric(5,2) DEFAULT NULL::numeric,
    hsn_code numeric(6,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_rate_effective_from date,
    item_code character varying(30) DEFAULT NULL::character varying,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    consumable integer DEFAULT 0,
    maintenance integer DEFAULT 0,
    insurance integer DEFAULT 0,
    item_display_criteria character varying(10) DEFAULT '1,2'::character varying,
    sap_code character varying(30),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    import_trans_id numeric(11,0) DEFAULT 0
);
    DROP TABLE erp.mst_item;
       erp         heap    postgres    false    245    6                       0    0    COLUMN mst_item.item_type    COMMENT     M   COMMENT ON COLUMN erp.mst_item.item_type IS '0:Raw Material 1:Finish Goods';
          erp          postgres    false    246            	           0    0    COLUMN mst_item.min_stock_qty    COMMENT     G   COMMENT ON COLUMN erp.mst_item.min_stock_qty IS 'Minimum Stock Level';
          erp          postgres    false    246            
           0    0    COLUMN mst_item.rec_status    COMMENT     D   COMMENT ON COLUMN erp.mst_item.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    246                       0    0    COLUMN mst_item.consumable    COMMENT     ?   COMMENT ON COLUMN erp.mst_item.consumable IS '0 - No
1 - Yes';
          erp          postgres    false    246                       0    0    COLUMN mst_item.maintenance    COMMENT     @   COMMENT ON COLUMN erp.mst_item.maintenance IS '0 - No
1 - Yes';
          erp          postgres    false    246                       0    0    COLUMN mst_item.insurance    COMMENT     >   COMMENT ON COLUMN erp.mst_item.insurance IS '0 - No
1 - Yes';
          erp          postgres    false    246                       0    0 %   COLUMN mst_item.item_display_criteria    COMMENT     t   COMMENT ON COLUMN erp.mst_item.item_display_criteria IS '0 - No
1 - Dashboard
2 - Report
1,2 - Dashboard, Report ';
          erp          postgres    false    246            ?            1259    212256    seq_item_category    SEQUENCE     w   CREATE SEQUENCE erp.seq_item_category
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1;
 %   DROP SEQUENCE erp.seq_item_category;
       erp          postgres    false    6            ?            1259    212258    mst_item_category    TABLE     &  CREATE TABLE erp.mst_item_category (
    ic_id numeric(3,0) DEFAULT nextval('erp.seq_item_category'::regclass) NOT NULL,
    cat_name character varying(20) NOT NULL,
    cat_desc character varying(100) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 "   DROP TABLE erp.mst_item_category;
       erp         heap    postgres    false    247    6                       0    0 #   COLUMN mst_item_category.rec_status    COMMENT     M   COMMENT ON COLUMN erp.mst_item_category.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    248            ?            1259    212271    mst_item_category_log    TABLE     ?  CREATE TABLE erp.mst_item_category_log (
    ic_id numeric(3,0),
    cat_name character varying(20),
    cat_desc character varying(100) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 &   DROP TABLE erp.mst_item_category_log;
       erp         heap    postgres    false    6            ?            1259    212283    seq_item_log    SEQUENCE     z   CREATE SEQUENCE erp.seq_item_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
     DROP SEQUENCE erp.seq_item_log;
       erp          postgres    false    6            ?            1259    212285    mst_item_log    TABLE     ?  CREATE TABLE erp.mst_item_log (
    item_id numeric(10,0) DEFAULT NULL::numeric,
    ic_id numeric(3,0) DEFAULT NULL::numeric,
    item_name character varying(100) DEFAULT NULL::character varying,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    make character varying(50) DEFAULT NULL::character varying,
    sr_no numeric(1,0) DEFAULT NULL::numeric,
    item_size numeric(1,0) DEFAULT NULL::numeric,
    item_type numeric(1,0) DEFAULT NULL::numeric,
    min_stock_qty numeric(5,0) DEFAULT NULL::numeric,
    unit_id numeric(3,0) DEFAULT NULL::numeric,
    unit_rate numeric(9,2) DEFAULT NULL::numeric,
    cgst_rate numeric(5,2) DEFAULT NULL::numeric,
    sgst_rate numeric(5,2) DEFAULT NULL::numeric,
    igst_rate numeric(5,2) DEFAULT NULL::numeric,
    hsn_code numeric(6,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) NOT NULL,
    action_type numeric(1,0) NOT NULL,
    action_by numeric(5,0) NOT NULL,
    action_on timestamp without time zone,
    item_rate_effective_from date,
    item_code character varying(30) DEFAULT NULL::character varying,
    hc_id numeric(2,0),
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_item_log'::regclass) NOT NULL,
    consumable integer,
    maintenance integer,
    insurance integer,
    item_display_criteria character varying(10),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_item_log;
       erp         heap    postgres    false    250    6            ?            1259    212310    seq_name_setup    SEQUENCE     |   CREATE SEQUENCE erp.seq_name_setup
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 "   DROP SEQUENCE erp.seq_name_setup;
       erp          postgres    false    6            ?            1259    212312    mst_name_setup    TABLE     ?  CREATE TABLE erp.mst_name_setup (
    trans_id numeric(9,0) DEFAULT nextval('erp.seq_name_setup'::regclass) NOT NULL,
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
    DROP TABLE erp.mst_name_setup;
       erp         heap    postgres    false    252    6            ?            1259    212339    mst_name_setup_log    TABLE     t  CREATE TABLE erp.mst_name_setup_log (
    trans_id numeric(9,0),
    int_id numeric,
    hc_id numeric,
    plant_id numeric,
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
 #   DROP TABLE erp.mst_name_setup_log;
       erp         heap    postgres    false    6            ?            1259    212365    seq_payment_other_conditions    SEQUENCE     ?   CREATE SEQUENCE erp.seq_payment_other_conditions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
 0   DROP SEQUENCE erp.seq_payment_other_conditions;
       erp          postgres    false    6                        1259    212367    mst_payment_other_conditions    TABLE     ?  CREATE TABLE erp.mst_payment_other_conditions (
    condition_id numeric(3,0) DEFAULT nextval('erp.seq_payment_other_conditions'::regclass) NOT NULL,
    condition_name character varying(100) DEFAULT NULL::character varying,
    payment_condition character varying(500) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 -   DROP TABLE erp.mst_payment_other_conditions;
       erp         heap    postgres    false    255    6                       0    0 .   COLUMN mst_payment_other_conditions.rec_status    COMMENT     X   COMMENT ON COLUMN erp.mst_payment_other_conditions.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    256                       1259    212381     mst_payment_other_conditions_log    TABLE     5  CREATE TABLE erp.mst_payment_other_conditions_log (
    condition_id numeric(3,0) DEFAULT NULL::numeric,
    condition_name character varying(100) DEFAULT NULL::character varying,
    payment_condition character varying(500) DEFAULT NULL::character varying,
    rec_status numeric(1,0) NOT NULL,
    action_type numeric(1,0),
    action_by numeric(5,0) NOT NULL,
    action_on timestamp without time zone,
    hc_id numeric(2,0) NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 1   DROP TABLE erp.mst_payment_other_conditions_log;
       erp         heap    postgres    false    6                       0    0 2   COLUMN mst_payment_other_conditions_log.rec_status    COMMENT     \   COMMENT ON COLUMN erp.mst_payment_other_conditions_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    257                       0    0 3   COLUMN mst_payment_other_conditions_log.action_type    COMMENT     f   COMMENT ON COLUMN erp.mst_payment_other_conditions_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    257                       1259    212392 	   seq_plant    SEQUENCE     o   CREATE SEQUENCE erp.seq_plant
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_plant;
       erp          postgres    false    6                       1259    212394 	   mst_plant    TABLE     ?  CREATE TABLE erp.mst_plant (
    plant_id numeric(7,0) DEFAULT nextval('erp.seq_plant'::regclass) NOT NULL,
    hc_id numeric(5,0) NOT NULL,
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
    sap_code character varying(20),
    sap_id numeric(8,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    plant_prefix character varying(7),
    prefix character varying(7)
);
    DROP TABLE erp.mst_plant;
       erp         heap    postgres    false    258    6                       0    0    COLUMN mst_plant.plant_reg_no    COMMENT     I   COMMENT ON COLUMN erp.mst_plant.plant_reg_no IS 'Plant Registration No';
          erp          postgres    false    259                       0    0    COLUMN mst_plant.plant_type    COMMENT     M   COMMENT ON COLUMN erp.mst_plant.plant_type IS 'Refer mst_presetdata table.';
          erp          postgres    false    259                       0    0    COLUMN mst_plant.plant_subtype    COMMENT     P   COMMENT ON COLUMN erp.mst_plant.plant_subtype IS 'Refer mst_presetdata table.';
          erp          postgres    false    259                       0    0    COLUMN mst_plant.plant_status    COMMENT     O   COMMENT ON COLUMN erp.mst_plant.plant_status IS 'Refer mst_presetdata table.';
          erp          postgres    false    259                       0    0    COLUMN mst_plant.rec_status    COMMENT     E   COMMENT ON COLUMN erp.mst_plant.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    259                       1259    212408    mst_plant_log    TABLE     ?  CREATE TABLE erp.mst_plant_log (
    plant_id numeric(7,0),
    hc_id numeric(5,0),
    int_id numeric(3,0),
    plant_name character varying(100),
    plant_reg_no character varying(50),
    plant_reg_date date,
    plant_address character varying(255),
    plant_details character varying(255),
    plant_install_date date,
    plant_contact_person character varying(100),
    plant_latitude numeric,
    plant_longitude numeric,
    plant_contact_mobile_no character varying(15),
    plant_type numeric(2,0),
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
    sap_code character varying(20),
    sap_id numeric(8,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_plant_log;
       erp         heap    postgres    false    6                       1259    212421    seq_presetdata    SEQUENCE     u   CREATE SEQUENCE erp.seq_presetdata
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
 "   DROP SEQUENCE erp.seq_presetdata;
       erp          postgres    false    6                       1259    212423    mst_presetdata    TABLE     x  CREATE TABLE erp.mst_presetdata (
    presetdata_id numeric(3,0) DEFAULT nextval('erp.seq_presetdata'::regclass) NOT NULL,
    dbtable_name character varying(100) NOT NULL,
    dbcolumn_name character varying(100) NOT NULL,
    presetdata_key numeric(3,0) NOT NULL,
    presetdata_value character varying(255) NOT NULL,
    presetdata_index numeric(3,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(5,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_presetdata;
       erp         heap    postgres    false    261    6                       0    0     COLUMN mst_presetdata.rec_status    COMMENT     J   COMMENT ON COLUMN erp.mst_presetdata.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    262                       1259    212431    mst_presetdata_log    TABLE       CREATE TABLE erp.mst_presetdata_log (
    presetdata_id numeric(3,0),
    dbtable_name character varying(100),
    dbcolumn_name character varying(100),
    presetdata_key numeric(3,0),
    presetdata_value character varying(255),
    presetdata_index numeric(3,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(5,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.mst_presetdata_log;
       erp         heap    postgres    false    6                       1259    212438    seq_role    SEQUENCE     o   CREATE SEQUENCE erp.seq_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
    DROP SEQUENCE erp.seq_role;
       erp          postgres    false    6            	           1259    212440    mst_role    TABLE     ?  CREATE TABLE erp.mst_role (
    role_id numeric(3,0) DEFAULT nextval('erp.seq_role'::regclass) NOT NULL,
    role_name character varying(50) NOT NULL,
    role_desc character varying(100) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(5,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_role;
       erp         heap    postgres    false    264    6                       0    0    COLUMN mst_role.rec_status    COMMENT     D   COMMENT ON COLUMN erp.mst_role.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    265            
           1259    212449    mst_role_log    TABLE     ?  CREATE TABLE erp.mst_role_log (
    role_id numeric(3,0),
    role_name character varying(50),
    role_desc character varying(100),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(5,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_role_log;
       erp         heap    postgres    false    6                       1259    212456 
   seq_screen    SEQUENCE     q   CREATE SEQUENCE erp.seq_screen
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
    DROP SEQUENCE erp.seq_screen;
       erp          postgres    false    6                       1259    212458 
   mst_screen    TABLE       CREATE TABLE erp.mst_screen (
    screen_id numeric(3,0) DEFAULT nextval('erp.seq_screen'::regclass) NOT NULL,
    screen_name character varying(100) NOT NULL,
    screen_nav_path character varying(500) NOT NULL,
    screen_desc character varying(100) DEFAULT NULL::character varying,
    parent_screen_id numeric(3,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.mst_screen;
       erp         heap    postgres    false    267    6                       0    0    COLUMN mst_screen.rec_status    COMMENT     F   COMMENT ON COLUMN erp.mst_screen.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    268                       1259    212470    seq_site    SEQUENCE     n   CREATE SEQUENCE erp.seq_site
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_site;
       erp          postgres    false    6                       1259    212472    mst_site    TABLE       CREATE TABLE erp.mst_site (
    site_id numeric DEFAULT nextval('erp.seq_site'::regclass) NOT NULL,
    hc_id numeric(5,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    site_name character varying(200),
    site_type integer DEFAULT 1,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    work_code character varying(50),
    cust_id numeric(7,0) NOT NULL,
    site_distance numeric(7,0),
    site_address character varying(200),
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    file_path text,
    import_trans_id numeric(11,0) DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_site;
       erp         heap    postgres    false    269    6                       0    0    COLUMN mst_site.site_type    COMMENT     C   COMMENT ON COLUMN erp.mst_site.site_type IS 'PWD =0 , Private =1';
          erp          postgres    false    270                       0    0    COLUMN mst_site.import_trans_id    COMMENT     ]   COMMENT ON COLUMN erp.mst_site.import_trans_id IS 'Will store erp_import table primary key';
          erp          postgres    false    270                       1259    212486    seq_site_contact    SEQUENCE     v   CREATE SEQUENCE erp.seq_site_contact
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_site_contact;
       erp          postgres    false    6                       1259    212488    mst_site_contact    TABLE       CREATE TABLE erp.mst_site_contact (
    site_con_id numeric(8,0) DEFAULT nextval('erp.seq_site_contact'::regclass) NOT NULL,
    cust_id numeric(7,0) NOT NULL,
    site_id numeric(7,0) NOT NULL,
    site_con_name character varying(100) NOT NULL,
    site_con_designation numeric(2,0) NOT NULL,
    mob_no1 character varying(15) NOT NULL,
    wa_no1 character varying(15),
    email_id1 character varying(50),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.mst_site_contact;
       erp         heap    postgres    false    271    6                       0    0 ,   COLUMN mst_site_contact.site_con_designation    COMMENT     _   COMMENT ON COLUMN erp.mst_site_contact.site_con_designation IS 'Refer mst_preset_data table.';
          erp          postgres    false    272                       0    0 "   COLUMN mst_site_contact.rec_status    COMMENT     L   COMMENT ON COLUMN erp.mst_site_contact.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    272                       1259    212500    mst_site_contact_log    TABLE     ?  CREATE TABLE erp.mst_site_contact_log (
    site_con_id numeric(8,0),
    cust_id numeric(7,0) NOT NULL,
    site_id numeric(7,0) NOT NULL,
    site_con_name character varying(100),
    site_con_designation numeric(2,0),
    mob_no1 character varying(15) NOT NULL,
    wa_no1 character varying(15),
    email_id1 character varying(50),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.mst_site_contact_log;
       erp         heap    postgres    false    6                       1259    212511    mst_site_log    TABLE     ?  CREATE TABLE erp.mst_site_log (
    site_id numeric,
    hc_id numeric(5,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    site_name character varying(200),
    site_type integer DEFAULT 1,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    work_code character varying(50),
    cust_id numeric(7,0) NOT NULL,
    site_distance numeric(7,0),
    site_address character varying(200),
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    file_path text,
    import_trans_id numeric(11,0) DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_site_log;
       erp         heap    postgres    false    6                       1259    212524 	   seq_state    SEQUENCE     o   CREATE SEQUENCE erp.seq_state
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99
    CACHE 1;
    DROP SEQUENCE erp.seq_state;
       erp          postgres    false    6                       1259    212526 	   mst_state    TABLE     ?  CREATE TABLE erp.mst_state (
    state_id numeric(2,0) DEFAULT nextval('erp.seq_state'::regclass) NOT NULL,
    state_name character varying(30) NOT NULL,
    state_desc character varying(100) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.mst_state;
       erp         heap    postgres    false    275    6                       0    0    COLUMN mst_state.rec_status    COMMENT     E   COMMENT ON COLUMN erp.mst_state.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    276                       1259    212534    seq_subtestmaster    SEQUENCE        CREATE SEQUENCE erp.seq_subtestmaster
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 %   DROP SEQUENCE erp.seq_subtestmaster;
       erp          postgres    false    6                       1259    212536    mst_subtestmaster    TABLE     ?  CREATE TABLE erp.mst_subtestmaster (
    sub_test_id numeric(5,0) DEFAULT nextval('erp.seq_subtestmaster'::regclass) NOT NULL,
    test_id numeric(5,0) NOT NULL,
    sub_test_name character varying(200) NOT NULL,
    days numeric(11,0) DEFAULT NULL::numeric,
    rate numeric(15,2) DEFAULT NULL::numeric,
    sub_test_abbrivation character varying(200),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 "   DROP TABLE erp.mst_subtestmaster;
       erp         heap    postgres    false    277    6                       1259    212548    seq_testmaster    SEQUENCE     |   CREATE SEQUENCE erp.seq_testmaster
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 "   DROP SEQUENCE erp.seq_testmaster;
       erp          postgres    false    6                       1259    212550    mst_testmaster    TABLE     ?  CREATE TABLE erp.mst_testmaster (
    test_id numeric(5,0) DEFAULT nextval('erp.seq_testmaster'::regclass) NOT NULL,
    main_cat character varying(10) NOT NULL,
    test_name character varying(200) NOT NULL,
    from_date timestamp without time zone DEFAULT now() NOT NULL,
    to_date timestamp without time zone DEFAULT now() NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_testmaster;
       erp         heap    postgres    false    279    6                        0    0    COLUMN mst_testmaster.main_cat    COMMENT     O   COMMENT ON COLUMN erp.mst_testmaster.main_cat IS 'Cement/Bitume/Agg/Soil/etc';
          erp          postgres    false    280                       1259    212562    seq_uiaction    SEQUENCE     s   CREATE SEQUENCE erp.seq_uiaction
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
     DROP SEQUENCE erp.seq_uiaction;
       erp          postgres    false    6                       1259    212564    mst_uiaction    TABLE     ?  CREATE TABLE erp.mst_uiaction (
    uiaction_id numeric(3,0) DEFAULT nextval('erp.seq_uiaction'::regclass) NOT NULL,
    uiaction_name character varying(100) NOT NULL,
    uiaction_short_desc character varying(100) NOT NULL,
    uiaction_long_desc character varying(300) DEFAULT NULL::character varying,
    uicomponent_type numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.mst_uiaction;
       erp         heap    postgres    false    281    6            !           0    0 $   COLUMN mst_uiaction.uicomponent_type    COMMENT     O   COMMENT ON COLUMN erp.mst_uiaction.uicomponent_type IS 'Refer mst_presetdata';
          erp          postgres    false    282            "           0    0    COLUMN mst_uiaction.rec_status    COMMENT     H   COMMENT ON COLUMN erp.mst_uiaction.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    282                       1259    212575    seq_unit    SEQUENCE     o   CREATE SEQUENCE erp.seq_unit
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999
    CACHE 1;
    DROP SEQUENCE erp.seq_unit;
       erp          postgres    false    6                       1259    212577    mst_unit    TABLE       CREATE TABLE erp.mst_unit (
    unit_id numeric(3,0) DEFAULT nextval('erp.seq_unit'::regclass) NOT NULL,
    unit_name character varying(50) NOT NULL,
    unit_desc character varying(100) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_unit;
       erp         heap    postgres    false    283    6            #           0    0    COLUMN mst_unit.rec_status    COMMENT     D   COMMENT ON COLUMN erp.mst_unit.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    284                       1259    212590    mst_unit_log    TABLE     ?  CREATE TABLE erp.mst_unit_log (
    unit_id numeric(3,0),
    unit_name character varying(50),
    unit_desc character varying(100),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_unit_log;
       erp         heap    postgres    false    6                       1259    212601    seq_user    SEQUENCE     q   CREATE SEQUENCE erp.seq_user
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    CACHE 1;
    DROP SEQUENCE erp.seq_user;
       erp          postgres    false    6                       1259    212603    mst_user    TABLE     O  CREATE TABLE erp.mst_user (
    user_id numeric(5,0) DEFAULT nextval('erp.seq_user'::regclass) NOT NULL,
    user_name character varying(20) NOT NULL,
    user_security_string character varying(250) NOT NULL,
    user_desc character varying(100) DEFAULT NULL::character varying,
    user_mobile_no character varying(15) NOT NULL,
    user_email_id character varying(100) NOT NULL,
    user_type numeric(1,0) NOT NULL,
    user_general_id numeric(5,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    is_restriction_free numeric(1,0) DEFAULT 0 NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_user;
       erp         heap    postgres    false    286    6            $           0    0    COLUMN mst_user.user_type    COMMENT     K   COMMENT ON COLUMN erp.mst_user.user_type IS 'Refer mst_presetdata table.';
          erp          postgres    false    287            %           0    0    COLUMN mst_user.user_general_id    COMMENT     O   COMMENT ON COLUMN erp.mst_user.user_general_id IS 'Int_Id,Con_Id,Comp_Emp_Id';
          erp          postgres    false    287            &           0    0    COLUMN mst_user.rec_status    COMMENT     D   COMMENT ON COLUMN erp.mst_user.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    287            '           0    0 #   COLUMN mst_user.is_restriction_free    COMMENT     d   COMMENT ON COLUMN erp.mst_user.is_restriction_free IS '0: Only logged in user, 1:View All Records';
          erp          postgres    false    287                        1259    212618    mst_user_log    TABLE        CREATE TABLE erp.mst_user_log (
    user_id numeric(5,0),
    user_name character varying(20) NOT NULL,
    user_security_string character varying(250) NOT NULL,
    user_desc character varying(100) DEFAULT NULL::character varying,
    user_mobile_no character varying(15) NOT NULL,
    user_email_id character varying(100) NOT NULL,
    user_type numeric(1,0) NOT NULL,
    user_general_id numeric(5,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    is_restriction_free numeric(1,0) DEFAULT 0 NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_user_log;
       erp         heap    postgres    false    6            !           1259    212632    seq_vehicle    SEQUENCE     q   CREATE SEQUENCE erp.seq_vehicle
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_vehicle;
       erp          postgres    false    6            "           1259    212634    mst_vehicle    TABLE     |  CREATE TABLE erp.mst_vehicle (
    veh_id numeric(5,0) DEFAULT nextval('erp.seq_vehicle'::regclass) NOT NULL,
    hc_id numeric(5,0) NOT NULL,
    int_id numeric(3,0) NOT NULL,
    dev_sim_no character varying(20),
    dev_imei_no character varying(20),
    dev_install_on date,
    veh_name character varying(50) DEFAULT NULL::character varying,
    veh_no character varying(15) DEFAULT NULL::character varying,
    veh_type numeric(2,0) NOT NULL,
    veh_make character varying(50) DEFAULT NULL::character varying,
    veh_color character varying(30) DEFAULT NULL::character varying,
    veh_chasis_no character varying(30) DEFAULT NULL::character varying,
    veh_fuel_capacity numeric(4,0) DEFAULT NULL::numeric,
    veh_status numeric(1,0) DEFAULT 1 NOT NULL,
    correction_factor numeric,
    full_voltage numeric,
    empty_voltage numeric,
    calibrated_voltage numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    created_by numeric(5,0) NOT NULL,
    created_on timestamp without time zone DEFAULT now() NOT NULL,
    modified_by numeric(5,0) DEFAULT NULL::numeric,
    modified_on timestamp without time zone,
    sync_status numeric(1,0) DEFAULT 0 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    allocated_card_id numeric(5,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    import_trans_id numeric(11,0) DEFAULT 0
);
    DROP TABLE erp.mst_vehicle;
       erp         heap    postgres    false    289    6            (           0    0    COLUMN mst_vehicle.veh_type    COMMENT     M   COMMENT ON COLUMN erp.mst_vehicle.veh_type IS 'Refer mst_presetdata table.';
          erp          postgres    false    290            )           0    0    COLUMN mst_vehicle.veh_color    COMMENT     H   COMMENT ON COLUMN erp.mst_vehicle.veh_color IS 'RRGGBB in hex number.';
          erp          postgres    false    290            *           0    0 $   COLUMN mst_vehicle.veh_fuel_capacity    COMMENT     D   COMMENT ON COLUMN erp.mst_vehicle.veh_fuel_capacity IS 'In Litres';
          erp          postgres    false    290            +           0    0    COLUMN mst_vehicle.rec_status    COMMENT     G   COMMENT ON COLUMN erp.mst_vehicle.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    290            ,           0    0 "   COLUMN mst_vehicle.import_trans_id    COMMENT     `   COMMENT ON COLUMN erp.mst_vehicle.import_trans_id IS 'Will store erp_import table primary key';
          erp          postgres    false    290            #           1259    212654    seq_vehicle_insurance    SEQUENCE     ?   CREATE SEQUENCE erp.seq_vehicle_insurance
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 )   DROP SEQUENCE erp.seq_vehicle_insurance;
       erp          postgres    false    6            $           1259    212656    mst_vehicle_insurance    TABLE     ?  CREATE TABLE erp.mst_vehicle_insurance (
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_vehicle_insurance'::regclass) NOT NULL,
    veh_id numeric(5,0) NOT NULL,
    veh_no character varying(45),
    insurance_no numeric(8,0) NOT NULL,
    from_date timestamp without time zone DEFAULT now() NOT NULL,
    to_date timestamp without time zone DEFAULT now() NOT NULL,
    premium_amt numeric(12,2) DEFAULT 0.00 NOT NULL,
    insurance_type character varying(45),
    owner_name character varying(50),
    company_name character varying(50),
    details_info character varying(200),
    id_no numeric(10,0) DEFAULT '0'::numeric,
    ide_value numeric(18,2) DEFAULT 0.00,
    vehicle_type_id numeric(10,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 &   DROP TABLE erp.mst_vehicle_insurance;
       erp         heap    postgres    false    291    6            %           1259    212669    mst_vehicle_insurance_log    TABLE     t  CREATE TABLE erp.mst_vehicle_insurance_log (
    trans_id numeric(10,0),
    veh_id numeric(5,0) NOT NULL,
    veh_no character varying(45),
    insurance_no numeric(8,0) NOT NULL,
    from_date timestamp without time zone DEFAULT now() NOT NULL,
    to_date timestamp without time zone DEFAULT now() NOT NULL,
    premium_amt numeric(12,2) DEFAULT 0.00 NOT NULL,
    insurance_type character varying(45),
    owner_name character varying(50),
    company_name character varying(50),
    details_info character varying(200),
    id_no numeric(10,0) DEFAULT '0'::numeric,
    ide_value numeric(18,2) DEFAULT 0.00,
    vehicle_type_id numeric(10,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 *   DROP TABLE erp.mst_vehicle_insurance_log;
       erp         heap    postgres    false    6            &           1259    212681    mst_vehicle_log    TABLE     J  CREATE TABLE erp.mst_vehicle_log (
    veh_id numeric(5,0),
    hc_id numeric(5,0) NOT NULL,
    int_id numeric(3,0) NOT NULL,
    dev_sim_no character varying(20),
    dev_imei_no character varying(20),
    dev_install_on date,
    veh_name character varying(50) DEFAULT NULL::character varying,
    veh_no character varying(15) DEFAULT NULL::character varying,
    veh_type numeric(2,0) NOT NULL,
    veh_make character varying(50) DEFAULT NULL::character varying,
    veh_color character varying(30) DEFAULT NULL::character varying,
    veh_chasis_no character varying(30) DEFAULT NULL::character varying,
    veh_fuel_capacity numeric(4,0) DEFAULT NULL::numeric,
    veh_status numeric(1,0) DEFAULT 1 NOT NULL,
    correction_factor numeric,
    full_voltage numeric,
    empty_voltage numeric,
    calibrated_voltage numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    created_by numeric(5,0) NOT NULL,
    created_on timestamp without time zone DEFAULT now() NOT NULL,
    modified_by numeric(5,0) DEFAULT NULL::numeric,
    modified_on timestamp without time zone,
    sync_status numeric(1,0) DEFAULT 0 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    allocated_card_id numeric(5,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    import_trans_id numeric(11,0) DEFAULT 0
);
     DROP TABLE erp.mst_vehicle_log;
       erp         heap    postgres    false    6            '           1259    212700 
   seq_vendor    SEQUENCE     u   CREATE SEQUENCE erp.seq_vendor
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1;
    DROP SEQUENCE erp.seq_vendor;
       erp          postgres    false    6            (           1259    212702 
   mst_vendor    TABLE     ?  CREATE TABLE erp.mst_vendor (
    vendor_id numeric(7,0) DEFAULT nextval('erp.seq_vendor'::regclass) NOT NULL,
    vendor_name character varying(100) NOT NULL,
    vendor_addr character varying(250),
    vendor_lat numeric(10,7),
    vendor_long numeric(10,7),
    vendor_city character varying(50),
    vendor_state_id numeric(2,0) DEFAULT 1,
    pin_code character varying(6),
    ll_no1 character varying(15) DEFAULT NULL::character varying,
    ll_no2 character varying(15) DEFAULT NULL::character varying,
    mob_no1 character varying(15) DEFAULT NULL::character varying,
    mob_no2 character varying(15) DEFAULT NULL::character varying,
    wa_no1 character varying(15) DEFAULT NULL::character varying,
    wa_no2 character varying(15) DEFAULT NULL::character varying,
    email_id1 character varying(50) DEFAULT NULL::character varying,
    email_id2 character varying(50) DEFAULT NULL::character varying,
    vendor_url character varying(100) DEFAULT NULL::character varying,
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
    vendor_code character varying(15),
    vendor_firm_name character varying(100),
    vendor_firm_addr character varying(250),
    credit_limit numeric(13,2) DEFAULT 0,
    int_id numeric(2,0) DEFAULT 1,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mst_vendor;
       erp         heap    postgres    false    295    6            -           0    0    COLUMN mst_vendor.wa_no1    COMMENT     <   COMMENT ON COLUMN erp.mst_vendor.wa_no1 IS 'WhatsApp No.1';
          erp          postgres    false    296            .           0    0    COLUMN mst_vendor.wa_no2    COMMENT     <   COMMENT ON COLUMN erp.mst_vendor.wa_no2 IS 'WhatsApp No.2';
          erp          postgres    false    296            /           0    0    COLUMN mst_vendor.rec_status    COMMENT     F   COMMENT ON COLUMN erp.mst_vendor.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    296            )           1259    212732    seq_vendor_contact    SEQUENCE     ~   CREATE SEQUENCE erp.seq_vendor_contact
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;
 &   DROP SEQUENCE erp.seq_vendor_contact;
       erp          postgres    false    6            *           1259    212734    mst_vendor_contact    TABLE     ?  CREATE TABLE erp.mst_vendor_contact (
    con_id numeric(8,0) DEFAULT nextval('erp.seq_vendor_contact'::regclass) NOT NULL,
    vendor_id numeric(7,0) NOT NULL,
    con_name character varying(100) NOT NULL,
    con_designation numeric(2,0) NOT NULL,
    mob_no1 character varying(15) NOT NULL,
    wa_no1 character varying(15),
    email_id1 character varying(50),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.mst_vendor_contact;
       erp         heap    postgres    false    297    6            0           0    0 )   COLUMN mst_vendor_contact.con_designation    COMMENT     \   COMMENT ON COLUMN erp.mst_vendor_contact.con_designation IS 'Refer mst_preset_data table.';
          erp          postgres    false    298            1           0    0 $   COLUMN mst_vendor_contact.rec_status    COMMENT     N   COMMENT ON COLUMN erp.mst_vendor_contact.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    298            +           1259    212746    seq_weigh_bridge    SEQUENCE     }   CREATE SEQUENCE erp.seq_weigh_bridge
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 999999999
    CACHE 1;
 $   DROP SEQUENCE erp.seq_weigh_bridge;
       erp          postgres    false    6            ,           1259    212748    mst_weigh_bridge    TABLE     ]  CREATE TABLE erp.mst_weigh_bridge (
    weg_bridge_id numeric(11,0) DEFAULT nextval('erp.seq_weigh_bridge'::regclass) NOT NULL,
    bridge_name character varying(500),
    hc_id numeric(5,0) NOT NULL,
    plant_id numeric(11,0) NOT NULL,
    reg_mobile_no character varying(15),
    imei_no character varying(20) NOT NULL,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.mst_weigh_bridge;
       erp         heap    postgres    false    299    6            2           0    0 "   COLUMN mst_weigh_bridge.rec_status    COMMENT     L   COMMENT ON COLUMN erp.mst_weigh_bridge.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    300            -           1259    212760    mstempl_info    TABLE     1  CREATE TABLE erp.mstempl_info (
    emp_id integer NOT NULL,
    emp_fname character varying(100),
    emp_lname character varying(100),
    age numeric(3,0),
    designation character varying(100),
    salary character varying(100),
    emp_address character varying(100),
    emp_mobno character varying(100),
    email character varying(100),
    rec_status numeric(1,0),
    action_by numeric(3,0),
    action_on timestamp without time zone NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mstempl_info;
       erp         heap    postgres    false    6            .           1259    212767    mstempl_info_emp_id_seq    SEQUENCE     ?   CREATE SEQUENCE erp.mstempl_info_emp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE erp.mstempl_info_emp_id_seq;
       erp          postgres    false    6    301            3           0    0    mstempl_info_emp_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE erp.mstempl_info_emp_id_seq OWNED BY erp.mstempl_info.emp_id;
          erp          postgres    false    302            /           1259    212769    seq_emp_bioprofile    SEQUENCE     {   CREATE SEQUENCE erp.seq_emp_bioprofile
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    CACHE 1;
 &   DROP SEQUENCE erp.seq_emp_bioprofile;
       erp          postgres    false    6            0           1259    212771    mtn_emp_bioprofile    TABLE     B  CREATE TABLE erp.mtn_emp_bioprofile (
    bioprof_id numeric(5,0) DEFAULT nextval('erp.seq_emp_bioprofile'::regclass) NOT NULL,
    emp_id numeric(5,0) NOT NULL,
    bio_id_type numeric(2,0) NOT NULL,
    scan_img_file_name character varying(500) NOT NULL,
    fp_rescan_reason character varying(255) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.mtn_emp_bioprofile;
       erp         heap    postgres    false    303    6            4           0    0 %   COLUMN mtn_emp_bioprofile.bio_id_type    COMMENT     Q  COMMENT ON COLUMN erp.mtn_emp_bioprofile.bio_id_type IS '1:RightHand_IndexFinger, 2:RightHand_MiddleFinger, 3:RightHand_RingFinger, 4:RightHand_PinkyFinger, 5:RightHand_ThumbFinger, 6:LeftHand_IndexFinger, 7:LeftHand_MiddleFinger, 8:LeftHand_RingFinger, 9:LeftHand_PinkyFinger 10:LeftHand_ThumbFinger, 11:IrisRetina, 12:Voice, 13:Face';
          erp          postgres    false    304            5           0    0 $   COLUMN mtn_emp_bioprofile.rec_status    COMMENT     N   COMMENT ON COLUMN erp.mtn_emp_bioprofile.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    304            1           1259    212782    mtn_emp_bioprofile_log    TABLE     #  CREATE TABLE erp.mtn_emp_bioprofile_log (
    bioprof_id numeric(5,0) DEFAULT NULL::numeric,
    emp_id numeric(5,0) DEFAULT NULL::numeric,
    bio_id_type numeric(2,0) DEFAULT NULL::numeric,
    scan_img_file_name character varying(500),
    fp_rescan_reason character varying(255),
    rec_status numeric(1,0) NOT NULL,
    action_type numeric(1,0) NOT NULL,
    action_by numeric(5,0) NOT NULL,
    action_on timestamp without time zone,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 '   DROP TABLE erp.mtn_emp_bioprofile_log;
       erp         heap    postgres    false    6            6           0    0 (   COLUMN mtn_emp_bioprofile_log.rec_status    COMMENT     R   COMMENT ON COLUMN erp.mtn_emp_bioprofile_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    305            7           0    0 )   COLUMN mtn_emp_bioprofile_log.action_type    COMMENT     \   COMMENT ON COLUMN erp.mtn_emp_bioprofile_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    305            2           1259    212792    seq_emp_doc    SEQUENCE     y   CREATE SEQUENCE erp.seq_emp_doc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
    DROP SEQUENCE erp.seq_emp_doc;
       erp          postgres    false    6            3           1259    212794    mtn_emp_doc    TABLE     ?  CREATE TABLE erp.mtn_emp_doc (
    emp_doc_id numeric(7,0) DEFAULT nextval('erp.seq_emp_doc'::regclass) NOT NULL,
    emp_id numeric(5,0) NOT NULL,
    doc_cat numeric(2,0) NOT NULL,
    doc_type numeric(2,0) NOT NULL,
    is_true_copy_submitted numeric(1,0) NOT NULL,
    scanned_doc_path character varying(255) NOT NULL,
    submitted_on date NOT NULL,
    returned_on date,
    other_info character varying(100),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.mtn_emp_doc;
       erp         heap    postgres    false    306    6            8           0    0    COLUMN mtn_emp_doc.doc_cat    COMMENT        COMMENT ON COLUMN erp.mtn_emp_doc.doc_cat IS '1:Academic, 2:Professional Service, 3:Address Proof, 4:ID Proof, 5:Birth Proof';
          erp          postgres    false    307            9           0    0    COLUMN mtn_emp_doc.doc_type    COMMENT     ?   COMMENT ON COLUMN erp.mtn_emp_doc.doc_type IS '1:SSC LC, 2:HSC LC, 3:PAN Card, 4:Aadhaar Card, 5:Voter Card, 6:Energy Bill, 7:Telephone Bill';
          erp          postgres    false    307            4           1259    212802    seq_emp_guardian    SEQUENCE     {   CREATE SEQUENCE erp.seq_emp_guardian
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999
    CACHE 1;
 $   DROP SEQUENCE erp.seq_emp_guardian;
       erp          postgres    false    6            5           1259    212804    mtn_emp_guardian    TABLE     ?  CREATE TABLE erp.mtn_emp_guardian (
    eg_id numeric(7,0) DEFAULT nextval('erp.seq_emp_guardian'::regclass) NOT NULL,
    emp_id numeric(5,0) NOT NULL,
    guardian_type numeric(2,0) NOT NULL,
    guardian_name character varying(50) NOT NULL,
    guardian_ll_no character varying(15),
    guardian_mobile_no character varying(15),
    guardian_email_id character varying(100),
    guardian_address character varying(100) NOT NULL,
    guardian_occupation character varying,
    other_info character varying(100),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 !   DROP TABLE erp.mtn_emp_guardian;
       erp         heap    postgres    false    308    6            :           0    0 %   COLUMN mtn_emp_guardian.guardian_type    COMMENT     ?   COMMENT ON COLUMN erp.mtn_emp_guardian.guardian_type IS '1:Mother, 2:Father, 3:Sister, 4:Brother, 5:Husband, 6:Wife, 7:Grand Father, 8:Grand Mother, 9:Uncle, 10:In Laws, 11:Friend, 12:Family Reference, 13:Professional Reference';
          erp          postgres    false    309            6           1259    212814    seq_emp_professional_summary    SEQUENCE     ?   CREATE SEQUENCE erp.seq_emp_professional_summary
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;
 0   DROP SEQUENCE erp.seq_emp_professional_summary;
       erp          postgres    false    6            7           1259    212816    mtn_emp_professional_summary    TABLE     ?  CREATE TABLE erp.mtn_emp_professional_summary (
    emp_profsummary_id numeric(5,0) DEFAULT nextval('erp.seq_emp_professional_summary'::regclass) NOT NULL,
    emp_id numeric(5,0) NOT NULL,
    comp_name character varying(100),
    comp_address character varying(200),
    designation character varying(100),
    experience_count numeric(2,0),
    ctc numeric(10,2),
    experience_letter_path character varying(255),
    relieving_letter_path character varying(255),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    from_date date,
    to_date date,
    salary_slip character varying(255),
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 -   DROP TABLE erp.mtn_emp_professional_summary;
       erp         heap    postgres    false    310    6            8           1259    212826    seq_emp_wish_date    SEQUENCE     }   CREATE SEQUENCE erp.seq_emp_wish_date
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999999
    CACHE 1;
 %   DROP SEQUENCE erp.seq_emp_wish_date;
       erp          postgres    false    6            9           1259    212828    mtn_emp_wish_date    TABLE     	  CREATE TABLE erp.mtn_emp_wish_date (
    ewd_id numeric(8,0) DEFAULT nextval('erp.seq_emp_wish_date'::regclass) NOT NULL,
    wish_type numeric(2,0) NOT NULL,
    wish_date date NOT NULL,
    applicable_to numeric(1,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    general_entity_id numeric(5,0) DEFAULT 0 NOT NULL,
    hc_id numeric(2,0) DEFAULT 25 NOT NULL,
    plant_id numeric(5,0)
);
 "   DROP TABLE erp.mtn_emp_wish_date;
       erp         heap    postgres    false    312    6            ;           0    0 "   COLUMN mtn_emp_wish_date.wish_type    COMMENT     ?   COMMENT ON COLUMN erp.mtn_emp_wish_date.wish_type IS '1:Company Anniversary Day, 2:Birth Day, 3:Joining Day, 4:Marriage Anniversary Day, 5:Spouse Birth Day, 6:Joining Anniversary Day';
          erp          postgres    false    313            <           0    0 &   COLUMN mtn_emp_wish_date.applicable_to    COMMENT     Z   COMMENT ON COLUMN erp.mtn_emp_wish_date.applicable_to IS '1:Common, 2:Employee Specific';
          erp          postgres    false    313            =           0    0 #   COLUMN mtn_emp_wish_date.rec_status    COMMENT     M   COMMENT ON COLUMN erp.mtn_emp_wish_date.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    313            :           1259    212837    seq_notification    SEQUENCE     v   CREATE SEQUENCE erp.seq_notification
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_notification;
       erp          postgres    false    6            ;           1259    212839    notification    TABLE     O  CREATE TABLE erp.notification (
    sr_id numeric(11,0) DEFAULT nextval('erp.seq_notification'::regclass) NOT NULL,
    notification_date date,
    notification_time time without time zone,
    trans_info character varying(150),
    error_qty numeric(7,0),
    mobile_no1 character varying(15),
    mobile_no2 character varying(15)
);
    DROP TABLE erp.notification;
       erp         heap    postgres    false    314    6            >           0    0    TABLE notification    COMMENT     S   COMMENT ON TABLE erp.notification IS 'Table used for send notification sms/email';
          erp          postgres    false    315            ?           0    0    COLUMN notification.error_qty    COMMENT     P   COMMENT ON COLUMN erp.notification.error_qty IS 'for future use extra column ';
          erp          postgres    false    315            <           1259    212843    seq_notification_log    SEQUENCE     z   CREATE SEQUENCE erp.seq_notification_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE erp.seq_notification_log;
       erp          postgres    false    6            =           1259    212845    notification_log    TABLE     {  CREATE TABLE erp.notification_log (
    trns_id numeric(11,0) DEFAULT nextval('erp.seq_notification_log'::regclass) NOT NULL,
    sr_id numeric(11,0) NOT NULL,
    notification_date date,
    notification_time time without time zone,
    trans_info character varying(150),
    error_qty numeric(7,0),
    mobile_no1 character varying(15),
    mobile_no2 character varying(15)
);
 !   DROP TABLE erp.notification_log;
       erp         heap    postgres    false    316    6            @           0    0    TABLE notification_log    COMMENT     S   COMMENT ON TABLE erp.notification_log IS 'maintain history of notification table';
          erp          postgres    false    317            A           0    0    COLUMN notification_log.sr_id    COMMENT     X   COMMENT ON COLUMN erp.notification_log.sr_id IS 'Primary key id of notification table';
          erp          postgres    false    317            >           1259    212849    seq_alert_sent    SEQUENCE     |   CREATE SEQUENCE erp.seq_alert_sent
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 "   DROP SEQUENCE erp.seq_alert_sent;
       erp          postgres    false    6            ?           1259    212851    seq_bpa_details    SEQUENCE     u   CREATE SEQUENCE erp.seq_bpa_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_bpa_details;
       erp          postgres    false    6            @           1259    212853    seq_bpa_info    SEQUENCE     r   CREATE SEQUENCE erp.seq_bpa_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE erp.seq_bpa_info;
       erp          postgres    false    6            A           1259    212855    seq_bpa_info_log    SEQUENCE     v   CREATE SEQUENCE erp.seq_bpa_info_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_bpa_info_log;
       erp          postgres    false    6            B           1259    212857    seq_card_access_transaction    SEQUENCE     ?   CREATE SEQUENCE erp.seq_card_access_transaction
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE erp.seq_card_access_transaction;
       erp          postgres    false    6            C           1259    212859    seq_card_allocation    SEQUENCE     ?   CREATE SEQUENCE erp.seq_card_allocation
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 '   DROP SEQUENCE erp.seq_card_allocation;
       erp          postgres    false    6            D           1259    212861    seq_card_allocation_log    SEQUENCE     ?   CREATE SEQUENCE erp.seq_card_allocation_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 +   DROP SEQUENCE erp.seq_card_allocation_log;
       erp          postgres    false    6            E           1259    212863    seq_dc_info    SEQUENCE     q   CREATE SEQUENCE erp.seq_dc_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_dc_info;
       erp          postgres    false    6            F           1259    212865    seq_dc_info_log    SEQUENCE     u   CREATE SEQUENCE erp.seq_dc_info_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_dc_info_log;
       erp          postgres    false    6            G           1259    212867    seq_dc_item    SEQUENCE     q   CREATE SEQUENCE erp.seq_dc_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_dc_item;
       erp          postgres    false    6            H           1259    212869    seq_dc_item_log    SEQUENCE     u   CREATE SEQUENCE erp.seq_dc_item_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_dc_item_log;
       erp          postgres    false    6            I           1259    212871    seq_dc_summary    SEQUENCE     t   CREATE SEQUENCE erp.seq_dc_summary
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE erp.seq_dc_summary;
       erp          postgres    false    6            J           1259    212873    seq_dc_summary_log    SEQUENCE     x   CREATE SEQUENCE erp.seq_dc_summary_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE erp.seq_dc_summary_log;
       erp          postgres    false    6            K           1259    212875    seq_designmix    SEQUENCE     s   CREATE SEQUENCE erp.seq_designmix
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE erp.seq_designmix;
       erp          postgres    false    6            L           1259    212877    seq_designmix_details    SEQUENCE     {   CREATE SEQUENCE erp.seq_designmix_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE erp.seq_designmix_details;
       erp          postgres    false    6            M           1259    212879    seq_designmix_details_log    SEQUENCE        CREATE SEQUENCE erp.seq_designmix_details_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE erp.seq_designmix_details_log;
       erp          postgres    false    6            N           1259    212881    seq_designmix_log    SEQUENCE     w   CREATE SEQUENCE erp.seq_designmix_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE erp.seq_designmix_log;
       erp          postgres    false    6            O           1259    212883    seq_diesel_refill    SEQUENCE     w   CREATE SEQUENCE erp.seq_diesel_refill
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE erp.seq_diesel_refill;
       erp          postgres    false    6            ?            1259    211797    seq_file_detail    SEQUENCE     u   CREATE SEQUENCE erp.seq_file_detail
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_file_detail;
       erp          postgres    false    6            P           1259    212885    seq_grn_info    SEQUENCE     r   CREATE SEQUENCE erp.seq_grn_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
     DROP SEQUENCE erp.seq_grn_info;
       erp          postgres    false    6            Q           1259    212887    seq_grn_info_log    SEQUENCE     v   CREATE SEQUENCE erp.seq_grn_info_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_grn_info_log;
       erp          postgres    false    6            R           1259    212889    seq_hmb_bmp_devicetransmission    SEQUENCE     ?   CREATE SEQUENCE erp.seq_hmb_bmp_devicetransmission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE erp.seq_hmb_bmp_devicetransmission;
       erp          postgres    false    6            S           1259    212891    seq_hmb_dmp_devicetransmission    SEQUENCE     ?   CREATE SEQUENCE erp.seq_hmb_dmp_devicetransmission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE erp.seq_hmb_dmp_devicetransmission;
       erp          postgres    false    6            T           1259    212893    seq_invoice_info    SEQUENCE     v   CREATE SEQUENCE erp.seq_invoice_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_invoice_info;
       erp          postgres    false    6            U           1259    212895    seq_invoice_info_log    SEQUENCE     z   CREATE SEQUENCE erp.seq_invoice_info_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE erp.seq_invoice_info_log;
       erp          postgres    false    6            V           1259    212897    seq_invoice_item    SEQUENCE     v   CREATE SEQUENCE erp.seq_invoice_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_invoice_item;
       erp          postgres    false    6            W           1259    212899    seq_invoice_item_log    SEQUENCE     z   CREATE SEQUENCE erp.seq_invoice_item_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE erp.seq_invoice_item_log;
       erp          postgres    false    6            X           1259    212901    seq_invoice_summary    SEQUENCE     y   CREATE SEQUENCE erp.seq_invoice_summary
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE erp.seq_invoice_summary;
       erp          postgres    false    6            Y           1259    212903    seq_invoice_summary_log    SEQUENCE     }   CREATE SEQUENCE erp.seq_invoice_summary_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE erp.seq_invoice_summary_log;
       erp          postgres    false    6            Z           1259    212905    seq_plant_office_inward    SEQUENCE     }   CREATE SEQUENCE erp.seq_plant_office_inward
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE erp.seq_plant_office_inward;
       erp          postgres    false    6            [           1259    212907    seq_plant_office_inward_log    SEQUENCE     ?   CREATE SEQUENCE erp.seq_plant_office_inward_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE erp.seq_plant_office_inward_log;
       erp          postgres    false    6            \           1259    212909    seq_plant_office_outward    SEQUENCE     ~   CREATE SEQUENCE erp.seq_plant_office_outward
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE erp.seq_plant_office_outward;
       erp          postgres    false    6            ]           1259    212911    seq_plant_office_outward_log    SEQUENCE     ?   CREATE SEQUENCE erp.seq_plant_office_outward_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE erp.seq_plant_office_outward_log;
       erp          postgres    false    6            ^           1259    212913    seq_po    SEQUENCE     l   CREATE SEQUENCE erp.seq_po
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_po;
       erp          postgres    false    6            _           1259    212915    seq_po_item    SEQUENCE     q   CREATE SEQUENCE erp.seq_po_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_po_item;
       erp          postgres    false    6            `           1259    212917    seq_po_item_log    SEQUENCE     u   CREATE SEQUENCE erp.seq_po_item_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_po_item_log;
       erp          postgres    false    6            a           1259    212919 
   seq_po_log    SEQUENCE     p   CREATE SEQUENCE erp.seq_po_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_po_log;
       erp          postgres    false    6            b           1259    212921    seq_po_payment_conditions    SEQUENCE        CREATE SEQUENCE erp.seq_po_payment_conditions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE erp.seq_po_payment_conditions;
       erp          postgres    false    6            c           1259    212923    seq_po_payment_conditions_log    SEQUENCE     ?   CREATE SEQUENCE erp.seq_po_payment_conditions_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE erp.seq_po_payment_conditions_log;
       erp          postgres    false    6            d           1259    212925    seq_po_summary    SEQUENCE     t   CREATE SEQUENCE erp.seq_po_summary
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE erp.seq_po_summary;
       erp          postgres    false    6            e           1259    212927    seq_po_summary_log    SEQUENCE     x   CREATE SEQUENCE erp.seq_po_summary_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE erp.seq_po_summary_log;
       erp          postgres    false    6            f           1259    212929 '   seq_rmc_batch_detail_devicetransmission    SEQUENCE     ?   CREATE SEQUENCE erp.seq_rmc_batch_detail_devicetransmission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE erp.seq_rmc_batch_detail_devicetransmission;
       erp          postgres    false    6            g           1259    212931     seq_rmc_batch_devicetransmission    SEQUENCE     ?   CREATE SEQUENCE erp.seq_rmc_batch_devicetransmission
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE erp.seq_rmc_batch_devicetransmission;
       erp          postgres    false    6            h           1259    212933    seq_role_screens    SEQUENCE     ~   CREATE SEQUENCE erp.seq_role_screens
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 $   DROP SEQUENCE erp.seq_role_screens;
       erp          postgres    false    6            i           1259    212935    seq_screen_uiactions    SEQUENCE     ?   CREATE SEQUENCE erp.seq_screen_uiactions
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 (   DROP SEQUENCE erp.seq_screen_uiactions;
       erp          postgres    false    6            j           1259    212937    seq_so    SEQUENCE     l   CREATE SEQUENCE erp.seq_so
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_so;
       erp          postgres    false    6            k           1259    212939    seq_so_designmix    SEQUENCE     v   CREATE SEQUENCE erp.seq_so_designmix
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE erp.seq_so_designmix;
       erp          postgres    false    6            l           1259    212941    seq_so_info    SEQUENCE     q   CREATE SEQUENCE erp.seq_so_info
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_so_info;
       erp          postgres    false    6            m           1259    212943    seq_so_info_log    SEQUENCE     u   CREATE SEQUENCE erp.seq_so_info_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_so_info_log;
       erp          postgres    false    6            n           1259    212945    seq_so_item    SEQUENCE     q   CREATE SEQUENCE erp.seq_so_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_so_item;
       erp          postgres    false    6            o           1259    212947    seq_so_item_log    SEQUENCE     u   CREATE SEQUENCE erp.seq_so_item_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE erp.seq_so_item_log;
       erp          postgres    false    6            p           1259    212949 
   seq_so_log    SEQUENCE     p   CREATE SEQUENCE erp.seq_so_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
    DROP SEQUENCE erp.seq_so_log;
       erp          postgres    false    6            q           1259    212951    seq_so_order_details    SEQUENCE     z   CREATE SEQUENCE erp.seq_so_order_details
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE erp.seq_so_order_details;
       erp          postgres    false    6            r           1259    212953    seq_so_summary    SEQUENCE     t   CREATE SEQUENCE erp.seq_so_summary
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE erp.seq_so_summary;
       erp          postgres    false    6            s           1259    212955    seq_so_summary_log    SEQUENCE     x   CREATE SEQUENCE erp.seq_so_summary_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE erp.seq_so_summary_log;
       erp          postgres    false    6            t           1259    212957    seq_summary_dashboard_record    SEQUENCE     ?   CREATE SEQUENCE erp.seq_summary_dashboard_record
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE erp.seq_summary_dashboard_record;
       erp          postgres    false    6            u           1259    212959    seq_summary_stock_level    SEQUENCE     }   CREATE SEQUENCE erp.seq_summary_stock_level
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE erp.seq_summary_stock_level;
       erp          postgres    false    6            v           1259    212961    seq_trn_ledger_transcation    SEQUENCE     ?   CREATE SEQUENCE erp.seq_trn_ledger_transcation
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE erp.seq_trn_ledger_transcation;
       erp          postgres    false    6            w           1259    212963    seq_trn_ledger_transcation_log    SEQUENCE     ?   CREATE SEQUENCE erp.seq_trn_ledger_transcation_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE erp.seq_trn_ledger_transcation_log;
       erp          postgres    false    6            x           1259    212965    seq_trn_stock    SEQUENCE     s   CREATE SEQUENCE erp.seq_trn_stock
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 !   DROP SEQUENCE erp.seq_trn_stock;
       erp          postgres    false    6            ?            1259    211708    seq_trn_weiging_bridge_log    SEQUENCE     ?   CREATE SEQUENCE erp.seq_trn_weiging_bridge_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE erp.seq_trn_weiging_bridge_log;
       erp          postgres    false    6            y           1259    212967    seq_user_roles    SEQUENCE     |   CREATE SEQUENCE erp.seq_user_roles
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 "   DROP SEQUENCE erp.seq_user_roles;
       erp          postgres    false    6            z           1259    212969 "   seq_weiging_bridge_log_wthout_poso    SEQUENCE     ?   CREATE SEQUENCE erp.seq_weiging_bridge_log_wthout_poso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE erp.seq_weiging_bridge_log_wthout_poso;
       erp          postgres    false    6            {           1259    212971    seq_wo    SEQUENCE     t   CREATE SEQUENCE erp.seq_wo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
    DROP SEQUENCE erp.seq_wo;
       erp          postgres    false    6            |           1259    212973    seq_work_allocation    SEQUENCE     ?   CREATE SEQUENCE erp.seq_work_allocation
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 9999999999
    CACHE 1;
 '   DROP SEQUENCE erp.seq_work_allocation;
       erp          postgres    false    6            }           1259    212975    trn_alert_sent    TABLE     ?  CREATE TABLE erp.trn_alert_sent (
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_alert_sent'::regclass) NOT NULL,
    ac_id numeric(3,0) NOT NULL,
    cust_id numeric(11,0) NOT NULL,
    hc_id numeric(8,0) NOT NULL,
    general_artifact_type numeric(1,0) NOT NULL,
    general_artifact_id numeric(10,0) NOT NULL,
    alert_source numeric(1,0) DEFAULT 1 NOT NULL,
    sms_sent_status numeric(1,0) DEFAULT 1 NOT NULL,
    email_sent_status numeric(1,0) DEFAULT 1 NOT NULL,
    alert_sent_on timestamp without time zone NOT NULL,
    sms_contents character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(7,0) DEFAULT 0,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_alert_sent;
       erp         heap    postgres    false    318    6            B           0    0 +   COLUMN trn_alert_sent.general_artifact_type    COMMENT     m   COMMENT ON COLUMN erp.trn_alert_sent.general_artifact_type IS '1: QT, 2: SO, 3: TI, 4: PR, 5: AMC, 6: TODO';
          erp          postgres    false    381            C           0    0 )   COLUMN trn_alert_sent.general_artifact_id    COMMENT     ?   COMMENT ON COLUMN erp.trn_alert_sent.general_artifact_id IS 'trn_quotation.qt_id, trn_so.so_id, trn_ti.ti_id, trn_pr.pr_id, trn_amc.amc_id';
          erp          postgres    false    381            D           0    0 "   COLUMN trn_alert_sent.alert_source    COMMENT     N   COMMENT ON COLUMN erp.trn_alert_sent.alert_source IS '1:Manual, 2:Scheduler';
          erp          postgres    false    381            E           0    0 %   COLUMN trn_alert_sent.sms_sent_status    COMMENT     O   COMMENT ON COLUMN erp.trn_alert_sent.sms_sent_status IS '1:Success, 0:Failed';
          erp          postgres    false    381            F           0    0 '   COLUMN trn_alert_sent.email_sent_status    COMMENT     Q   COMMENT ON COLUMN erp.trn_alert_sent.email_sent_status IS '1:Success, 0:Failed';
          erp          postgres    false    381            G           0    0     COLUMN trn_alert_sent.rec_status    COMMENT     J   COMMENT ON COLUMN erp.trn_alert_sent.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    381            ~           1259    212989    trn_bpa_details    TABLE     ?  CREATE TABLE erp.trn_bpa_details (
    bpa_dt_id numeric(11,0) DEFAULT nextval('erp.seq_bpa_details'::regclass) NOT NULL,
    bpa_id numeric(11,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0),
    grn_id numeric(11,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) DEFAULT 0.00 NOT NULL,
    quality_percentage numeric(5,2) DEFAULT 0.00 NOT NULL,
    net_amt numeric(13,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
     DROP TABLE erp.trn_bpa_details;
       erp         heap    postgres    false    319    6                       1259    213001    trn_bpa_details_log    TABLE     ?  CREATE TABLE erp.trn_bpa_details_log (
    bpa_dt_id numeric(11,0),
    bpa_id numeric(11,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0),
    grn_id numeric(11,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) DEFAULT 0.00 NOT NULL,
    quality_percentage numeric(5,2) DEFAULT 0.00 NOT NULL,
    net_amt numeric(13,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 $   DROP TABLE erp.trn_bpa_details_log;
       erp         heap    postgres    false    6            ?           1259    213012    trn_bpa_info    TABLE     ?  CREATE TABLE erp.trn_bpa_info (
    bpa_id numeric(11,0) DEFAULT nextval('erp.seq_bpa_info'::regclass) NOT NULL,
    bpa_no numeric NOT NULL,
    bpa_date date NOT NULL,
    bpa_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    vendor_id numeric(11,0) NOT NULL,
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(7,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text
);
    DROP TABLE erp.trn_bpa_info;
       erp         heap    postgres    false    320    6            ?           1259    213025    trn_bpa_info_log    TABLE     r  CREATE TABLE erp.trn_bpa_info_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_bpa_info_log'::regclass) NOT NULL,
    bpa_id numeric(11,0) NOT NULL,
    bpa_no numeric NOT NULL,
    bpa_date date NOT NULL,
    bpa_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    vendor_id numeric(11,0) NOT NULL,
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    int_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(7,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.trn_bpa_info_log;
       erp         heap    postgres    false    321    6            ?           1259    213040    trn_card_access_transaction    TABLE     ?  CREATE TABLE erp.trn_card_access_transaction (
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_card_access_transaction'::regclass) NOT NULL,
    card_id numeric(5,0) NOT NULL,
    card_access_string character varying(50) NOT NULL,
    card_allocation_id numeric(10,0) NOT NULL,
    access_tab_type integer NOT NULL,
    access_time timestamp without time zone DEFAULT now() NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 ,   DROP TABLE erp.trn_card_access_transaction;
       erp         heap    postgres    false    322    6            H           0    0 2   COLUMN trn_card_access_transaction.access_tab_type    COMMENT     |   COMMENT ON COLUMN erp.trn_card_access_transaction.access_tab_type IS 'Refer Weighbridge, fuel refill, batch mix, vehicle ';
          erp          postgres    false    386            ?           1259    213050    trn_card_allocation    TABLE     ?  CREATE TABLE erp.trn_card_allocation (
    card_allocation_id numeric(10,0) DEFAULT nextval('erp.seq_card_allocation'::regclass) NOT NULL,
    card_id numeric(5,0) NOT NULL,
    card_access_string character varying(50) NOT NULL,
    allocated_to_id numeric(5,0) NOT NULL,
    allocate_type integer NOT NULL,
    allocate_time timestamp without time zone DEFAULT now() NOT NULL,
    submit_time timestamp without time zone,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 $   DROP TABLE erp.trn_card_allocation;
       erp         heap    postgres    false    323    6            I           0    0 *   COLUMN trn_card_allocation.allocated_to_id    COMMENT     p   COMMENT ON COLUMN erp.trn_card_allocation.allocated_to_id IS 'Refer employee id, driver id  , material id etc';
          erp          postgres    false    387            J           0    0 (   COLUMN trn_card_allocation.allocate_type    COMMENT     y   COMMENT ON COLUMN erp.trn_card_allocation.allocate_type IS 'Refer Mst_PresetData table employee, driver , material etc';
          erp          postgres    false    387            ?           1259    213060    trn_card_allocation_log    TABLE     y  CREATE TABLE erp.trn_card_allocation_log (
    card_allocation_id numeric(10,0),
    card_id numeric(5,0) NOT NULL,
    card_access_string character varying(50),
    allocated_to_id numeric(5,0),
    allocate_type integer,
    allocate_time timestamp without time zone DEFAULT now() NOT NULL,
    submit_time timestamp without time zone,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) DEFAULT 1 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 (   DROP TABLE erp.trn_card_allocation_log;
       erp         heap    postgres    false    6            ?           1259    213069    trn_dc_info    TABLE     ?  CREATE TABLE erp.trn_dc_info (
    dc_id numeric(11,0) DEFAULT nextval('erp.seq_dc_info'::regclass) NOT NULL,
    dc_no numeric NOT NULL,
    dc_date date NOT NULL,
    dc_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    cust_id numeric(11,0) NOT NULL,
    so_id numeric(11,0),
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    weg_bridge_id numeric(10,0) DEFAULT 0,
    batch_id numeric(10,0),
    term_delivery character varying(500),
    term_payment character varying(500),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text,
    increment_against_fy_comp numeric(7,0) DEFAULT 0,
    batch_no character varying(15)
);
    DROP TABLE erp.trn_dc_info;
       erp         heap    postgres    false    325    6            ?           1259    213083    trn_dc_info_log    TABLE     K  CREATE TABLE erp.trn_dc_info_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_dc_info_log'::regclass) NOT NULL,
    dc_id numeric(11,0) NOT NULL,
    dc_no numeric,
    dc_date date,
    dc_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0),
    cust_id numeric(11,0),
    so_id numeric(11,0),
    note character varying(500),
    hc_id numeric(2,0),
    rec_status numeric(1,0) DEFAULT 1,
    action_by numeric(5,0) DEFAULT 1,
    action_on timestamp without time zone DEFAULT now(),
    action_type numeric(1,0),
    sap_code character varying(20),
    sap_id numeric(8,0),
    weg_bridge_id numeric(10,0),
    batch_id numeric(10,0),
    term_delivery character varying(500),
    term_payment character varying(500),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
     DROP TABLE erp.trn_dc_info_log;
       erp         heap    postgres    false    326    6            ?           1259    213095    trn_dc_item    TABLE     ?  CREATE TABLE erp.trn_dc_item (
    dci_id numeric(12,0) DEFAULT nextval('erp.seq_dc_item'::regclass) NOT NULL,
    dc_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    hc_id numeric(2,0),
    plant_id numeric(7,0),
    dmix_id numeric(11,0) DEFAULT 0,
    dc_type numeric(1,0) DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_dc_item;
       erp         heap    postgres    false    327    6            K           0    0    COLUMN trn_dc_item.dc_type    COMMENT     E   COMMENT ON COLUMN erp.trn_dc_item.dc_type IS '0:Item, 1:Production';
          erp          postgres    false    391            ?           1259    213115    trn_dc_item_log    TABLE     ?  CREATE TABLE erp.trn_dc_item_log (
    trans_id numeric(12,0) DEFAULT nextval('erp.seq_dc_item_log'::regclass) NOT NULL,
    dci_id numeric(12,0) NOT NULL,
    dc_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    hc_id numeric(2,0),
    plant_id numeric(7,0),
    dmix_id numeric(11,0) DEFAULT 0,
    dc_type numeric(1,0) DEFAULT 0,
    action_type numeric(1,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
     DROP TABLE erp.trn_dc_item_log;
       erp         heap    postgres    false    328    6            L           0    0 !   COLUMN trn_dc_item_log.rec_status    COMMENT     K   COMMENT ON COLUMN erp.trn_dc_item_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    392            M           0    0 "   COLUMN trn_dc_item_log.action_type    COMMENT     U   COMMENT ON COLUMN erp.trn_dc_item_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    392            ?           1259    213135    trn_dc_summary    TABLE     ?  CREATE TABLE erp.trn_dc_summary (
    dcs_id numeric(11,0) DEFAULT nextval('erp.seq_dc_summary'::regclass) NOT NULL,
    dc_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_dc_summary;
       erp         heap    postgres    false    329    6            N           0    0     COLUMN trn_dc_summary.rec_status    COMMENT     J   COMMENT ON COLUMN erp.trn_dc_summary.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    393            ?           1259    213146    trn_dc_summary_log    TABLE     ?  CREATE TABLE erp.trn_dc_summary_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_dc_summary_log'::regclass) NOT NULL,
    dcs_id numeric(11,0) NOT NULL,
    dc_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.trn_dc_summary_log;
       erp         heap    postgres    false    330    6            O           0    0 $   COLUMN trn_dc_summary_log.rec_status    COMMENT     N   COMMENT ON COLUMN erp.trn_dc_summary_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    394            P           0    0 %   COLUMN trn_dc_summary_log.action_type    COMMENT     X   COMMENT ON COLUMN erp.trn_dc_summary_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    394            ?           1259    213157    trn_designmix    TABLE     r  CREATE TABLE erp.trn_designmix (
    dmix_id numeric(11,0) DEFAULT nextval('erp.seq_designmix'::regclass) NOT NULL,
    design_mix_code character varying(50) NOT NULL,
    design_mix_name character varying(100) NOT NULL,
    item_id numeric(10,0) NOT NULL,
    is_close integer DEFAULT 0,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    agg1_name character varying(10) DEFAULT '-'::character varying,
    agg1_item_id numeric,
    agg1_qty numeric(11,2) DEFAULT 0,
    agg2_name character varying(10) DEFAULT '-'::character varying,
    agg2_item_id numeric,
    agg2_qty numeric(11,2) DEFAULT 0,
    agg3_name character varying(10) DEFAULT '-'::character varying,
    agg3_item_id numeric,
    agg3_qty numeric(11,2) DEFAULT 0,
    agg4_name character varying(10) DEFAULT '-'::character varying,
    agg4_item_id numeric,
    agg4_qty numeric(11,2) DEFAULT 0,
    agg5_name character varying(10) DEFAULT '-'::character varying,
    agg5_item_id numeric,
    agg5_qty numeric(11,2) DEFAULT 0,
    cement1_name character varying(10) DEFAULT '-'::character varying,
    cement1_item_id numeric,
    cement1_qty numeric(11,2) DEFAULT 0,
    cement2_name character varying(10) DEFAULT '-'::character varying,
    cement2_item_id numeric,
    cement2_qty numeric(11,2) DEFAULT 0,
    fill_name character varying(10) DEFAULT '-'::character varying,
    fill_item_id numeric,
    fill_qty numeric(11,2) DEFAULT 0,
    water1_name character varying(10) DEFAULT '-'::character varying,
    water1_item_id numeric,
    water1_qty numeric(11,2) DEFAULT 0,
    water2_name character varying(10) DEFAULT '-'::character varying,
    water2_item_id numeric,
    water2_qty numeric(11,2) DEFAULT 0,
    admix1_name character varying(10) DEFAULT '-'::character varying,
    admix1_item_id numeric,
    admix1_qty numeric(11,3) DEFAULT 0,
    admix12_name character varying(10) DEFAULT '-'::character varying,
    admix12_item_id numeric,
    admix12_qty numeric(11,3) DEFAULT 0,
    admix2_name character varying(10) DEFAULT '-'::character varying,
    admix2_item_id numeric,
    admix2_qty numeric(11,3) DEFAULT 0,
    admix22_name character varying(10) DEFAULT '-'::character varying,
    admix22_item_id numeric,
    admix22_qty numeric(11,3) DEFAULT 0,
    silica_name character varying(10) DEFAULT '-'::character varying,
    silica_item_id numeric,
    silica_qty numeric(11,2) DEFAULT 0,
    slurry_name character varying(10) DEFAULT '-'::character varying,
    slurry_item_id numeric,
    slurry_qty numeric(11,2) DEFAULT 0,
    pigname character varying(10) DEFAULT '-'::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    sap_code character varying(50),
    sap_id numeric(8,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    import_trans_id numeric(11,0) DEFAULT 0
);
    DROP TABLE erp.trn_designmix;
       erp         heap    postgres    false    331    6            Q           0    0    COLUMN trn_designmix.is_close    COMMENT     B   COMMENT ON COLUMN erp.trn_designmix.is_close IS '0:open 1:close';
          erp          postgres    false    395            R           0    0 $   COLUMN trn_designmix.import_trans_id    COMMENT     b   COMMENT ON COLUMN erp.trn_designmix.import_trans_id IS 'Will store erp_import table primary key';
          erp          postgres    false    395            ?           1259    213203    trn_designmix_log    TABLE     S  CREATE TABLE erp.trn_designmix_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_designmix_log'::regclass) NOT NULL,
    dmix_id numeric(11,0) NOT NULL,
    design_mix_code character varying(50) NOT NULL,
    design_mix_name character varying(100) NOT NULL,
    item_id numeric(10,0) NOT NULL,
    is_close integer DEFAULT 0,
    agg1_name character varying(10) DEFAULT '-'::character varying,
    agg1_item_id numeric,
    agg1_qty numeric(11,2) DEFAULT 0,
    agg2_name character varying(10) DEFAULT '-'::character varying,
    agg2_item_id numeric,
    agg2_qty numeric(11,2) DEFAULT 0,
    agg3_name character varying(10) DEFAULT '-'::character varying,
    agg3_item_id numeric,
    agg3_qty numeric(11,2) DEFAULT 0,
    agg4_name character varying(10) DEFAULT '-'::character varying,
    agg4_item_id numeric,
    agg4_qty numeric(11,2) DEFAULT 0,
    agg5_name character varying(10) DEFAULT '-'::character varying,
    agg5_item_id numeric,
    agg5_qty numeric(11,2) DEFAULT 0,
    cement1_name character varying(10) DEFAULT '-'::character varying,
    cement1_item_id numeric,
    cement1_qty numeric(11,2) DEFAULT 0,
    cement2_name character varying(10) DEFAULT '-'::character varying,
    cement2_item_id numeric,
    cement2_qty numeric(11,2) DEFAULT 0,
    fill_name character varying(10) DEFAULT '-'::character varying,
    fill_item_id numeric,
    fill_qty numeric(11,2) DEFAULT 0,
    water1_name character varying(10) DEFAULT '-'::character varying,
    water1_item_id numeric,
    water1_qty numeric(11,2) DEFAULT 0,
    water2_name character varying(10) DEFAULT '-'::character varying,
    water2_item_id numeric,
    water2_qty numeric(11,2) DEFAULT 0,
    admix1_name character varying(10) DEFAULT '-'::character varying,
    admix1_item_id numeric,
    admix1_qty numeric(11,3) DEFAULT 0,
    admix12_name character varying(10) DEFAULT '-'::character varying,
    admix12_item_id numeric,
    admix12_qty numeric(11,3) DEFAULT 0,
    admix2_name character varying(10) DEFAULT '-'::character varying,
    admix2_item_id numeric,
    admix2_qty numeric(11,3) DEFAULT 0,
    admix22_name character varying(10) DEFAULT '-'::character varying,
    admix22_item_id numeric,
    admix22_qty numeric(11,3) DEFAULT 0,
    silica_name character varying(10) DEFAULT '-'::character varying,
    silica_item_id numeric,
    silica_qty numeric(11,2) DEFAULT 0,
    slurry_name character varying(10) DEFAULT '-'::character varying,
    slurry_item_id numeric,
    slurry_qty numeric(11,2) DEFAULT 0,
    pigname character varying(10) DEFAULT '-'::character varying,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 "   DROP TABLE erp.trn_designmix_log;
       erp         heap    postgres    false    334    6            S           0    0 #   COLUMN trn_designmix_log.rec_status    COMMENT     M   COMMENT ON COLUMN erp.trn_designmix_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    396            T           0    0 $   COLUMN trn_designmix_log.action_type    COMMENT     W   COMMENT ON COLUMN erp.trn_designmix_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    396            ?           1259    213248    trn_diesel_refill    TABLE     R  CREATE TABLE erp.trn_diesel_refill (
    trans_id numeric(5,0) DEFAULT nextval('erp.seq_diesel_refill'::regclass) NOT NULL,
    diesel_id numeric(5,0) NOT NULL,
    refill_date timestamp without time zone DEFAULT now() NOT NULL,
    card_id numeric(5,0) NOT NULL,
    diesel_refill_qty numeric(7,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(3,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(2,0) NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 "   DROP TABLE erp.trn_diesel_refill;
       erp         heap    postgres    false    335    6            ?           1259    213257    trn_grn_info    TABLE     b  CREATE TABLE erp.trn_grn_info (
    grn_id numeric(11,0) DEFAULT nextval('erp.seq_grn_info'::regclass) NOT NULL,
    grn_no numeric DEFAULT 0,
    grn_date date NOT NULL,
    grn_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    vendor_id numeric(11,0) NOT NULL,
    po_id numeric(11,0) NOT NULL,
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    quality_percentage numeric(5,2) DEFAULT 0.00,
    plant_id numeric(7,0) NOT NULL,
    weg_bridge_id numeric(10,0),
    ref_invoice_no character varying(20),
    ref_invoice_date timestamp without time zone,
    ref_challan_no character varying(20),
    ref_challan_date timestamp without time zone,
    po_iw_id numeric(10,0),
    is_usedin_bpa integer DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text,
    increment_against_fy_comp numeric(7,0) DEFAULT 0
);
    DROP TABLE erp.trn_grn_info;
       erp         heap    postgres    false    336    6            U           0    0 !   COLUMN trn_grn_info.is_usedin_bpa    COMMENT     ]   COMMENT ON COLUMN erp.trn_grn_info.is_usedin_bpa IS 'this grn is used in BPA
0 - No
1- Yes';
          erp          postgres    false    398            ?           1259    213280    trn_grn_info_log    TABLE     =  CREATE TABLE erp.trn_grn_info_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_grn_info_log'::regclass) NOT NULL,
    grn_id numeric(11,0) NOT NULL,
    grn_no numeric NOT NULL,
    grn_date date NOT NULL,
    grn_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    vendor_id numeric(11,0) NOT NULL,
    po_id numeric(11,0) NOT NULL,
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    quality_percentage numeric(5,2) DEFAULT 0.00,
    plant_id numeric(7,0) NOT NULL,
    ref_invoice_no character varying(20),
    ref_invoice_date timestamp without time zone,
    ref_challan_no character varying(20),
    ref_challan_date timestamp without time zone,
    po_iw_id numeric(10,0),
    weg_bridge_id numeric(10,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.trn_grn_info_log;
       erp         heap    postgres    false    337    6            ?           1259    213300    trn_hmb_bmp_devicetransmission    TABLE     &  CREATE TABLE erp.trn_hmb_bmp_devicetransmission (
    trans_id numeric(20,0) DEFAULT nextval('erp.seq_hmb_bmp_devicetransmission'::regclass) NOT NULL,
    int_id numeric(3,0) DEFAULT 0 NOT NULL,
    cust_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) DEFAULT 0 NOT NULL,
    wo_code character varying(50) DEFAULT NULL::character varying,
    plant_reg_code character varying(50) DEFAULT NULL::character varying,
    batch_id numeric(11,0) DEFAULT 0 NOT NULL,
    opr_lat character varying(20) DEFAULT NULL::character varying,
    opr_long character varying(20) DEFAULT NULL::character varying,
    opr_juri character varying(50) DEFAULT NULL::character varying,
    opr_div character varying(50) DEFAULT NULL::character varying,
    opr_work_name character varying(250) DEFAULT NULL::character varying,
    opr_date date,
    opr_time time without time zone,
    tipper_no character varying(20) DEFAULT NULL::character varying,
    f1 numeric(6,2) DEFAULT NULL::numeric,
    f2 numeric(6,2) DEFAULT NULL::numeric,
    f3 numeric(6,2) DEFAULT NULL::numeric,
    f4 numeric(6,2) DEFAULT NULL::numeric,
    filler_inkg numeric,
    bituman_inkg numeric,
    bituman_percent numeric(6,2) DEFAULT NULL::numeric,
    netmix_ton numeric,
    tank1_temp numeric(6,2) DEFAULT NULL::numeric,
    tank2_temp numeric(6,2) DEFAULT NULL::numeric,
    exhaust_temp numeric(6,2) DEFAULT NULL::numeric,
    mix_temp numeric(6,2) DEFAULT NULL::numeric,
    sr_no numeric,
    filler_percent numeric(6,2) DEFAULT NULL::numeric,
    truck_count numeric(5,0) DEFAULT 0,
    work_type character varying(10) DEFAULT NULL::character varying,
    material_type character varying(20) DEFAULT NULL::character varying,
    device_imei_no character varying(50) DEFAULT NULL::character varying,
    moisture_percent numeric(6,2) DEFAULT NULL::numeric,
    aggregate_ton numeric,
    aggregate_intph numeric(7,2) DEFAULT NULL::numeric,
    bituman_inkgpermin numeric(6,2) DEFAULT NULL::numeric,
    filler_inkgpermin numeric(6,2) DEFAULT NULL::numeric,
    batch_duration_insec numeric(7,2) DEFAULT NULL::numeric,
    weight_kgperbatch numeric(7,2) DEFAULT NULL::numeric,
    bituman_kgperbatch numeric(7,2) DEFAULT NULL::numeric,
    hb1_kgperbatch numeric(7,2) DEFAULT NULL::numeric,
    hb2_kgperbatch numeric(7,2) DEFAULT NULL::numeric,
    hb3_kgperbatch numeric(7,2) DEFAULT NULL::numeric,
    hb4_kgperbatch numeric(7,2) DEFAULT NULL::numeric,
    aggregate_kg numeric(7,2) DEFAULT NULL::numeric,
    packet_arrived_on timestamp without time zone DEFAULT now() NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    batch_end_flag numeric(1,0) DEFAULT NULL::numeric,
    column_validity_status numeric(1,0) DEFAULT 1 NOT NULL,
    customer_name character varying(20) DEFAULT '-'::character varying NOT NULL,
    driver_name character varying(20) DEFAULT '-'::character varying NOT NULL,
    site_name character varying(500) DEFAULT '-'::character varying NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    so_id numeric(10,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 /   DROP TABLE erp.trn_hmb_bmp_devicetransmission;
       erp         heap    postgres    false    338    6            V           0    0 0   COLUMN trn_hmb_bmp_devicetransmission.rec_status    COMMENT     Z   COMMENT ON COLUMN erp.trn_hmb_bmp_devicetransmission.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    400            W           0    0 4   COLUMN trn_hmb_bmp_devicetransmission.batch_end_flag    COMMENT     V   COMMENT ON COLUMN erp.trn_hmb_bmp_devicetransmission.batch_end_flag IS '0:No, 1:Yes';
          erp          postgres    false    400            X           0    0 <   COLUMN trn_hmb_bmp_devicetransmission.column_validity_status    COMMENT     e   COMMENT ON COLUMN erp.trn_hmb_bmp_devicetransmission.column_validity_status IS '0:Invalid, 1:Valid';
          erp          postgres    false    400            ?           1259    213353    trn_hmb_dmp_devicetransmission    TABLE     u	  CREATE TABLE erp.trn_hmb_dmp_devicetransmission (
    trans_id numeric(20,0) DEFAULT nextval('erp.seq_hmb_dmp_devicetransmission'::regclass) NOT NULL,
    int_id numeric(3,0) DEFAULT 0 NOT NULL,
    cust_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) DEFAULT 0 NOT NULL,
    wo_code character varying(50) DEFAULT NULL::character varying,
    plant_reg_code character varying(50) DEFAULT NULL::character varying,
    batch_id numeric(11,0) DEFAULT 0 NOT NULL,
    opr_lat character varying(20) DEFAULT NULL::character varying,
    opr_long character varying(20) DEFAULT NULL::character varying,
    opr_juri character varying(50) DEFAULT NULL::character varying,
    opr_div character varying(50) DEFAULT NULL::character varying,
    opr_work_name character varying(250) DEFAULT NULL::character varying,
    opr_date date,
    opr_time time without time zone,
    tipper_no character varying(20) DEFAULT NULL::character varying,
    f1 numeric(6,2) DEFAULT NULL::numeric,
    f2 numeric(6,2) DEFAULT NULL::numeric,
    f3 numeric(6,2) DEFAULT NULL::numeric,
    f4 numeric(6,2) DEFAULT NULL::numeric,
    filler_inkg numeric,
    bituman_inkg numeric,
    bituman_percent numeric(6,2) DEFAULT NULL::numeric,
    netmix_ton numeric,
    tank1_temp numeric(6,2) DEFAULT NULL::numeric,
    tank2_temp numeric(6,2) DEFAULT NULL::numeric,
    exhaust_temp numeric(6,2) DEFAULT NULL::numeric,
    mix_temp numeric(6,2) DEFAULT NULL::numeric,
    sr_no numeric,
    filler_percent numeric(6,2) DEFAULT NULL::numeric,
    truck_count numeric(5,0) DEFAULT 0,
    work_type character varying(10) DEFAULT NULL::character varying,
    material_type character varying(20) DEFAULT NULL::character varying,
    device_imei_no character varying(50) DEFAULT NULL::character varying,
    moisture_percent numeric(6,2) DEFAULT NULL::numeric,
    aggregate_ton numeric,
    aggregate_intph numeric(7,2) DEFAULT NULL::numeric,
    bituman_inkgpermin numeric(6,2) DEFAULT NULL::numeric,
    filler_inkgpermin numeric(6,2) DEFAULT NULL::numeric,
    packet_arrived_on timestamp without time zone DEFAULT now() NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    batch_end_flag numeric(1,0) DEFAULT NULL::numeric,
    column_validity_status numeric(1,0) DEFAULT 1 NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    so_id numeric(10,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 /   DROP TABLE erp.trn_hmb_dmp_devicetransmission;
       erp         heap    postgres    false    339    6            Y           0    0 0   COLUMN trn_hmb_dmp_devicetransmission.rec_status    COMMENT     Z   COMMENT ON COLUMN erp.trn_hmb_dmp_devicetransmission.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    401            Z           0    0 4   COLUMN trn_hmb_dmp_devicetransmission.batch_end_flag    COMMENT     V   COMMENT ON COLUMN erp.trn_hmb_dmp_devicetransmission.batch_end_flag IS '0:No, 1:Yes';
          erp          postgres    false    401            [           0    0 <   COLUMN trn_hmb_dmp_devicetransmission.column_validity_status    COMMENT     e   COMMENT ON COLUMN erp.trn_hmb_dmp_devicetransmission.column_validity_status IS '0:Invalid, 1:Valid';
          erp          postgres    false    401            ?           1259    213395    trn_invoice_info    TABLE     ?  CREATE TABLE erp.trn_invoice_info (
    invoice_id numeric(11,0) DEFAULT nextval('erp.seq_invoice_info'::regclass) NOT NULL,
    invoice_no numeric NOT NULL,
    invoice_date date NOT NULL,
    invoice_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    cust_id numeric(11,0) NOT NULL,
    so_id numeric(11,0),
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    weg_bridge_id numeric(10,0) DEFAULT 0,
    dc_id numeric(10,0),
    batch_id numeric(10,0),
    term_delivery character varying(500),
    term_payment character varying(500),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text,
    increment_against_fy_comp numeric(7,0) DEFAULT 0
);
 !   DROP TABLE erp.trn_invoice_info;
       erp         heap    postgres    false    340    6            ?           1259    213409    trn_invoice_info_log    TABLE     ?  CREATE TABLE erp.trn_invoice_info_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_invoice_info_log'::regclass) NOT NULL,
    invoice_id numeric(11,0) NOT NULL,
    invoice_no numeric NOT NULL,
    invoice_date date NOT NULL,
    invoice_code character varying(20) DEFAULT NULL::character varying,
    fy_id numeric(2,0) NOT NULL,
    cust_id numeric(11,0) NOT NULL,
    so_id numeric(11,0),
    note character varying(500),
    hc_id numeric(2,0) NOT NULL,
    sap_code character varying(20),
    sap_id numeric(8,0),
    weg_bridge_id numeric(10,0) DEFAULT 0,
    dc_id numeric(10,0),
    batch_id numeric(10,0),
    term_delivery character varying(500),
    term_payment character varying(500),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.trn_invoice_info_log;
       erp         heap    postgres    false    341    6            \           0    0 &   COLUMN trn_invoice_info_log.rec_status    COMMENT     P   COMMENT ON COLUMN erp.trn_invoice_info_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    403            ]           0    0 '   COLUMN trn_invoice_info_log.action_type    COMMENT     Z   COMMENT ON COLUMN erp.trn_invoice_info_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    403            ?           1259    213422    trn_invoice_item    TABLE     ?  CREATE TABLE erp.trn_invoice_item (
    inv_item_id numeric(12,0) DEFAULT nextval('erp.seq_invoice_item'::regclass) NOT NULL,
    invoice_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    hc_id numeric(2,0),
    plant_id numeric(7,0),
    dmix_id numeric(11,0) DEFAULT 0,
    invoice_type numeric(1,0) DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.trn_invoice_item;
       erp         heap    postgres    false    342    6            ^           0    0 $   COLUMN trn_invoice_item.invoice_type    COMMENT     O   COMMENT ON COLUMN erp.trn_invoice_item.invoice_type IS '0:Item, 1:Production';
          erp          postgres    false    404            ?           1259    213442    trn_invoice_item_log    TABLE       CREATE TABLE erp.trn_invoice_item_log (
    trans_id numeric(12,0) DEFAULT nextval('erp.seq_invoice_item_log'::regclass) NOT NULL,
    inv_item_id numeric(12,0) NOT NULL,
    invoice_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    hc_id numeric(2,0),
    plant_id numeric(7,0),
    dmix_id numeric(11,0) DEFAULT 0,
    invoice_type numeric(1,0) DEFAULT 0,
    action_type numeric(1,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.trn_invoice_item_log;
       erp         heap    postgres    false    343    6            _           0    0 &   COLUMN trn_invoice_item_log.rec_status    COMMENT     P   COMMENT ON COLUMN erp.trn_invoice_item_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    405            `           0    0 '   COLUMN trn_invoice_item_log.action_type    COMMENT     Z   COMMENT ON COLUMN erp.trn_invoice_item_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    405            ?           1259    213462    trn_invoice_summary    TABLE     ?  CREATE TABLE erp.trn_invoice_summary (
    invoice_sum_id numeric(11,0) DEFAULT nextval('erp.seq_invoice_summary'::regclass) NOT NULL,
    invoice_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 $   DROP TABLE erp.trn_invoice_summary;
       erp         heap    postgres    false    344    6            a           0    0 %   COLUMN trn_invoice_summary.rec_status    COMMENT     O   COMMENT ON COLUMN erp.trn_invoice_summary.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    406            ?           1259    213473    trn_invoice_summary_log    TABLE     ?  CREATE TABLE erp.trn_invoice_summary_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_invoice_summary_log'::regclass) NOT NULL,
    invoice_sum_id numeric(11,0) NOT NULL,
    invoice_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 (   DROP TABLE erp.trn_invoice_summary_log;
       erp         heap    postgres    false    345    6            b           0    0 )   COLUMN trn_invoice_summary_log.rec_status    COMMENT     S   COMMENT ON COLUMN erp.trn_invoice_summary_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    407            c           0    0 *   COLUMN trn_invoice_summary_log.action_type    COMMENT     ]   COMMENT ON COLUMN erp.trn_invoice_summary_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    407            ?           1259    213483    trn_ledger_transcation    TABLE     |  CREATE TABLE erp.trn_ledger_transcation (
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_trn_ledger_transcation'::regclass) NOT NULL,
    gen_led_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    gn_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    trans_date time without time zone NOT NULL,
    credit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    debit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    op_bal numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    depriciation character varying(45) DEFAULT ''::character varying,
    ref_ac_no numeric(10,0) NOT NULL,
    ref_type integer NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 '   DROP TABLE erp.trn_ledger_transcation;
       erp         heap    postgres    false    374    6            d           0    0 '   COLUMN trn_ledger_transcation.ref_ac_no    COMMENT     Y   COMMENT ON COLUMN erp.trn_ledger_transcation.ref_ac_no IS 'cust no / vendor no / other';
          erp          postgres    false    408            e           0    0 &   COLUMN trn_ledger_transcation.ref_type    COMMENT     a   COMMENT ON COLUMN erp.trn_ledger_transcation.ref_type IS ' 1- cust table , 2- other any table ';
          erp          postgres    false    408            f           0    0 (   COLUMN trn_ledger_transcation.rec_status    COMMENT     R   COMMENT ON COLUMN erp.trn_ledger_transcation.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    408            ?           1259    213497    trn_ledger_transcation_log    TABLE     ?  CREATE TABLE erp.trn_ledger_transcation_log (
    trans_id numeric(10,0) DEFAULT nextval('erp.seq_trn_ledger_transcation_log'::regclass) NOT NULL,
    led_trans_id numeric(10,0) NOT NULL,
    gen_led_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    gn_no numeric(10,0) DEFAULT '0'::numeric NOT NULL,
    trans_date time without time zone NOT NULL,
    credit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    debit_amt numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    op_bal numeric(10,2) DEFAULT '0'::numeric NOT NULL,
    depriciation character varying(45) DEFAULT ''::character varying,
    ref_ac_no numeric(10,0) NOT NULL,
    ref_type integer NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 +   DROP TABLE erp.trn_ledger_transcation_log;
       erp         heap    postgres    false    375    6            g           0    0 ,   COLUMN trn_ledger_transcation_log.rec_status    COMMENT     V   COMMENT ON COLUMN erp.trn_ledger_transcation_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    409            h           0    0 -   COLUMN trn_ledger_transcation_log.action_type    COMMENT     `   COMMENT ON COLUMN erp.trn_ledger_transcation_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    409            ?           1259    213511    trn_plant_office_inward    TABLE     ?  CREATE TABLE erp.trn_plant_office_inward (
    po_iw_id numeric DEFAULT nextval('erp.seq_plant_office_inward'::regclass) NOT NULL,
    hc_id numeric(5,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    vendor_id numeric(7,0) NOT NULL,
    po_id numeric(11,0),
    veh_no character varying(20),
    item_id numeric(7,0) NOT NULL,
    inward_date timestamp without time zone DEFAULT now() NOT NULL,
    isqc_apply integer DEFAULT 0,
    isqc_accept_reject integer DEFAULT 0,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    poi_code character varying(20),
    poi_no numeric(10,0),
    fy_id numeric(2,0),
    ref_invoice_no character varying(20),
    ref_invoice_date timestamp without time zone,
    ref_challan_no character varying(20),
    ref_challan_date timestamp without time zone,
    note character varying(200),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text
);
 (   DROP TABLE erp.trn_plant_office_inward;
       erp         heap    postgres    false    346    6            i           0    0 )   COLUMN trn_plant_office_inward.isqc_apply    COMMENT     N   COMMENT ON COLUMN erp.trn_plant_office_inward.isqc_apply IS 'No =0 , Yes =1';
          erp          postgres    false    410            j           0    0 1   COLUMN trn_plant_office_inward.isqc_accept_reject    COMMENT     i   COMMENT ON COLUMN erp.trn_plant_office_inward.isqc_accept_reject IS 'process =0 , Accept=1, Reject =2 ';
          erp          postgres    false    410            ?           1259    213525    trn_plant_office_inward_log    TABLE     ?  CREATE TABLE erp.trn_plant_office_inward_log (
    trans_id numeric DEFAULT nextval('erp.seq_plant_office_inward_log'::regclass) NOT NULL,
    po_iw_id numeric,
    hc_id numeric(5,0),
    plant_id numeric(7,0),
    vendor_id numeric(7,0),
    po_id numeric(11,0),
    veh_no character varying(20),
    item_id numeric(7,0),
    inward_date timestamp without time zone DEFAULT now(),
    isqc_apply integer DEFAULT 0,
    isqc_accept_reject integer DEFAULT 0,
    poi_code character varying(20),
    poi_no numeric(10,0),
    fy_id numeric(2,0),
    ref_invoice_no character varying(20),
    ref_invoice_date timestamp without time zone,
    ref_challan_no character varying(20),
    ref_challan_date timestamp without time zone,
    note character varying(200),
    rec_status numeric(1,0) DEFAULT 1,
    action_by numeric(5,0) DEFAULT 1,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0)
);
 ,   DROP TABLE erp.trn_plant_office_inward_log;
       erp         heap    postgres    false    347    6            k           0    0 -   COLUMN trn_plant_office_inward_log.rec_status    COMMENT     W   COMMENT ON COLUMN erp.trn_plant_office_inward_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    411            l           0    0 .   COLUMN trn_plant_office_inward_log.action_type    COMMENT     a   COMMENT ON COLUMN erp.trn_plant_office_inward_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    411            ?           1259    213538    trn_plant_office_outward    TABLE     ?  CREATE TABLE erp.trn_plant_office_outward (
    po_ow_id numeric DEFAULT nextval('erp.seq_plant_office_outward'::regclass) NOT NULL,
    hc_id numeric(5,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    client_id numeric(7,0) NOT NULL,
    so_id numeric(11,0),
    veh_no character varying(20),
    item_id numeric(7,0) NOT NULL,
    outward_date timestamp without time zone DEFAULT now() NOT NULL,
    isqc_apply integer DEFAULT 0,
    isqc_accept_reject integer DEFAULT 0,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    po_ow_code character varying(20),
    po_ow_no numeric(10,0),
    fy_id numeric(2,0),
    ref_invoice_id character varying(20),
    ref_challan_id character varying(20),
    note character varying(200),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 )   DROP TABLE erp.trn_plant_office_outward;
       erp         heap    postgres    false    348    6            m           0    0 *   COLUMN trn_plant_office_outward.isqc_apply    COMMENT     O   COMMENT ON COLUMN erp.trn_plant_office_outward.isqc_apply IS 'No =0 , Yes =1';
          erp          postgres    false    412            n           0    0 2   COLUMN trn_plant_office_outward.isqc_accept_reject    COMMENT     j   COMMENT ON COLUMN erp.trn_plant_office_outward.isqc_accept_reject IS 'process =0 , Accept=1, Reject =2 ';
          erp          postgres    false    412            ?           1259    213552    trn_plant_office_outward_log    TABLE     ?  CREATE TABLE erp.trn_plant_office_outward_log (
    trans_id numeric DEFAULT nextval('erp.seq_plant_office_outward_log'::regclass) NOT NULL,
    po_ow_id numeric NOT NULL,
    hc_id numeric(5,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    po_ow_code character varying(20),
    po_ow_no numeric(10,0),
    client_id numeric(7,0) NOT NULL,
    so_id numeric(11,0),
    veh_no character varying(20),
    item_id numeric(7,0) NOT NULL,
    outward_date timestamp without time zone DEFAULT now() NOT NULL,
    isqc_apply integer DEFAULT 0,
    isqc_accept_reject integer DEFAULT 0,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    fy_id numeric(2,0),
    ref_invoice_id character varying(20),
    ref_dchallan_id character varying(20),
    note character varying(200),
    action_type numeric(1,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 -   DROP TABLE erp.trn_plant_office_outward_log;
       erp         heap    postgres    false    349    6            ?           1259    213566    trn_po    TABLE     ]  CREATE TABLE erp.trn_po (
    po_id numeric(11,0) DEFAULT nextval('erp.seq_po'::regclass) NOT NULL,
    vendor_id numeric(11,0) NOT NULL,
    fy_id numeric(2,0) NOT NULL,
    po_date date NOT NULL,
    po_code character varying(20) DEFAULT NULL::character varying,
    po_finalized numeric(1,0) DEFAULT 0,
    note character varying(500),
    po_finalized_date date,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    po_no numeric NOT NULL,
    po_version numeric,
    con_id numeric(8,0),
    plant_id numeric(7,0) NOT NULL,
    sap_po_code character varying(20),
    sap_po_id numeric(8,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text,
    import_trans_id numeric(11,0) DEFAULT 0
);
    DROP TABLE erp.trn_po;
       erp         heap    postgres    false    350    6            o           0    0    COLUMN trn_po.import_trans_id    COMMENT     [   COMMENT ON COLUMN erp.trn_po.import_trans_id IS 'Will store erp_import table primary key';
          erp          postgres    false    414            ?           1259    213580    trn_po_item    TABLE     [  CREATE TABLE erp.trn_po_item (
    poi_id numeric(12,0) DEFAULT nextval('erp.seq_po_item'::regclass) NOT NULL,
    po_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_po_item;
       erp         heap    postgres    false    351    6            ?           1259    213598    trn_po_item_log    TABLE     ?  CREATE TABLE erp.trn_po_item_log (
    po_trans_id numeric(12,0) DEFAULT nextval('erp.seq_po_item_log'::regclass) NOT NULL,
    poi_id numeric(11,0) DEFAULT NULL::numeric,
    po_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(5,2) DEFAULT 0.00 NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
     DROP TABLE erp.trn_po_item_log;
       erp         heap    postgres    false    352    6            ?           1259    213617 
   trn_po_log    TABLE     j  CREATE TABLE erp.trn_po_log (
    po_trans_id numeric(11,0) DEFAULT nextval('erp.seq_po_log'::regclass) NOT NULL,
    po_id numeric(11,0) NOT NULL,
    vendor_id numeric(11,0) NOT NULL,
    fy_id numeric(2,0) NOT NULL,
    po_date date NOT NULL,
    po_code character varying(20) DEFAULT NULL::character varying,
    po_finalized numeric(1,0) DEFAULT 0,
    note character varying(500),
    po_finalized_date date,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    hc_id numeric(2,0) NOT NULL,
    po_no numeric NOT NULL,
    po_version numeric,
    con_id numeric(8,0),
    plant_id numeric(7,0) NOT NULL,
    sap_po_code character varying(20),
    sap_po_id numeric(8,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_po_log;
       erp         heap    postgres    false    353    6            ?           1259    213630    trn_po_payment_conditions    TABLE     ?  CREATE TABLE erp.trn_po_payment_conditions (
    po_condition_id numeric(3,0) DEFAULT nextval('erp.seq_po_payment_conditions'::regclass) NOT NULL,
    po_id numeric(9,0) NOT NULL,
    condition_name character varying(100) DEFAULT NULL::character varying,
    payment_condition character varying(500) DEFAULT NULL::character varying,
    vendor_id numeric(8,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 *   DROP TABLE erp.trn_po_payment_conditions;
       erp         heap    postgres    false    354    6            ?           1259    213643    trn_po_payment_conditions_log    TABLE     ?  CREATE TABLE erp.trn_po_payment_conditions_log (
    trans_id numeric(9,0) DEFAULT nextval('erp.seq_po_payment_conditions_log'::regclass) NOT NULL,
    po_condition_id numeric(3,0) NOT NULL,
    po_id numeric(9,0) NOT NULL,
    condition_name character varying(100) DEFAULT NULL::character varying,
    payment_condition character varying(500) DEFAULT NULL::character varying,
    vendor_id numeric(8,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(3,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 .   DROP TABLE erp.trn_po_payment_conditions_log;
       erp         heap    postgres    false    355    6            ?           1259    213656    trn_po_summary    TABLE     ?  CREATE TABLE erp.trn_po_summary (
    pos_id numeric(11,0) DEFAULT nextval('erp.seq_po_summary'::regclass) NOT NULL,
    po_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(5,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_po_summary;
       erp         heap    postgres    false    356    6            ?           1259    213667    trn_po_summary_log    TABLE        CREATE TABLE erp.trn_po_summary_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_po_summary_log'::regclass) NOT NULL,
    pos_id numeric(11,0) NOT NULL,
    po_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT '1'::numeric NOT NULL,
    action_by numeric(5,0) DEFAULT '1'::numeric NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 #   DROP TABLE erp.trn_po_summary_log;
       erp         heap    postgres    false    357    6            ?           1259    213678 '   trn_rmc_batch_detail_devicetransmission    TABLE     @  CREATE TABLE erp.trn_rmc_batch_detail_devicetransmission (
    trans_id numeric(20,0) DEFAULT nextval('erp.seq_rmc_batch_detail_devicetransmission'::regclass) NOT NULL,
    int_id numeric(3,0) DEFAULT 0 NOT NULL,
    con_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) DEFAULT 0 NOT NULL,
    batch_no numeric,
    batch_index numeric(11,0) DEFAULT NULL::numeric,
    batch_date date,
    batch_time time without time zone,
    batch_time_text character varying(255) DEFAULT NULL::character varying,
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
    hc_id numeric(2,0) NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 8   DROP TABLE erp.trn_rmc_batch_detail_devicetransmission;
       erp         heap    postgres    false    358    6            ?           1259    213724 +   trn_rmc_batch_detail_devicetransmission_log    TABLE       CREATE TABLE erp.trn_rmc_batch_detail_devicetransmission_log (
    trans_id numeric(20,0),
    int_id numeric(3,0) DEFAULT 0 NOT NULL,
    con_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) DEFAULT 0 NOT NULL,
    batch_no numeric,
    batch_index numeric(11,0) DEFAULT NULL::numeric,
    batch_date date,
    batch_time time without time zone,
    batch_time_text character varying(255) DEFAULT NULL::character varying,
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
    hc_id numeric(2,0) NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar,
    update_on timestamp without time zone
);
 <   DROP TABLE erp.trn_rmc_batch_detail_devicetransmission_log;
       erp         heap    postgres    false    6            ?           1259    213769     trn_rmc_batch_devicetransmission    TABLE       CREATE TABLE erp.trn_rmc_batch_devicetransmission (
    trans_id numeric(20,0) DEFAULT nextval('erp.seq_rmc_batch_devicetransmission'::regclass) NOT NULL,
    int_id numeric(3,0) DEFAULT 0 NOT NULL,
    cust_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) DEFAULT 0 NOT NULL,
    batch_no numeric,
    batch_index numeric(11,0) DEFAULT NULL::numeric,
    batch_date date,
    batch_time time without time zone,
    batch_time_text character varying(255) DEFAULT NULL::character varying,
    batch_start_time character varying(255) DEFAULT NULL::character varying,
    batch_end_time character varying(255) DEFAULT NULL::character varying,
    batch_year numeric(11,0) DEFAULT NULL::numeric,
    batcher_name character varying(255) DEFAULT NULL::character varying,
    batcher_user_level character varying(255) DEFAULT NULL::character varying,
    customer_code character varying(255) DEFAULT NULL::character varying,
    recipe_code character varying(255) DEFAULT NULL::character varying,
    recipe_name character varying(255) DEFAULT NULL::character varying,
    mixing_time numeric,
    mixer_capacity numeric,
    site character varying(255) DEFAULT NULL::character varying,
    truck_no character varying(255) DEFAULT NULL::character varying,
    truck_driver character varying(255) DEFAULT NULL::character varying,
    production_qty numeric,
    ordered_qty numeric,
    returned_qty numeric,
    withthisload numeric,
    batch_size numeric,
    order_no character varying(255) DEFAULT NULL::character varying,
    schedule_id character varying(255) DEFAULT NULL::character varying,
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
    hc_id numeric(2,0) NOT NULL,
    so_id numeric(10,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    is_dc_invoice_done numeric(1,0) DEFAULT 0,
    tare_weight numeric(7,2) DEFAULT 0,
    gross_weight numeric(7,2) DEFAULT 0,
    net_weight numeric(7,2) DEFAULT 0,
    wb_slip_no numeric(7,2) DEFAULT 0,
    tdate_time date,
    docket_no character varying(20)
);
 1   DROP TABLE erp.trn_rmc_batch_devicetransmission;
       erp         heap    postgres    false    359    6            ?           1259    213815 $   trn_rmc_batch_devicetransmission_log    TABLE     ?
  CREATE TABLE erp.trn_rmc_batch_devicetransmission_log (
    trans_id numeric(20,0),
    int_id numeric(3,0) DEFAULT 0 NOT NULL,
    cust_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    wo_id numeric(11,0) DEFAULT 0 NOT NULL,
    batch_no numeric,
    batch_index numeric(11,0) DEFAULT NULL::numeric,
    batch_date date,
    batch_time time without time zone,
    batch_time_text character varying(255) DEFAULT NULL::character varying,
    batch_start_time character varying(255) DEFAULT NULL::character varying,
    batch_end_time character varying(255) DEFAULT NULL::character varying,
    batch_year numeric(11,0) DEFAULT NULL::numeric,
    batcher_name character varying(255) DEFAULT NULL::character varying,
    batcher_user_level character varying(255) DEFAULT NULL::character varying,
    customer_code character varying(255) DEFAULT NULL::character varying,
    recipe_code character varying(255) DEFAULT NULL::character varying,
    recipe_name character varying(255) DEFAULT NULL::character varying,
    mixing_time numeric,
    mixer_capacity numeric,
    site character varying(255) DEFAULT NULL::character varying,
    truck_no character varying(255) DEFAULT NULL::character varying,
    truck_driver character varying(255) DEFAULT NULL::character varying,
    production_qty numeric,
    ordered_qty numeric,
    returned_qty numeric,
    withthisload numeric,
    batch_size numeric,
    order_no character varying(255) DEFAULT NULL::character varying,
    schedule_id character varying(255) DEFAULT NULL::character varying,
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
    hc_id numeric(2,0) NOT NULL,
    so_id numeric(10,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    update_on timestamp without time zone,
    is_dc_invoice_done numeric(1,0) DEFAULT 0
);
 5   DROP TABLE erp.trn_rmc_batch_devicetransmission_log;
       erp         heap    postgres    false    6            ?           1259    213856    trn_role_screens    TABLE     ?  CREATE TABLE erp.trn_role_screens (
    trans_id numeric(5,0) DEFAULT nextval('erp.seq_role_screens'::regclass) NOT NULL,
    role_id numeric(3,0) NOT NULL,
    screen_uiaction_id numeric(3,0) NOT NULL,
    screen_index numeric(3,0) DEFAULT NULL::numeric,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 !   DROP TABLE erp.trn_role_screens;
       erp         heap    postgres    false    360    6            p           0    0 "   COLUMN trn_role_screens.rec_status    COMMENT     L   COMMENT ON COLUMN erp.trn_role_screens.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    426            ?           1259    213864    trn_screen_uiactions    TABLE     r  CREATE TABLE erp.trn_screen_uiactions (
    trans_id numeric(5,0) DEFAULT nextval('erp.seq_screen_uiactions'::regclass) NOT NULL,
    screen_id numeric(3,0) NOT NULL,
    uiaction_id numeric(3,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
 %   DROP TABLE erp.trn_screen_uiactions;
       erp         heap    postgres    false    361    6            q           0    0 &   COLUMN trn_screen_uiactions.rec_status    COMMENT     P   COMMENT ON COLUMN erp.trn_screen_uiactions.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    427            ?           1259    213871    trn_so    TABLE     ?  CREATE TABLE erp.trn_so (
    so_id numeric(11,0) DEFAULT nextval('erp.seq_so'::regclass) NOT NULL,
    cust_id numeric(11,0) NOT NULL,
    fy_id numeric(2,0) NOT NULL,
    so_date date NOT NULL,
    so_code character varying(20) DEFAULT NULL::character varying,
    so_finalized numeric(1,0) DEFAULT 0,
    note character varying(500),
    so_finalized_date date,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    so_no numeric NOT NULL,
    con_id numeric(8,0),
    sap_so_code character varying(20),
    sap_so_id numeric(8,0),
    plant_id numeric(7,0),
    term_of_payment character varying(100),
    term_of_delivery character varying(100),
    site_id numeric(7,0),
    ref_po_no character varying(20),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    file_path text,
    import_trans_id numeric(11,0) DEFAULT 0
);
    DROP TABLE erp.trn_so;
       erp         heap    postgres    false    362    6            r           0    0    COLUMN trn_so.con_id    COMMENT     <   COMMENT ON COLUMN erp.trn_so.con_id IS 'contact person id';
          erp          postgres    false    428            s           0    0    COLUMN trn_so.import_trans_id    COMMENT     [   COMMENT ON COLUMN erp.trn_so.import_trans_id IS 'Will store erp_import table primary key';
          erp          postgres    false    428            ?           1259    213885    trn_so_designmix    TABLE     ?  CREATE TABLE erp.trn_so_designmix (
    so_dmix_id numeric(11,0) DEFAULT nextval('erp.seq_so_designmix'::regclass) NOT NULL,
    soi_id numeric(12,0),
    so_id numeric(11,0) DEFAULT NULL::numeric,
    so_item_id numeric(10,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    dmix_item_name character varying(200) DEFAULT NULL::character varying,
    dmix_item_subid numeric(10,0) NOT NULL,
    qty numeric(11,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 !   DROP TABLE erp.trn_so_designmix;
       erp         heap    postgres    false    363    6            ?           1259    213895    trn_so_item    TABLE     ?  CREATE TABLE erp.trn_so_item (
    soi_id numeric(12,0) DEFAULT nextval('erp.seq_so_item'::regclass) NOT NULL,
    so_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    hc_id numeric(2,0),
    plant_id numeric(7,0),
    dmix_id numeric(11,0) DEFAULT 0,
    so_type numeric(1,0) DEFAULT 0,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_so_item;
       erp         heap    postgres    false    366    6            t           0    0    COLUMN trn_so_item.so_type    COMMENT     E   COMMENT ON COLUMN erp.trn_so_item.so_type IS '0:Item, 1:Production';
          erp          postgres    false    430            ?           1259    213915    trn_so_item_log    TABLE     ?  CREATE TABLE erp.trn_so_item_log (
    trans_id numeric(12,0) DEFAULT nextval('erp.seq_so_item_log'::regclass) NOT NULL,
    soi_id numeric(12,0) NOT NULL,
    so_id numeric(11,0) DEFAULT NULL::numeric,
    item_id numeric(10,0) NOT NULL,
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(13,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    item_desc character varying(1000) DEFAULT NULL::character varying,
    unit_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    cgst_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    sgst_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    igst_rate numeric(9,2) DEFAULT 0.00 NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
     DROP TABLE erp.trn_so_item_log;
       erp         heap    postgres    false    367    6            u           0    0 !   COLUMN trn_so_item_log.rec_status    COMMENT     K   COMMENT ON COLUMN erp.trn_so_item_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    431            v           0    0 "   COLUMN trn_so_item_log.action_type    COMMENT     U   COMMENT ON COLUMN erp.trn_so_item_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    431            ?           1259    213933 
   trn_so_log    TABLE     ?  CREATE TABLE erp.trn_so_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_so_log'::regclass) NOT NULL,
    so_id numeric(11,0) NOT NULL,
    cust_id numeric(11,0) NOT NULL,
    fy_id numeric(2,0) NOT NULL,
    so_date date NOT NULL,
    so_code character varying(20) DEFAULT NULL::character varying,
    so_finalized numeric(1,0) DEFAULT 0,
    note character varying(500),
    so_finalized_date date,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    so_no numeric NOT NULL,
    action_type numeric(1,0),
    con_id numeric(8,0),
    sap_so_code character varying(20),
    sap_so_id numeric(8,0),
    plant_id numeric(7,0),
    term_of_payment character varying(100),
    term_of_delivery character varying(100),
    site_id numeric(7,0),
    ref_po_no character varying(20),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_so_log;
       erp         heap    postgres    false    368    6            ?           1259    213946    trn_so_order_details    TABLE     ?  CREATE TABLE erp.trn_so_order_details (
    so_ord_detail_id numeric(11,0) DEFAULT nextval('erp.seq_so_order_details'::regclass) NOT NULL,
    so_id numeric(11,0) DEFAULT NULL::numeric,
    order_no character varying(20) DEFAULT NULL::character varying,
    order_date timestamp without time zone DEFAULT now() NOT NULL,
    order_name character varying(200) DEFAULT NULL::character varying,
    cust_id numeric(11,0) DEFAULT NULL::numeric,
    order_cust_name character varying(100) DEFAULT NULL::character varying,
    customer_code character varying(15) DEFAULT NULL::character varying,
    ordered_recipe character varying(15) DEFAULT NULL::character varying,
    ordered_for_site character varying(100) DEFAULT NULL::character varying,
    ordered_qty numeric(11,2) DEFAULT NULL::numeric,
    production_qty numeric(11,2) DEFAULT NULL::numeric,
    aggregate_used numeric(11,2) DEFAULT NULL::numeric,
    cement_used numeric(11,2) DEFAULT NULL::numeric,
    water_used numeric(11,2) DEFAULT NULL::numeric,
    admixture_used numeric(11,3) DEFAULT NULL::numeric,
    truck_no character varying(20) DEFAULT NULL::character varying,
    withthisload numeric(11,2) DEFAULT NULL::numeric,
    type_pump numeric(11,2) DEFAULT NULL::numeric,
    total_order numeric(11,2) DEFAULT NULL::numeric,
    total_with_this_load numeric(11,2) DEFAULT NULL::numeric,
    max_cem numeric(11,2) DEFAULT NULL::numeric,
    wcratio numeric(11,2) DEFAULT NULL::numeric,
    sap_id numeric(7,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 %   DROP TABLE erp.trn_so_order_details;
       erp         heap    postgres    false    369    6            ?           1259    213979    trn_so_summary    TABLE     ?  CREATE TABLE erp.trn_so_summary (
    sos_id numeric(11,0) DEFAULT nextval('erp.seq_so_summary'::regclass) NOT NULL,
    so_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    plant_id numeric(5,0),
    hc_id numeric(5,0),
    insertion_type character(1) DEFAULT 'M'::bpchar
);
    DROP TABLE erp.trn_so_summary;
       erp         heap    postgres    false    370    6            w           0    0     COLUMN trn_so_summary.rec_status    COMMENT     J   COMMENT ON COLUMN erp.trn_so_summary.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    434            ?           1259    213990    trn_so_summary_log    TABLE     ?  CREATE TABLE erp.trn_so_summary_log (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_so_summary_log'::regclass) NOT NULL,
    sos_id numeric(11,0) NOT NULL,
    so_id numeric(11,0) NOT NULL,
    net_tot_amt numeric(17,2) NOT NULL,
    disc_percent numeric(4,2) DEFAULT 0.00 NOT NULL,
    disc_amt numeric(16,2) DEFAULT 0.00 NOT NULL,
    grand_tot_amt numeric(17,2) NOT NULL,
    remarks character varying(200) DEFAULT NULL::character varying,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    action_type numeric(1,0),
    plant_id numeric(5,0),
    hc_id numeric(5,0)
);
 #   DROP TABLE erp.trn_so_summary_log;
       erp         heap    postgres    false    371    6            x           0    0 $   COLUMN trn_so_summary_log.rec_status    COMMENT     N   COMMENT ON COLUMN erp.trn_so_summary_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    435            y           0    0 %   COLUMN trn_so_summary_log.action_type    COMMENT     X   COMMENT ON COLUMN erp.trn_so_summary_log.action_type IS '1:Insert, 2:Update, 3:Delete';
          erp          postgres    false    435            ?           1259    214000 	   trn_stock    TABLE     ?  CREATE TABLE erp.trn_stock (
    stock_id numeric(11,0) DEFAULT nextval('erp.seq_trn_stock'::regclass) NOT NULL,
    item_id numeric(10,0),
    inward_quantity numeric(9,0) DEFAULT 0,
    outward_quantity numeric(9,0) DEFAULT 0,
    balance_quantity numeric(9,0) DEFAULT 0,
    note character varying(100),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.trn_stock;
       erp         heap    postgres    false    376    6            z           0    0    TABLE trn_stock    COMMENT     Y   COMMENT ON TABLE erp.trn_stock IS 'Table used for maintain stock of item(Raw material)';
          erp          postgres    false    436            {           0    0     COLUMN trn_stock.inward_quantity    COMMENT     S   COMMENT ON COLUMN erp.trn_stock.inward_quantity IS '--total purchase qty of item';
          erp          postgres    false    436            |           0    0 !   COLUMN trn_stock.outward_quantity    COMMENT     P   COMMENT ON COLUMN erp.trn_stock.outward_quantity IS '--total sale qty of item';
          erp          postgres    false    436            }           0    0 !   COLUMN trn_stock.balance_quantity    COMMENT     W   COMMENT ON COLUMN erp.trn_stock.balance_quantity IS '--total amount of item in stock';
          erp          postgres    false    436            ?           1259    214010    trn_stock_log    TABLE     ?  CREATE TABLE erp.trn_stock_log (
    stock_id numeric(11,0),
    item_id numeric(10,0),
    inward_quantity numeric(9,0),
    outward_quantity numeric(9,0),
    balance_quantity numeric(9,0),
    note character varying(100),
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.trn_stock_log;
       erp         heap    postgres    false    6            ?           1259    214016    trn_summary_dashboard_record    TABLE     F  CREATE TABLE erp.trn_summary_dashboard_record (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_summary_dashboard_record'::regclass) NOT NULL,
    fy_id numeric(2,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(2,0) NOT NULL,
    vendor_site_id numeric(11,0) NOT NULL,
    vendor_site_type integer DEFAULT 0,
    item_id numeric(11,0),
    item_qty numeric(10,0) NOT NULL,
    item_amt numeric(12,2) NOT NULL,
    so_po_qty numeric(10,0) NOT NULL,
    so_po_amt numeric(12,2) NOT NULL,
    description character varying(500),
    last_modify_date timestamp without time zone DEFAULT now() NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 -   DROP TABLE erp.trn_summary_dashboard_record;
       erp         heap    postgres    false    372    6            ~           0    0 2   COLUMN trn_summary_dashboard_record.vendor_site_id    COMMENT     ?   COMMENT ON COLUMN erp.trn_summary_dashboard_record.vendor_site_id IS 'mst_site = site id; mst_customer_vendor = cust_id vendor ';
          erp          postgres    false    438                       0    0 4   COLUMN trn_summary_dashboard_record.vendor_site_type    COMMENT     r   COMMENT ON COLUMN erp.trn_summary_dashboard_record.vendor_site_type IS 'mst_site = 0 , mst_customer_vendor = 1 ';
          erp          postgres    false    438            ?           0    0 ,   COLUMN trn_summary_dashboard_record.item_qty    COMMENT     q   COMMENT ON COLUMN erp.trn_summary_dashboard_record.item_qty IS 'create/enter new entry in respect to SO and PO';
          erp          postgres    false    438            ?           0    0 -   COLUMN trn_summary_dashboard_record.so_po_qty    COMMENT     ?   COMMENT ON COLUMN erp.trn_summary_dashboard_record.so_po_qty IS '1] If direct PO / SO then SO / PO qty update Zero [0]. 2] PO / SO qty ';
          erp          postgres    false    438            ?           1259    214029    trn_summary_stock_level    TABLE     J  CREATE TABLE erp.trn_summary_stock_level (
    trans_id numeric(11,0) DEFAULT nextval('erp.seq_summary_stock_level'::regclass) NOT NULL,
    fy_id numeric(2,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(2,0) NOT NULL,
    dc_id numeric(11,0) NOT NULL,
    grn_id numeric(11,0) NOT NULL,
    item_id numeric(11,0),
    inward_item_qty numeric(10,0) NOT NULL,
    inward_item_amt numeric(12,2) NOT NULL,
    outward_item_qty numeric(10,0) NOT NULL,
    outward_item_amt numeric(12,2) NOT NULL,
    description character varying(500),
    last_modify_date timestamp without time zone DEFAULT now() NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 (   DROP TABLE erp.trn_summary_stock_level;
       erp         heap    postgres    false    373    6            ?           1259    214041    trn_user_roles    TABLE     `  CREATE TABLE erp.trn_user_roles (
    trans_id numeric(5,0) DEFAULT nextval('erp.seq_user_roles'::regclass) NOT NULL,
    user_id numeric(5,0) NOT NULL,
    role_id numeric(3,0) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(11,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE erp.trn_user_roles;
       erp         heap    postgres    false    377    6            ?           0    0     COLUMN trn_user_roles.rec_status    COMMENT     J   COMMENT ON COLUMN erp.trn_user_roles.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    440            ?            1259    211710    trn_weiging_bridge_log    TABLE     t  CREATE TABLE erp.trn_weiging_bridge_log (
    trans_id numeric(20,0) DEFAULT nextval('erp.seq_trn_weiging_bridge_log'::regclass) NOT NULL,
    weg_bridge_id numeric(11,0) DEFAULT 0 NOT NULL,
    hc_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(11,0) NOT NULL,
    po_so_id numeric(11,0) NOT NULL,
    po_so_type integer NOT NULL,
    in_date date,
    in_time time without time zone,
    out_date date,
    out_time time without time zone,
    log_type numeric(1,0) NOT NULL,
    in_weight numeric(9,3),
    out_weight numeric(9,3),
    gross_weight numeric(9,3),
    tear_weight numeric(9,3),
    net_weight numeric(9,3),
    material_type_id character varying(255),
    material_type_name character varying(255) DEFAULT NULL::character varying,
    veh_id numeric(11,0) NOT NULL,
    veh_name character varying(255) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    po_iw_so_ow_id numeric(10,0),
    insertion_type character(1) DEFAULT 'M'::bpchar,
    is_grn_dc_invoice_done numeric(1,0) DEFAULT 0
);
 '   DROP TABLE erp.trn_weiging_bridge_log;
       erp         heap    postgres    false    206    6            ?           0    0 (   COLUMN trn_weiging_bridge_log.po_so_type    COMMENT     ?   COMMENT ON COLUMN erp.trn_weiging_bridge_log.po_so_type IS '0:po id - trn_po , 1:so id - trn_so     [OR]

0:po_iw_id - trn_plant_office_inward , 1:po_ow_id - trn_plant_office_outward

later decide';
          erp          postgres    false    207            ?           0    0 (   COLUMN trn_weiging_bridge_log.rec_status    COMMENT     R   COMMENT ON COLUMN erp.trn_weiging_bridge_log.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    207            ?           1259    214048 "   trn_weiging_bridge_log_wthout_poso    TABLE     ?  CREATE TABLE erp.trn_weiging_bridge_log_wthout_poso (
    trans_id numeric(20,0) DEFAULT nextval('erp.seq_weiging_bridge_log_wthout_poso'::regclass) NOT NULL,
    weg_bridge_id numeric(11,0) DEFAULT 0 NOT NULL,
    hc_id numeric(5,0) DEFAULT 0 NOT NULL,
    plant_id numeric(11,0) NOT NULL,
    in_date date,
    in_time time without time zone,
    out_date date,
    out_time time without time zone,
    log_type numeric(1,0) NOT NULL,
    in_weight numeric(9,3),
    out_weight numeric(9,3),
    gross_weight numeric(9,3),
    tear_weight numeric(9,3),
    net_weight numeric(9,3),
    material_type_id character varying(255),
    material_type_name character varying(255) DEFAULT NULL::character varying,
    veh_id numeric(11,0) NOT NULL,
    veh_name character varying(255) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL,
    insertion_type character(1) DEFAULT 'M'::bpchar
);
 3   DROP TABLE erp.trn_weiging_bridge_log_wthout_poso;
       erp         heap    postgres    false    378    6            ?           0    0 4   COLUMN trn_weiging_bridge_log_wthout_poso.rec_status    COMMENT     ^   COMMENT ON COLUMN erp.trn_weiging_bridge_log_wthout_poso.rec_status IS '1:Active, 9:Deleted';
          erp          postgres    false    441            ?           1259    214077    vw_bpa_details    VIEW     ?  CREATE VIEW erp.vw_bpa_details AS
 SELECT bpa.bpa_id,
    bpa.bpa_no,
    bpa.bpa_code,
    bpa.note,
    bpa.vendor_id,
    ( SELECT to_char((bpa.bpa_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS bpa_date,
    ( SELECT mst_vendor.vendor_name
           FROM erp.mst_vendor
          WHERE (mst_vendor.vendor_id = bpa.vendor_id)) AS vendor_name
   FROM erp.trn_bpa_info bpa
  WHERE (bpa.rec_status = (1)::numeric);
    DROP VIEW erp.vw_bpa_details;
       erp          postgres    false    384    384    384    296    296    384    384    384    384    6            ?           1259    214082 
   vw_bpa_grn    VIEW       CREATE VIEW erp.vw_bpa_grn AS
 SELECT grn.grn_id,
    grn.grn_no,
    grn.item_qty,
    grn.item_amt,
    grn.quality_percentage,
    grn.net_tot_amt,
    grn.note,
    grn.vendor_id,
    ( SELECT to_char((grn.grn_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS grn_date,
    ( SELECT mst_vendor.vendor_name
           FROM erp.mst_vendor
          WHERE (mst_vendor.vendor_id = grn.vendor_id)) AS vendor_name
   FROM erp.trn_grn_info grn
  WHERE ((grn.rec_status = (1)::numeric) AND (grn.is_usedin_bpa = 0));
    DROP VIEW erp.vw_bpa_grn;
       erp          postgres    false    398    296    398    398    398    398    398    398    398    398    296    398    398    6            ?           1259    214087    vw_customer_contacts    VIEW     ?  CREATE VIEW erp.vw_customer_contacts AS
 SELECT mst_cust_vendor_contact.con_id,
    mst_cust_vendor_contact.con_designation,
    mst_cust_vendor_contact.con_name,
    mst_cust_vendor_contact.cust_vendor_id AS cust_id,
    mst_cust_vendor_contact.email_id1,
    mst_cust_vendor_contact.hc_id,
    mst_cust_vendor_contact.mob_no1,
    mst_cust_vendor_contact.rec_status,
    mst_cust_vendor_contact.wa_no1
   FROM erp.mst_cust_vendor_contact
  WHERE (mst_cust_vendor_contact.rec_status = (1)::numeric);
 $   DROP VIEW erp.vw_customer_contacts;
       erp          postgres    false    215    215    215    215    215    215    215    215    215    6            ?           1259    214091    vw_customer_details    VIEW     ?  CREATE VIEW erp.vw_customer_details AS
 SELECT mst_customer_vendor.cust_vendor_id AS cust_id,
    mst_customer_vendor.cust_vendor_code AS cust_code,
    mst_customer_vendor.cust_vendor_name AS cust_name,
    mst_customer_vendor.cust_vendor_firm_name AS cust_firm_name,
    mst_customer_vendor.cust_vendor_addr AS cust_addr,
    mst_customer_vendor.email_id1
   FROM erp.mst_customer_vendor
  WHERE (mst_customer_vendor.rec_status = (1)::numeric);
 #   DROP VIEW erp.vw_customer_details;
       erp          postgres    false    222    222    222    222    222    222    222    6            ?           1259    214095    vw_customer_vendor    VIEW     x  CREATE VIEW erp.vw_customer_vendor AS
 SELECT mst_customer_vendor.cust_vendor_id AS cust_id,
    mst_customer_vendor.bank_acc_no,
    mst_customer_vendor.bank_name,
    mst_customer_vendor.credit_limit,
    mst_customer_vendor.cust_vendor_addr AS cust_addr,
    mst_customer_vendor.cust_vendor_city AS cust_city,
    mst_customer_vendor.cust_vendor_code AS cust_code,
    mst_customer_vendor.cust_vendor_firm_addr AS cust_firm_addr,
    mst_customer_vendor.cust_vendor_firm_name AS cust_firm_name,
    mst_customer_vendor.cust_vendor_lat AS cust_lat,
    mst_customer_vendor.cust_vendor_long AS cust_long,
    mst_customer_vendor.cust_vendor_name AS cust_name,
    mst_customer_vendor.cust_vendor_state_id AS cust_state_id,
    mst_customer_vendor.cust_vendor_url AS cust_url,
    mst_customer_vendor.email_id1,
    mst_customer_vendor.email_id2,
    mst_customer_vendor.fb_handle,
    mst_customer_vendor.gst_no,
    mst_customer_vendor.hc_id,
    mst_customer_vendor.ifsc_code,
    mst_customer_vendor.ll_no1,
    mst_customer_vendor.ll_no2,
    mst_customer_vendor.mob_no1,
    mst_customer_vendor.mob_no2,
    mst_customer_vendor.pan_no,
    mst_customer_vendor.pin_code,
    mst_customer_vendor.rec_status,
    mst_customer_vendor.twr_handle,
    mst_customer_vendor.wa_no1,
    mst_customer_vendor.wa_no2
   FROM erp.mst_customer_vendor
  WHERE (mst_customer_vendor.rec_status = (1)::numeric);
 "   DROP VIEW erp.vw_customer_vendor;
       erp          postgres    false    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    222    6            ?           1259    214100    vw_dc_details    VIEW       CREATE VIEW erp.vw_dc_details AS
 SELECT dc.dc_id,
    to_char((dc.dc_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS dc_date,
    dc.dc_code,
    dc.cust_id,
    dc.batch_id,
    dc.so_id,
    ( SELECT so_1.so_code
           FROM erp.trn_so so_1
          WHERE ((so_1.so_id = dc.so_id) AND (so_1.rec_status = (1)::numeric))) AS so_code,
    ( SELECT mst_site.site_name
           FROM erp.mst_site
          WHERE ((mst_site.site_id = so.site_id) AND (mst_site.rec_status = (1)::numeric))) AS site_name
   FROM (erp.trn_dc_info dc
     LEFT JOIN erp.trn_so so ON ((so.so_id = dc.so_id)))
  WHERE (dc.rec_status = (1)::numeric);
    DROP VIEW erp.vw_dc_details;
       erp          postgres    false    428    428    428    428    389    389    389    389    389    389    389    270    270    270    6            ?           1259    214105 
   vw_dc_info    VIEW     ?  CREATE VIEW erp.vw_dc_info AS
 SELECT dc.dc_id,
    dc.dc_no,
    to_char((dc.dc_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS dc_date,
    dc.dc_code,
    dc.fy_id,
    dc.cust_id,
    dc.so_id,
    dc.note,
    dc.hc_id,
    dc.rec_status,
    dc.weg_bridge_id,
    dc.batch_id,
    dc.term_delivery,
    dc.term_payment,
    COALESCE(summr.net_tot_amt, 0.00) AS net_tot_amt,
    COALESCE(summr.disc_percent, (0)::numeric) AS disc_percent,
    COALESCE(summr.disc_amt, 0.00) AS disc_amt,
    COALESCE(summr.grand_tot_amt, 0.00) AS grand_tot_amt,
    COALESCE(summr.dcs_id, 0.00) AS dcs_id
   FROM (erp.trn_dc_info dc
     LEFT JOIN erp.trn_dc_summary summr ON ((dc.dc_id = summr.dc_id)))
  WHERE (dc.rec_status = (1)::numeric);
    DROP VIEW erp.vw_dc_info;
       erp          postgres    false    393    393    393    393    389    389    389    389    389    389    389    389    389    389    389    389    389    389    393    393    6            ?           1259    214110 
   vw_dc_item    VIEW     t  CREATE VIEW erp.vw_dc_item AS
 SELECT dc.dci_id,
    dc.dc_id,
    dc.item_id,
    dc.item_qty,
    dc.item_amt,
    dc.disc_percent,
    dc.rec_status,
    dc.item_desc,
    dc.unit_rate,
    dc.cgst_rate,
    dc.sgst_rate,
    dc.igst_rate,
    dc.hc_id,
    dc.plant_id,
    dc.dmix_id,
    dc.dc_type
   FROM erp.trn_dc_item dc
  WHERE (dc.rec_status = (1)::numeric);
    DROP VIEW erp.vw_dc_item;
       erp          postgres    false    391    391    391    391    391    391    391    391    391    391    391    391    391    391    391    391    6            ?           1259    214114    vw_design_mix    VIEW     ?   CREATE VIEW erp.vw_design_mix AS
 SELECT mix.dmix_id,
    mix.design_mix_code,
    mix.design_mix_name,
    mix.item_id,
    mix.is_close,
    mix.hc_id,
    mix.plant_id
   FROM erp.trn_designmix mix
  WHERE (mix.rec_status = (1)::numeric);
    DROP VIEW erp.vw_design_mix;
       erp          postgres    false    395    395    395    395    395    395    395    395    6            ?           1259    214118    vw_designation    VIEW       CREATE VIEW erp.vw_designation AS
 SELECT pre.presetdata_key,
    pre.presetdata_value
   FROM erp.mst_presetdata pre
  WHERE (((pre.dbtable_name)::text = 'mst_contractor'::text) AND ((pre.dbcolumn_name)::text = 'designation'::text) AND (pre.rec_status = (1)::numeric));
    DROP VIEW erp.vw_designation;
       erp          postgres    false    262    262    262    262    262    6            ?           1259    214122    vw_designmix_details    VIEW     2  CREATE VIEW erp.vw_designmix_details AS
 SELECT mix.dmix_id,
    mix.design_mix_name,
    ( SELECT mst_plant.plant_name
           FROM erp.mst_plant
          WHERE (mst_plant.plant_id = mix.plant_id)) AS plant_name,
        CASE
            WHEN (mix.is_close = 1) THEN 'Closed'::text
            ELSE 'Open'::text
        END AS is_close,
    mix.hc_id
   FROM erp.trn_designmix mix
  WHERE (mix.rec_status = (1)::numeric)
  ORDER BY mix.dmix_id,
        CASE
            WHEN (mix.is_close = 1) THEN 'Closed'::text
            ELSE 'Open'::text
        END;
 $   DROP VIEW erp.vw_designmix_details;
       erp          postgres    false    395    395    395    395    259    259    395    395    6            ?           1259    214127    vw_employee    VIEW     ?   CREATE VIEW erp.vw_employee AS
 SELECT emp.emp_id,
    emp.hc_id,
    emp.emp_name
   FROM erp.mst_employee emp
  WHERE (emp.rec_status = (1)::numeric);
    DROP VIEW erp.vw_employee;
       erp          postgres    false    229    229    229    229    6            ?           1259    214131    vw_employee_contacts    VIEW     Z  CREATE VIEW erp.vw_employee_contacts AS
 SELECT mst_employee_contact.con_id,
    mst_employee_contact.emp_address1,
    mst_employee_contact.emp_mobno1,
    mst_employee_contact.email1,
    mst_employee_contact.rec_status,
    mst_employee_contact.emp_id
   FROM erp.mst_employee_contact
  WHERE (mst_employee_contact.rec_status = (1)::numeric);
 $   DROP VIEW erp.vw_employee_contacts;
       erp          postgres    false    230    230    230    230    230    230    6            ?           1259    214135    vw_employee_details    VIEW       CREATE VIEW erp.vw_employee_details AS
 SELECT mstempl_info.emp_id,
    mstempl_info.emp_fname,
    mstempl_info.emp_lname,
    mstempl_info.age,
    mstempl_info.designation,
    mstempl_info.salary
   FROM erp.mstempl_info
  WHERE (mstempl_info.rec_status = (1)::numeric);
 #   DROP VIEW erp.vw_employee_details;
       erp          postgres    false    301    301    301    301    301    301    301    6            ?           1259    214139    vw_grn    VIEW     ?  CREATE VIEW erp.vw_grn AS
 SELECT grn.grn_id,
    grn.grn_no,
    grn.grn_code,
    grn.vendor_id,
    grn.po_id,
    ( SELECT trn_plant_office_inward.poi_no
           FROM erp.trn_plant_office_inward
          WHERE (trn_plant_office_inward.po_iw_id = grn.po_iw_id)) AS poi_no,
    ( SELECT to_char((grn.grn_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS grn_date,
    ( SELECT mst_vendor.vendor_name
           FROM erp.mst_vendor
          WHERE (mst_vendor.vendor_id = grn.vendor_id)) AS vendor_name,
    ( SELECT mst_plant.plant_name
           FROM erp.mst_plant
          WHERE (mst_plant.plant_id = grn.plant_id)) AS plant_name
   FROM erp.trn_grn_info grn
  WHERE ((grn.rec_status = (1)::numeric) AND (grn.is_usedin_bpa = 0));
    DROP VIEW erp.vw_grn;
       erp          postgres    false    398    398    398    398    398    398    410    398    259    259    296    296    398    398    398    410    6            ?           1259    214144    vw_host_company    VIEW     ?   CREATE VIEW erp.vw_host_company AS
 SELECT host.hc_id,
    host.comp_name
   FROM erp.mst_host_company host
  WHERE (host.rec_status = (1)::numeric);
    DROP VIEW erp.vw_host_company;
       erp          postgres    false    238    238    238    6            ?           1259    214148    vw_integrator    VIEW     ?   CREATE VIEW erp.vw_integrator AS
 SELECT intg.int_id,
    intg.int_name
   FROM erp.mst_integrator intg
  WHERE (intg.rec_status = (1)::numeric);
    DROP VIEW erp.vw_integrator;
       erp          postgres    false    241    241    241    6            ?           1259    214152    vw_invoice_details    VIEW       CREATE VIEW erp.vw_invoice_details AS
 SELECT trn_invoice_info.invoice_id,
    trn_invoice_info.cust_id,
    trn_invoice_info.invoice_code,
    to_char((trn_invoice_info.invoice_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS invoice_date,
    trn_invoice_info.batch_id,
    ( SELECT so.so_code
           FROM erp.trn_so so
          WHERE ((so.so_id = trn_invoice_info.so_id) AND (so.rec_status = (1)::numeric))) AS so_code,
    ( SELECT site.site_name
           FROM erp.mst_site site
          WHERE (site.site_id = ( SELECT so.site_id
                   FROM erp.trn_so so
                  WHERE ((so.so_id = trn_invoice_info.so_id) AND (so.rec_status = (1)::numeric))))) AS site_name
   FROM erp.trn_invoice_info
  WHERE (trn_invoice_info.rec_status = (1)::numeric);
 "   DROP VIEW erp.vw_invoice_details;
       erp          postgres    false    402    270    270    402    402    402    402    402    402    428    428    428    428    6            ?           1259    214157    vw_invoice_info    VIEW     F  CREATE VIEW erp.vw_invoice_info AS
 SELECT inv.invoice_id,
    inv.invoice_no,
    to_char((inv.invoice_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS invoice_date,
    inv.invoice_code,
    inv.fy_id,
    inv.cust_id,
    inv.so_id,
    inv.note,
    inv.hc_id,
    inv.rec_status,
    inv.weg_bridge_id,
    inv.dc_id,
    inv.batch_id,
    inv.term_delivery,
    inv.term_payment,
    COALESCE(summr.net_tot_amt, 0.00) AS net_tot_amt,
    COALESCE(summr.disc_percent, (0)::numeric) AS disc_percent,
    COALESCE(summr.disc_amt, 0.00) AS disc_amt,
    COALESCE(summr.grand_tot_amt, 0.00) AS grand_tot_amt,
    COALESCE(summr.invoice_sum_id, 0.00) AS invoice_sum_id
   FROM (erp.trn_invoice_info inv
     LEFT JOIN erp.trn_invoice_summary summr ON ((inv.invoice_id = summr.invoice_id)))
  WHERE (inv.rec_status = (1)::numeric);
    DROP VIEW erp.vw_invoice_info;
       erp          postgres    false    406    402    402    402    402    402    402    402    406    402    406    406    406    406    402    402    402    402    402    402    402    6            ?           1259    214162    vw_invoice_items    VIEW     ?  CREATE VIEW erp.vw_invoice_items AS
 SELECT item.inv_item_id,
    item.invoice_id,
    item.item_id,
    item.item_qty,
    item.item_amt,
    item.disc_percent,
    item.rec_status,
    item.item_desc,
    item.unit_rate,
    item.cgst_rate,
    item.sgst_rate,
    item.igst_rate,
    item.hc_id,
    item.plant_id,
    item.dmix_id,
    item.invoice_type
   FROM erp.trn_invoice_item item
  WHERE (item.rec_status = (1)::numeric);
     DROP VIEW erp.vw_invoice_items;
       erp          postgres    false    404    404    404    404    404    404    404    404    404    404    404    404    404    404    404    404    6            ?           1259    214166    vw_item_category    VIEW     ?   CREATE VIEW erp.vw_item_category AS
 SELECT cat.ic_id,
    cat.cat_name,
    COALESCE(cat.cat_desc, ''::character varying) AS cat_desc
   FROM erp.mst_item_category cat
  WHERE (cat.rec_status = (1)::numeric);
     DROP VIEW erp.vw_item_category;
       erp          postgres    false    248    248    248    248    6            ?           1259    214170    vw_item_details    VIEW     S  CREATE VIEW erp.vw_item_details AS
 SELECT item.item_id,
    item.item_name,
    ( SELECT mst_item_category.cat_name
           FROM erp.mst_item_category
          WHERE ((mst_item_category.ic_id = item.ic_id) AND (mst_item_category.rec_status = (1)::numeric))) AS category_name,
    COALESCE(item.make, ''::character varying) AS make,
        CASE
            WHEN (item.item_type = (0)::numeric) THEN 'Raw Material'::text
            ELSE 'Finish Goods'::text
        END AS item_type,
    item.unit_rate,
    item.hsn_code
   FROM erp.mst_item item
  WHERE (item.rec_status = (1)::numeric);
    DROP VIEW erp.vw_item_details;
       erp          postgres    false    246    248    248    248    246    246    246    246    246    246    246    6            ?           1259    214175    vw_mst_finyear    VIEW     ?   CREATE VIEW erp.vw_mst_finyear AS
 SELECT yr.fy_id,
    yr.fy_from,
    yr.fy_to,
    yr.fy_name
   FROM erp.mst_finyear yr
  WHERE (yr.rec_status = (1)::numeric);
    DROP VIEW erp.vw_mst_finyear;
       erp          postgres    false    233    233    233    233    233    6            ?           1259    214179    vw_name_setup    VIEW     P  CREATE VIEW erp.vw_name_setup AS
 SELECT pre.presetdata_id,
    pre.presetdata_key,
    pre.presetdata_value,
    pre.dbtable_name,
    pre.dbcolumn_name
   FROM erp.mst_presetdata pre
  WHERE (((pre.dbtable_name)::text = 'mst_name_setup'::text) AND ((pre.dbcolumn_name)::text = 'item_type'::text) AND (pre.rec_status = (1)::numeric));
    DROP VIEW erp.vw_name_setup;
       erp          postgres    false    262    262    262    262    262    262    6            ?           1259    214183    vw_plant    VIEW     ?   CREATE VIEW erp.vw_plant AS
 SELECT pl.plant_id,
    pl.plant_name,
    pl.hc_id
   FROM erp.mst_plant pl
  WHERE (pl.rec_status = (1)::numeric);
    DROP VIEW erp.vw_plant;
       erp          postgres    false    259    259    259    259    6            ?           1259    214187    vw_plant_inward_details    VIEW     ?  CREATE VIEW erp.vw_plant_inward_details AS
 SELECT poi.po_iw_id,
    poi.vendor_id,
    poi.poi_no,
    poi.poi_code,
    ( SELECT to_char((poi.inward_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS inward_date,
    ( SELECT trn_po.po_no
           FROM erp.trn_po
          WHERE (trn_po.po_id = poi.po_id)) AS po_no,
    poi.veh_no,
    ( SELECT mst_vendor.vendor_name
           FROM erp.mst_vendor
          WHERE (mst_vendor.vendor_id = poi.vendor_id)) AS vendor_name,
    ( SELECT mst_item.item_name
           FROM erp.mst_item
          WHERE (mst_item.item_id = poi.item_id)) AS item_name
   FROM erp.trn_plant_office_inward poi
  WHERE (poi.rec_status = (1)::numeric);
 '   DROP VIEW erp.vw_plant_inward_details;
       erp          postgres    false    414    410    410    410    410    410    410    410    410    296    246    414    410    296    246    6            ?           1259    214192    vw_plant_office_inward    VIEW     ?  CREATE VIEW erp.vw_plant_office_inward AS
 SELECT pow.po_iw_id,
    pow.vendor_id,
    pow.po_id,
    pow.veh_no,
    pow.item_id,
    pow.poi_no,
    pow.poi_code,
    pow.ref_invoice_no,
    pow.ref_challan_no,
    pow.note,
    ( SELECT to_char((pow.inward_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS inward_date,
    ( SELECT to_char((pow.ref_invoice_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS ref_invoice_date,
    ( SELECT to_char((pow.ref_challan_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS ref_challan_date,
    pow.isqc_apply,
    pow.isqc_accept_reject
   FROM erp.trn_plant_office_inward pow
  WHERE (pow.rec_status = (1)::numeric);
 &   DROP VIEW erp.vw_plant_office_inward;
       erp          postgres    false    410    410    410    410    410    410    410    410    410    410    410    410    410    410    410    410    6            ?           1259    214197    vw_po_details    VIEW     ?  CREATE VIEW erp.vw_po_details AS
 SELECT po.po_id,
    po.po_no,
    po.vendor_id,
    ( SELECT to_char((po.po_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS po_date,
    ( SELECT mst_vendor.vendor_name
           FROM erp.mst_vendor
          WHERE (mst_vendor.vendor_id = po.vendor_id)) AS vendor_name,
    ( SELECT mst_plant.plant_name
           FROM erp.mst_plant
          WHERE (mst_plant.plant_id = po.plant_id)) AS branch_name,
    ( SELECT mst_cust_vendor_contact.con_name
           FROM erp.mst_cust_vendor_contact
          WHERE (mst_cust_vendor_contact.con_id = po.con_id)) AS contact_person
   FROM erp.trn_po po
  WHERE (po.rec_status = (1)::numeric);
    DROP VIEW erp.vw_po_details;
       erp          postgres    false    215    215    259    259    296    296    414    414    414    414    414    414    414    6            ?           1259    214202    vw_po_finalized    VIEW     	  CREATE VIEW erp.vw_po_finalized AS
 SELECT pre.presetdata_key,
    pre.presetdata_value
   FROM erp.mst_presetdata pre
  WHERE (((pre.dbtable_name)::text = 'trn_po'::text) AND ((pre.dbcolumn_name)::text = 'po_finalized'::text) AND (pre.rec_status = (1)::numeric));
    DROP VIEW erp.vw_po_finalized;
       erp          postgres    false    262    262    262    262    262    6            ?           1259    214206    vw_po_item_detail    VIEW     ?  CREATE VIEW erp.vw_po_item_detail AS
 SELECT po.poi_id,
    po.po_id,
    po.item_id,
    ( SELECT mst_item.item_name
           FROM erp.mst_item
          WHERE ((mst_item.item_id = po.item_id) AND (mst_item.rec_status = (1)::numeric))) AS item_name
   FROM erp.trn_po_item po
  WHERE (po.rec_status = (1)::numeric);
 !   DROP VIEW erp.vw_po_item_detail;
       erp          postgres    false    415    415    415    246    246    246    415    6            ?           1259    214210 
   vw_pow_grn    VIEW     s  CREATE VIEW erp.vw_pow_grn AS
 SELECT po.po_iw_id,
    po.vendor_id,
    po.plant_id,
    po.po_id,
    po.veh_no,
    po.item_id,
    po.ref_invoice_no,
    po.ref_challan_no,
    po.note,
    ( SELECT to_char((po.inward_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS inward_date,
    ( SELECT to_char((po.ref_invoice_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS ref_invoice_date,
    ( SELECT to_char((po.ref_challan_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS ref_challan_date
   FROM erp.trn_plant_office_inward po
  WHERE (po.rec_status = (1)::numeric);
    DROP VIEW erp.vw_pow_grn;
       erp          postgres    false    410    410    410    410    410    410    410    410    410    410    410    410    410    6            ?           1259    214215    vw_preset_data    VIEW       CREATE VIEW erp.vw_preset_data AS
 SELECT DISTINCT min(ps.presetdata_id) AS presetdata_id,
    ps.dbtable_name,
    ps.dbcolumn_name
   FROM erp.mst_presetdata ps
  WHERE (ps.rec_status = (1)::numeric)
  GROUP BY ps.dbtable_name, ps.dbcolumn_name
  ORDER BY (min(ps.presetdata_id));
    DROP VIEW erp.vw_preset_data;
       erp          postgres    false    262    262    262    262    6            ?           1259    214219    vw_role    VIEW     ?   CREATE VIEW erp.vw_role AS
 SELECT rol.role_id,
    rol.role_name,
    rol.role_desc
   FROM erp.mst_role rol
  WHERE (rol.rec_status = (1)::numeric);
    DROP VIEW erp.vw_role;
       erp          postgres    false    265    265    265    265    6            ?           1259    214223    vw_role_screens    VIEW     ?   CREATE VIEW erp.vw_role_screens AS
 SELECT rolsc.trans_id,
    rolsc.role_id,
    rolsc.screen_uiaction_id,
    rolsc.screen_index,
    rolsc.rec_status
   FROM erp.trn_role_screens rolsc;
    DROP VIEW erp.vw_role_screens;
       erp          postgres    false    426    426    426    426    426    6            ?           1259    214227 	   vw_screen    VIEW     ?  CREATE VIEW erp.vw_screen AS
 SELECT sc.screen_id,
    sc.screen_name,
    sc.screen_nav_path,
    sc.screen_desc,
    sc.parent_screen_id,
    COALESCE(( SELECT mst_screen.screen_name
           FROM erp.mst_screen
          WHERE (mst_screen.screen_id = sc.parent_screen_id)), ''::character varying) AS parent_screen_name
   FROM erp.mst_screen sc
  WHERE (sc.rec_status = (1)::numeric);
    DROP VIEW erp.vw_screen;
       erp          postgres    false    268    268    268    268    268    268    6            ?           1259    214231    vw_screen_uiactions    VIEW     `  CREATE VIEW erp.vw_screen_uiactions AS
 SELECT ui.trans_id,
    ui.screen_id,
    ui.uiaction_id,
    ( SELECT mst_uiaction.uiaction_name
           FROM erp.mst_uiaction
          WHERE ((mst_uiaction.rec_status = (1)::numeric) AND (mst_uiaction.uiaction_id = ui.uiaction_id))) AS uiaction_name,
    ui.rec_status
   FROM erp.trn_screen_uiactions ui;
 #   DROP VIEW erp.vw_screen_uiactions;
       erp          postgres    false    427    427    427    427    282    282    282    6            ?           1259    214235    vw_site_contact    VIEW       CREATE VIEW erp.vw_site_contact AS
 SELECT sc.site_con_id,
    sc.cust_id,
    sc.site_id,
    sc.site_con_name,
    sc.site_con_designation,
    sc.mob_no1,
    sc.wa_no1,
    sc.email_id1,
    sc.hc_id
   FROM erp.mst_site_contact sc
  WHERE (sc.rec_status = (1)::numeric);
    DROP VIEW erp.vw_site_contact;
       erp          postgres    false    272    272    272    272    272    272    272    272    272    272    6            ?           1259    214239    vw_sites    VIEW     ?  CREATE VIEW erp.vw_sites AS
 SELECT site.site_id,
    site.site_name,
    site.cust_id,
    ( SELECT mst_customer_vendor.cust_vendor_firm_name AS cust_firm_name
           FROM erp.mst_customer_vendor
          WHERE (mst_customer_vendor.cust_vendor_id = site.cust_id)) AS cust_name,
    site.site_distance,
    site.site_address
   FROM erp.mst_site site
  WHERE (site.rec_status = (1)::numeric);
    DROP VIEW erp.vw_sites;
       erp          postgres    false    222    270    270    270    270    270    270    222    6            ?           1259    214243    vw_so_details    VIEW     ?  CREATE VIEW erp.vw_so_details AS
 SELECT so.so_id,
    so.so_no,
    so.so_date,
    ( SELECT mst_site.site_name
           FROM erp.mst_site
          WHERE ((mst_site.site_id = so.site_id) AND (mst_site.rec_status = (1)::numeric))) AS site_name,
    ( SELECT mst_plant.plant_name
           FROM erp.mst_plant
          WHERE ((mst_plant.plant_id = so.plant_id) AND (mst_plant.rec_status = (1)::numeric))) AS branch_name,
    ( SELECT sitecon.site_con_name
           FROM erp.mst_site_contact sitecon
          WHERE ((sitecon.site_con_id = so.con_id) AND (sitecon.rec_status = (1)::numeric))) AS contact_person,
    so.cust_id,
    so.site_id
   FROM erp.trn_so so
  WHERE (so.rec_status = (1)::numeric);
    DROP VIEW erp.vw_so_details;
       erp          postgres    false    428    428    428    428    428    428    428    428    272    272    272    270    270    270    259    259    259    6            ?           1259    214248    vw_so_items    VIEW     ?  CREATE VIEW erp.vw_so_items AS
 SELECT so.soi_id,
    so.so_id,
    so.item_id,
    so.item_qty,
    so.item_amt,
    so.disc_percent,
    so.item_desc,
    so.unit_rate,
    so.cgst_rate,
    so.sgst_rate,
    so.igst_rate,
    so.plant_id,
    ( SELECT mst_item.item_name
           FROM erp.mst_item
          WHERE (mst_item.item_id = so.item_id)) AS item_name,
    so.dmix_id,
    so.so_type
   FROM erp.trn_so_item so
  WHERE (so.rec_status = (1)::numeric);
    DROP VIEW erp.vw_so_items;
       erp          postgres    false    246    246    430    430    430    430    430    430    430    430    430    430    430    430    430    430    430    6            ?           1259    214253 	   vw_states    VIEW     ?   CREATE VIEW erp.vw_states AS
 SELECT st.state_id,
    st.state_name
   FROM erp.mst_state st
  WHERE (st.rec_status = (1)::numeric);
    DROP VIEW erp.vw_states;
       erp          postgres    false    276    276    276    6            ?           1259    214257    vw_trn_bpa_dt    VIEW     ?  CREATE VIEW erp.vw_trn_bpa_dt AS
 SELECT bpa.bpa_dt_id,
    bpa.bpa_id,
    bpa.grn_id,
    ( SELECT trn_grn_info.grn_date
           FROM erp.trn_grn_info
          WHERE (trn_grn_info.grn_id = bpa.grn_id)) AS grn_date,
    ( SELECT trn_grn_info.grn_no
           FROM erp.trn_grn_info
          WHERE (trn_grn_info.grn_id = bpa.grn_id)) AS grn_no,
    bpa.item_qty,
    bpa.item_amt,
    bpa.quality_percentage,
    bpa.net_amt
   FROM erp.trn_bpa_details bpa
  WHERE (bpa.rec_status = (1)::numeric);
    DROP VIEW erp.vw_trn_bpa_dt;
       erp          postgres    false    382    382    382    382    382    382    382    398    398    398    382    6            ?           1259    214262    vw_trn_bpa_info    VIEW     ?  CREATE VIEW erp.vw_trn_bpa_info AS
 SELECT bpa.bpa_id,
    bpa.vendor_id,
    bpa.fy_id,
    ( SELECT to_char((bpa.bpa_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS bpa_date,
    bpa.bpa_code,
    bpa.bpa_no,
    bpa.grand_tot_amt,
    bpa.note,
    ( SELECT mst_vendor.vendor_name
           FROM erp.mst_vendor
          WHERE (mst_vendor.vendor_id = bpa.vendor_id)) AS vendor_name
   FROM erp.trn_bpa_info bpa
  WHERE (bpa.rec_status = (1)::numeric);
    DROP VIEW erp.vw_trn_bpa_info;
       erp          postgres    false    384    384    384    384    384    384    384    384    384    296    296    6            ?           1259    214267    vw_trn_card_allocation    VIEW     ?  CREATE VIEW erp.vw_trn_card_allocation AS
 SELECT cal.card_allocation_id,
    cal.card_id,
    cal.card_access_string,
    cal.allocated_to_id,
    cal.allocate_type,
    cal.allocate_time,
    cal.submit_time
   FROM erp.trn_card_allocation cal
  WHERE ((cal.rec_status = (1)::numeric) AND (cal.submit_time IS NULL));
 &   DROP VIEW erp.vw_trn_card_allocation;
       erp          postgres    false    387    387    387    387    387    387    387    387    6            ?           1259    214271 
   vw_trn_grn    VIEW        CREATE VIEW erp.vw_trn_grn AS
 SELECT grn.grn_id,
    grn.vendor_id,
    ( SELECT to_char((grn.grn_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS grn_date,
    ( SELECT to_char((grn.ref_invoice_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS ref_invoice_date,
    ( SELECT to_char((grn.ref_challan_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS ref_challan_date,
    grn.po_iw_id,
    grn.grn_no,
    grn.grn_code,
    grn.item_id,
    grn.item_desc,
    grn.item_qty,
    grn.item_amt,
    grn.net_tot_amt,
    grn.quality_percentage,
    grn.weg_bridge_id,
    grn.ref_invoice_no,
    grn.ref_challan_no,
    grn.note,
    grn.plant_id
   FROM erp.trn_grn_info grn
  WHERE ((grn.rec_status = (1)::numeric) AND (grn.is_usedin_bpa = 0));
    DROP VIEW erp.vw_trn_grn;
       erp          postgres    false    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    6            ?           1259    214276 	   vw_trn_po    VIEW     ?  CREATE VIEW erp.vw_trn_po AS
 SELECT po.po_id,
    po.vendor_id,
    po.fy_id,
    ( SELECT to_char((po.po_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS po_date,
    po.po_finalized,
    po.po_no,
    po.po_version,
    po.con_id,
    po.plant_id,
    COALESCE(po.sap_po_code, '-'::character varying) AS sap_po_code,
    COALESCE(summr.net_tot_amt, 0.00) AS net_tot_amt,
    COALESCE(summr.disc_percent, (0)::numeric) AS disc_percent,
    COALESCE(summr.disc_amt, 0.00) AS disc_amt,
    COALESCE(summr.grand_tot_amt, 0.00) AS grand_tot_amt,
    COALESCE(summr.pos_id, 0.00) AS pos_id
   FROM (erp.trn_po po
     LEFT JOIN erp.trn_po_summary summr ON ((po.po_id = summr.po_id)))
  WHERE (po.rec_status = (1)::numeric);
    DROP VIEW erp.vw_trn_po;
       erp          postgres    false    420    420    420    420    420    414    420    414    414    414    414    414    414    414    414    414    414    6            ?           1259    214281    vw_trn_po_items    VIEW     '  CREATE VIEW erp.vw_trn_po_items AS
 SELECT po.poi_id,
    po.po_id,
    po.item_id,
    po.item_qty,
    po.item_amt,
    po.disc_percent,
    po.item_desc,
    po.unit_rate,
    po.cgst_rate,
    po.sgst_rate,
    po.igst_rate
   FROM erp.trn_po_item po
  WHERE (po.rec_status = (1)::numeric);
    DROP VIEW erp.vw_trn_po_items;
       erp          postgres    false    415    415    415    415    415    415    415    415    415    415    415    415    6            ?           1259    214285 	   vw_trn_so    VIEW     /  CREATE VIEW erp.vw_trn_so AS
 SELECT so.so_id,
    so.cust_id,
    so.fy_id,
    ( SELECT to_char((so.so_date)::timestamp with time zone, 'DD-MM-YYYY'::text) AS to_char) AS so_date,
    so.so_finalized,
    so.so_no,
    so.note,
    so.con_id,
    so.plant_id,
    so.ref_po_no,
    so.term_of_payment,
    so.term_of_delivery,
    so.site_id,
    COALESCE(so.sap_so_code, '-'::character varying) AS sap_so_code,
    COALESCE(summr.net_tot_amt, 0.00) AS net_tot_amt,
    COALESCE(summr.disc_percent, (0)::numeric) AS disc_percent,
    COALESCE(summr.disc_amt, 0.00) AS disc_amt,
    COALESCE(summr.grand_tot_amt, 0.00) AS grand_tot_amt,
    COALESCE(summr.sos_id, 0.00) AS sos_id
   FROM (erp.trn_so so
     LEFT JOIN erp.trn_so_summary summr ON ((so.so_id = summr.so_id)))
  WHERE (so.rec_status = (1)::numeric);
    DROP VIEW erp.vw_trn_so;
       erp          postgres    false    428    428    428    428    428    428    428    428    428    428    434    434    434    434    428    428    428    428    434    434    428    6            ?           1259    214290    vw_ui_action    VIEW       CREATE VIEW erp.vw_ui_action AS
 SELECT ui.uiaction_id,
    ui.uiaction_name,
    ui.uiaction_short_desc,
    ui.uiaction_long_desc,
    ui.uicomponent_type,
    ( SELECT pre.presetdata_value
           FROM erp.mst_presetdata pre
          WHERE (((pre.dbtable_name)::text = 'mst_uiaction'::text) AND ((pre.dbcolumn_name)::text = 'uicomponent_type'::text) AND (pre.presetdata_key = ui.uicomponent_type) AND (pre.rec_status = (1)::numeric))) AS uicomponent_type_name
   FROM erp.mst_uiaction ui
  WHERE (ui.rec_status = (1)::numeric);
    DROP VIEW erp.vw_ui_action;
       erp          postgres    false    282    282    262    262    262    262    282    282    282    262    282    6            ?           1259    214295    vw_uicomponant_type    VIEW     [  CREATE VIEW erp.vw_uicomponant_type AS
 SELECT pre.presetdata_id,
    pre.presetdata_key,
    pre.presetdata_value,
    pre.dbtable_name,
    pre.dbcolumn_name
   FROM erp.mst_presetdata pre
  WHERE (((pre.dbtable_name)::text = 'mst_uiaction'::text) AND ((pre.dbcolumn_name)::text = 'uicomponent_type'::text) AND (pre.rec_status = (1)::numeric));
 #   DROP VIEW erp.vw_uicomponant_type;
       erp          postgres    false    262    262    262    262    262    262    6            ?           1259    214299    vw_unit    VIEW     ?   CREATE VIEW erp.vw_unit AS
 SELECT unit.unit_id,
    unit.unit_name,
    COALESCE(unit.unit_desc, ''::character varying) AS unit_desc
   FROM erp.mst_unit unit
  WHERE (unit.rec_status = (1)::numeric);
    DROP VIEW erp.vw_unit;
       erp          postgres    false    284    284    284    284    6            ?           1259    214303    vw_user    VIEW     ?  CREATE VIEW erp.vw_user AS
 SELECT usr.user_id,
    usr.user_name,
    usr.user_security_string,
    COALESCE((usr.user_desc)::text, ''::text) AS user_desc,
    usr.user_mobile_no,
    usr.user_email_id,
    usr.user_type,
    usr.user_general_id,
    usr.is_restriction_free,
    usr.hc_id,
    COALESCE((( SELECT trn_user_roles.role_id
           FROM erp.trn_user_roles
          WHERE (trn_user_roles.user_id = usr.user_id)))::text, ''::text) AS role_id,
    COALESCE((( SELECT trn_user_roles.trans_id
           FROM erp.trn_user_roles
          WHERE (trn_user_roles.user_id = usr.user_id)))::text, ''::text) AS role_trans_id
   FROM erp.mst_user usr
  WHERE (usr.rec_status = (1)::numeric);
    DROP VIEW erp.vw_user;
       erp          postgres    false    287    287    287    287    287    287    287    287    287    287    440    440    440    287    6            ?           1259    214308    vw_user_details    VIEW       CREATE VIEW erp.vw_user_details AS
 SELECT usr.user_id,
    usr.user_name,
    usr.user_desc,
    usr.user_mobile_no,
    usr.user_email_id,
    ( SELECT mst_presetdata.presetdata_value
           FROM erp.mst_presetdata
          WHERE ((mst_presetdata.rec_status = (1)::numeric) AND ((mst_presetdata.dbtable_name)::text = 'mst_user'::text) AND ((mst_presetdata.dbcolumn_name)::text = 'user_type'::text) AND (mst_presetdata.presetdata_key = usr.user_type))) AS user_type_name,
        CASE
            WHEN (usr.user_type = erp.get_presetdata_key('mst_user'::character varying, 'user_type'::character varying, 'Employee'::character varying)) THEN ( SELECT mst_employee.emp_name
               FROM erp.mst_employee
              WHERE (mst_employee.emp_id = usr.user_general_id))
            WHEN (usr.user_type = erp.get_presetdata_key('mst_user'::character varying, 'user_type'::character varying, 'Integrator'::character varying)) THEN ( SELECT mst_integrator.int_name
               FROM erp.mst_integrator
              WHERE (mst_integrator.int_id = usr.user_general_id))
            WHEN (usr.user_type = erp.get_presetdata_key('mst_user'::character varying, 'user_type'::character varying, 'Customer'::character varying)) THEN ( SELECT mst_customer_vendor.cust_vendor_name AS cust_name
               FROM erp.mst_customer_vendor
              WHERE (mst_customer_vendor.cust_vendor_id = usr.user_general_id))
            ELSE NULL::character varying
        END AS enity_name
   FROM erp.mst_user usr
  WHERE (usr.rec_status = (1)::numeric);
    DROP VIEW erp.vw_user_details;
       erp          postgres    false    262    287    287    287    287    287    287    287    287    262    262    262    262    241    241    229    229    222    222    518    6            ?           1259    214313    vw_user_type    VIEW     I  CREATE VIEW erp.vw_user_type AS
 SELECT pre.presetdata_id,
    pre.presetdata_key,
    pre.presetdata_value,
    pre.dbtable_name,
    pre.dbcolumn_name
   FROM erp.mst_presetdata pre
  WHERE (((pre.dbtable_name)::text = 'mst_user'::text) AND ((pre.dbcolumn_name)::text = 'user_type'::text) AND (pre.rec_status = (1)::numeric));
    DROP VIEW erp.vw_user_type;
       erp          postgres    false    262    262    262    262    262    262    6            ?           1259    214317 	   vw_vendor    VIEW       CREATE VIEW erp.vw_vendor AS
 SELECT vendor.vendor_id,
    vendor.vendor_name,
    vendor.vendor_addr,
    vendor.vendor_lat,
    vendor.vendor_long,
    vendor.vendor_city,
    vendor.vendor_state_id,
    vendor.pin_code,
    vendor.ll_no1,
    vendor.ll_no2,
    vendor.mob_no1,
    vendor.mob_no2,
    vendor.wa_no1,
    vendor.wa_no2,
    vendor.email_id1,
    vendor.email_id2,
    vendor.vendor_url,
    vendor.fb_handle,
    vendor.twr_handle,
    vendor.pan_no,
    vendor.gst_no,
    vendor.ifsc_code,
    vendor.bank_acc_no,
    vendor.hc_id,
    vendor.bank_name,
    vendor.vendor_code,
    vendor.vendor_firm_name,
    vendor.vendor_firm_addr,
    vendor.credit_limit,
    vendor.int_id
   FROM erp.mst_vendor vendor
  WHERE (vendor.rec_status = (1)::numeric);
    DROP VIEW erp.vw_vendor;
       erp          postgres    false    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    296    6            ?           1259    214322    vw_vendor_contact    VIEW     6  CREATE VIEW erp.vw_vendor_contact AS
 SELECT vendor.con_id,
    vendor.vendor_id,
    vendor.con_name,
    vendor.con_designation,
    vendor.mob_no1,
    vendor.wa_no1,
    vendor.email_id1,
    vendor.hc_id,
    vendor.int_id
   FROM erp.mst_vendor_contact vendor
  WHERE (vendor.rec_status = (1)::numeric);
 !   DROP VIEW erp.vw_vendor_contact;
       erp          postgres    false    298    298    298    298    298    298    298    298    298    298    6            ?           1259    214326    vw_vendor_details    VIEW       CREATE VIEW erp.vw_vendor_details AS
 SELECT vendor.vendor_id,
    vendor.vendor_code,
    vendor.vendor_name,
    vendor.vendor_firm_name,
    vendor.vendor_addr,
    vendor.email_id1
   FROM erp.mst_vendor vendor
  WHERE (vendor.rec_status = (1)::numeric);
 !   DROP VIEW erp.vw_vendor_details;
       erp          postgres    false    296    296    296    296    296    296    296    6            ?           1259    214438 
   temp_table    TABLE     ?   CREATE TABLE public.temp_table (
    trans_id numeric(11,0),
    unitid numeric,
    catid numeric,
    item_description character varying(500),
    itemtype integer,
    item_no character varying(20),
    hsn_code numeric(6,0),
    plantid numeric
);
    DROP TABLE public.temp_table;
       public         heap    postgres    false            ?           1259    214444    trn_designmix    TABLE     ?  CREATE TABLE public.trn_designmix (
    dmix_id numeric(11,0) NOT NULL,
    item_id numeric(10,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    dmix_item_name character varying(200) DEFAULT NULL::character varying,
    dmix_item_subid numeric(10,0) NOT NULL,
    qty numeric(11,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE public.trn_designmix;
       public         heap    postgres    false            ?           1259    214451    trn_so_designmix    TABLE     =  CREATE TABLE public.trn_so_designmix (
    so_dmix_id numeric(11,0) NOT NULL,
    soi_id numeric(12,0),
    so_id numeric(11,0) DEFAULT NULL::numeric,
    so_item_id numeric(10,0) NOT NULL,
    hc_id numeric(2,0) NOT NULL,
    plant_id numeric(7,0) NOT NULL,
    dmix_item_name character varying(200) DEFAULT NULL::character varying,
    dmix_item_subid numeric(10,0) NOT NULL,
    qty numeric(11,2) NOT NULL,
    rec_status numeric(1,0) DEFAULT 1 NOT NULL,
    action_by numeric(5,0) DEFAULT 1 NOT NULL,
    action_on timestamp without time zone DEFAULT now() NOT NULL
);
 $   DROP TABLE public.trn_so_designmix;
       public         heap    postgres    false            ?           1259    214459    v_ticket    MATERIALIZED VIEW     ?  CREATE MATERIALIZED VIEW public.v_ticket AS
 SELECT trn_grn_info.grn_id,
    trn_grn_info.grn_no,
    trn_grn_info.grn_date,
    trn_grn_info.grn_code,
    trn_grn_info.fy_id,
    trn_grn_info.vendor_id,
    trn_grn_info.po_id,
    trn_grn_info.note,
    trn_grn_info.hc_id,
    trn_grn_info.item_id,
    trn_grn_info.item_qty,
    trn_grn_info.item_amt,
    trn_grn_info.item_desc,
    trn_grn_info.unit_rate,
    trn_grn_info.cgst_rate,
    trn_grn_info.sgst_rate,
    trn_grn_info.igst_rate,
    trn_grn_info.net_tot_amt,
    trn_grn_info.disc_percent,
    trn_grn_info.disc_amt,
    trn_grn_info.grand_tot_amt,
    trn_grn_info.rec_status,
    trn_grn_info.action_by,
    trn_grn_info.action_on,
    trn_grn_info.quality_percentage,
    trn_grn_info.plant_id,
    trn_grn_info.weg_bridge_id,
    trn_grn_info.ref_invoice_no,
    trn_grn_info.ref_invoice_date,
    trn_grn_info.ref_challan_no,
    trn_grn_info.ref_challan_date,
    trn_grn_info.po_iw_id,
    trn_grn_info.is_usedin_bpa,
    trn_grn_info.insertion_type,
    trn_grn_info.file_path,
    row_number() OVER (PARTITION BY trn_grn_info.vendor_id ORDER BY trn_grn_info.grn_no) AS seat_number_effective
   FROM erp.trn_grn_info
  WITH NO DATA;
 (   DROP MATERIALIZED VIEW public.v_ticket;
       public         heap    postgres    false    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398    398            `           2604    214467    mst_employee_contact con_id    DEFAULT     ?   ALTER TABLE ONLY erp.mst_employee_contact ALTER COLUMN con_id SET DEFAULT nextval('erp.mst_employee_contact_con_id_seq'::regclass);
 G   ALTER TABLE erp.mst_employee_contact ALTER COLUMN con_id DROP DEFAULT;
       erp          postgres    false    231    230            ,           2604    214468    mstempl_info emp_id    DEFAULT     t   ALTER TABLE ONLY erp.mstempl_info ALTER COLUMN emp_id SET DEFAULT nextval('erp.mstempl_info_emp_id_seq'::regclass);
 ?   ALTER TABLE erp.mstempl_info ALTER COLUMN emp_id DROP DEFAULT;
       erp          postgres    false    302    301            ?          0    211819    mst_alert_config 
   TABLE DATA              COPY erp.mst_alert_config (ac_id, ac_event_type, ac_name, ac_desc, sms_contents, email_subject, email_body, email_signature, email_cc, email_bcc, sms_active, email_active, rec_status, action_by, action_on, int_id, hc_id, plant_id, insert_type) FROM stdin;
    erp          postgres    false    210   K?      ?          0    211838    mst_card 
   TABLE DATA           ?   COPY erp.mst_card (card_id, card_name, card_type, card_access_string, rec_status, action_by, action_on, hc_id, int_id, plant_id, is_allocated, insertion_type) FROM stdin;
    erp          postgres    false    212   h?      ?          0    211850    mst_card_log 
   TABLE DATA           ?   COPY erp.mst_card_log (card_id, card_name, card_type, card_access_string, rec_status, action_by, action_on, hc_id, int_id, plant_id, is_allocated, insertion_type) FROM stdin;
    erp          postgres    false    213   ??      ?          0    211862    mst_cust_vendor_contact 
   TABLE DATA           ?   COPY erp.mst_cust_vendor_contact (con_id, cust_vendor_id, con_name, con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    215   /?      ?          0    211874    mst_cust_vendor_contact_log 
   TABLE DATA           ?   COPY erp.mst_cust_vendor_contact_log (con_id, cust_vendor_id, con_name, con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    216   ??      ?          0    211888    mst_cust_vendor_item 
   TABLE DATA           ?   COPY erp.mst_cust_vendor_item (ven_item_id, item_id, cust_id, cgst_rate, sgst_rate, igst_rate, unit_rate, note, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    218   g?                 0    211904 "   mst_cust_vendor_payment_conditions 
   TABLE DATA           ?   COPY erp.mst_cust_vendor_payment_conditions (ven_condition_id, condition_name, payment_condition, cust_id, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    220   ??                0    211920    mst_customer_vendor 
   TABLE DATA           *  COPY erp.mst_customer_vendor (cust_vendor_id, cust_vendor_name, cust_vendor_addr, cust_vendor_lat, cust_vendor_long, cust_vendor_city, cust_vendor_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, cust_vendor_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, hc_id, bank_name, cust_vendor_code, cust_vendor_firm_name, cust_vendor_firm_addr, credit_limit, int_id, sap_code, sap_id, plant_id, insertion_type, file_path, is_customer, import_trans_id) FROM stdin;
    erp          postgres    false    222   ??                0    211954    mst_customer_vendor_log 
   TABLE DATA           #  COPY erp.mst_customer_vendor_log (cust_vendor_id, cust_vendor_name, cust_vendor_addr, cust_vendor_lat, cust_vendor_long, cust_vendor_city, cust_vendor_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, cust_vendor_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, hc_id, bank_name, cust_vendor_code, cust_vendor_firm_name, cust_vendor_firm_addr, credit_limit, int_id, sap_code, sap_id, plant_id, insertion_type, is_customer, import_trans_id) FROM stdin;
    erp          postgres    false    223   ??                0    211986    mst_department 
   TABLE DATA           ?   COPY erp.mst_department (dept_id, dept_name, dept_location, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    225   ??                0    211998    mst_diesel_type 
   TABLE DATA           ?   COPY erp.mst_diesel_type (diesel_id, diesel_name, diesel_type, diesel_qty, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    227   ?      	          0    212009    mst_employee 
   TABLE DATA             COPY erp.mst_employee (emp_id, hc_id, dept_id, ro1_id, ro2_id, employment_type, emp_code, emp_name, designation, joining_on, exit_on, ll_no1, ll_no2, mobile_no1, mobile_no2, comp_email_id, personal_email_id, curr_addr, perm_addr, curr_resi_type, born_on, marital_status, blood_group, alergic_to, pan_no, aadhaar_no, esic_no, other_info, rec_status, action_by, action_on, emp_gender, emp_img_path, pf_no, emp_first_name, emp_middle_name, emp_last_name, emp_comp_mob_no, plant_id, sap_code, sap_id, insertion_type) FROM stdin;
    erp          postgres    false    229   6?      
          0    212023    mst_employee_contact 
   TABLE DATA           ?   COPY erp.mst_employee_contact (con_id, emp_address1, emp_mobno1, email1, rec_status, action_by, action_on, emp_id, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    230   S?                0    212031    mst_finyear 
   TABLE DATA           d   COPY erp.mst_finyear (fy_id, fy_from, fy_to, fy_name, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    233   f?                0    212040    mst_general_ledger 
   TABLE DATA           ?  COPY erp.mst_general_ledger (trans_id, gen_led_no, gen_led_name, gn_no, trans_date, credit_amt, debit_amt, op_bal, br_id, is_inventory, is_tds_apply, depriciation, drcr_limit, ap_name, acp_name, address, state_name, pincode, mobile_no, email_id, pancard_no, salestax_no, ref_ac_type, ref_ac_no1, ref_ac_no2, ref_ac_name1, ref_ac_name2, ref_ac_details, ref_ac_address2, ref_ac_sitedistance2, gm_no, import_status, firm_add, phone_noo1, phone_noo2, phone_no_f1, phone_no_f2, ecc_no, tin_no, cgst_no, igst_no, gl_alias, drcr_limit_period, upload_status, lbt_no, hc_id, rec_status, action_by, action_on, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    235   v?                0    212095    mst_general_ledger_log 
   TABLE DATA           ?  COPY erp.mst_general_ledger_log (trans_id, gen_led_no, gen_led_name, gn_no, trans_date, credit_amt, debit_amt, op_bal, br_id, is_inventory, is_tds_apply, depriciation, drcr_limit, ap_name, acp_name, address, state_name, pincode, mobile_no, email_id, pancard_no, salestax_no, ref_ac_type, ref_ac_no1, ref_ac_no2, ref_ac_name1, ref_ac_name2, ref_ac_details, ref_ac_address2, ref_ac_sitedistance2, gm_no, import_status, firm_add, phone_noo1, phone_noo2, phone_no_f1, phone_no_f2, ecc_no, tin_no, cgst_no, igst_no, gl_alias, drcr_limit_period, upload_status, lbt_no, hc_id, rec_status, action_by, action_on, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    236   ??                0    212149    mst_host_company 
   TABLE DATA           ~  COPY erp.mst_host_company (hc_id, comp_name, comp_addr, comp_lat, comp_long, comp_city, comp_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, comp_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, comp_logo, bank_branch, int_id, insertion_type, comp_code, hc_prefix, prefix) FROM stdin;
    erp          postgres    false    238   ??                0    212161    mst_host_company_log 
   TABLE DATA           d  COPY erp.mst_host_company_log (hc_id, comp_name, comp_addr, comp_lat, comp_long, comp_city, comp_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, comp_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, comp_logo, bank_branch, int_id, insertion_type) FROM stdin;
    erp          postgres    false    239   I?                0    212174    mst_integrator 
   TABLE DATA           ?   COPY erp.mst_integrator (int_id, int_name, int_shortname, int_address, int_phone1, int_phone2, int_mobile1, int_mobile2, int_email1, int_email2, int_logo_path, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    241   #?                0    212196    mst_integrator_config 
   TABLE DATA           ?   COPY erp.mst_integrator_config (int_i_id, int_id, config_param_key, config_param_val, value_datatype, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    243   ??                0    212206    mst_integrator_log 
   TABLE DATA           ?   COPY erp.mst_integrator_log (int_id, int_name, int_shortname, int_address, int_phone1, int_phone2, int_mobile1, int_mobile2, int_email1, int_email2, int_logo_path, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    244   ??                0    212227    mst_item 
   TABLE DATA           ?  COPY erp.mst_item (item_id, ic_id, item_name, item_desc, make, sr_no, item_size, item_type, min_stock_qty, unit_id, unit_rate, cgst_rate, sgst_rate, igst_rate, hsn_code, rec_status, action_by, action_on, item_rate_effective_from, item_code, hc_id, int_id, consumable, maintenance, insurance, item_display_criteria, sap_code, sap_id, plant_id, insertion_type, import_trans_id) FROM stdin;
    erp          postgres    false    246   -?                0    212258    mst_item_category 
   TABLE DATA           ?   COPY erp.mst_item_category (ic_id, cat_name, cat_desc, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    248   ?                0    212271    mst_item_category_log 
   TABLE DATA           ?   COPY erp.mst_item_category_log (ic_id, cat_name, cat_desc, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    249   ?                0    212285    mst_item_log 
   TABLE DATA           |  COPY erp.mst_item_log (item_id, ic_id, item_name, item_desc, make, sr_no, item_size, item_type, min_stock_qty, unit_id, unit_rate, cgst_rate, sgst_rate, igst_rate, hsn_code, rec_status, action_type, action_by, action_on, item_rate_effective_from, item_code, hc_id, int_id, trans_id, consumable, maintenance, insurance, item_display_criteria, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    251   6      !          0    212312    mst_name_setup 
   TABLE DATA           8  COPY erp.mst_name_setup (trans_id, int_id, hc_id, plant_id, agg1_name, agg1_item_id, agg2_name, agg2_item_id, agg3_name, agg3_item_id, agg4_name, agg4_item_id, agg5_name, agg5_item_id, cement1_name, cement1_item_id, cement2_name, cement2_item_id, fill_name, fill_item_id, water1_name, water1_item_id, water2_name, water2_item_id, admix1_name, admix1_item_id, admix12_name, admix12_item_id, admix2_name, admix2_item_id, admix22_name, admix22_item_id, silica_name, silica_item_id, slurry_name, slurry_item_id, pigname, action_on, rec_status, insertion_type) FROM stdin;
    erp          postgres    false    253   ?      "          0    212339    mst_name_setup_log 
   TABLE DATA           <  COPY erp.mst_name_setup_log (trans_id, int_id, hc_id, plant_id, agg1_name, agg1_item_id, agg2_name, agg2_item_id, agg3_name, agg3_item_id, agg4_name, agg4_item_id, agg5_name, agg5_item_id, cement1_name, cement1_item_id, cement2_name, cement2_item_id, fill_name, fill_item_id, water1_name, water1_item_id, water2_name, water2_item_id, admix1_name, admix1_item_id, admix12_name, admix12_item_id, admix2_name, admix2_item_id, admix22_name, admix22_item_id, silica_name, silica_item_id, slurry_name, slurry_item_id, pigname, action_on, rec_status, insertion_type) FROM stdin;
    erp          postgres    false    254   ?      $          0    212367    mst_payment_other_conditions 
   TABLE DATA           ?   COPY erp.mst_payment_other_conditions (condition_id, condition_name, payment_condition, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    256   _      %          0    212381     mst_payment_other_conditions_log 
   TABLE DATA           ?   COPY erp.mst_payment_other_conditions_log (condition_id, condition_name, payment_condition, rec_status, action_type, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    257   |      '          0    212394 	   mst_plant 
   TABLE DATA           ?  COPY erp.mst_plant (plant_id, hc_id, int_id, plant_name, plant_reg_no, plant_reg_date, plant_address, plant_details, plant_install_date, plant_contact_person, plant_latitude, plant_longitude, plant_contact_mobile_no, plant_type, plant_subtype, plant_capacity, plant_valid_from, plant_valid_to, plant_status, geofence, comp_location_id, device_imei_no, rec_status, created_by, created_on, modified_by, modified_on, sync_status, sap_code, sap_id, insertion_type, plant_prefix, prefix) FROM stdin;
    erp          postgres    false    259   ?      (          0    212408    mst_plant_log 
   TABLE DATA           ?  COPY erp.mst_plant_log (plant_id, hc_id, int_id, plant_name, plant_reg_no, plant_reg_date, plant_address, plant_details, plant_install_date, plant_contact_person, plant_latitude, plant_longitude, plant_contact_mobile_no, plant_type, plant_subtype, plant_capacity, plant_valid_from, plant_valid_to, plant_status, geofence, comp_location_id, device_imei_no, rec_status, created_by, created_on, modified_by, modified_on, sync_status, sap_code, sap_id, insertion_type) FROM stdin;
    erp          postgres    false    260   _      *          0    212423    mst_presetdata 
   TABLE DATA           ?   COPY erp.mst_presetdata (presetdata_id, dbtable_name, dbcolumn_name, presetdata_key, presetdata_value, presetdata_index, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    262   i      +          0    212431    mst_presetdata_log 
   TABLE DATA           ?   COPY erp.mst_presetdata_log (presetdata_id, dbtable_name, dbcolumn_name, presetdata_key, presetdata_value, presetdata_index, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    263   %      -          0    212440    mst_role 
   TABLE DATA           ?   COPY erp.mst_role (role_id, role_name, role_desc, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    265   ?      .          0    212449    mst_role_log 
   TABLE DATA           ?   COPY erp.mst_role_log (role_id, role_name, role_desc, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    266   y      0          0    212458 
   mst_screen 
   TABLE DATA           ?   COPY erp.mst_screen (screen_id, screen_name, screen_nav_path, screen_desc, parent_screen_id, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    268   ?      2          0    212472    mst_site 
   TABLE DATA           ?   COPY erp.mst_site (site_id, hc_id, plant_id, site_name, site_type, rec_status, action_by, action_on, work_code, cust_id, site_distance, site_address, int_id, sap_code, sap_id, file_path, import_trans_id, insertion_type) FROM stdin;
    erp          postgres    false    270   +      4          0    212488    mst_site_contact 
   TABLE DATA           ?   COPY erp.mst_site_contact (site_con_id, cust_id, site_id, site_con_name, site_con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    272   D      5          0    212500    mst_site_contact_log 
   TABLE DATA           ?   COPY erp.mst_site_contact_log (site_con_id, cust_id, site_id, site_con_name, site_con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    273   ?      6          0    212511    mst_site_log 
   TABLE DATA           ?   COPY erp.mst_site_log (site_id, hc_id, plant_id, site_name, site_type, rec_status, action_by, action_on, work_code, cust_id, site_distance, site_address, int_id, sap_code, sap_id, file_path, import_trans_id, insertion_type) FROM stdin;
    erp          postgres    false    274   ?      8          0    212526 	   mst_state 
   TABLE DATA           d   COPY erp.mst_state (state_id, state_name, state_desc, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    276   A       :          0    212536    mst_subtestmaster 
   TABLE DATA           ?   COPY erp.mst_subtestmaster (sub_test_id, test_id, sub_test_name, days, rate, sub_test_abbrivation, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    278   ?       <          0    212550    mst_testmaster 
   TABLE DATA           ?   COPY erp.mst_testmaster (test_id, main_cat, test_name, from_date, to_date, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    280   ?       >          0    212564    mst_uiaction 
   TABLE DATA           ?   COPY erp.mst_uiaction (uiaction_id, uiaction_name, uiaction_short_desc, uiaction_long_desc, uicomponent_type, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    282   ?       @          0    212577    mst_unit 
   TABLE DATA           ?   COPY erp.mst_unit (unit_id, unit_name, unit_desc, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    284   ?!      A          0    212590    mst_unit_log 
   TABLE DATA           ?   COPY erp.mst_unit_log (unit_id, unit_name, unit_desc, rec_status, action_by, action_on, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    285   ?"      C          0    212603    mst_user 
   TABLE DATA           ?   COPY erp.mst_user (user_id, user_name, user_security_string, user_desc, user_mobile_no, user_email_id, user_type, user_general_id, rec_status, action_by, action_on, is_restriction_free, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    287   #      D          0    212618    mst_user_log 
   TABLE DATA           ?   COPY erp.mst_user_log (user_id, user_name, user_security_string, user_desc, user_mobile_no, user_email_id, user_type, user_general_id, rec_status, action_by, action_on, is_restriction_free, hc_id, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    288   ?#      F          0    212634    mst_vehicle 
   TABLE DATA           ?  COPY erp.mst_vehicle (veh_id, hc_id, int_id, dev_sim_no, dev_imei_no, dev_install_on, veh_name, veh_no, veh_type, veh_make, veh_color, veh_chasis_no, veh_fuel_capacity, veh_status, correction_factor, full_voltage, empty_voltage, calibrated_voltage, rec_status, created_by, created_on, modified_by, modified_on, sync_status, sap_code, sap_id, allocated_card_id, plant_id, insertion_type, import_trans_id) FROM stdin;
    erp          postgres    false    290   $      H          0    212656    mst_vehicle_insurance 
   TABLE DATA             COPY erp.mst_vehicle_insurance (trans_id, veh_id, veh_no, insurance_no, from_date, to_date, premium_amt, insurance_type, owner_name, company_name, details_info, id_no, ide_value, vehicle_type_id, rec_status, action_by, action_on, plant_id, hc_id) FROM stdin;
    erp          postgres    false    292   ?$      I          0    212669    mst_vehicle_insurance_log 
   TABLE DATA             COPY erp.mst_vehicle_insurance_log (trans_id, veh_id, veh_no, insurance_no, from_date, to_date, premium_amt, insurance_type, owner_name, company_name, details_info, id_no, ide_value, vehicle_type_id, rec_status, action_by, action_on, plant_id, hc_id) FROM stdin;
    erp          postgres    false    293   Z%      J          0    212681    mst_vehicle_log 
   TABLE DATA           ?  COPY erp.mst_vehicle_log (veh_id, hc_id, int_id, dev_sim_no, dev_imei_no, dev_install_on, veh_name, veh_no, veh_type, veh_make, veh_color, veh_chasis_no, veh_fuel_capacity, veh_status, correction_factor, full_voltage, empty_voltage, calibrated_voltage, rec_status, created_by, created_on, modified_by, modified_on, sync_status, sap_code, sap_id, allocated_card_id, plant_id, insertion_type, import_trans_id) FROM stdin;
    erp          postgres    false    294   ?%      L          0    212702 
   mst_vendor 
   TABLE DATA           ?  COPY erp.mst_vendor (vendor_id, vendor_name, vendor_addr, vendor_lat, vendor_long, vendor_city, vendor_state_id, pin_code, ll_no1, ll_no2, mob_no1, mob_no2, wa_no1, wa_no2, email_id1, email_id2, vendor_url, fb_handle, twr_handle, pan_no, gst_no, ifsc_code, bank_acc_no, rec_status, action_by, action_on, hc_id, bank_name, vendor_code, vendor_firm_name, vendor_firm_addr, credit_limit, int_id, sap_code, sap_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    296   +&      N          0    212734    mst_vendor_contact 
   TABLE DATA           ?   COPY erp.mst_vendor_contact (con_id, vendor_id, con_name, con_designation, mob_no1, wa_no1, email_id1, rec_status, action_by, action_on, hc_id, int_id, sap_code, sap_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    298   (      P          0    212748    mst_weigh_bridge 
   TABLE DATA           ?   COPY erp.mst_weigh_bridge (weg_bridge_id, bridge_name, hc_id, plant_id, reg_mobile_no, imei_no, rec_status, action_by, action_on, int_id, insertion_type) FROM stdin;
    erp          postgres    false    300   ?(      Q          0    212760    mstempl_info 
   TABLE DATA           ?   COPY erp.mstempl_info (emp_id, emp_fname, emp_lname, age, designation, salary, emp_address, emp_mobno, email, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    301   ?(      T          0    212771    mtn_emp_bioprofile 
   TABLE DATA           ?   COPY erp.mtn_emp_bioprofile (bioprof_id, emp_id, bio_id_type, scan_img_file_name, fp_rescan_reason, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    304   ?*      U          0    212782    mtn_emp_bioprofile_log 
   TABLE DATA           ?   COPY erp.mtn_emp_bioprofile_log (bioprof_id, emp_id, bio_id_type, scan_img_file_name, fp_rescan_reason, rec_status, action_type, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    305   ?*      W          0    212794    mtn_emp_doc 
   TABLE DATA           ?   COPY erp.mtn_emp_doc (emp_doc_id, emp_id, doc_cat, doc_type, is_true_copy_submitted, scanned_doc_path, submitted_on, returned_on, other_info, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    307   ?*      Y          0    212804    mtn_emp_guardian 
   TABLE DATA           ?   COPY erp.mtn_emp_guardian (eg_id, emp_id, guardian_type, guardian_name, guardian_ll_no, guardian_mobile_no, guardian_email_id, guardian_address, guardian_occupation, other_info, rec_status, action_by, action_on, plant_id, hc_id) FROM stdin;
    erp          postgres    false    309   ?*      [          0    212816    mtn_emp_professional_summary 
   TABLE DATA             COPY erp.mtn_emp_professional_summary (emp_profsummary_id, emp_id, comp_name, comp_address, designation, experience_count, ctc, experience_letter_path, relieving_letter_path, rec_status, action_by, action_on, from_date, to_date, salary_slip, plant_id, hc_id) FROM stdin;
    erp          postgres    false    311   ?*      ]          0    212828    mtn_emp_wish_date 
   TABLE DATA           ?   COPY erp.mtn_emp_wish_date (ewd_id, wish_type, wish_date, applicable_to, rec_status, action_by, action_on, general_entity_id, hc_id, plant_id) FROM stdin;
    erp          postgres    false    313   +      _          0    212839    notification 
   TABLE DATA              COPY erp.notification (sr_id, notification_date, notification_time, trans_info, error_qty, mobile_no1, mobile_no2) FROM stdin;
    erp          postgres    false    315   /+      a          0    212845    notification_log 
   TABLE DATA           ?   COPY erp.notification_log (trns_id, sr_id, notification_date, notification_time, trans_info, error_qty, mobile_no1, mobile_no2) FROM stdin;
    erp          postgres    false    317   q+      ?          0    212975    trn_alert_sent 
   TABLE DATA             COPY erp.trn_alert_sent (trans_id, ac_id, cust_id, hc_id, general_artifact_type, general_artifact_id, alert_source, sms_sent_status, email_sent_status, alert_sent_on, sms_contents, rec_status, action_by, action_on, plant_id, int_id, insertion_type) FROM stdin;
    erp          postgres    false    381   ?+      ?          0    212989    trn_bpa_details 
   TABLE DATA           ?   COPY erp.trn_bpa_details (bpa_dt_id, bpa_id, hc_id, plant_id, grn_id, item_qty, item_amt, quality_percentage, net_amt, rec_status, action_by, action_on, int_id, insertion_type) FROM stdin;
    erp          postgres    false    382   ?+      ?          0    213001    trn_bpa_details_log 
   TABLE DATA           ?   COPY erp.trn_bpa_details_log (bpa_dt_id, bpa_id, hc_id, plant_id, grn_id, item_qty, item_amt, quality_percentage, net_amt, rec_status, action_by, action_on, int_id, insertion_type) FROM stdin;
    erp          postgres    false    383   %,      ?          0    213012    trn_bpa_info 
   TABLE DATA           ?   COPY erp.trn_bpa_info (bpa_id, bpa_no, bpa_date, bpa_code, fy_id, vendor_id, note, hc_id, grand_tot_amt, rec_status, action_by, action_on, int_id, plant_id, insertion_type, file_path) FROM stdin;
    erp          postgres    false    384   z,      ?          0    213025    trn_bpa_info_log 
   TABLE DATA           ?   COPY erp.trn_bpa_info_log (trans_id, bpa_id, bpa_no, bpa_date, bpa_code, fy_id, vendor_id, note, hc_id, disc_percent, disc_amt, grand_tot_amt, rec_status, action_by, action_on, action_type, int_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    385   ?,      ?          0    213040    trn_card_access_transaction 
   TABLE DATA           ?   COPY erp.trn_card_access_transaction (trans_id, card_id, card_access_string, card_allocation_id, access_tab_type, access_time, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    386   9-      ?          0    213050    trn_card_allocation 
   TABLE DATA           ?   COPY erp.trn_card_allocation (card_allocation_id, card_id, card_access_string, allocated_to_id, allocate_type, allocate_time, submit_time, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    387   V-      ?          0    213060    trn_card_allocation_log 
   TABLE DATA           ?   COPY erp.trn_card_allocation_log (card_allocation_id, card_id, card_access_string, allocated_to_id, allocate_type, allocate_time, submit_time, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    388   ?-      ?          0    213069    trn_dc_info 
   TABLE DATA             COPY erp.trn_dc_info (dc_id, dc_no, dc_date, dc_code, fy_id, cust_id, so_id, note, hc_id, rec_status, action_by, action_on, sap_code, sap_id, weg_bridge_id, batch_id, term_delivery, term_payment, plant_id, insertion_type, file_path, increment_against_fy_comp, batch_no) FROM stdin;
    erp          postgres    false    389   1.      ?          0    213083    trn_dc_info_log 
   TABLE DATA             COPY erp.trn_dc_info_log (trans_id, dc_id, dc_no, dc_date, dc_code, fy_id, cust_id, so_id, note, hc_id, rec_status, action_by, action_on, action_type, sap_code, sap_id, weg_bridge_id, batch_id, term_delivery, term_payment, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    390   ?.      ?          0    213095    trn_dc_item 
   TABLE DATA           ?   COPY erp.trn_dc_item (dci_id, dc_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, dc_type, insertion_type) FROM stdin;
    erp          postgres    false    391   2/      ?          0    213115    trn_dc_item_log 
   TABLE DATA             COPY erp.trn_dc_item_log (trans_id, dci_id, dc_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, dc_type, action_type, insertion_type) FROM stdin;
    erp          postgres    false    392   ?/      ?          0    213135    trn_dc_summary 
   TABLE DATA           ?   COPY erp.trn_dc_summary (dcs_id, dc_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    393   %0      ?          0    213146    trn_dc_summary_log 
   TABLE DATA           ?   COPY erp.trn_dc_summary_log (trans_id, dcs_id, dc_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, action_type, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    394   ?0      ?          0    213157    trn_designmix 
   TABLE DATA           I  COPY erp.trn_designmix (dmix_id, design_mix_code, design_mix_name, item_id, is_close, hc_id, plant_id, agg1_name, agg1_item_id, agg1_qty, agg2_name, agg2_item_id, agg2_qty, agg3_name, agg3_item_id, agg3_qty, agg4_name, agg4_item_id, agg4_qty, agg5_name, agg5_item_id, agg5_qty, cement1_name, cement1_item_id, cement1_qty, cement2_name, cement2_item_id, cement2_qty, fill_name, fill_item_id, fill_qty, water1_name, water1_item_id, water1_qty, water2_name, water2_item_id, water2_qty, admix1_name, admix1_item_id, admix1_qty, admix12_name, admix12_item_id, admix12_qty, admix2_name, admix2_item_id, admix2_qty, admix22_name, admix22_item_id, admix22_qty, silica_name, silica_item_id, silica_qty, slurry_name, slurry_item_id, slurry_qty, pigname, rec_status, action_by, action_on, sap_code, sap_id, insertion_type, import_trans_id) FROM stdin;
    erp          postgres    false    395   ?0      ?          0    213203    trn_designmix_log 
   TABLE DATA           A  COPY erp.trn_designmix_log (trans_id, dmix_id, design_mix_code, design_mix_name, item_id, is_close, agg1_name, agg1_item_id, agg1_qty, agg2_name, agg2_item_id, agg2_qty, agg3_name, agg3_item_id, agg3_qty, agg4_name, agg4_item_id, agg4_qty, agg5_name, agg5_item_id, agg5_qty, cement1_name, cement1_item_id, cement1_qty, cement2_name, cement2_item_id, cement2_qty, fill_name, fill_item_id, fill_qty, water1_name, water1_item_id, water1_qty, water2_name, water2_item_id, water2_qty, admix1_name, admix1_item_id, admix1_qty, admix12_name, admix12_item_id, admix12_qty, admix2_name, admix2_item_id, admix2_qty, admix22_name, admix22_item_id, admix22_qty, silica_name, silica_item_id, silica_qty, slurry_name, slurry_item_id, slurry_qty, pigname, hc_id, plant_id, rec_status, action_by, action_on, action_type, insertion_type) FROM stdin;
    erp          postgres    false    396   "4      ?          0    213248    trn_diesel_refill 
   TABLE DATA           ?   COPY erp.trn_diesel_refill (trans_id, diesel_id, refill_date, card_id, diesel_refill_qty, rec_status, action_by, action_on, hc_id, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    397   ?7      ?          0    213257    trn_grn_info 
   TABLE DATA           ?  COPY erp.trn_grn_info (grn_id, grn_no, grn_date, grn_code, fy_id, vendor_id, po_id, note, hc_id, item_id, item_qty, item_amt, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, rec_status, action_by, action_on, quality_percentage, plant_id, weg_bridge_id, ref_invoice_no, ref_invoice_date, ref_challan_no, ref_challan_date, po_iw_id, is_usedin_bpa, insertion_type, file_path, increment_against_fy_comp) FROM stdin;
    erp          postgres    false    398   ?7      ?          0    213280    trn_grn_info_log 
   TABLE DATA           ?  COPY erp.trn_grn_info_log (trans_id, grn_id, grn_no, grn_date, grn_code, fy_id, vendor_id, po_id, note, hc_id, item_id, item_qty, item_amt, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, rec_status, action_by, action_on, action_type, quality_percentage, plant_id, ref_invoice_no, ref_invoice_date, ref_challan_no, ref_challan_date, po_iw_id, weg_bridge_id, insertion_type) FROM stdin;
    erp          postgres    false    399   [9      ?          0    213300    trn_hmb_bmp_devicetransmission 
   TABLE DATA             COPY erp.trn_hmb_bmp_devicetransmission (trans_id, int_id, cust_id, plant_id, wo_id, wo_code, plant_reg_code, batch_id, opr_lat, opr_long, opr_juri, opr_div, opr_work_name, opr_date, opr_time, tipper_no, f1, f2, f3, f4, filler_inkg, bituman_inkg, bituman_percent, netmix_ton, tank1_temp, tank2_temp, exhaust_temp, mix_temp, sr_no, filler_percent, truck_count, work_type, material_type, device_imei_no, moisture_percent, aggregate_ton, aggregate_intph, bituman_inkgpermin, filler_inkgpermin, batch_duration_insec, weight_kgperbatch, bituman_kgperbatch, hb1_kgperbatch, hb2_kgperbatch, hb3_kgperbatch, hb4_kgperbatch, aggregate_kg, packet_arrived_on, rec_status, batch_end_flag, column_validity_status, customer_name, driver_name, site_name, hc_id, so_id, insertion_type) FROM stdin;
    erp          postgres    false    400   ?<      ?          0    213353    trn_hmb_dmp_devicetransmission 
   TABLE DATA           \  COPY erp.trn_hmb_dmp_devicetransmission (trans_id, int_id, cust_id, plant_id, wo_id, wo_code, plant_reg_code, batch_id, opr_lat, opr_long, opr_juri, opr_div, opr_work_name, opr_date, opr_time, tipper_no, f1, f2, f3, f4, filler_inkg, bituman_inkg, bituman_percent, netmix_ton, tank1_temp, tank2_temp, exhaust_temp, mix_temp, sr_no, filler_percent, truck_count, work_type, material_type, device_imei_no, moisture_percent, aggregate_ton, aggregate_intph, bituman_inkgpermin, filler_inkgpermin, packet_arrived_on, rec_status, batch_end_flag, column_validity_status, hc_id, so_id, insertion_type) FROM stdin;
    erp          postgres    false    401   ?<      ?          0    213395    trn_invoice_info 
   TABLE DATA           0  COPY erp.trn_invoice_info (invoice_id, invoice_no, invoice_date, invoice_code, fy_id, cust_id, so_id, note, hc_id, rec_status, action_by, action_on, sap_code, sap_id, weg_bridge_id, dc_id, batch_id, term_delivery, term_payment, plant_id, insertion_type, file_path, increment_against_fy_comp) FROM stdin;
    erp          postgres    false    402   ?<      ?          0    213409    trn_invoice_info_log 
   TABLE DATA           %  COPY erp.trn_invoice_info_log (trans_id, invoice_id, invoice_no, invoice_date, invoice_code, fy_id, cust_id, so_id, note, hc_id, sap_code, sap_id, weg_bridge_id, dc_id, batch_id, term_delivery, term_payment, rec_status, action_by, action_on, action_type, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    403   c=      ?          0    213422    trn_invoice_item 
   TABLE DATA           ?   COPY erp.trn_invoice_item (inv_item_id, invoice_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, invoice_type, insertion_type) FROM stdin;
    erp          postgres    false    404   ?=      ?          0    213442    trn_invoice_item_log 
   TABLE DATA             COPY erp.trn_invoice_item_log (trans_id, inv_item_id, invoice_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, invoice_type, action_type, insertion_type) FROM stdin;
    erp          postgres    false    405   {>      ?          0    213462    trn_invoice_summary 
   TABLE DATA           ?   COPY erp.trn_invoice_summary (invoice_sum_id, invoice_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    406   ?>      ?          0    213473    trn_invoice_summary_log 
   TABLE DATA           ?   COPY erp.trn_invoice_summary_log (trans_id, invoice_sum_id, invoice_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, action_type, plant_id, hc_id) FROM stdin;
    erp          postgres    false    407   j?      ?          0    213483    trn_ledger_transcation 
   TABLE DATA           ?   COPY erp.trn_ledger_transcation (trans_id, gen_led_no, gn_no, trans_date, credit_amt, debit_amt, op_bal, depriciation, ref_ac_no, ref_type, hc_id, rec_status, action_by, action_on, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    408   ??      ?          0    213497    trn_ledger_transcation_log 
   TABLE DATA           ?   COPY erp.trn_ledger_transcation_log (trans_id, led_trans_id, gen_led_no, gn_no, trans_date, credit_amt, debit_amt, op_bal, depriciation, ref_ac_no, ref_type, hc_id, rec_status, action_by, action_on, action_type, plant_id, insertion_type) FROM stdin;
    erp          postgres    false    409   >@      ?          0    213511    trn_plant_office_inward 
   TABLE DATA           9  COPY erp.trn_plant_office_inward (po_iw_id, hc_id, plant_id, vendor_id, po_id, veh_no, item_id, inward_date, isqc_apply, isqc_accept_reject, rec_status, action_by, action_on, poi_code, poi_no, fy_id, ref_invoice_no, ref_invoice_date, ref_challan_no, ref_challan_date, note, insertion_type, file_path) FROM stdin;
    erp          postgres    false    410   ?@      ?          0    213525    trn_plant_office_inward_log 
   TABLE DATA           9  COPY erp.trn_plant_office_inward_log (trans_id, po_iw_id, hc_id, plant_id, vendor_id, po_id, veh_no, item_id, inward_date, isqc_apply, isqc_accept_reject, poi_code, poi_no, fy_id, ref_invoice_no, ref_invoice_date, ref_challan_no, ref_challan_date, note, rec_status, action_by, action_on, action_type) FROM stdin;
    erp          postgres    false    411   B      ?          0    213538    trn_plant_office_outward 
   TABLE DATA             COPY erp.trn_plant_office_outward (po_ow_id, hc_id, plant_id, client_id, so_id, veh_no, item_id, outward_date, isqc_apply, isqc_accept_reject, rec_status, action_by, action_on, po_ow_code, po_ow_no, fy_id, ref_invoice_id, ref_challan_id, note, insertion_type) FROM stdin;
    erp          postgres    false    412   C      ?          0    213552    trn_plant_office_outward_log 
   TABLE DATA           ,  COPY erp.trn_plant_office_outward_log (trans_id, po_ow_id, hc_id, plant_id, po_ow_code, po_ow_no, client_id, so_id, veh_no, item_id, outward_date, isqc_apply, isqc_accept_reject, rec_status, action_by, action_on, fy_id, ref_invoice_id, ref_dchallan_id, note, action_type, insertion_type) FROM stdin;
    erp          postgres    false    413   bC      ?          0    213566    trn_po 
   TABLE DATA             COPY erp.trn_po (po_id, vendor_id, fy_id, po_date, po_code, po_finalized, note, po_finalized_date, rec_status, action_by, action_on, hc_id, po_no, po_version, con_id, plant_id, sap_po_code, sap_po_id, insertion_type, file_path, import_trans_id) FROM stdin;
    erp          postgres    false    414   ?C      ?          0    213580    trn_po_item 
   TABLE DATA           ?   COPY erp.trn_po_item (poi_id, po_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    415   ?E      ?          0    213598    trn_po_item_log 
   TABLE DATA           ?   COPY erp.trn_po_item_log (po_trans_id, poi_id, po_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, action_type, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    416   gG      ?          0    213617 
   trn_po_log 
   TABLE DATA             COPY erp.trn_po_log (po_trans_id, po_id, vendor_id, fy_id, po_date, po_code, po_finalized, note, po_finalized_date, rec_status, action_by, action_on, action_type, hc_id, po_no, po_version, con_id, plant_id, sap_po_code, sap_po_id, insertion_type) FROM stdin;
    erp          postgres    false    417   J      ?          0    213630    trn_po_payment_conditions 
   TABLE DATA           ?   COPY erp.trn_po_payment_conditions (po_condition_id, po_id, condition_name, payment_condition, vendor_id, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    418   ?J      ?          0    213643    trn_po_payment_conditions_log 
   TABLE DATA           ?   COPY erp.trn_po_payment_conditions_log (trans_id, po_condition_id, po_id, condition_name, payment_condition, vendor_id, rec_status, action_by, action_on, action_type, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    419   ?J      ?          0    213656    trn_po_summary 
   TABLE DATA           ?   COPY erp.trn_po_summary (pos_id, po_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    420   JK      ?          0    213667    trn_po_summary_log 
   TABLE DATA           ?   COPY erp.trn_po_summary_log (trans_id, pos_id, po_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, action_type, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    421   ?L      ?          0    213678 '   trn_rmc_batch_detail_devicetransmission 
   TABLE DATA           ?  COPY erp.trn_rmc_batch_detail_devicetransmission (trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    422   /O      ?          0    213724 +   trn_rmc_batch_detail_devicetransmission_log 
   TABLE DATA           ?  COPY erp.trn_rmc_batch_detail_devicetransmission_log (trans_id, int_id, con_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_year, consistancy, production_qty, ordered_qty, returned_qty, withthisload, batch_size, gate1_actual, gate1_target, gate1_moisture, gate2_actual, gate2_target, gate2_moisture, gate3_actual, gate3_target, gate3_moisture, gate4_actual, gate4_target, gate4_moisture, gate5_actual, gate5_target, gate5_moisture, gate6_actual, gate6_target, gate6_moisture, cement1_actual, cement1_target, cement1_correction, cement2_actual, cement2_target, cement2_correction, cement3_actual, cement3_target, cement3_correction, cement4_actual, cement4_target, cement4_correction, filler1_actual, filler1_target, filler1_correction, water1_actual, water1_target, water1_correction, water2_actual, water2_target, water2_correction, silica_actual, silica_target, silica_correction, slurry_actual, slurry_target, slurry_correction, adm1_actual1, adm1_target1, adm1_correction1, adm1_actual2, adm1_target2, adm1_correction2, adm2_actual1, adm2_target1, adm2_correction1, adm2_actual2, adm2_target2, adm2_correction2, pigment_actual, pigment_target, batch_end_flag, hc_id, insertion_type, update_on) FROM stdin;
    erp          postgres    false    423   ?S      ?          0    213769     trn_rmc_batch_devicetransmission 
   TABLE DATA           F  COPY erp.trn_rmc_batch_devicetransmission (trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2, hc_id, so_id, insertion_type, is_dc_invoice_done, tare_weight, gross_weight, net_weight, wb_slip_no, tdate_time, docket_no) FROM stdin;
    erp          postgres    false    424   ?S      ?          0    213815 $   trn_rmc_batch_devicetransmission_log 
   TABLE DATA             COPY erp.trn_rmc_batch_devicetransmission_log (trans_id, int_id, cust_id, plant_id, wo_id, batch_no, batch_index, batch_date, batch_time, batch_time_text, batch_start_time, batch_end_time, batch_year, batcher_name, batcher_user_level, customer_code, recipe_code, recipe_name, mixing_time, mixer_capacity, site, truck_no, truck_driver, production_qty, ordered_qty, returned_qty, withthisload, batch_size, order_no, schedule_id, gate1_target, gate2_target, gate3_target, gate4_target, gate5_target, gate6_target, cement1_target, cement2_target, cement3_target, cement4_target, filler_target, water1_target, slurry_target, water2_target, silica_target, adm1_target1, adm1_target2, adm2_target1, adm2_target2, hc_id, so_id, insertion_type, update_on, is_dc_invoice_done) FROM stdin;
    erp          postgres    false    425   DW      ?          0    213856    trn_role_screens 
   TABLE DATA           ?   COPY erp.trn_role_screens (trans_id, role_id, screen_uiaction_id, screen_index, rec_status, action_by, action_on, plant_id, hc_id) FROM stdin;
    erp          postgres    false    426   aW      ?          0    213864    trn_screen_uiactions 
   TABLE DATA           o   COPY erp.trn_screen_uiactions (trans_id, screen_id, uiaction_id, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    427   zX      ?          0    213871    trn_so 
   TABLE DATA           *  COPY erp.trn_so (so_id, cust_id, fy_id, so_date, so_code, so_finalized, note, so_finalized_date, rec_status, action_by, action_on, hc_id, so_no, con_id, sap_so_code, sap_so_id, plant_id, term_of_payment, term_of_delivery, site_id, ref_po_no, insertion_type, file_path, import_trans_id) FROM stdin;
    erp          postgres    false    428   GY      ?          0    213885    trn_so_designmix 
   TABLE DATA           ?   COPY erp.trn_so_designmix (so_dmix_id, soi_id, so_id, so_item_id, hc_id, plant_id, dmix_item_name, dmix_item_subid, qty, rec_status, action_by, action_on, insertion_type) FROM stdin;
    erp          postgres    false    429   ?Z      ?          0    213895    trn_so_item 
   TABLE DATA           ?   COPY erp.trn_so_item (soi_id, so_id, item_id, item_qty, item_amt, disc_percent, rec_status, action_by, action_on, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, hc_id, plant_id, dmix_id, so_type, insertion_type) FROM stdin;
    erp          postgres    false    430   ?Z      ?          0    213915    trn_so_item_log 
   TABLE DATA           ?   COPY erp.trn_so_item_log (trans_id, soi_id, so_id, item_id, item_qty, item_amt, disc_percent, item_desc, unit_rate, cgst_rate, sgst_rate, igst_rate, rec_status, action_by, action_on, action_type, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    431   E]      ?          0    213933 
   trn_so_log 
   TABLE DATA           )  COPY erp.trn_so_log (trans_id, so_id, cust_id, fy_id, so_date, so_code, so_finalized, note, so_finalized_date, rec_status, action_by, action_on, hc_id, so_no, action_type, con_id, sap_so_code, sap_so_id, plant_id, term_of_payment, term_of_delivery, site_id, ref_po_no, insertion_type) FROM stdin;
    erp          postgres    false    432   ?a      ?          0    213946    trn_so_order_details 
   TABLE DATA           ?  COPY erp.trn_so_order_details (so_ord_detail_id, so_id, order_no, order_date, order_name, cust_id, order_cust_name, customer_code, ordered_recipe, ordered_for_site, ordered_qty, production_qty, aggregate_used, cement_used, water_used, admixture_used, truck_no, withthisload, type_pump, total_order, total_with_this_load, max_cem, wcratio, sap_id, hc_id, plant_id, rec_status, action_by, action_on, insertion_type) FROM stdin;
    erp          postgres    false    433   Ae      ?          0    213979    trn_so_summary 
   TABLE DATA           ?   COPY erp.trn_so_summary (sos_id, so_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, plant_id, hc_id, insertion_type) FROM stdin;
    erp          postgres    false    434   ^e      ?          0    213990    trn_so_summary_log 
   TABLE DATA           ?   COPY erp.trn_so_summary_log (trans_id, sos_id, so_id, net_tot_amt, disc_percent, disc_amt, grand_tot_amt, remarks, rec_status, action_by, action_on, action_type, plant_id, hc_id) FROM stdin;
    erp          postgres    false    435   Kf      ?          0    214000 	   trn_stock 
   TABLE DATA           ?   COPY erp.trn_stock (stock_id, item_id, inward_quantity, outward_quantity, balance_quantity, note, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    436   +i      ?          0    214010    trn_stock_log 
   TABLE DATA           ?   COPY erp.trn_stock_log (stock_id, item_id, inward_quantity, outward_quantity, balance_quantity, note, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    437   ?i      ?          0    214016    trn_summary_dashboard_record 
   TABLE DATA           ?   COPY erp.trn_summary_dashboard_record (trans_id, fy_id, hc_id, plant_id, vendor_site_id, vendor_site_type, item_id, item_qty, item_amt, so_po_qty, so_po_amt, description, last_modify_date, rec_status, action_by, action_on, insertion_type) FROM stdin;
    erp          postgres    false    438   cj      ?          0    214029    trn_summary_stock_level 
   TABLE DATA           ?   COPY erp.trn_summary_stock_level (trans_id, fy_id, hc_id, plant_id, dc_id, grn_id, item_id, inward_item_qty, inward_item_amt, outward_item_qty, outward_item_amt, description, last_modify_date, rec_status, action_by, action_on, insertion_type) FROM stdin;
    erp          postgres    false    439   ?j      ?          0    214041    trn_user_roles 
   TABLE DATA           c   COPY erp.trn_user_roles (trans_id, user_id, role_id, rec_status, action_by, action_on) FROM stdin;
    erp          postgres    false    440   ?j      ?          0    211710    trn_weiging_bridge_log 
   TABLE DATA           m  COPY erp.trn_weiging_bridge_log (trans_id, weg_bridge_id, hc_id, plant_id, po_so_id, po_so_type, in_date, in_time, out_date, out_time, log_type, in_weight, out_weight, gross_weight, tear_weight, net_weight, material_type_id, material_type_name, veh_id, veh_name, rec_status, action_by, action_on, po_iw_so_ow_id, insertion_type, is_grn_dc_invoice_done) FROM stdin;
    erp          postgres    false    207   ?j      ?          0    214048 "   trn_weiging_bridge_log_wthout_poso 
   TABLE DATA           ;  COPY erp.trn_weiging_bridge_log_wthout_poso (trans_id, weg_bridge_id, hc_id, plant_id, in_date, in_time, out_date, out_time, log_type, in_weight, out_weight, gross_weight, tear_weight, net_weight, material_type_id, material_type_name, veh_id, veh_name, rec_status, action_by, action_on, insertion_type) FROM stdin;
    erp          postgres    false    441   ?k      ?          0    214438 
   temp_table 
   TABLE DATA           u   COPY public.temp_table (trans_id, unitid, catid, item_description, itemtype, item_no, hsn_code, plantid) FROM stdin;
    public          postgres    false    499   ?k      ?          0    214444    trn_designmix 
   TABLE DATA           ?   COPY public.trn_designmix (dmix_id, item_id, hc_id, plant_id, dmix_item_name, dmix_item_subid, qty, rec_status, action_by, action_on) FROM stdin;
    public          postgres    false    500   ]l      ?          0    214451    trn_so_designmix 
   TABLE DATA           ?   COPY public.trn_so_designmix (so_dmix_id, soi_id, so_id, so_item_id, hc_id, plant_id, dmix_item_name, dmix_item_subid, qty, rec_status, action_by, action_on) FROM stdin;
    public          postgres    false    501   zl      ?           0    0    mst_employee_contact_con_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('erp.mst_employee_contact_con_id_seq', 10, true);
          erp          postgres    false    231            ?           0    0    mstempl_info_emp_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('erp.mstempl_info_emp_id_seq', 14, true);
          erp          postgres    false    302            ?           0    0    seq_alert_config    SEQUENCE SET     <   SELECT pg_catalog.setval('erp.seq_alert_config', 1, false);
          erp          postgres    false    209            ?           0    0    seq_alert_sent    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_alert_sent', 1, false);
          erp          postgres    false    318            ?           0    0    seq_bpa_details    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_bpa_details', 1, true);
          erp          postgres    false    319            ?           0    0    seq_bpa_info    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_bpa_info', 9, true);
          erp          postgres    false    320            ?           0    0    seq_bpa_info_log    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_bpa_info_log', 8, true);
          erp          postgres    false    321            ?           0    0    seq_card_access_transaction    SEQUENCE SET     G   SELECT pg_catalog.setval('erp.seq_card_access_transaction', 1, false);
          erp          postgres    false    322            ?           0    0    seq_card_allocation    SEQUENCE SET     >   SELECT pg_catalog.setval('erp.seq_card_allocation', 5, true);
          erp          postgres    false    323            ?           0    0    seq_card_allocation_log    SEQUENCE SET     B   SELECT pg_catalog.setval('erp.seq_card_allocation_log', 5, true);
          erp          postgres    false    324            ?           0    0    seq_cust_vendor_contact    SEQUENCE SET     B   SELECT pg_catalog.setval('erp.seq_cust_vendor_contact', 8, true);
          erp          postgres    false    214            ?           0    0 "   seq_cust_vendor_payment_conditions    SEQUENCE SET     M   SELECT pg_catalog.setval('erp.seq_cust_vendor_payment_conditions', 1, true);
          erp          postgres    false    219            ?           0    0    seq_customer    SEQUENCE SET     8   SELECT pg_catalog.setval('erp.seq_customer', 69, true);
          erp          postgres    false    221            ?           0    0    seq_dc_info    SEQUENCE SET     6   SELECT pg_catalog.setval('erp.seq_dc_info', 2, true);
          erp          postgres    false    325            ?           0    0    seq_dc_info_log    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_dc_info_log', 4, true);
          erp          postgres    false    326            ?           0    0    seq_dc_item    SEQUENCE SET     6   SELECT pg_catalog.setval('erp.seq_dc_item', 4, true);
          erp          postgres    false    327            ?           0    0    seq_dc_item_log    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_dc_item_log', 4, true);
          erp          postgres    false    328            ?           0    0    seq_dc_summary    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_dc_summary', 2, true);
          erp          postgres    false    329            ?           0    0    seq_dc_summary_log    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_dc_summary_log', 3, true);
          erp          postgres    false    330            ?           0    0    seq_department    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_department', 1, false);
          erp          postgres    false    224            ?           0    0    seq_designmix    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_designmix', 37, true);
          erp          postgres    false    331            ?           0    0    seq_designmix_details    SEQUENCE SET     A   SELECT pg_catalog.setval('erp.seq_designmix_details', 23, true);
          erp          postgres    false    332            ?           0    0    seq_designmix_details_log    SEQUENCE SET     E   SELECT pg_catalog.setval('erp.seq_designmix_details_log', 1, false);
          erp          postgres    false    333            ?           0    0    seq_designmix_log    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_designmix_log', 26, true);
          erp          postgres    false    334            ?           0    0    seq_diesel_refill    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_diesel_refill', 1, false);
          erp          postgres    false    335            ?           0    0    seq_diesel_type    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_diesel_type', 1, false);
          erp          postgres    false    226            ?           0    0    seq_emp_bioprofile    SEQUENCE SET     >   SELECT pg_catalog.setval('erp.seq_emp_bioprofile', 1, false);
          erp          postgres    false    303            ?           0    0    seq_emp_doc    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_emp_doc', 1, false);
          erp          postgres    false    306            ?           0    0    seq_emp_guardian    SEQUENCE SET     <   SELECT pg_catalog.setval('erp.seq_emp_guardian', 1, false);
          erp          postgres    false    308            ?           0    0    seq_emp_professional_summary    SEQUENCE SET     H   SELECT pg_catalog.setval('erp.seq_emp_professional_summary', 1, false);
          erp          postgres    false    310            ?           0    0    seq_emp_wish_date    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_emp_wish_date', 1, false);
          erp          postgres    false    312            ?           0    0    seq_employee    SEQUENCE SET     8   SELECT pg_catalog.setval('erp.seq_employee', 1, false);
          erp          postgres    false    228            ?           0    0    seq_file_detail    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_file_detail', 1, true);
          erp          postgres    false    208            ?           0    0    seq_finyear    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_finyear', 1, false);
          erp          postgres    false    232            ?           0    0    seq_grn_info    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_grn_info', 120, true);
          erp          postgres    false    336            ?           0    0    seq_grn_info_log    SEQUENCE SET     <   SELECT pg_catalog.setval('erp.seq_grn_info_log', 49, true);
          erp          postgres    false    337            ?           0    0    seq_hmb_bmp_devicetransmission    SEQUENCE SET     J   SELECT pg_catalog.setval('erp.seq_hmb_bmp_devicetransmission', 1, false);
          erp          postgres    false    338            ?           0    0    seq_hmb_dmp_devicetransmission    SEQUENCE SET     J   SELECT pg_catalog.setval('erp.seq_hmb_dmp_devicetransmission', 1, false);
          erp          postgres    false    339            ?           0    0    seq_host_company    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_host_company', 6, true);
          erp          postgres    false    237            ?           0    0    seq_integrator    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_integrator', 2, true);
          erp          postgres    false    240            ?           0    0    seq_integrator_config    SEQUENCE SET     A   SELECT pg_catalog.setval('erp.seq_integrator_config', 1, false);
          erp          postgres    false    242            ?           0    0    seq_invoice_info    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_invoice_info', 3, true);
          erp          postgres    false    340            ?           0    0    seq_invoice_info_log    SEQUENCE SET     ?   SELECT pg_catalog.setval('erp.seq_invoice_info_log', 9, true);
          erp          postgres    false    341            ?           0    0    seq_invoice_item    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_invoice_item', 2, true);
          erp          postgres    false    342            ?           0    0    seq_invoice_item_log    SEQUENCE SET     ?   SELECT pg_catalog.setval('erp.seq_invoice_item_log', 3, true);
          erp          postgres    false    343            ?           0    0    seq_invoice_summary    SEQUENCE SET     >   SELECT pg_catalog.setval('erp.seq_invoice_summary', 2, true);
          erp          postgres    false    344            ?           0    0    seq_invoice_summary_log    SEQUENCE SET     B   SELECT pg_catalog.setval('erp.seq_invoice_summary_log', 3, true);
          erp          postgres    false    345            ?           0    0    seq_item    SEQUENCE SET     4   SELECT pg_catalog.setval('erp.seq_item', 58, true);
          erp          postgres    false    245            ?           0    0    seq_item_category    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_item_category', 27, true);
          erp          postgres    false    247            ?           0    0    seq_item_log    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_item_log', 148, true);
          erp          postgres    false    250            ?           0    0    seq_mst_card    SEQUENCE SET     8   SELECT pg_catalog.setval('erp.seq_mst_card', 1, false);
          erp          postgres    false    211            ?           0    0    seq_mst_general_ledger    SEQUENCE SET     B   SELECT pg_catalog.setval('erp.seq_mst_general_ledger', 1, false);
          erp          postgres    false    234            ?           0    0    seq_name_setup    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_name_setup', 2, true);
          erp          postgres    false    252            ?           0    0    seq_notification    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_notification', 1, true);
          erp          postgres    false    314            ?           0    0    seq_notification_log    SEQUENCE SET     ?   SELECT pg_catalog.setval('erp.seq_notification_log', 1, true);
          erp          postgres    false    316            ?           0    0    seq_payment_other_conditions    SEQUENCE SET     H   SELECT pg_catalog.setval('erp.seq_payment_other_conditions', 1, false);
          erp          postgres    false    255            ?           0    0 	   seq_plant    SEQUENCE SET     5   SELECT pg_catalog.setval('erp.seq_plant', 15, true);
          erp          postgres    false    258            ?           0    0    seq_plant_office_inward    SEQUENCE SET     C   SELECT pg_catalog.setval('erp.seq_plant_office_inward', 11, true);
          erp          postgres    false    346            ?           0    0    seq_plant_office_inward_log    SEQUENCE SET     G   SELECT pg_catalog.setval('erp.seq_plant_office_inward_log', 11, true);
          erp          postgres    false    347            ?           0    0    seq_plant_office_outward    SEQUENCE SET     C   SELECT pg_catalog.setval('erp.seq_plant_office_outward', 3, true);
          erp          postgres    false    348            ?           0    0    seq_plant_office_outward_log    SEQUENCE SET     G   SELECT pg_catalog.setval('erp.seq_plant_office_outward_log', 1, true);
          erp          postgres    false    349            ?           0    0    seq_po    SEQUENCE SET     3   SELECT pg_catalog.setval('erp.seq_po', 135, true);
          erp          postgres    false    350            ?           0    0    seq_po_item    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_po_item', 49, true);
          erp          postgres    false    351            ?           0    0    seq_po_item_log    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_po_item_log', 66, true);
          erp          postgres    false    352            ?           0    0 
   seq_po_log    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_po_log', 110, true);
          erp          postgres    false    353            ?           0    0    seq_po_payment_conditions    SEQUENCE SET     E   SELECT pg_catalog.setval('erp.seq_po_payment_conditions', 11, true);
          erp          postgres    false    354            ?           0    0    seq_po_payment_conditions_log    SEQUENCE SET     H   SELECT pg_catalog.setval('erp.seq_po_payment_conditions_log', 2, true);
          erp          postgres    false    355            ?           0    0    seq_po_summary    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_po_summary', 28, true);
          erp          postgres    false    356            ?           0    0    seq_po_summary_log    SEQUENCE SET     >   SELECT pg_catalog.setval('erp.seq_po_summary_log', 42, true);
          erp          postgres    false    357            ?           0    0    seq_presetdata    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_presetdata', 143, true);
          erp          postgres    false    261            ?           0    0 '   seq_rmc_batch_detail_devicetransmission    SEQUENCE SET     S   SELECT pg_catalog.setval('erp.seq_rmc_batch_detail_devicetransmission', 1, false);
          erp          postgres    false    358            ?           0    0     seq_rmc_batch_devicetransmission    SEQUENCE SET     K   SELECT pg_catalog.setval('erp.seq_rmc_batch_devicetransmission', 2, true);
          erp          postgres    false    359            ?           0    0    seq_role    SEQUENCE SET     4   SELECT pg_catalog.setval('erp.seq_role', 10, true);
          erp          postgres    false    264            ?           0    0    seq_role_screens    SEQUENCE SET     <   SELECT pg_catalog.setval('erp.seq_role_screens', 36, true);
          erp          postgres    false    360            ?           0    0 
   seq_screen    SEQUENCE SET     6   SELECT pg_catalog.setval('erp.seq_screen', 12, true);
          erp          postgres    false    267            ?           0    0    seq_screen_uiactions    SEQUENCE SET     @   SELECT pg_catalog.setval('erp.seq_screen_uiactions', 24, true);
          erp          postgres    false    361            ?           0    0    seq_site    SEQUENCE SET     4   SELECT pg_catalog.setval('erp.seq_site', 21, true);
          erp          postgres    false    269            ?           0    0    seq_site_contact    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_site_contact', 9, true);
          erp          postgres    false    271            ?           0    0    seq_so    SEQUENCE SET     2   SELECT pg_catalog.setval('erp.seq_so', 22, true);
          erp          postgres    false    362            ?           0    0    seq_so_designmix    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_so_designmix', 1, true);
          erp          postgres    false    363            ?           0    0    seq_so_info    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_so_info', 1, false);
          erp          postgres    false    364            ?           0    0    seq_so_info_log    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_so_info_log', 1, false);
          erp          postgres    false    365            ?           0    0    seq_so_item    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_so_item', 16, true);
          erp          postgres    false    366            ?           0    0    seq_so_item_log    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_so_item_log', 53, true);
          erp          postgres    false    367            ?           0    0 
   seq_so_log    SEQUENCE SET     6   SELECT pg_catalog.setval('erp.seq_so_log', 57, true);
          erp          postgres    false    368            ?           0    0    seq_so_order_details    SEQUENCE SET     @   SELECT pg_catalog.setval('erp.seq_so_order_details', 1, false);
          erp          postgres    false    369            ?           0    0    seq_so_summary    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_so_summary', 23, true);
          erp          postgres    false    370            ?           0    0    seq_so_summary_log    SEQUENCE SET     >   SELECT pg_catalog.setval('erp.seq_so_summary_log', 49, true);
          erp          postgres    false    371            ?           0    0 	   seq_state    SEQUENCE SET     4   SELECT pg_catalog.setval('erp.seq_state', 3, true);
          erp          postgres    false    275            ?           0    0    seq_subtestmaster    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_subtestmaster', 1, false);
          erp          postgres    false    277            ?           0    0    seq_summary_dashboard_record    SEQUENCE SET     H   SELECT pg_catalog.setval('erp.seq_summary_dashboard_record', 1, false);
          erp          postgres    false    372            ?           0    0    seq_summary_stock_level    SEQUENCE SET     C   SELECT pg_catalog.setval('erp.seq_summary_stock_level', 1, false);
          erp          postgres    false    373            ?           0    0    seq_testmaster    SEQUENCE SET     :   SELECT pg_catalog.setval('erp.seq_testmaster', 1, false);
          erp          postgres    false    279            ?           0    0    seq_trn_ledger_transcation    SEQUENCE SET     E   SELECT pg_catalog.setval('erp.seq_trn_ledger_transcation', 3, true);
          erp          postgres    false    374            ?           0    0    seq_trn_ledger_transcation_log    SEQUENCE SET     I   SELECT pg_catalog.setval('erp.seq_trn_ledger_transcation_log', 3, true);
          erp          postgres    false    375            ?           0    0    seq_trn_stock    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_trn_stock', 13, true);
          erp          postgres    false    376            ?           0    0    seq_trn_weiging_bridge_log    SEQUENCE SET     F   SELECT pg_catalog.setval('erp.seq_trn_weiging_bridge_log', 27, true);
          erp          postgres    false    206            ?           0    0    seq_uiaction    SEQUENCE SET     7   SELECT pg_catalog.setval('erp.seq_uiaction', 6, true);
          erp          postgres    false    281            ?           0    0    seq_unit    SEQUENCE SET     4   SELECT pg_catalog.setval('erp.seq_unit', 13, true);
          erp          postgres    false    283            ?           0    0    seq_user    SEQUENCE SET     3   SELECT pg_catalog.setval('erp.seq_user', 4, true);
          erp          postgres    false    286            ?           0    0    seq_user_roles    SEQUENCE SET     9   SELECT pg_catalog.setval('erp.seq_user_roles', 5, true);
          erp          postgres    false    377            ?           0    0    seq_vehicle    SEQUENCE SET     6   SELECT pg_catalog.setval('erp.seq_vehicle', 7, true);
          erp          postgres    false    289            ?           0    0    seq_vehicle_insurance    SEQUENCE SET     @   SELECT pg_catalog.setval('erp.seq_vehicle_insurance', 1, true);
          erp          postgres    false    291            ?           0    0 
   seq_vendor    SEQUENCE SET     6   SELECT pg_catalog.setval('erp.seq_vendor', 10, true);
          erp          postgres    false    295            ?           0    0    seq_vendor_contact    SEQUENCE SET     =   SELECT pg_catalog.setval('erp.seq_vendor_contact', 3, true);
          erp          postgres    false    297            ?           0    0    seq_vendor_item    SEQUENCE SET     ;   SELECT pg_catalog.setval('erp.seq_vendor_item', 1, false);
          erp          postgres    false    217            ?           0    0    seq_weigh_bridge    SEQUENCE SET     <   SELECT pg_catalog.setval('erp.seq_weigh_bridge', 1, false);
          erp          postgres    false    299            ?           0    0 "   seq_weiging_bridge_log_wthout_poso    SEQUENCE SET     N   SELECT pg_catalog.setval('erp.seq_weiging_bridge_log_wthout_poso', 1, false);
          erp          postgres    false    378            ?           0    0    seq_wo    SEQUENCE SET     1   SELECT pg_catalog.setval('erp.seq_wo', 5, true);
          erp          postgres    false    379            ?           0    0    seq_work_allocation    SEQUENCE SET     ?   SELECT pg_catalog.setval('erp.seq_work_allocation', 1, false);
          erp          postgres    false    380            ?           2606    214472 .   mst_employee_contact mst_employee_contact_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY erp.mst_employee_contact
    ADD CONSTRAINT mst_employee_contact_pkey PRIMARY KEY (con_id);
 U   ALTER TABLE ONLY erp.mst_employee_contact DROP CONSTRAINT mst_employee_contact_pkey;
       erp            postgres    false    230            ?           2606    214474    mst_item_log mst_item_log_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mst_item_log
    ADD CONSTRAINT mst_item_log_pkey PRIMARY KEY (trans_id);
 E   ALTER TABLE ONLY erp.mst_item_log DROP CONSTRAINT mst_item_log_pkey;
       erp            postgres    false    251            ?           2606    214476    mstempl_info mstempl_info_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY erp.mstempl_info
    ADD CONSTRAINT mstempl_info_pkey PRIMARY KEY (emp_id);
 E   ALTER TABLE ONLY erp.mstempl_info DROP CONSTRAINT mstempl_info_pkey;
       erp            postgres    false    301                        2606    214478    mtn_emp_doc mtn_emp_doc_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mtn_emp_doc
    ADD CONSTRAINT mtn_emp_doc_pkey PRIMARY KEY (emp_doc_id);
 C   ALTER TABLE ONLY erp.mtn_emp_doc DROP CONSTRAINT mtn_emp_doc_pkey;
       erp            postgres    false    307                       2606    214480 &   mtn_emp_guardian mtn_emp_guardian_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY erp.mtn_emp_guardian
    ADD CONSTRAINT mtn_emp_guardian_pkey PRIMARY KEY (eg_id);
 M   ALTER TABLE ONLY erp.mtn_emp_guardian DROP CONSTRAINT mtn_emp_guardian_pkey;
       erp            postgres    false    309                       2606    214482 5   mtn_emp_professional_summary mtn_emp_profsummary_pkey 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mtn_emp_professional_summary
    ADD CONSTRAINT mtn_emp_profsummary_pkey PRIMARY KEY (emp_profsummary_id);
 \   ALTER TABLE ONLY erp.mtn_emp_professional_summary DROP CONSTRAINT mtn_emp_profsummary_pkey;
       erp            postgres    false    311                       2606    214484 &   notification_log notification_log_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY erp.notification_log
    ADD CONSTRAINT notification_log_pkey PRIMARY KEY (trns_id);
 M   ALTER TABLE ONLY erp.notification_log DROP CONSTRAINT notification_log_pkey;
       erp            postgres    false    317                       2606    214486    notification notification_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY erp.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (sr_id);
 E   ALTER TABLE ONLY erp.notification DROP CONSTRAINT notification_pkey;
       erp            postgres    false    315            n           2606    214488 $   mst_alert_config pk_alertconfig_acid 
   CONSTRAINT     b   ALTER TABLE ONLY erp.mst_alert_config
    ADD CONSTRAINT pk_alertconfig_acid PRIMARY KEY (ac_id);
 K   ALTER TABLE ONLY erp.mst_alert_config DROP CONSTRAINT pk_alertconfig_acid;
       erp            postgres    false    210                       2606    214490 #   trn_alert_sent pk_alertsent_transid 
   CONSTRAINT     d   ALTER TABLE ONLY erp.trn_alert_sent
    ADD CONSTRAINT pk_alertsent_transid PRIMARY KEY (trans_id);
 J   ALTER TABLE ONLY erp.trn_alert_sent DROP CONSTRAINT pk_alertsent_transid;
       erp            postgres    false    381            ?           2606    214492 *   mtn_emp_bioprofile pk_bioprofile_bioprofid 
   CONSTRAINT     m   ALTER TABLE ONLY erp.mtn_emp_bioprofile
    ADD CONSTRAINT pk_bioprofile_bioprofid PRIMARY KEY (bioprof_id);
 Q   ALTER TABLE ONLY erp.mtn_emp_bioprofile DROP CONSTRAINT pk_bioprofile_bioprofid;
       erp            postgres    false    304                       2606    214494    trn_bpa_info pk_bpa_bpaid 
   CONSTRAINT     X   ALTER TABLE ONLY erp.trn_bpa_info
    ADD CONSTRAINT pk_bpa_bpaid PRIMARY KEY (bpa_id);
 @   ALTER TABLE ONLY erp.trn_bpa_info DROP CONSTRAINT pk_bpa_bpaid;
       erp            postgres    false    384                       2606    214496    trn_bpa_info_log pk_bpa_transid 
   CONSTRAINT     `   ALTER TABLE ONLY erp.trn_bpa_info_log
    ADD CONSTRAINT pk_bpa_transid PRIMARY KEY (trans_id);
 F   ALTER TABLE ONLY erp.trn_bpa_info_log DROP CONSTRAINT pk_bpa_transid;
       erp            postgres    false    385                       2606    214498    trn_bpa_details pk_bpadt_bpaid 
   CONSTRAINT     `   ALTER TABLE ONLY erp.trn_bpa_details
    ADD CONSTRAINT pk_bpadt_bpaid PRIMARY KEY (bpa_dt_id);
 E   ALTER TABLE ONLY erp.trn_bpa_details DROP CONSTRAINT pk_bpadt_bpaid;
       erp            postgres    false    382            ?           2606    214500     mst_weigh_bridge pk_bridge_wegno 
   CONSTRAINT     f   ALTER TABLE ONLY erp.mst_weigh_bridge
    ADD CONSTRAINT pk_bridge_wegno PRIMARY KEY (weg_bridge_id);
 G   ALTER TABLE ONLY erp.mst_weigh_bridge DROP CONSTRAINT pk_bridge_wegno;
       erp            postgres    false    300                       2606    214502 2   trn_card_access_transaction pk_card_access_transid 
   CONSTRAINT     s   ALTER TABLE ONLY erp.trn_card_access_transaction
    ADD CONSTRAINT pk_card_access_transid PRIMARY KEY (trans_id);
 Y   ALTER TABLE ONLY erp.trn_card_access_transaction DROP CONSTRAINT pk_card_access_transid;
       erp            postgres    false    386                       2606    214504 .   trn_card_allocation pk_card_allocation_transid 
   CONSTRAINT     y   ALTER TABLE ONLY erp.trn_card_allocation
    ADD CONSTRAINT pk_card_allocation_transid PRIMARY KEY (card_allocation_id);
 U   ALTER TABLE ONLY erp.trn_card_allocation DROP CONSTRAINT pk_card_allocation_transid;
       erp            postgres    false    387            t           2606    214506    mst_card pk_card_cardid 
   CONSTRAINT     W   ALTER TABLE ONLY erp.mst_card
    ADD CONSTRAINT pk_card_cardid PRIMARY KEY (card_id);
 >   ALTER TABLE ONLY erp.mst_card DROP CONSTRAINT pk_card_cardid;
       erp            postgres    false    212            ?           2606    214508 "   mst_customer_vendor pk_cust_custid 
   CONSTRAINT     i   ALTER TABLE ONLY erp.mst_customer_vendor
    ADD CONSTRAINT pk_cust_custid PRIMARY KEY (cust_vendor_id);
 I   ALTER TABLE ONLY erp.mst_customer_vendor DROP CONSTRAINT pk_cust_custid;
       erp            postgres    false    222            x           2606    214510 ,   mst_cust_vendor_contact pk_custcontact_conid 
   CONSTRAINT     k   ALTER TABLE ONLY erp.mst_cust_vendor_contact
    ADD CONSTRAINT pk_custcontact_conid PRIMARY KEY (con_id);
 S   ALTER TABLE ONLY erp.mst_cust_vendor_contact DROP CONSTRAINT pk_custcontact_conid;
       erp            postgres    false    215                       2606    214512    trn_dc_info pk_dc_dcinfoid 
   CONSTRAINT     X   ALTER TABLE ONLY erp.trn_dc_info
    ADD CONSTRAINT pk_dc_dcinfoid PRIMARY KEY (dc_id);
 A   ALTER TABLE ONLY erp.trn_dc_info DROP CONSTRAINT pk_dc_dcinfoid;
       erp            postgres    false    389            "           2606    214514    trn_dc_info_log pk_dc_trans_id 
   CONSTRAINT     _   ALTER TABLE ONLY erp.trn_dc_info_log
    ADD CONSTRAINT pk_dc_trans_id PRIMARY KEY (trans_id);
 E   ALTER TABLE ONLY erp.trn_dc_info_log DROP CONSTRAINT pk_dc_trans_id;
       erp            postgres    false    390            $           2606    214516    trn_dc_item pk_dcitem_dciid 
   CONSTRAINT     Z   ALTER TABLE ONLY erp.trn_dc_item
    ADD CONSTRAINT pk_dcitem_dciid PRIMARY KEY (dci_id);
 B   ALTER TABLE ONLY erp.trn_dc_item DROP CONSTRAINT pk_dcitem_dciid;
       erp            postgres    false    391            &           2606    214518 %   trn_dc_item_log pk_dcitemlog_trans_id 
   CONSTRAINT     f   ALTER TABLE ONLY erp.trn_dc_item_log
    ADD CONSTRAINT pk_dcitemlog_trans_id PRIMARY KEY (trans_id);
 L   ALTER TABLE ONLY erp.trn_dc_item_log DROP CONSTRAINT pk_dcitemlog_trans_id;
       erp            postgres    false    392            (           2606    214520 !   trn_dc_summary pk_dcsummary_dcsid 
   CONSTRAINT     `   ALTER TABLE ONLY erp.trn_dc_summary
    ADD CONSTRAINT pk_dcsummary_dcsid PRIMARY KEY (dcs_id);
 H   ALTER TABLE ONLY erp.trn_dc_summary DROP CONSTRAINT pk_dcsummary_dcsid;
       erp            postgres    false    393            *           2606    214522 *   trn_dc_summary_log pk_dcsummarylg_trans_id 
   CONSTRAINT     k   ALTER TABLE ONLY erp.trn_dc_summary_log
    ADD CONSTRAINT pk_dcsummarylg_trans_id PRIMARY KEY (trans_id);
 Q   ALTER TABLE ONLY erp.trn_dc_summary_log DROP CONSTRAINT pk_dcsummarylg_trans_id;
       erp            postgres    false    394            ?           2606    214524    mst_department pk_dept_deptid 
   CONSTRAINT     ]   ALTER TABLE ONLY erp.mst_department
    ADD CONSTRAINT pk_dept_deptid PRIMARY KEY (dept_id);
 D   ALTER TABLE ONLY erp.mst_department DROP CONSTRAINT pk_dept_deptid;
       erp            postgres    false    225            2           2606    214526    trn_diesel_refill pk_diesel_id 
   CONSTRAINT     `   ALTER TABLE ONLY erp.trn_diesel_refill
    ADD CONSTRAINT pk_diesel_id PRIMARY KEY (diesel_id);
 E   ALTER TABLE ONLY erp.trn_diesel_refill DROP CONSTRAINT pk_diesel_id;
       erp            postgres    false    397            ?           2606    214528    mst_diesel_type pk_diesetl_id 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mst_diesel_type
    ADD CONSTRAINT pk_diesetl_id PRIMARY KEY (diesel_id);
 D   ALTER TABLE ONLY erp.mst_diesel_type DROP CONSTRAINT pk_diesetl_id;
       erp            postgres    false    227            ,           2606    214530    trn_designmix pk_dmix_dmixid 
   CONSTRAINT     \   ALTER TABLE ONLY erp.trn_designmix
    ADD CONSTRAINT pk_dmix_dmixid PRIMARY KEY (dmix_id);
 C   ALTER TABLE ONLY erp.trn_designmix DROP CONSTRAINT pk_dmix_dmixid;
       erp            postgres    false    395            r           2606    214532 !   trn_so_designmix pk_dmix_sodmixid 
   CONSTRAINT     d   ALTER TABLE ONLY erp.trn_so_designmix
    ADD CONSTRAINT pk_dmix_sodmixid PRIMARY KEY (so_dmix_id);
 H   ALTER TABLE ONLY erp.trn_so_designmix DROP CONSTRAINT pk_dmix_sodmixid;
       erp            postgres    false    429            0           2606    214534 #   trn_designmix_log pk_dmixlog_dmixid 
   CONSTRAINT     d   ALTER TABLE ONLY erp.trn_designmix_log
    ADD CONSTRAINT pk_dmixlog_dmixid PRIMARY KEY (trans_id);
 J   ALTER TABLE ONLY erp.trn_designmix_log DROP CONSTRAINT pk_dmixlog_dmixid;
       erp            postgres    false    396            ?           2606    214536    mst_employee pk_emp_empid 
   CONSTRAINT     X   ALTER TABLE ONLY erp.mst_employee
    ADD CONSTRAINT pk_emp_empid PRIMARY KEY (emp_id);
 @   ALTER TABLE ONLY erp.mst_employee DROP CONSTRAINT pk_emp_empid;
       erp            postgres    false    229                       2606    214538 &   mtn_emp_wish_date pk_empwishdate_ewdid 
   CONSTRAINT     e   ALTER TABLE ONLY erp.mtn_emp_wish_date
    ADD CONSTRAINT pk_empwishdate_ewdid PRIMARY KEY (ewd_id);
 M   ALTER TABLE ONLY erp.mtn_emp_wish_date DROP CONSTRAINT pk_empwishdate_ewdid;
       erp            postgres    false    313            ?           2606    214540    mst_finyear pk_finyear_fyid 
   CONSTRAINT     Y   ALTER TABLE ONLY erp.mst_finyear
    ADD CONSTRAINT pk_finyear_fyid PRIMARY KEY (fy_id);
 B   ALTER TABLE ONLY erp.mst_finyear DROP CONSTRAINT pk_finyear_fyid;
       erp            postgres    false    233            ?           2606    214542 ,   mst_general_ledger pk_general_ledger_transid 
   CONSTRAINT     m   ALTER TABLE ONLY erp.mst_general_ledger
    ADD CONSTRAINT pk_general_ledger_transid PRIMARY KEY (trans_id);
 S   ALTER TABLE ONLY erp.mst_general_ledger DROP CONSTRAINT pk_general_ledger_transid;
       erp            postgres    false    235            4           2606    214544    trn_grn_info pk_grn_grnid 
   CONSTRAINT     X   ALTER TABLE ONLY erp.trn_grn_info
    ADD CONSTRAINT pk_grn_grnid PRIMARY KEY (grn_id);
 @   ALTER TABLE ONLY erp.trn_grn_info DROP CONSTRAINT pk_grn_grnid;
       erp            postgres    false    398            8           2606    214546 D   trn_hmb_bmp_devicetransmission pk_hmb_bmp_devicetransmission_transid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_hmb_bmp_devicetransmission
    ADD CONSTRAINT pk_hmb_bmp_devicetransmission_transid PRIMARY KEY (trans_id);
 k   ALTER TABLE ONLY erp.trn_hmb_bmp_devicetransmission DROP CONSTRAINT pk_hmb_bmp_devicetransmission_transid;
       erp            postgres    false    400            :           2606    214548 D   trn_hmb_dmp_devicetransmission pk_hmb_dmp_devicetransmission_transid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_hmb_dmp_devicetransmission
    ADD CONSTRAINT pk_hmb_dmp_devicetransmission_transid PRIMARY KEY (trans_id);
 k   ALTER TABLE ONLY erp.trn_hmb_dmp_devicetransmission DROP CONSTRAINT pk_hmb_dmp_devicetransmission_transid;
       erp            postgres    false    401            ?           2606    214550 !   mst_host_company pk_hostcomp_hcid 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mst_host_company
    ADD CONSTRAINT pk_hostcomp_hcid PRIMARY KEY (hc_id);
 H   ALTER TABLE ONLY erp.mst_host_company DROP CONSTRAINT pk_hostcomp_hcid;
       erp            postgres    false    238            ?           2606    214552 ,   mst_integrator_config pk_integrator_int_i_id 
   CONSTRAINT     m   ALTER TABLE ONLY erp.mst_integrator_config
    ADD CONSTRAINT pk_integrator_int_i_id PRIMARY KEY (int_i_id);
 S   ALTER TABLE ONLY erp.mst_integrator_config DROP CONSTRAINT pk_integrator_int_i_id;
       erp            postgres    false    243            ?           2606    214554 )   mst_integrator pk_integrator_integratorid 
   CONSTRAINT     h   ALTER TABLE ONLY erp.mst_integrator
    ADD CONSTRAINT pk_integrator_integratorid PRIMARY KEY (int_id);
 P   ALTER TABLE ONLY erp.mst_integrator DROP CONSTRAINT pk_integrator_integratorid;
       erp            postgres    false    241            @           2606    214556 "   trn_invoice_item pk_invitem_inviid 
   CONSTRAINT     f   ALTER TABLE ONLY erp.trn_invoice_item
    ADD CONSTRAINT pk_invitem_inviid PRIMARY KEY (inv_item_id);
 I   ALTER TABLE ONLY erp.trn_invoice_item DROP CONSTRAINT pk_invitem_inviid;
       erp            postgres    false    404            B           2606    214558 *   trn_invoice_item_log pk_invitemlg_trans_id 
   CONSTRAINT     k   ALTER TABLE ONLY erp.trn_invoice_item_log
    ADD CONSTRAINT pk_invitemlg_trans_id PRIMARY KEY (trans_id);
 Q   ALTER TABLE ONLY erp.trn_invoice_item_log DROP CONSTRAINT pk_invitemlg_trans_id;
       erp            postgres    false    405            <           2606    214560 )   trn_invoice_info pk_invoice_invoiceinfoid 
   CONSTRAINT     l   ALTER TABLE ONLY erp.trn_invoice_info
    ADD CONSTRAINT pk_invoice_invoiceinfoid PRIMARY KEY (invoice_id);
 P   ALTER TABLE ONLY erp.trn_invoice_info DROP CONSTRAINT pk_invoice_invoiceinfoid;
       erp            postgres    false    402            D           2606    214562 0   trn_invoice_summary pk_invsummary_invoice_sum_id 
   CONSTRAINT     w   ALTER TABLE ONLY erp.trn_invoice_summary
    ADD CONSTRAINT pk_invsummary_invoice_sum_id PRIMARY KEY (invoice_sum_id);
 W   ALTER TABLE ONLY erp.trn_invoice_summary DROP CONSTRAINT pk_invsummary_invoice_sum_id;
       erp            postgres    false    406            F           2606    214564 0   trn_invoice_summary_log pk_invsummarylg_trans_id 
   CONSTRAINT     q   ALTER TABLE ONLY erp.trn_invoice_summary_log
    ADD CONSTRAINT pk_invsummarylg_trans_id PRIMARY KEY (trans_id);
 W   ALTER TABLE ONLY erp.trn_invoice_summary_log DROP CONSTRAINT pk_invsummarylg_trans_id;
       erp            postgres    false    407            ?           2606    214566    mst_item pk_item_itemid 
   CONSTRAINT     W   ALTER TABLE ONLY erp.mst_item
    ADD CONSTRAINT pk_item_itemid PRIMARY KEY (item_id);
 >   ALTER TABLE ONLY erp.mst_item DROP CONSTRAINT pk_item_itemid;
       erp            postgres    false    246            ?           2606    214568 '   mst_item_category pk_itemcategory_catid 
   CONSTRAINT     e   ALTER TABLE ONLY erp.mst_item_category
    ADD CONSTRAINT pk_itemcategory_catid PRIMARY KEY (ic_id);
 N   ALTER TABLE ONLY erp.mst_item_category DROP CONSTRAINT pk_itemcategory_catid;
       erp            postgres    false    248            J           2606    214570 0   trn_ledger_transcation_log pk_ledger_log_transid 
   CONSTRAINT     q   ALTER TABLE ONLY erp.trn_ledger_transcation_log
    ADD CONSTRAINT pk_ledger_log_transid PRIMARY KEY (trans_id);
 W   ALTER TABLE ONLY erp.trn_ledger_transcation_log DROP CONSTRAINT pk_ledger_log_transid;
       erp            postgres    false    409            H           2606    214572 (   trn_ledger_transcation pk_ledger_transid 
   CONSTRAINT     i   ALTER TABLE ONLY erp.trn_ledger_transcation
    ADD CONSTRAINT pk_ledger_transid PRIMARY KEY (trans_id);
 O   ALTER TABLE ONLY erp.trn_ledger_transcation DROP CONSTRAINT pk_ledger_transid;
       erp            postgres    false    408            |           2606    214574 -   mst_cust_vendor_item pk_mstcustitem_venitemid 
   CONSTRAINT     q   ALTER TABLE ONLY erp.mst_cust_vendor_item
    ADD CONSTRAINT pk_mstcustitem_venitemid PRIMARY KEY (ven_item_id);
 T   ALTER TABLE ONLY erp.mst_cust_vendor_item DROP CONSTRAINT pk_mstcustitem_venitemid;
       erp            postgres    false    218            ?           2606    214576    mst_name_setup pk_namesetup 
   CONSTRAINT     \   ALTER TABLE ONLY erp.mst_name_setup
    ADD CONSTRAINT pk_namesetup PRIMARY KEY (trans_id);
 B   ALTER TABLE ONLY erp.mst_name_setup DROP CONSTRAINT pk_namesetup;
       erp            postgres    false    253            ?           2606    214578 <   mst_payment_other_conditions pk_paymentcondition_conditionid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_payment_other_conditions
    ADD CONSTRAINT pk_paymentcondition_conditionid PRIMARY KEY (condition_id);
 c   ALTER TABLE ONLY erp.mst_payment_other_conditions DROP CONSTRAINT pk_paymentcondition_conditionid;
       erp            postgres    false    256            \           2606    214580 ;   trn_po_payment_conditions pk_paymentcondition_poconditionid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_po_payment_conditions
    ADD CONSTRAINT pk_paymentcondition_poconditionid PRIMARY KEY (po_condition_id);
 b   ALTER TABLE ONLY erp.trn_po_payment_conditions DROP CONSTRAINT pk_paymentcondition_poconditionid;
       erp            postgres    false    418            ?           2606    214582 K   mst_cust_vendor_payment_conditions pk_paymentvendorcondition_venconditionid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions
    ADD CONSTRAINT pk_paymentvendorcondition_venconditionid PRIMARY KEY (ven_condition_id);
 r   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions DROP CONSTRAINT pk_paymentvendorcondition_venconditionid;
       erp            postgres    false    220            ?           2606    214584    mst_plant pk_plant_plantid 
   CONSTRAINT     [   ALTER TABLE ONLY erp.mst_plant
    ADD CONSTRAINT pk_plant_plantid PRIMARY KEY (plant_id);
 A   ALTER TABLE ONLY erp.mst_plant DROP CONSTRAINT pk_plant_plantid;
       erp            postgres    false    259            T           2606    214586    trn_po pk_po_poid 
   CONSTRAINT     O   ALTER TABLE ONLY erp.trn_po
    ADD CONSTRAINT pk_po_poid PRIMARY KEY (po_id);
 8   ALTER TABLE ONLY erp.trn_po DROP CONSTRAINT pk_po_poid;
       erp            postgres    false    414            X           2606    214588    trn_po_item pk_poitem_poiid 
   CONSTRAINT     Z   ALTER TABLE ONLY erp.trn_po_item
    ADD CONSTRAINT pk_poitem_poiid PRIMARY KEY (poi_id);
 B   ALTER TABLE ONLY erp.trn_po_item DROP CONSTRAINT pk_poitem_poiid;
       erp            postgres    false    415            L           2606    214590 &   trn_plant_office_inward pk_poiw_siteid 
   CONSTRAINT     g   ALTER TABLE ONLY erp.trn_plant_office_inward
    ADD CONSTRAINT pk_poiw_siteid PRIMARY KEY (po_iw_id);
 M   ALTER TABLE ONLY erp.trn_plant_office_inward DROP CONSTRAINT pk_poiw_siteid;
       erp            postgres    false    410            N           2606    214592 /   trn_plant_office_inward_log pk_poiwlog_trans_id 
   CONSTRAINT     p   ALTER TABLE ONLY erp.trn_plant_office_inward_log
    ADD CONSTRAINT pk_poiwlog_trans_id PRIMARY KEY (trans_id);
 V   ALTER TABLE ONLY erp.trn_plant_office_inward_log DROP CONSTRAINT pk_poiwlog_trans_id;
       erp            postgres    false    411            R           2606    214594 +   trn_plant_office_outward_log pk_poow_siteid 
   CONSTRAINT     l   ALTER TABLE ONLY erp.trn_plant_office_outward_log
    ADD CONSTRAINT pk_poow_siteid PRIMARY KEY (trans_id);
 R   ALTER TABLE ONLY erp.trn_plant_office_outward_log DROP CONSTRAINT pk_poow_siteid;
       erp            postgres    false    413            P           2606    214596 (   trn_plant_office_outward pk_poowt_siteid 
   CONSTRAINT     i   ALTER TABLE ONLY erp.trn_plant_office_outward
    ADD CONSTRAINT pk_poowt_siteid PRIMARY KEY (po_ow_id);
 O   ALTER TABLE ONLY erp.trn_plant_office_outward DROP CONSTRAINT pk_poowt_siteid;
       erp            postgres    false    412            `           2606    214598 !   trn_po_summary pk_posummary_posid 
   CONSTRAINT     `   ALTER TABLE ONLY erp.trn_po_summary
    ADD CONSTRAINT pk_posummary_posid PRIMARY KEY (pos_id);
 H   ALTER TABLE ONLY erp.trn_po_summary DROP CONSTRAINT pk_posummary_posid;
       erp            postgres    false    420            ?           2606    214600 )   mst_presetdata pk_presetdata_presetdataid 
   CONSTRAINT     o   ALTER TABLE ONLY erp.mst_presetdata
    ADD CONSTRAINT pk_presetdata_presetdataid PRIMARY KEY (presetdata_id);
 P   ALTER TABLE ONLY erp.mst_presetdata DROP CONSTRAINT pk_presetdata_presetdataid;
       erp            postgres    false    262            b           2606    214602 V   trn_rmc_batch_detail_devicetransmission pk_rmc_batch_detail_devicetransmission_transid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_rmc_batch_detail_devicetransmission
    ADD CONSTRAINT pk_rmc_batch_detail_devicetransmission_transid PRIMARY KEY (trans_id);
 }   ALTER TABLE ONLY erp.trn_rmc_batch_detail_devicetransmission DROP CONSTRAINT pk_rmc_batch_detail_devicetransmission_transid;
       erp            postgres    false    422            d           2606    214604 H   trn_rmc_batch_devicetransmission pk_rmc_batch_devicetransmission_transid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_rmc_batch_devicetransmission
    ADD CONSTRAINT pk_rmc_batch_devicetransmission_transid PRIMARY KEY (trans_id);
 o   ALTER TABLE ONLY erp.trn_rmc_batch_devicetransmission DROP CONSTRAINT pk_rmc_batch_devicetransmission_transid;
       erp            postgres    false    424            ?           2606    214606    mst_role pk_role_roleid 
   CONSTRAINT     W   ALTER TABLE ONLY erp.mst_role
    ADD CONSTRAINT pk_role_roleid PRIMARY KEY (role_id);
 >   ALTER TABLE ONLY erp.mst_role DROP CONSTRAINT pk_role_roleid;
       erp            postgres    false    265            f           2606    214608 '   trn_role_screens pk_rolescreens_transid 
   CONSTRAINT     h   ALTER TABLE ONLY erp.trn_role_screens
    ADD CONSTRAINT pk_rolescreens_transid PRIMARY KEY (trans_id);
 N   ALTER TABLE ONLY erp.trn_role_screens DROP CONSTRAINT pk_rolescreens_transid;
       erp            postgres    false    426            ?           2606    214610    mst_screen pk_screen_screenid 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mst_screen
    ADD CONSTRAINT pk_screen_screenid PRIMARY KEY (screen_id);
 D   ALTER TABLE ONLY erp.mst_screen DROP CONSTRAINT pk_screen_screenid;
       erp            postgres    false    268            j           2606    214612 /   trn_screen_uiactions pk_screenuiactions_transid 
   CONSTRAINT     p   ALTER TABLE ONLY erp.trn_screen_uiactions
    ADD CONSTRAINT pk_screenuiactions_transid PRIMARY KEY (trans_id);
 V   ALTER TABLE ONLY erp.trn_screen_uiactions DROP CONSTRAINT pk_screenuiactions_transid;
       erp            postgres    false    427            ?           2606    214614    mst_site pk_site_siteid 
   CONSTRAINT     W   ALTER TABLE ONLY erp.mst_site
    ADD CONSTRAINT pk_site_siteid PRIMARY KEY (site_id);
 >   ALTER TABLE ONLY erp.mst_site DROP CONSTRAINT pk_site_siteid;
       erp            postgres    false    270            ?           2606    214616 %   mst_site_contact pk_sitecontact_conid 
   CONSTRAINT     i   ALTER TABLE ONLY erp.mst_site_contact
    ADD CONSTRAINT pk_sitecontact_conid PRIMARY KEY (site_con_id);
 L   ALTER TABLE ONLY erp.mst_site_contact DROP CONSTRAINT pk_sitecontact_conid;
       erp            postgres    false    272            ?           2606    214618 4   trn_summary_dashboard_record pk_smudashboard_transid 
   CONSTRAINT     u   ALTER TABLE ONLY erp.trn_summary_dashboard_record
    ADD CONSTRAINT pk_smudashboard_transid PRIMARY KEY (trans_id);
 [   ALTER TABLE ONLY erp.trn_summary_dashboard_record DROP CONSTRAINT pk_smudashboard_transid;
       erp            postgres    false    438            n           2606    214620    trn_so pk_so_soid 
   CONSTRAINT     O   ALTER TABLE ONLY erp.trn_so
    ADD CONSTRAINT pk_so_soid PRIMARY KEY (so_id);
 8   ALTER TABLE ONLY erp.trn_so DROP CONSTRAINT pk_so_soid;
       erp            postgres    false    428            z           2606    214622    trn_so_log pk_so_tranid 
   CONSTRAINT     X   ALTER TABLE ONLY erp.trn_so_log
    ADD CONSTRAINT pk_so_tranid PRIMARY KEY (trans_id);
 >   ALTER TABLE ONLY erp.trn_so_log DROP CONSTRAINT pk_so_tranid;
       erp            postgres    false    432            |           2606    214624 "   trn_so_order_details pk_sodorderid 
   CONSTRAINT     k   ALTER TABLE ONLY erp.trn_so_order_details
    ADD CONSTRAINT pk_sodorderid PRIMARY KEY (so_ord_detail_id);
 I   ALTER TABLE ONLY erp.trn_so_order_details DROP CONSTRAINT pk_sodorderid;
       erp            postgres    false    433            t           2606    214626    trn_so_item pk_soitem_soiid 
   CONSTRAINT     Z   ALTER TABLE ONLY erp.trn_so_item
    ADD CONSTRAINT pk_soitem_soiid PRIMARY KEY (soi_id);
 B   ALTER TABLE ONLY erp.trn_so_item DROP CONSTRAINT pk_soitem_soiid;
       erp            postgres    false    430            x           2606    214628 !   trn_so_item_log pk_soitem_transid 
   CONSTRAINT     b   ALTER TABLE ONLY erp.trn_so_item_log
    ADD CONSTRAINT pk_soitem_transid PRIMARY KEY (trans_id);
 H   ALTER TABLE ONLY erp.trn_so_item_log DROP CONSTRAINT pk_soitem_transid;
       erp            postgres    false    431            ~           2606    214630 !   trn_so_summary pk_sosummary_sosid 
   CONSTRAINT     `   ALTER TABLE ONLY erp.trn_so_summary
    ADD CONSTRAINT pk_sosummary_sosid PRIMARY KEY (sos_id);
 H   ALTER TABLE ONLY erp.trn_so_summary DROP CONSTRAINT pk_sosummary_sosid;
       erp            postgres    false    434            ?           2606    214632 &   trn_so_summary_log pk_sosummary_tranid 
   CONSTRAINT     g   ALTER TABLE ONLY erp.trn_so_summary_log
    ADD CONSTRAINT pk_sosummary_tranid PRIMARY KEY (trans_id);
 M   ALTER TABLE ONLY erp.trn_so_summary_log DROP CONSTRAINT pk_sosummary_tranid;
       erp            postgres    false    435            ?           2606    214634 &   trn_summary_stock_level pk_ssl_transid 
   CONSTRAINT     g   ALTER TABLE ONLY erp.trn_summary_stock_level
    ADD CONSTRAINT pk_ssl_transid PRIMARY KEY (trans_id);
 M   ALTER TABLE ONLY erp.trn_summary_stock_level DROP CONSTRAINT pk_ssl_transid;
       erp            postgres    false    439            ?           2606    214636    mst_state pk_state_stateid 
   CONSTRAINT     [   ALTER TABLE ONLY erp.mst_state
    ADD CONSTRAINT pk_state_stateid PRIMARY KEY (state_id);
 A   ALTER TABLE ONLY erp.mst_state DROP CONSTRAINT pk_state_stateid;
       erp            postgres    false    276            ?           2606    214638 .   mst_subtestmaster pk_subtestmaster_sub_test_id 
   CONSTRAINT     r   ALTER TABLE ONLY erp.mst_subtestmaster
    ADD CONSTRAINT pk_subtestmaster_sub_test_id PRIMARY KEY (sub_test_id);
 U   ALTER TABLE ONLY erp.mst_subtestmaster DROP CONSTRAINT pk_subtestmaster_sub_test_id;
       erp            postgres    false    278            ?           2606    214640 #   mst_testmaster pk_testmaster_testid 
   CONSTRAINT     c   ALTER TABLE ONLY erp.mst_testmaster
    ADD CONSTRAINT pk_testmaster_testid PRIMARY KEY (test_id);
 J   ALTER TABLE ONLY erp.mst_testmaster DROP CONSTRAINT pk_testmaster_testid;
       erp            postgres    false    280            l           2606    214642 6   trn_weiging_bridge_log pk_trn_weigh_bridge_log_transid 
   CONSTRAINT     w   ALTER TABLE ONLY erp.trn_weiging_bridge_log
    ADD CONSTRAINT pk_trn_weigh_bridge_log_transid PRIMARY KEY (trans_id);
 ]   ALTER TABLE ONLY erp.trn_weiging_bridge_log DROP CONSTRAINT pk_trn_weigh_bridge_log_transid;
       erp            postgres    false    207            ?           2606    214644 M   trn_weiging_bridge_log_wthout_poso pk_trn_weigh_bridge_log_wthoutposo_transid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_weiging_bridge_log_wthout_poso
    ADD CONSTRAINT pk_trn_weigh_bridge_log_wthoutposo_transid PRIMARY KEY (trans_id);
 t   ALTER TABLE ONLY erp.trn_weiging_bridge_log_wthout_poso DROP CONSTRAINT pk_trn_weigh_bridge_log_wthoutposo_transid;
       erp            postgres    false    441            ?           2606    214646 #   mst_uiaction pk_uiaction_uiactionid 
   CONSTRAINT     g   ALTER TABLE ONLY erp.mst_uiaction
    ADD CONSTRAINT pk_uiaction_uiactionid PRIMARY KEY (uiaction_id);
 J   ALTER TABLE ONLY erp.mst_uiaction DROP CONSTRAINT pk_uiaction_uiactionid;
       erp            postgres    false    282            ?           2606    214648    mst_unit pk_unit_unitid 
   CONSTRAINT     W   ALTER TABLE ONLY erp.mst_unit
    ADD CONSTRAINT pk_unit_unitid PRIMARY KEY (unit_id);
 >   ALTER TABLE ONLY erp.mst_unit DROP CONSTRAINT pk_unit_unitid;
       erp            postgres    false    284            ?           2606    214650    mst_user pk_user_userid 
   CONSTRAINT     W   ALTER TABLE ONLY erp.mst_user
    ADD CONSTRAINT pk_user_userid PRIMARY KEY (user_id);
 >   ALTER TABLE ONLY erp.mst_user DROP CONSTRAINT pk_user_userid;
       erp            postgres    false    287            ?           2606    214652 "   trn_user_roles pk_userroles_todoid 
   CONSTRAINT     c   ALTER TABLE ONLY erp.trn_user_roles
    ADD CONSTRAINT pk_userroles_todoid PRIMARY KEY (trans_id);
 I   ALTER TABLE ONLY erp.trn_user_roles DROP CONSTRAINT pk_userroles_todoid;
       erp            postgres    false    440            ?           2606    214654 /   mst_vehicle_insurance pk_veh_insurance_trans_id 
   CONSTRAINT     p   ALTER TABLE ONLY erp.mst_vehicle_insurance
    ADD CONSTRAINT pk_veh_insurance_trans_id PRIMARY KEY (trans_id);
 V   ALTER TABLE ONLY erp.mst_vehicle_insurance DROP CONSTRAINT pk_veh_insurance_trans_id;
       erp            postgres    false    292            ?           2606    214656    mst_vehicle pk_vehicle_vehid 
   CONSTRAINT     [   ALTER TABLE ONLY erp.mst_vehicle
    ADD CONSTRAINT pk_vehicle_vehid PRIMARY KEY (veh_id);
 C   ALTER TABLE ONLY erp.mst_vehicle DROP CONSTRAINT pk_vehicle_vehid;
       erp            postgres    false    290            ?           2606    214658    mst_vendor pk_vendor_vendorid 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mst_vendor
    ADD CONSTRAINT pk_vendor_vendorid PRIMARY KEY (vendor_id);
 D   ALTER TABLE ONLY erp.mst_vendor DROP CONSTRAINT pk_vendor_vendorid;
       erp            postgres    false    296            ?           2606    214660 )   mst_vendor_contact pk_vendorcontact_conid 
   CONSTRAINT     h   ALTER TABLE ONLY erp.mst_vendor_contact
    ADD CONSTRAINT pk_vendorcontact_conid PRIMARY KEY (con_id);
 P   ALTER TABLE ONLY erp.mst_vendor_contact DROP CONSTRAINT pk_vendorcontact_conid;
       erp            postgres    false    298            ?           2606    214666    trn_stock trn_stock_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY erp.trn_stock
    ADD CONSTRAINT trn_stock_pkey PRIMARY KEY (stock_id);
 ?   ALTER TABLE ONLY erp.trn_stock DROP CONSTRAINT trn_stock_pkey;
       erp            postgres    false    436            p           2606    214668 (   mst_alert_config uk_ ac_event_type_intid 
   CONSTRAINT     s   ALTER TABLE ONLY erp.mst_alert_config
    ADD CONSTRAINT "uk_ ac_event_type_intid" UNIQUE (ac_event_type, int_id);
 Q   ALTER TABLE ONLY erp.mst_alert_config DROP CONSTRAINT "uk_ ac_event_type_intid";
       erp            postgres    false    210    210            r           2606    214670 &   mst_alert_config uk_alertconfig_acname 
   CONSTRAINT     i   ALTER TABLE ONLY erp.mst_alert_config
    ADD CONSTRAINT uk_alertconfig_acname UNIQUE (ac_name, int_id);
 M   ALTER TABLE ONLY erp.mst_alert_config DROP CONSTRAINT uk_alertconfig_acname;
       erp            postgres    false    210    210            ?           2606    214672 !   mst_weigh_bridge uk_bridge_imeino 
   CONSTRAINT     \   ALTER TABLE ONLY erp.mst_weigh_bridge
    ADD CONSTRAINT uk_bridge_imeino UNIQUE (imei_no);
 H   ALTER TABLE ONLY erp.mst_weigh_bridge DROP CONSTRAINT uk_bridge_imeino;
       erp            postgres    false    300            ?           2606    214674    mst_weigh_bridge uk_bridge_name 
   CONSTRAINT     ^   ALTER TABLE ONLY erp.mst_weigh_bridge
    ADD CONSTRAINT uk_bridge_name UNIQUE (bridge_name);
 F   ALTER TABLE ONLY erp.mst_weigh_bridge DROP CONSTRAINT uk_bridge_name;
       erp            postgres    false    300            v           2606    214676    mst_card uk_card_access_string 
   CONSTRAINT     k   ALTER TABLE ONLY erp.mst_card
    ADD CONSTRAINT uk_card_access_string UNIQUE (card_access_string, hc_id);
 E   ALTER TABLE ONLY erp.mst_card DROP CONSTRAINT uk_card_access_string;
       erp            postgres    false    212    212            ?           2606    214678 $   mst_customer_vendor uk_cust_custcode 
   CONSTRAINT     o   ALTER TABLE ONLY erp.mst_customer_vendor
    ADD CONSTRAINT uk_cust_custcode UNIQUE (cust_vendor_code, hc_id);
 K   ALTER TABLE ONLY erp.mst_customer_vendor DROP CONSTRAINT uk_cust_custcode;
       erp            postgres    false    222    222            ?           2606    214680 $   mst_customer_vendor uk_cust_custname 
   CONSTRAINT     o   ALTER TABLE ONLY erp.mst_customer_vendor
    ADD CONSTRAINT uk_cust_custname UNIQUE (cust_vendor_name, hc_id);
 K   ALTER TABLE ONLY erp.mst_customer_vendor DROP CONSTRAINT uk_cust_custname;
       erp            postgres    false    222    222            z           2606    214682 .   mst_cust_vendor_contact uk_custcontact_conname 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_contact
    ADD CONSTRAINT uk_custcontact_conname UNIQUE (cust_vendor_id, con_name, hc_id);
 U   ALTER TABLE ONLY erp.mst_cust_vendor_contact DROP CONSTRAINT uk_custcontact_conname;
       erp            postgres    false    215    215    215            ?           2606    214684 B   mst_cust_vendor_payment_conditions uk_custvendor_id_condition_name 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions
    ADD CONSTRAINT uk_custvendor_id_condition_name UNIQUE (cust_id, condition_name);
 i   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions DROP CONSTRAINT uk_custvendor_id_condition_name;
       erp            postgres    false    220    220            ?           2606    214686    mst_department uk_dept_deptname 
   CONSTRAINT     c   ALTER TABLE ONLY erp.mst_department
    ADD CONSTRAINT uk_dept_deptname UNIQUE (dept_name, hc_id);
 F   ALTER TABLE ONLY erp.mst_department DROP CONSTRAINT uk_dept_deptname;
       erp            postgres    false    225    225            .           2606    214688 %   trn_designmix uk_designmix_designname 
   CONSTRAINT     y   ALTER TABLE ONLY erp.trn_designmix
    ADD CONSTRAINT uk_designmix_designname UNIQUE (design_mix_name, hc_id, plant_id);
 L   ALTER TABLE ONLY erp.trn_designmix DROP CONSTRAINT uk_designmix_designname;
       erp            postgres    false    395    395    395            ?           2606    214690    mst_employee uk_emp_empcode 
   CONSTRAINT     ^   ALTER TABLE ONLY erp.mst_employee
    ADD CONSTRAINT uk_emp_empcode UNIQUE (hc_id, emp_code);
 B   ALTER TABLE ONLY erp.mst_employee DROP CONSTRAINT uk_emp_empcode;
       erp            postgres    false    229    229            ?           2606    214692    mst_employee uk_emp_empname 
   CONSTRAINT     ^   ALTER TABLE ONLY erp.mst_employee
    ADD CONSTRAINT uk_emp_empname UNIQUE (hc_id, emp_name);
 B   ALTER TABLE ONLY erp.mst_employee DROP CONSTRAINT uk_emp_empname;
       erp            postgres    false    229    229                       2606    214694 #   mtn_emp_doc uk_empdoc_empid_doctype 
   CONSTRAINT     g   ALTER TABLE ONLY erp.mtn_emp_doc
    ADD CONSTRAINT uk_empdoc_empid_doctype UNIQUE (emp_id, doc_type);
 J   ALTER TABLE ONLY erp.mtn_emp_doc DROP CONSTRAINT uk_empdoc_empid_doctype;
       erp            postgres    false    307    307            
           2606    214696 O   mtn_emp_wish_date uk_empwishdate_wishtype_wishdate_applicableto_generalentityid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mtn_emp_wish_date
    ADD CONSTRAINT uk_empwishdate_wishtype_wishdate_applicableto_generalentityid UNIQUE (wish_type, wish_date, applicable_to, general_entity_id);
 v   ALTER TABLE ONLY erp.mtn_emp_wish_date DROP CONSTRAINT uk_empwishdate_wishtype_wishdate_applicableto_generalentityid;
       erp            postgres    false    313    313    313    313            ?           2606    214698    mst_finyear uk_finyear_fyname 
   CONSTRAINT     X   ALTER TABLE ONLY erp.mst_finyear
    ADD CONSTRAINT uk_finyear_fyname UNIQUE (fy_name);
 D   ALTER TABLE ONLY erp.mst_finyear DROP CONSTRAINT uk_finyear_fyname;
       erp            postgres    false    233            ?           2606    214700 %   mst_host_company uk_hostcomp_compname 
   CONSTRAINT     b   ALTER TABLE ONLY erp.mst_host_company
    ADD CONSTRAINT uk_hostcomp_compname UNIQUE (comp_name);
 L   ALTER TABLE ONLY erp.mst_host_company DROP CONSTRAINT uk_hostcomp_compname;
       erp            postgres    false    238            ?           2606    214702 +   mst_integrator uk_integrator_integratorname 
   CONSTRAINT     g   ALTER TABLE ONLY erp.mst_integrator
    ADD CONSTRAINT uk_integrator_integratorname UNIQUE (int_name);
 R   ALTER TABLE ONLY erp.mst_integrator DROP CONSTRAINT uk_integrator_integratorname;
       erp            postgres    false    241            ?           2606    214704 8   mst_integrator_config uk_integrator_intid_configparamkey 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_integrator_config
    ADD CONSTRAINT uk_integrator_intid_configparamkey UNIQUE (int_id, config_param_key);
 _   ALTER TABLE ONLY erp.mst_integrator_config DROP CONSTRAINT uk_integrator_intid_configparamkey;
       erp            postgres    false    243    243            ?           2606    214706    mst_item uk_item_itemname 
   CONSTRAINT     ]   ALTER TABLE ONLY erp.mst_item
    ADD CONSTRAINT uk_item_itemname UNIQUE (item_name, hc_id);
 @   ALTER TABLE ONLY erp.mst_item DROP CONSTRAINT uk_item_itemname;
       erp            postgres    false    246    246            ?           2606    214708 )   mst_item_category uk_itemcategory_catname 
   CONSTRAINT     l   ALTER TABLE ONLY erp.mst_item_category
    ADD CONSTRAINT uk_itemcategory_catname UNIQUE (cat_name, hc_id);
 P   ALTER TABLE ONLY erp.mst_item_category DROP CONSTRAINT uk_itemcategory_catname;
       erp            postgres    false    248    248            ~           2606    214710 *   mst_cust_vendor_item uk_mstcustitem_itemid 
   CONSTRAINT     u   ALTER TABLE ONLY erp.mst_cust_vendor_item
    ADD CONSTRAINT uk_mstcustitem_itemid UNIQUE (item_id, cust_id, hc_id);
 Q   ALTER TABLE ONLY erp.mst_cust_vendor_item DROP CONSTRAINT uk_mstcustitem_itemid;
       erp            postgres    false    218    218    218            ?           2606    214712 %   mst_name_setup uk_namesetup_con_plant 
   CONSTRAINT     h   ALTER TABLE ONLY erp.mst_name_setup
    ADD CONSTRAINT uk_namesetup_con_plant UNIQUE (hc_id, plant_id);
 L   ALTER TABLE ONLY erp.mst_name_setup DROP CONSTRAINT uk_namesetup_con_plant;
       erp            postgres    false    253    253            ?           2606    214714    mst_plant uk_plant_plantname 
   CONSTRAINT     Z   ALTER TABLE ONLY erp.mst_plant
    ADD CONSTRAINT uk_plant_plantname UNIQUE (plant_name);
 C   ALTER TABLE ONLY erp.mst_plant DROP CONSTRAINT uk_plant_plantname;
       erp            postgres    false    259            ?           2606    214716    mst_plant uk_plant_plantregno 
   CONSTRAINT     ]   ALTER TABLE ONLY erp.mst_plant
    ADD CONSTRAINT uk_plant_plantregno UNIQUE (plant_reg_no);
 D   ALTER TABLE ONLY erp.mst_plant DROP CONSTRAINT uk_plant_plantregno;
       erp            postgres    false    259            ^           2606    214718 1   trn_po_payment_conditions uk_po_id_condition_name 
   CONSTRAINT     z   ALTER TABLE ONLY erp.trn_po_payment_conditions
    ADD CONSTRAINT uk_po_id_condition_name UNIQUE (po_id, condition_name);
 X   ALTER TABLE ONLY erp.trn_po_payment_conditions DROP CONSTRAINT uk_po_id_condition_name;
       erp            postgres    false    418    418            Z           2606    214720 !   trn_po_item uk_poitem_poid_itemid 
   CONSTRAINT     c   ALTER TABLE ONLY erp.trn_po_item
    ADD CONSTRAINT uk_poitem_poid_itemid UNIQUE (po_id, item_id);
 H   ALTER TABLE ONLY erp.trn_po_item DROP CONSTRAINT uk_poitem_poid_itemid;
       erp            postgres    false    415    415            ?           2606    214722 '   mst_presetdata uk_presetdata_presetdata 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_presetdata
    ADD CONSTRAINT uk_presetdata_presetdata UNIQUE (dbtable_name, dbcolumn_name, presetdata_key, presetdata_value, presetdata_index);
 N   ALTER TABLE ONLY erp.mst_presetdata DROP CONSTRAINT uk_presetdata_presetdata;
       erp            postgres    false    262    262    262    262    262            ?           2606    214724    mst_role uk_role_rolename 
   CONSTRAINT     V   ALTER TABLE ONLY erp.mst_role
    ADD CONSTRAINT uk_role_rolename UNIQUE (role_name);
 @   ALTER TABLE ONLY erp.mst_role DROP CONSTRAINT uk_role_rolename;
       erp            postgres    false    265            h           2606    214726 /   trn_role_screens uk_rolescreens_roleid_screenid 
   CONSTRAINT     ~   ALTER TABLE ONLY erp.trn_role_screens
    ADD CONSTRAINT uk_rolescreens_roleid_screenid UNIQUE (role_id, screen_uiaction_id);
 V   ALTER TABLE ONLY erp.trn_role_screens DROP CONSTRAINT uk_rolescreens_roleid_screenid;
       erp            postgres    false    426    426            ?           2606    214728    mst_screen uk_screen_screenname 
   CONSTRAINT     ^   ALTER TABLE ONLY erp.mst_screen
    ADD CONSTRAINT uk_screen_screenname UNIQUE (screen_name);
 F   ALTER TABLE ONLY erp.mst_screen DROP CONSTRAINT uk_screen_screenname;
       erp            postgres    false    268            l           2606    214730 ;   trn_screen_uiactions uk_screenuiactions_screenid_uiactionid 
   CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_screen_uiactions
    ADD CONSTRAINT uk_screenuiactions_screenid_uiactionid UNIQUE (screen_id, uiaction_id);
 b   ALTER TABLE ONLY erp.trn_screen_uiactions DROP CONSTRAINT uk_screenuiactions_screenid_uiactionid;
       erp            postgres    false    427    427            v           2606    214732 !   trn_so_item uk_soitem_soid_itemid 
   CONSTRAINT     s   ALTER TABLE ONLY erp.trn_so_item
    ADD CONSTRAINT uk_soitem_soid_itemid UNIQUE (so_id, item_id, dmix_id, hc_id);
 H   ALTER TABLE ONLY erp.trn_so_item DROP CONSTRAINT uk_soitem_soid_itemid;
       erp            postgres    false    430    430    430    430            ?           2606    214734    mst_state uk_state_statename 
   CONSTRAINT     Z   ALTER TABLE ONLY erp.mst_state
    ADD CONSTRAINT uk_state_statename UNIQUE (state_name);
 C   ALTER TABLE ONLY erp.mst_state DROP CONSTRAINT uk_state_statename;
       erp            postgres    false    276                       2606    214736    trn_bpa_info uk_trnbpa_bpano 
   CONSTRAINT     d   ALTER TABLE ONLY erp.trn_bpa_info
    ADD CONSTRAINT uk_trnbpa_bpano UNIQUE (fy_id, hc_id, bpa_no);
 C   ALTER TABLE ONLY erp.trn_bpa_info DROP CONSTRAINT uk_trnbpa_bpano;
       erp            postgres    false    384    384    384                        2606    214738    trn_dc_info uk_trndcinfio_dcno 
   CONSTRAINT     e   ALTER TABLE ONLY erp.trn_dc_info
    ADD CONSTRAINT uk_trndcinfio_dcno UNIQUE (fy_id, hc_id, dc_no);
 E   ALTER TABLE ONLY erp.trn_dc_info DROP CONSTRAINT uk_trndcinfio_dcno;
       erp            postgres    false    389    389    389            6           2606    214740    trn_grn_info uk_trngrn_grnno 
   CONSTRAINT     d   ALTER TABLE ONLY erp.trn_grn_info
    ADD CONSTRAINT uk_trngrn_grnno UNIQUE (fy_id, hc_id, grn_no);
 C   ALTER TABLE ONLY erp.trn_grn_info DROP CONSTRAINT uk_trngrn_grnno;
       erp            postgres    false    398    398    398            >           2606    214742 -   trn_invoice_info uk_trninvoiceinfio_invoiceno 
   CONSTRAINT     y   ALTER TABLE ONLY erp.trn_invoice_info
    ADD CONSTRAINT uk_trninvoiceinfio_invoiceno UNIQUE (fy_id, hc_id, invoice_no);
 T   ALTER TABLE ONLY erp.trn_invoice_info DROP CONSTRAINT uk_trninvoiceinfio_invoiceno;
       erp            postgres    false    402    402    402            V           2606    214744    trn_po uk_trnpo_pono 
   CONSTRAINT     [   ALTER TABLE ONLY erp.trn_po
    ADD CONSTRAINT uk_trnpo_pono UNIQUE (fy_id, hc_id, po_no);
 ;   ALTER TABLE ONLY erp.trn_po DROP CONSTRAINT uk_trnpo_pono;
       erp            postgres    false    414    414    414            p           2606    214746    trn_so uk_trnso_sono 
   CONSTRAINT     [   ALTER TABLE ONLY erp.trn_so
    ADD CONSTRAINT uk_trnso_sono UNIQUE (fy_id, hc_id, so_no);
 ;   ALTER TABLE ONLY erp.trn_so DROP CONSTRAINT uk_trnso_sono;
       erp            postgres    false    428    428    428            ?           2606    214748 !   mst_uiaction uk_uiaction_uiaction 
   CONSTRAINT     t   ALTER TABLE ONLY erp.mst_uiaction
    ADD CONSTRAINT uk_uiaction_uiaction UNIQUE (uiaction_name, uicomponent_type);
 H   ALTER TABLE ONLY erp.mst_uiaction DROP CONSTRAINT uk_uiaction_uiaction;
       erp            postgres    false    282    282            ?           2606    214750    mst_unit uk_unit_unitname 
   CONSTRAINT     ]   ALTER TABLE ONLY erp.mst_unit
    ADD CONSTRAINT uk_unit_unitname UNIQUE (unit_name, hc_id);
 @   ALTER TABLE ONLY erp.mst_unit DROP CONSTRAINT uk_unit_unitname;
       erp            postgres    false    284    284            ?           2606    214752    mst_user uk_user_username 
   CONSTRAINT     V   ALTER TABLE ONLY erp.mst_user
    ADD CONSTRAINT uk_user_username UNIQUE (user_name);
 @   ALTER TABLE ONLY erp.mst_user DROP CONSTRAINT uk_user_username;
       erp            postgres    false    287            ?           2606    214754 )   trn_user_roles uk_userroles_userid_roleid 
   CONSTRAINT     m   ALTER TABLE ONLY erp.trn_user_roles
    ADD CONSTRAINT uk_userroles_userid_roleid UNIQUE (user_id, role_id);
 P   ALTER TABLE ONLY erp.trn_user_roles DROP CONSTRAINT uk_userroles_userid_roleid;
       erp            postgres    false    440    440            ?           2606    214756     mst_vehicle uk_vehicle_devimeino 
   CONSTRAINT     _   ALTER TABLE ONLY erp.mst_vehicle
    ADD CONSTRAINT uk_vehicle_devimeino UNIQUE (dev_imei_no);
 G   ALTER TABLE ONLY erp.mst_vehicle DROP CONSTRAINT uk_vehicle_devimeino;
       erp            postgres    false    290            ?           2606    214758    mst_vehicle uk_vehicle_vehno 
   CONSTRAINT     V   ALTER TABLE ONLY erp.mst_vehicle
    ADD CONSTRAINT uk_vehicle_vehno UNIQUE (veh_no);
 C   ALTER TABLE ONLY erp.mst_vehicle DROP CONSTRAINT uk_vehicle_vehno;
       erp            postgres    false    290            ?           2606    214760    mst_vendor uk_vendor_vendorcode 
   CONSTRAINT     e   ALTER TABLE ONLY erp.mst_vendor
    ADD CONSTRAINT uk_vendor_vendorcode UNIQUE (vendor_code, hc_id);
 F   ALTER TABLE ONLY erp.mst_vendor DROP CONSTRAINT uk_vendor_vendorcode;
       erp            postgres    false    296    296            ?           2606    214762    mst_vendor uk_vendor_vendorname 
   CONSTRAINT     e   ALTER TABLE ONLY erp.mst_vendor
    ADD CONSTRAINT uk_vendor_vendorname UNIQUE (vendor_name, hc_id);
 F   ALTER TABLE ONLY erp.mst_vendor DROP CONSTRAINT uk_vendor_vendorname;
       erp            postgres    false    296    296            ?           2606    214764 +   mst_vendor_contact uk_vendorcontact_conname 
   CONSTRAINT     y   ALTER TABLE ONLY erp.mst_vendor_contact
    ADD CONSTRAINT uk_vendorcontact_conname UNIQUE (vendor_id, con_name, hc_id);
 R   ALTER TABLE ONLY erp.mst_vendor_contact DROP CONSTRAINT uk_vendorcontact_conname;
       erp            postgres    false    298    298    298            ?           2606    214792    trn_designmix pk_dmix_dmixid 
   CONSTRAINT     _   ALTER TABLE ONLY public.trn_designmix
    ADD CONSTRAINT pk_dmix_dmixid PRIMARY KEY (dmix_id);
 F   ALTER TABLE ONLY public.trn_designmix DROP CONSTRAINT pk_dmix_dmixid;
       public            postgres    false    500            ?           2606    214794 !   trn_so_designmix pk_dmix_sodmixid 
   CONSTRAINT     g   ALTER TABLE ONLY public.trn_so_designmix
    ADD CONSTRAINT pk_dmix_sodmixid PRIMARY KEY (so_dmix_id);
 K   ALTER TABLE ONLY public.trn_so_designmix DROP CONSTRAINT pk_dmix_sodmixid;
       public            postgres    false    501                       2620    214795 ,   mtn_emp_bioprofile tgr_ad_mtn_emp_bioprofile    TRIGGER     ?   CREATE TRIGGER tgr_ad_mtn_emp_bioprofile AFTER DELETE ON erp.mtn_emp_bioprofile FOR EACH ROW EXECUTE FUNCTION erp.log_ad_mtn_emp_bioprofile();
 B   DROP TRIGGER tgr_ad_mtn_emp_bioprofile ON erp.mtn_emp_bioprofile;
       erp          postgres    false    304    520                       2620    214796 ,   mtn_emp_bioprofile tgr_ai_mtn_emp_bioprofile    TRIGGER     ?   CREATE TRIGGER tgr_ai_mtn_emp_bioprofile AFTER INSERT ON erp.mtn_emp_bioprofile FOR EACH ROW EXECUTE FUNCTION erp.log_ai_mtn_emp_bioprofile();
 B   DROP TRIGGER tgr_ai_mtn_emp_bioprofile ON erp.mtn_emp_bioprofile;
       erp          postgres    false    521    304                        2620    214797 ,   mtn_emp_bioprofile tgr_au_mtn_emp_bioprofile    TRIGGER     ?   CREATE TRIGGER tgr_au_mtn_emp_bioprofile AFTER UPDATE ON erp.mtn_emp_bioprofile FOR EACH ROW EXECUTE FUNCTION erp.log_au_mtn_emp_bioprofile();
 B   DROP TRIGGER tgr_au_mtn_emp_bioprofile ON erp.mtn_emp_bioprofile;
       erp          postgres    false    522    304                       2620    214799    mst_card tgr_bu_mst_card    TRIGGER     r   CREATE TRIGGER tgr_bu_mst_card BEFORE UPDATE ON erp.mst_card FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_card();
 .   DROP TRIGGER tgr_bu_mst_card ON erp.mst_card;
       erp          postgres    false    503    212                       2620    214800 6   mst_cust_vendor_contact tgr_bu_mst_cust_vendor_contact    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_cust_vendor_contact BEFORE UPDATE ON erp.mst_cust_vendor_contact FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_cust_vendor_contact();
 L   DROP TRIGGER tgr_bu_mst_cust_vendor_contact ON erp.mst_cust_vendor_contact;
       erp          postgres    false    504    215                       2620    214801 ,   mst_general_ledger tgr_bu_mst_general_ledger    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_general_ledger BEFORE UPDATE ON erp.mst_general_ledger FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_general_ledger();
 B   DROP TRIGGER tgr_bu_mst_general_ledger ON erp.mst_general_ledger;
       erp          postgres    false    524    235                       2620    214802 (   mst_host_company tgr_bu_mst_host_company    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_host_company BEFORE UPDATE ON erp.mst_host_company FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_host_company();
 >   DROP TRIGGER tgr_bu_mst_host_company ON erp.mst_host_company;
       erp          postgres    false    525    238                       2620    214803 $   mst_integrator tgr_bu_mst_integrator    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_integrator BEFORE UPDATE ON erp.mst_integrator FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_integrator();
 :   DROP TRIGGER tgr_bu_mst_integrator ON erp.mst_integrator;
       erp          postgres    false    526    241                       2620    214804    mst_item tgr_bu_mst_item    TRIGGER     r   CREATE TRIGGER tgr_bu_mst_item BEFORE UPDATE ON erp.mst_item FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_item();
 .   DROP TRIGGER tgr_bu_mst_item ON erp.mst_item;
       erp          postgres    false    527    246                       2620    214805 *   mst_item_category tgr_bu_mst_item_category    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_item_category BEFORE UPDATE ON erp.mst_item_category FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_item_category();
 @   DROP TRIGGER tgr_bu_mst_item_category ON erp.mst_item_category;
       erp          postgres    false    528    248                       2620    214806 2   mst_customer_vendor tgr_bu_mst_mst_customer_vendor    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_mst_customer_vendor BEFORE UPDATE ON erp.mst_customer_vendor FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_mst_customer_vendor();
 H   DROP TRIGGER tgr_bu_mst_mst_customer_vendor ON erp.mst_customer_vendor;
       erp          postgres    false    529    222                       2620    214807 $   mst_name_setup tgr_bu_mst_name_setup    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_name_setup BEFORE UPDATE ON erp.mst_name_setup FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_name_setup();
 :   DROP TRIGGER tgr_bu_mst_name_setup ON erp.mst_name_setup;
       erp          postgres    false    253    530                       2620    214808 @   mst_payment_other_conditions tgr_bu_mst_payment_other_conditions    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_payment_other_conditions BEFORE UPDATE ON erp.mst_payment_other_conditions FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_payment_other_conditions();
 V   DROP TRIGGER tgr_bu_mst_payment_other_conditions ON erp.mst_payment_other_conditions;
       erp          postgres    false    256    505                       2620    214809    mst_plant tgr_bu_mst_plant    TRIGGER     u   CREATE TRIGGER tgr_bu_mst_plant BEFORE UPDATE ON erp.mst_plant FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_plant();
 0   DROP TRIGGER tgr_bu_mst_plant ON erp.mst_plant;
       erp          postgres    false    531    259                       2620    214810 $   mst_presetdata tgr_bu_mst_presetdata    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_presetdata BEFORE UPDATE ON erp.mst_presetdata FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_presetdata();
 :   DROP TRIGGER tgr_bu_mst_presetdata ON erp.mst_presetdata;
       erp          postgres    false    262    532                       2620    214811    mst_role tgr_bu_mst_role    TRIGGER     r   CREATE TRIGGER tgr_bu_mst_role BEFORE UPDATE ON erp.mst_role FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_role();
 .   DROP TRIGGER tgr_bu_mst_role ON erp.mst_role;
       erp          postgres    false    265    533                       2620    214812    mst_site tgr_bu_mst_site    TRIGGER     r   CREATE TRIGGER tgr_bu_mst_site BEFORE UPDATE ON erp.mst_site FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_site();
 .   DROP TRIGGER tgr_bu_mst_site ON erp.mst_site;
       erp          postgres    false    270    534                       2620    214813 (   mst_site_contact tgr_bu_mst_site_contact    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_site_contact BEFORE UPDATE ON erp.mst_site_contact FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_site_contact();
 >   DROP TRIGGER tgr_bu_mst_site_contact ON erp.mst_site_contact;
       erp          postgres    false    535    272                       2620    214814    mst_unit tgr_bu_mst_unit    TRIGGER     r   CREATE TRIGGER tgr_bu_mst_unit BEFORE UPDATE ON erp.mst_unit FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_unit();
 .   DROP TRIGGER tgr_bu_mst_unit ON erp.mst_unit;
       erp          postgres    false    284    536                       2620    214815    mst_user tgr_bu_mst_user    TRIGGER     r   CREATE TRIGGER tgr_bu_mst_user BEFORE UPDATE ON erp.mst_user FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_user();
 .   DROP TRIGGER tgr_bu_mst_user ON erp.mst_user;
       erp          postgres    false    537    287                       2620    214816    mst_vehicle tgr_bu_mst_vehicle    TRIGGER     {   CREATE TRIGGER tgr_bu_mst_vehicle BEFORE UPDATE ON erp.mst_vehicle FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_vehicle();
 4   DROP TRIGGER tgr_bu_mst_vehicle ON erp.mst_vehicle;
       erp          postgres    false    538    290                       2620    214817 2   mst_vehicle_insurance tgr_bu_mst_vehicle_insurance    TRIGGER     ?   CREATE TRIGGER tgr_bu_mst_vehicle_insurance BEFORE UPDATE ON erp.mst_vehicle_insurance FOR EACH ROW EXECUTE FUNCTION erp.log_bu_mst_vehicle_insurance();
 H   DROP TRIGGER tgr_bu_mst_vehicle_insurance ON erp.mst_vehicle_insurance;
       erp          postgres    false    292    539            !           2620    214818     notification tgr_bu_notification    TRIGGER     ~   CREATE TRIGGER tgr_bu_notification BEFORE UPDATE ON erp.notification FOR EACH ROW EXECUTE FUNCTION erp.log_bu_notification();
 6   DROP TRIGGER tgr_bu_notification ON erp.notification;
       erp          postgres    false    315    540            "           2620    214819 &   trn_bpa_details tgr_bu_trn_bpa_details    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_bpa_details BEFORE UPDATE ON erp.trn_bpa_details FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_bpa_details();
 <   DROP TRIGGER tgr_bu_trn_bpa_details ON erp.trn_bpa_details;
       erp          postgres    false    382    541            #           2620    214820     trn_bpa_info tgr_bu_trn_bpa_info    TRIGGER     ~   CREATE TRIGGER tgr_bu_trn_bpa_info BEFORE UPDATE ON erp.trn_bpa_info FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_bpa_info();
 6   DROP TRIGGER tgr_bu_trn_bpa_info ON erp.trn_bpa_info;
       erp          postgres    false    542    384            $           2620    214821 .   trn_card_allocation tgr_bu_trn_card_allocation    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_card_allocation BEFORE UPDATE ON erp.trn_card_allocation FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_card_allocation();
 D   DROP TRIGGER tgr_bu_trn_card_allocation ON erp.trn_card_allocation;
       erp          postgres    false    387    543            %           2620    214822    trn_dc_info tgr_bu_trn_dc_info    TRIGGER     {   CREATE TRIGGER tgr_bu_trn_dc_info BEFORE UPDATE ON erp.trn_dc_info FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_dc_info();
 4   DROP TRIGGER tgr_bu_trn_dc_info ON erp.trn_dc_info;
       erp          postgres    false    544    389            &           2620    214823    trn_dc_item tgr_bu_trn_dc_item    TRIGGER     {   CREATE TRIGGER tgr_bu_trn_dc_item BEFORE UPDATE ON erp.trn_dc_item FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_dc_item();
 4   DROP TRIGGER tgr_bu_trn_dc_item ON erp.trn_dc_item;
       erp          postgres    false    391    545            '           2620    214824 $   trn_dc_summary tgr_bu_trn_dc_summary    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_dc_summary BEFORE UPDATE ON erp.trn_dc_summary FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_dc_summary();
 :   DROP TRIGGER tgr_bu_trn_dc_summary ON erp.trn_dc_summary;
       erp          postgres    false    393    546            (           2620    214825 "   trn_designmix tgr_bu_trn_designmix    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_designmix BEFORE UPDATE ON erp.trn_designmix FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_designmix();
 8   DROP TRIGGER tgr_bu_trn_designmix ON erp.trn_designmix;
       erp          postgres    false    547    395            )           2620    214826     trn_grn_info tgr_bu_trn_grn_info    TRIGGER     ~   CREATE TRIGGER tgr_bu_trn_grn_info BEFORE UPDATE ON erp.trn_grn_info FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_grn_info();
 6   DROP TRIGGER tgr_bu_trn_grn_info ON erp.trn_grn_info;
       erp          postgres    false    398    548            *           2620    214827 (   trn_invoice_info tgr_bu_trn_invoice_info    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_invoice_info BEFORE UPDATE ON erp.trn_invoice_info FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_invoice_info();
 >   DROP TRIGGER tgr_bu_trn_invoice_info ON erp.trn_invoice_info;
       erp          postgres    false    549    402            +           2620    214828 (   trn_invoice_item tgr_bu_trn_invoice_item    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_invoice_item BEFORE UPDATE ON erp.trn_invoice_item FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_invoice_item();
 >   DROP TRIGGER tgr_bu_trn_invoice_item ON erp.trn_invoice_item;
       erp          postgres    false    404    550            ,           2620    214829 .   trn_invoice_summary tgr_bu_trn_invoice_summary    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_invoice_summary BEFORE UPDATE ON erp.trn_invoice_summary FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_invoice_summary();
 D   DROP TRIGGER tgr_bu_trn_invoice_summary ON erp.trn_invoice_summary;
       erp          postgres    false    406    551            -           2620    214830 4   trn_ledger_transcation tgr_bu_trn_ledger_transcation    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_ledger_transcation BEFORE UPDATE ON erp.trn_ledger_transcation FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_ledger_transcation();
 J   DROP TRIGGER tgr_bu_trn_ledger_transcation ON erp.trn_ledger_transcation;
       erp          postgres    false    408    552            .           2620    214831 6   trn_plant_office_inward tgr_bu_trn_plant_office_inward    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_plant_office_inward BEFORE UPDATE ON erp.trn_plant_office_inward FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_plant_office_inward();
 L   DROP TRIGGER tgr_bu_trn_plant_office_inward ON erp.trn_plant_office_inward;
       erp          postgres    false    410    553            /           2620    214832 8   trn_plant_office_outward tgr_bu_trn_plant_office_outward    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_plant_office_outward BEFORE UPDATE ON erp.trn_plant_office_outward FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_plant_office_outward();
 N   DROP TRIGGER tgr_bu_trn_plant_office_outward ON erp.trn_plant_office_outward;
       erp          postgres    false    554    412            0           2620    214833    trn_po tgr_bu_trn_po    TRIGGER     l   CREATE TRIGGER tgr_bu_trn_po BEFORE UPDATE ON erp.trn_po FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_po();
 *   DROP TRIGGER tgr_bu_trn_po ON erp.trn_po;
       erp          postgres    false    555    414            1           2620    214834    trn_po_item tgr_bu_trn_po_item    TRIGGER     {   CREATE TRIGGER tgr_bu_trn_po_item BEFORE UPDATE ON erp.trn_po_item FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_po_item();
 4   DROP TRIGGER tgr_bu_trn_po_item ON erp.trn_po_item;
       erp          postgres    false    556    415            2           2620    214835 :   trn_po_payment_conditions tgr_bu_trn_po_payment_conditions    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_po_payment_conditions BEFORE UPDATE ON erp.trn_po_payment_conditions FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_po_payment_conditions();
 P   DROP TRIGGER tgr_bu_trn_po_payment_conditions ON erp.trn_po_payment_conditions;
       erp          postgres    false    418    557            3           2620    214836 $   trn_po_summary tgr_bu_trn_po_summary    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_po_summary BEFORE UPDATE ON erp.trn_po_summary FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_po_summary();
 :   DROP TRIGGER tgr_bu_trn_po_summary ON erp.trn_po_summary;
       erp          postgres    false    420    558            4           2620    214837 V   trn_rmc_batch_detail_devicetransmission tgr_bu_trn_rmc_batch_detail_devicetransmission    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_rmc_batch_detail_devicetransmission BEFORE UPDATE ON erp.trn_rmc_batch_detail_devicetransmission FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_rmc_batch_detail_devicetransmission();
 l   DROP TRIGGER tgr_bu_trn_rmc_batch_detail_devicetransmission ON erp.trn_rmc_batch_detail_devicetransmission;
       erp          postgres    false    559    422            5           2620    214838 O   trn_rmc_batch_devicetransmission tgr_bu_trn_rmc_batch_detail_devicetransmission    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_rmc_batch_detail_devicetransmission BEFORE UPDATE ON erp.trn_rmc_batch_devicetransmission FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_rmc_batch_devicetransmission();
 e   DROP TRIGGER tgr_bu_trn_rmc_batch_detail_devicetransmission ON erp.trn_rmc_batch_devicetransmission;
       erp          postgres    false    424    560            6           2620    214839    trn_so tgr_bu_trn_so    TRIGGER     l   CREATE TRIGGER tgr_bu_trn_so BEFORE UPDATE ON erp.trn_so FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_so();
 *   DROP TRIGGER tgr_bu_trn_so ON erp.trn_so;
       erp          postgres    false    561    428            7           2620    214840    trn_so_item tgr_bu_trn_so_item    TRIGGER     {   CREATE TRIGGER tgr_bu_trn_so_item BEFORE UPDATE ON erp.trn_so_item FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_so_item();
 4   DROP TRIGGER tgr_bu_trn_so_item ON erp.trn_so_item;
       erp          postgres    false    562    430            8           2620    214841 $   trn_so_summary tgr_bu_trn_so_summary    TRIGGER     ?   CREATE TRIGGER tgr_bu_trn_so_summary BEFORE UPDATE ON erp.trn_so_summary FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_so_summary();
 :   DROP TRIGGER tgr_bu_trn_so_summary ON erp.trn_so_summary;
       erp          postgres    false    563    434            9           2620    214842    trn_stock tgr_bu_trn_stock    TRIGGER     u   CREATE TRIGGER tgr_bu_trn_stock BEFORE UPDATE ON erp.trn_stock FOR EACH ROW EXECUTE FUNCTION erp.log_bu_trn_stock();
 0   DROP TRIGGER tgr_bu_trn_stock ON erp.trn_stock;
       erp          postgres    false    436    564            ?           2606    214843     trn_alert_sent fk_alertsent_acid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_alert_sent
    ADD CONSTRAINT fk_alertsent_acid FOREIGN KEY (ac_id) REFERENCES erp.mst_alert_config(ac_id);
 G   ALTER TABLE ONLY erp.trn_alert_sent DROP CONSTRAINT fk_alertsent_acid;
       erp          postgres    false    210    5230    381            ?           2606    214848 "   trn_alert_sent fk_alertsent_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_alert_sent
    ADD CONSTRAINT fk_alertsent_custid FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 I   ALTER TABLE ONLY erp.trn_alert_sent DROP CONSTRAINT fk_alertsent_custid;
       erp          postgres    false    381    5252    222            ?           2606    214853    trn_bpa_info fk_bpa_fyid    FK CONSTRAINT     x   ALTER TABLE ONLY erp.trn_bpa_info
    ADD CONSTRAINT fk_bpa_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 ?   ALTER TABLE ONLY erp.trn_bpa_info DROP CONSTRAINT fk_bpa_fyid;
       erp          postgres    false    384    233    5272            ?           2606    214858    trn_bpa_info fk_bpa_vendorid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_bpa_info
    ADD CONSTRAINT fk_bpa_vendorid FOREIGN KEY (vendor_id) REFERENCES erp.mst_vendor(vendor_id);
 C   ALTER TABLE ONLY erp.trn_bpa_info DROP CONSTRAINT fk_bpa_vendorid;
       erp          postgres    false    296    384    5356            ?           2606    214863    trn_bpa_details fk_bpadt_bpaid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_bpa_details
    ADD CONSTRAINT fk_bpadt_bpaid FOREIGN KEY (bpa_id) REFERENCES erp.trn_bpa_info(bpa_id);
 E   ALTER TABLE ONLY erp.trn_bpa_details DROP CONSTRAINT fk_bpadt_bpaid;
       erp          postgres    false    5396    382    384            ?           2606    214868    mst_weigh_bridge fk_bridge_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_weigh_bridge
    ADD CONSTRAINT fk_bridge_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 F   ALTER TABLE ONLY erp.mst_weigh_bridge DROP CONSTRAINT fk_bridge_hcid;
       erp          postgres    false    238    300    5278            ?           2606    214873 "   mst_weigh_bridge fk_bridge_plantid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_weigh_bridge
    ADD CONSTRAINT fk_bridge_plantid FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 I   ALTER TABLE ONLY erp.mst_weigh_bridge DROP CONSTRAINT fk_bridge_plantid;
       erp          postgres    false    259    300    5306            ?           2606    214878 -   trn_card_access_transaction fk_card_access_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_card_access_transaction
    ADD CONSTRAINT fk_card_access_id FOREIGN KEY (card_allocation_id) REFERENCES erp.trn_card_allocation(card_allocation_id);
 T   ALTER TABLE ONLY erp.trn_card_access_transaction DROP CONSTRAINT fk_card_access_id;
       erp          postgres    false    387    5404    386            ?           2606    214883     trn_card_allocation fk_card_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_card_allocation
    ADD CONSTRAINT fk_card_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 G   ALTER TABLE ONLY erp.trn_card_allocation DROP CONSTRAINT fk_card_hcid;
       erp          postgres    false    387    238    5278            ?           2606    214888 (   trn_card_access_transaction fk_card_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_card_access_transaction
    ADD CONSTRAINT fk_card_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 O   ALTER TABLE ONLY erp.trn_card_access_transaction DROP CONSTRAINT fk_card_hcid;
       erp          postgres    false    238    386    5278            ?           2606    214893    mst_card fk_card_hcid    FK CONSTRAINT     z   ALTER TABLE ONLY erp.mst_card
    ADD CONSTRAINT fk_card_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 <   ALTER TABLE ONLY erp.mst_card DROP CONSTRAINT fk_card_hcid;
       erp          postgres    false    238    5278    212            ?           2606    214898    mst_card fk_card_intid    FK CONSTRAINT     {   ALTER TABLE ONLY erp.mst_card
    ADD CONSTRAINT fk_card_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 =   ALTER TABLE ONLY erp.mst_card DROP CONSTRAINT fk_card_intid;
       erp          postgres    false    212    241    5282            ?           2606    214903 '   mst_customer_vendor fk_cust_custstateid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_customer_vendor
    ADD CONSTRAINT fk_cust_custstateid FOREIGN KEY (cust_vendor_state_id) REFERENCES erp.mst_state(state_id);
 N   ALTER TABLE ONLY erp.mst_customer_vendor DROP CONSTRAINT fk_cust_custstateid;
       erp          postgres    false    5328    222    276            ?           2606    214908 %   mst_cust_vendor_contact fk_cust_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_contact
    ADD CONSTRAINT fk_cust_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 L   ALTER TABLE ONLY erp.mst_cust_vendor_contact DROP CONSTRAINT fk_cust_intid;
       erp          postgres    false    241    215    5282            ?           2606    214913 "   mst_cust_vendor_item fk_cust_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_item
    ADD CONSTRAINT fk_cust_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 I   ALTER TABLE ONLY erp.mst_cust_vendor_item DROP CONSTRAINT fk_cust_intid;
       erp          postgres    false    218    5282    241            ?           2606    214918 -   mst_cust_vendor_contact fk_custcontact_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_contact
    ADD CONSTRAINT fk_custcontact_custid FOREIGN KEY (cust_vendor_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 T   ALTER TABLE ONLY erp.mst_cust_vendor_contact DROP CONSTRAINT fk_custcontact_custid;
       erp          postgres    false    215    222    5252            ?           2606    214923 +   mst_cust_vendor_contact fk_custcontact_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_contact
    ADD CONSTRAINT fk_custcontact_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 R   ALTER TABLE ONLY erp.mst_cust_vendor_contact DROP CONSTRAINT fk_custcontact_hcid;
       erp          postgres    false    238    215    5278            ?           2606    214928 $   mst_customer_vendor fk_customer_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_customer_vendor
    ADD CONSTRAINT fk_customer_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 K   ALTER TABLE ONLY erp.mst_customer_vendor DROP CONSTRAINT fk_customer_hcid;
       erp          postgres    false    238    222    5278            ?           2606    214933 3   mst_cust_vendor_payment_conditions fk_custpay_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions
    ADD CONSTRAINT fk_custpay_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 Z   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions DROP CONSTRAINT fk_custpay_intid;
       erp          postgres    false    220    241    5282            ?           2606    214938 $   mst_customer_vendor fk_custven_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_customer_vendor
    ADD CONSTRAINT fk_custven_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 K   ALTER TABLE ONLY erp.mst_customer_vendor DROP CONSTRAINT fk_custven_intid;
       erp          postgres    false    222    241    5282            ?           2606    214943    mst_department fk_custven_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_department
    ADD CONSTRAINT fk_custven_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 F   ALTER TABLE ONLY erp.mst_department DROP CONSTRAINT fk_custven_intid;
       erp          postgres    false    225    5282    241            ?           2606    214948    trn_dc_info fk_dcinfo_fyid    FK CONSTRAINT     z   ALTER TABLE ONLY erp.trn_dc_info
    ADD CONSTRAINT fk_dcinfo_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 A   ALTER TABLE ONLY erp.trn_dc_info DROP CONSTRAINT fk_dcinfo_fyid;
       erp          postgres    false    5272    389    233            ?           2606    214953    trn_dc_item fk_dcitem_dcid    FK CONSTRAINT     z   ALTER TABLE ONLY erp.trn_dc_item
    ADD CONSTRAINT fk_dcitem_dcid FOREIGN KEY (dc_id) REFERENCES erp.trn_dc_info(dc_id);
 A   ALTER TABLE ONLY erp.trn_dc_item DROP CONSTRAINT fk_dcitem_dcid;
       erp          postgres    false    391    5406    389            ?           2606    214958    trn_dc_item fk_dcitem_itemid    FK CONSTRAINT     }   ALTER TABLE ONLY erp.trn_dc_item
    ADD CONSTRAINT fk_dcitem_itemid FOREIGN KEY (item_id) REFERENCES erp.mst_item(item_id);
 C   ALTER TABLE ONLY erp.trn_dc_item DROP CONSTRAINT fk_dcitem_itemid;
       erp          postgres    false    5290    246    391            ?           2606    214963     trn_dc_summary fk_dcsummary_dcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_dc_summary
    ADD CONSTRAINT fk_dcsummary_dcid FOREIGN KEY (dc_id) REFERENCES erp.trn_dc_info(dc_id);
 G   ALTER TABLE ONLY erp.trn_dc_summary DROP CONSTRAINT fk_dcsummary_dcid;
       erp          postgres    false    5406    393    389            ?           2606    214968    mst_department fk_dept_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_department
    ADD CONSTRAINT fk_dept_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 B   ALTER TABLE ONLY erp.mst_department DROP CONSTRAINT fk_dept_hcid;
       erp          postgres    false    238    225    5278            ?           2606    214973     trn_diesel_refill fk_diesel_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_diesel_refill
    ADD CONSTRAINT fk_diesel_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 G   ALTER TABLE ONLY erp.trn_diesel_refill DROP CONSTRAINT fk_diesel_hcid;
       erp          postgres    false    5278    238    397            ?           2606    214978 #   trn_diesel_refill fk_diesel_plantid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_diesel_refill
    ADD CONSTRAINT fk_diesel_plantid FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 J   ALTER TABLE ONLY erp.trn_diesel_refill DROP CONSTRAINT fk_diesel_plantid;
       erp          postgres    false    5306    259    397            ?           2606    214983    mst_diesel_type fk_diesetl_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_diesel_type
    ADD CONSTRAINT fk_diesetl_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 F   ALTER TABLE ONLY erp.mst_diesel_type DROP CONSTRAINT fk_diesetl_hcid;
       erp          postgres    false    5278    238    227            ?           2606    214988    trn_designmix fk_dmix_hcid    FK CONSTRAINT        ALTER TABLE ONLY erp.trn_designmix
    ADD CONSTRAINT fk_dmix_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 A   ALTER TABLE ONLY erp.trn_designmix DROP CONSTRAINT fk_dmix_hcid;
       erp          postgres    false    395    238    5278            ?           2606    214993    mst_employee fk_emp_deptid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_employee
    ADD CONSTRAINT fk_emp_deptid FOREIGN KEY (dept_id) REFERENCES erp.mst_department(dept_id);
 A   ALTER TABLE ONLY erp.mst_employee DROP CONSTRAINT fk_emp_deptid;
       erp          postgres    false    5258    229    225            ?           2606    214998    mtn_emp_guardian fk_emp_empid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mtn_emp_guardian
    ADD CONSTRAINT fk_emp_empid FOREIGN KEY (emp_id) REFERENCES erp.mst_employee(emp_id);
 D   ALTER TABLE ONLY erp.mtn_emp_guardian DROP CONSTRAINT fk_emp_empid;
       erp          postgres    false    229    309    5264            ?           2606    215003    mst_employee fk_emp_hostcompid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_employee
    ADD CONSTRAINT fk_emp_hostcompid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 E   ALTER TABLE ONLY erp.mst_employee DROP CONSTRAINT fk_emp_hostcompid;
       erp          postgres    false    238    229    5278            ?           2606    215008    mtn_emp_doc fk_empdoc_empid    FK CONSTRAINT     ~   ALTER TABLE ONLY erp.mtn_emp_doc
    ADD CONSTRAINT fk_empdoc_empid FOREIGN KEY (emp_id) REFERENCES erp.mst_employee(emp_id);
 B   ALTER TABLE ONLY erp.mtn_emp_doc DROP CONSTRAINT fk_empdoc_empid;
       erp          postgres    false    229    307    5264            ?           2606    215013 4   mtn_emp_professional_summary fk_empprofsummary_empid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mtn_emp_professional_summary
    ADD CONSTRAINT fk_empprofsummary_empid FOREIGN KEY (emp_id) REFERENCES erp.mst_employee(emp_id);
 [   ALTER TABLE ONLY erp.mtn_emp_professional_summary DROP CONSTRAINT fk_empprofsummary_empid;
       erp          postgres    false    229    311    5264            ?           2606    215018    mst_general_ledger fk_gl_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_general_ledger
    ADD CONSTRAINT fk_gl_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 E   ALTER TABLE ONLY erp.mst_general_ledger DROP CONSTRAINT fk_gl_intid;
       erp          postgres    false    241    235    5282            ?           2606    215023    trn_grn_info fk_grn_fyid    FK CONSTRAINT     x   ALTER TABLE ONLY erp.trn_grn_info
    ADD CONSTRAINT fk_grn_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 ?   ALTER TABLE ONLY erp.trn_grn_info DROP CONSTRAINT fk_grn_fyid;
       erp          postgres    false    5272    398    233            ?           2606    215028    trn_grn_info fk_grn_vendoreid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_grn_info
    ADD CONSTRAINT fk_grn_vendoreid FOREIGN KEY (vendor_id) REFERENCES erp.mst_vendor(vendor_id) NOT VALID;
 D   ALTER TABLE ONLY erp.trn_grn_info DROP CONSTRAINT fk_grn_vendoreid;
       erp          postgres    false    398    296    5356            ?           2606    215033    mst_host_company fk_hc_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_host_company
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 C   ALTER TABLE ONLY erp.mst_host_company DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    5282    238    241            ?           2606    215038    mst_item_category fk_hc_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_item_category
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 D   ALTER TABLE ONLY erp.mst_item_category DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    248    5282            ?           2606    215043 (   mst_payment_other_conditions fk_hc_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_payment_other_conditions
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 O   ALTER TABLE ONLY erp.mst_payment_other_conditions DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    256    5282            ?           2606    215048    mst_site fk_hc_intid    FK CONSTRAINT     y   ALTER TABLE ONLY erp.mst_site
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 ;   ALTER TABLE ONLY erp.mst_site DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    270    5282            ?           2606    215053    mst_site_contact fk_hc_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_site_contact
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 C   ALTER TABLE ONLY erp.mst_site_contact DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    272    5282            ?           2606    215058    mst_subtestmaster fk_hc_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_subtestmaster
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 D   ALTER TABLE ONLY erp.mst_subtestmaster DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    278    5282            ?           2606    215063    mst_testmaster fk_hc_intid    FK CONSTRAINT        ALTER TABLE ONLY erp.mst_testmaster
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 A   ALTER TABLE ONLY erp.mst_testmaster DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    280    5282            ?           2606    215068    mst_unit fk_hc_intid    FK CONSTRAINT     y   ALTER TABLE ONLY erp.mst_unit
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 ;   ALTER TABLE ONLY erp.mst_unit DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    5282    284            ?           2606    215073    mst_user fk_hc_intid    FK CONSTRAINT     y   ALTER TABLE ONLY erp.mst_user
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 ;   ALTER TABLE ONLY erp.mst_user DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    287    5282            ?           2606    215078    mst_weigh_bridge fk_hc_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_weigh_bridge
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 C   ALTER TABLE ONLY erp.mst_weigh_bridge DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    300    5282            ?           2606    215083    trn_alert_sent fk_hc_intid    FK CONSTRAINT        ALTER TABLE ONLY erp.trn_alert_sent
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 A   ALTER TABLE ONLY erp.trn_alert_sent DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    5282    241    381            ?           2606    215088    trn_bpa_info fk_hc_intid    FK CONSTRAINT     }   ALTER TABLE ONLY erp.trn_bpa_info
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 ?   ALTER TABLE ONLY erp.trn_bpa_info DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    384    241    5282            ?           2606    215093    mst_item fk_hc_intid    FK CONSTRAINT     y   ALTER TABLE ONLY erp.mst_item
    ADD CONSTRAINT fk_hc_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 ;   ALTER TABLE ONLY erp.mst_item DROP CONSTRAINT fk_hc_intid;
       erp          postgres    false    241    246    5282            ?           2606    215098 (   mst_host_company fk_hostcomp_compstateid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_host_company
    ADD CONSTRAINT fk_hostcomp_compstateid FOREIGN KEY (comp_state_id) REFERENCES erp.mst_state(state_id);
 O   ALTER TABLE ONLY erp.mst_host_company DROP CONSTRAINT fk_hostcomp_compstateid;
       erp          postgres    false    5328    238    276            ?           2606    215103 *   mst_integrator_config fk_integrator_int_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_integrator_config
    ADD CONSTRAINT fk_integrator_int_id FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 Q   ALTER TABLE ONLY erp.mst_integrator_config DROP CONSTRAINT fk_integrator_int_id;
       erp          postgres    false    243    5282    241            ?           2606    215108    mst_alert_config fk_intid    FK CONSTRAINT     ~   ALTER TABLE ONLY erp.mst_alert_config
    ADD CONSTRAINT fk_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 @   ALTER TABLE ONLY erp.mst_alert_config DROP CONSTRAINT fk_intid;
       erp          postgres    false    241    210    5282            ?           2606    215113     trn_invoice_item fk_invitem_dcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_invoice_item
    ADD CONSTRAINT fk_invitem_dcid FOREIGN KEY (invoice_id) REFERENCES erp.trn_invoice_info(invoice_id);
 G   ALTER TABLE ONLY erp.trn_invoice_item DROP CONSTRAINT fk_invitem_dcid;
       erp          postgres    false    5436    404    402            ?           2606    215118 "   trn_invoice_item fk_invitem_itemid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_invoice_item
    ADD CONSTRAINT fk_invitem_itemid FOREIGN KEY (item_id) REFERENCES erp.mst_item(item_id);
 I   ALTER TABLE ONLY erp.trn_invoice_item DROP CONSTRAINT fk_invitem_itemid;
       erp          postgres    false    5290    404    246            ?           2606    215123 $   trn_invoice_info fk_invoiceinfo_fyid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_invoice_info
    ADD CONSTRAINT fk_invoiceinfo_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 K   ALTER TABLE ONLY erp.trn_invoice_info DROP CONSTRAINT fk_invoiceinfo_fyid;
       erp          postgres    false    402    233    5272            ?           2606    215128 '   trn_invoice_summary fk_invsummary_invid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_invoice_summary
    ADD CONSTRAINT fk_invsummary_invid FOREIGN KEY (invoice_id) REFERENCES erp.trn_invoice_info(invoice_id);
 N   ALTER TABLE ONLY erp.trn_invoice_summary DROP CONSTRAINT fk_invsummary_invid;
       erp          postgres    false    406    402    5436            ?           2606    215133 "   mst_item_category fk_item_category    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_item_category
    ADD CONSTRAINT fk_item_category FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 I   ALTER TABLE ONLY erp.mst_item_category DROP CONSTRAINT fk_item_category;
       erp          postgres    false    238    248    5278            ?           2606    215138    mst_item fk_item_hcid    FK CONSTRAINT     z   ALTER TABLE ONLY erp.mst_item
    ADD CONSTRAINT fk_item_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 <   ALTER TABLE ONLY erp.mst_item DROP CONSTRAINT fk_item_hcid;
       erp          postgres    false    246    5278    238            ?           2606    215143    mst_item fk_item_icid    FK CONSTRAINT     {   ALTER TABLE ONLY erp.mst_item
    ADD CONSTRAINT fk_item_icid FOREIGN KEY (ic_id) REFERENCES erp.mst_item_category(ic_id);
 <   ALTER TABLE ONLY erp.mst_item DROP CONSTRAINT fk_item_icid;
       erp          postgres    false    5294    248    246            ?           2606    215148    mst_item fk_item_unitid    FK CONSTRAINT     x   ALTER TABLE ONLY erp.mst_item
    ADD CONSTRAINT fk_item_unitid FOREIGN KEY (unit_id) REFERENCES erp.mst_unit(unit_id);
 >   ALTER TABLE ONLY erp.mst_item DROP CONSTRAINT fk_item_unitid;
       erp          postgres    false    284    5340    246            ?           2606    215153 (   mst_cust_vendor_item fk_mstcustitem_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_item
    ADD CONSTRAINT fk_mstcustitem_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 O   ALTER TABLE ONLY erp.mst_cust_vendor_item DROP CONSTRAINT fk_mstcustitem_hcid;
       erp          postgres    false    238    5278    218            ?           2606    215158 '   mtn_emp_bioprofile fk_mstemployee_empid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mtn_emp_bioprofile
    ADD CONSTRAINT fk_mstemployee_empid FOREIGN KEY (emp_id) REFERENCES erp.mst_employee(emp_id);
 N   ALTER TABLE ONLY erp.mtn_emp_bioprofile DROP CONSTRAINT fk_mstemployee_empid;
       erp          postgres    false    229    5264    304            ?           2606    215163 .   mst_cust_vendor_item fk_mstvendoritem_vendorid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_item
    ADD CONSTRAINT fk_mstvendoritem_vendorid FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 U   ALTER TABLE ONLY erp.mst_cust_vendor_item DROP CONSTRAINT fk_mstvendoritem_vendorid;
       erp          postgres    false    222    5252    218            ?           2606    215168 &   mtn_emp_wish_date fk_mtn_emp_wish_date    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mtn_emp_wish_date
    ADD CONSTRAINT fk_mtn_emp_wish_date FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 M   ALTER TABLE ONLY erp.mtn_emp_wish_date DROP CONSTRAINT fk_mtn_emp_wish_date;
       erp          postgres    false    238    313    5278            ?           2606    215173 !   mst_name_setup fk_namesetup_hc_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_name_setup
    ADD CONSTRAINT fk_namesetup_hc_id FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 H   ALTER TABLE ONLY erp.mst_name_setup DROP CONSTRAINT fk_namesetup_hc_id;
       erp          postgres    false    5278    238    253            ?           2606    215178 $   mst_name_setup fk_namesetup_plant_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_name_setup
    ADD CONSTRAINT fk_namesetup_plant_id FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 K   ALTER TABLE ONLY erp.mst_name_setup DROP CONSTRAINT fk_namesetup_plant_id;
       erp          postgres    false    259    253    5306            ?           2606    215183 6   mst_cust_vendor_payment_conditions fk_paymenconditions    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions
    ADD CONSTRAINT fk_paymenconditions FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 ]   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions DROP CONSTRAINT fk_paymenconditions;
       erp          postgres    false    238    220    5278            ?           2606    215188 1   trn_po_payment_conditions fk_payment_condition_po    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_po_payment_conditions
    ADD CONSTRAINT fk_payment_condition_po FOREIGN KEY (po_id) REFERENCES erp.trn_po(po_id);
 X   ALTER TABLE ONLY erp.trn_po_payment_conditions DROP CONSTRAINT fk_payment_condition_po;
       erp          postgres    false    5460    418    414            ?           2606    215193 8   mst_payment_other_conditions fk_payment_other_conditions    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_payment_other_conditions
    ADD CONSTRAINT fk_payment_other_conditions FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 _   ALTER TABLE ONLY erp.mst_payment_other_conditions DROP CONSTRAINT fk_payment_other_conditions;
       erp          postgres    false    256    5278    238            ?           2606    215198 G   mst_cust_vendor_payment_conditions fk_paymentotherconditions_custvendor    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions
    ADD CONSTRAINT fk_paymentotherconditions_custvendor FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 n   ALTER TABLE ONLY erp.mst_cust_vendor_payment_conditions DROP CONSTRAINT fk_paymentotherconditions_custvendor;
       erp          postgres    false    222    220    5252            ?           2606    215203    trn_po fk_po_fyid    FK CONSTRAINT     q   ALTER TABLE ONLY erp.trn_po
    ADD CONSTRAINT fk_po_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 8   ALTER TABLE ONLY erp.trn_po DROP CONSTRAINT fk_po_fyid;
       erp          postgres    false    233    414    5272            ?           2606    215208    trn_po fk_po_vend_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_po
    ADD CONSTRAINT fk_po_vend_id FOREIGN KEY (vendor_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 ;   ALTER TABLE ONLY erp.trn_po DROP CONSTRAINT fk_po_vend_id;
       erp          postgres    false    5252    414    222            ?           2606    215213    trn_po_item fk_poitem_poid    FK CONSTRAINT     u   ALTER TABLE ONLY erp.trn_po_item
    ADD CONSTRAINT fk_poitem_poid FOREIGN KEY (po_id) REFERENCES erp.trn_po(po_id);
 A   ALTER TABLE ONLY erp.trn_po_item DROP CONSTRAINT fk_poitem_poid;
       erp          postgres    false    415    5460    414            ?           2606    215218 $   trn_plant_office_inward fk_poiw_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_plant_office_inward
    ADD CONSTRAINT fk_poiw_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 K   ALTER TABLE ONLY erp.trn_plant_office_inward DROP CONSTRAINT fk_poiw_hcid;
       erp          postgres    false    410    238    5278            ?           2606    215223 (   trn_plant_office_inward fk_poiw_plant_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_plant_office_inward
    ADD CONSTRAINT fk_poiw_plant_id FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 O   ALTER TABLE ONLY erp.trn_plant_office_inward DROP CONSTRAINT fk_poiw_plant_id;
       erp          postgres    false    410    5306    259            ?           2606    215228 )   trn_plant_office_inward fk_poiw_vendor_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_plant_office_inward
    ADD CONSTRAINT fk_poiw_vendor_id FOREIGN KEY (vendor_id) REFERENCES erp.mst_vendor(vendor_id);
 P   ALTER TABLE ONLY erp.trn_plant_office_inward DROP CONSTRAINT fk_poiw_vendor_id;
       erp          postgres    false    5356    410    296            ?           2606    215233 *   trn_plant_office_outward fk_pootw_plant_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_plant_office_outward
    ADD CONSTRAINT fk_pootw_plant_id FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 Q   ALTER TABLE ONLY erp.trn_plant_office_outward DROP CONSTRAINT fk_pootw_plant_id;
       erp          postgres    false    412    259    5306            ?           2606    215238 &   trn_plant_office_outward fk_poowt_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_plant_office_outward
    ADD CONSTRAINT fk_poowt_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 M   ALTER TABLE ONLY erp.trn_plant_office_outward DROP CONSTRAINT fk_poowt_hcid;
       erp          postgres    false    412    5278    238            ?           2606    215243     trn_po_summary fk_posummary_poid    FK CONSTRAINT     {   ALTER TABLE ONLY erp.trn_po_summary
    ADD CONSTRAINT fk_posummary_poid FOREIGN KEY (po_id) REFERENCES erp.trn_po(po_id);
 G   ALTER TABLE ONLY erp.trn_po_summary DROP CONSTRAINT fk_posummary_poid;
       erp          postgres    false    414    5460    420            ?           2606    215248    trn_dc_info fk_qt_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_dc_info
    ADD CONSTRAINT fk_qt_custid FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 ?   ALTER TABLE ONLY erp.trn_dc_info DROP CONSTRAINT fk_qt_custid;
       erp          postgres    false    389    5252    222            ?           2606    215253    trn_invoice_info fk_qt_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_invoice_info
    ADD CONSTRAINT fk_qt_custid FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 D   ALTER TABLE ONLY erp.trn_invoice_info DROP CONSTRAINT fk_qt_custid;
       erp          postgres    false    222    5252    402            ?           2606    215258 &   trn_role_screens fk_rolescreens_roleid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_role_screens
    ADD CONSTRAINT fk_rolescreens_roleid FOREIGN KEY (role_id) REFERENCES erp.mst_role(role_id);
 M   ALTER TABLE ONLY erp.trn_role_screens DROP CONSTRAINT fk_rolescreens_roleid;
       erp          postgres    false    5316    426    265            ?           2606    215263 0   trn_role_screens fk_rolescreens_screenuiactionid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_role_screens
    ADD CONSTRAINT fk_rolescreens_screenuiactionid FOREIGN KEY (screen_uiaction_id) REFERENCES erp.trn_screen_uiactions(trans_id);
 W   ALTER TABLE ONLY erp.trn_role_screens DROP CONSTRAINT fk_rolescreens_screenuiactionid;
       erp          postgres    false    427    5482    426            ?           2606    215268 0   trn_screen_uiactions fk_screenuiactions_screenid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_screen_uiactions
    ADD CONSTRAINT fk_screenuiactions_screenid FOREIGN KEY (screen_id) REFERENCES erp.mst_screen(screen_id);
 W   ALTER TABLE ONLY erp.trn_screen_uiactions DROP CONSTRAINT fk_screenuiactions_screenid;
       erp          postgres    false    268    5320    427            ?           2606    215273 2   trn_screen_uiactions fk_screenuiactions_uiactionid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_screen_uiactions
    ADD CONSTRAINT fk_screenuiactions_uiactionid FOREIGN KEY (uiaction_id) REFERENCES erp.mst_uiaction(uiaction_id);
 Y   ALTER TABLE ONLY erp.trn_screen_uiactions DROP CONSTRAINT fk_screenuiactions_uiactionid;
       erp          postgres    false    427    5336    282            ?           2606    215278    mst_site fk_site_hcid    FK CONSTRAINT     z   ALTER TABLE ONLY erp.mst_site
    ADD CONSTRAINT fk_site_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 <   ALTER TABLE ONLY erp.mst_site DROP CONSTRAINT fk_site_hcid;
       erp          postgres    false    238    270    5278            ?           2606    215283 &   mst_site_contact fk_sitecontact_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_site_contact
    ADD CONSTRAINT fk_sitecontact_custid FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 M   ALTER TABLE ONLY erp.mst_site_contact DROP CONSTRAINT fk_sitecontact_custid;
       erp          postgres    false    222    272    5252            ?           2606    215288 $   mst_site_contact fk_sitecontact_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_site_contact
    ADD CONSTRAINT fk_sitecontact_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 K   ALTER TABLE ONLY erp.mst_site_contact DROP CONSTRAINT fk_sitecontact_hcid;
       erp          postgres    false    238    5278    272            ?           2606    215293 &   mst_site_contact fk_sitecontact_siteid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_site_contact
    ADD CONSTRAINT fk_sitecontact_siteid FOREIGN KEY (site_id) REFERENCES erp.mst_site(site_id);
 M   ALTER TABLE ONLY erp.mst_site_contact DROP CONSTRAINT fk_sitecontact_siteid;
       erp          postgres    false    5324    272    270                       2606    215298 3   trn_summary_dashboard_record fk_smudashboard_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_summary_dashboard_record
    ADD CONSTRAINT fk_smudashboard_custid FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 Z   ALTER TABLE ONLY erp.trn_summary_dashboard_record DROP CONSTRAINT fk_smudashboard_custid;
       erp          postgres    false    259    438    5306                       2606    215303 1   trn_summary_dashboard_record fk_smudashboard_fyid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_summary_dashboard_record
    ADD CONSTRAINT fk_smudashboard_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 X   ALTER TABLE ONLY erp.trn_summary_dashboard_record DROP CONSTRAINT fk_smudashboard_fyid;
       erp          postgres    false    5272    233    438                       2606    215308 1   trn_summary_dashboard_record fk_smudashboard_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_summary_dashboard_record
    ADD CONSTRAINT fk_smudashboard_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 X   ALTER TABLE ONLY erp.trn_summary_dashboard_record DROP CONSTRAINT fk_smudashboard_hcid;
       erp          postgres    false    438    238    5278            ?           2606    215313    trn_so fk_so_cust_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_so
    ADD CONSTRAINT fk_so_cust_id FOREIGN KEY (cust_id) REFERENCES erp.mst_customer_vendor(cust_vendor_id);
 ;   ALTER TABLE ONLY erp.trn_so DROP CONSTRAINT fk_so_cust_id;
       erp          postgres    false    5252    428    222            ?           2606    215318    trn_so fk_so_fyid    FK CONSTRAINT     q   ALTER TABLE ONLY erp.trn_so
    ADD CONSTRAINT fk_so_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 8   ALTER TABLE ONLY erp.trn_so DROP CONSTRAINT fk_so_fyid;
       erp          postgres    false    233    428    5272                        2606    215323    trn_so_item fk_soitem_itemid    FK CONSTRAINT     }   ALTER TABLE ONLY erp.trn_so_item
    ADD CONSTRAINT fk_soitem_itemid FOREIGN KEY (item_id) REFERENCES erp.mst_item(item_id);
 C   ALTER TABLE ONLY erp.trn_so_item DROP CONSTRAINT fk_soitem_itemid;
       erp          postgres    false    246    430    5290                       2606    215328    trn_so_item fk_soitem_soid    FK CONSTRAINT     u   ALTER TABLE ONLY erp.trn_so_item
    ADD CONSTRAINT fk_soitem_soid FOREIGN KEY (so_id) REFERENCES erp.trn_so(so_id);
 A   ALTER TABLE ONLY erp.trn_so_item DROP CONSTRAINT fk_soitem_soid;
       erp          postgres    false    430    428    5486                       2606    215333     trn_so_summary fk_sosummary_soid    FK CONSTRAINT     {   ALTER TABLE ONLY erp.trn_so_summary
    ADD CONSTRAINT fk_sosummary_soid FOREIGN KEY (so_id) REFERENCES erp.trn_so(so_id);
 G   ALTER TABLE ONLY erp.trn_so_summary DROP CONSTRAINT fk_sosummary_soid;
       erp          postgres    false    434    428    5486                       2606    215338 %   trn_summary_stock_level fk_ssl_custid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_summary_stock_level
    ADD CONSTRAINT fk_ssl_custid FOREIGN KEY (plant_id) REFERENCES erp.mst_plant(plant_id);
 L   ALTER TABLE ONLY erp.trn_summary_stock_level DROP CONSTRAINT fk_ssl_custid;
       erp          postgres    false    259    439    5306                       2606    215343 #   trn_summary_stock_level fk_ssl_fyid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_summary_stock_level
    ADD CONSTRAINT fk_ssl_fyid FOREIGN KEY (fy_id) REFERENCES erp.mst_finyear(fy_id);
 J   ALTER TABLE ONLY erp.trn_summary_stock_level DROP CONSTRAINT fk_ssl_fyid;
       erp          postgres    false    439    233    5272                       2606    215348 #   trn_summary_stock_level fk_ssl_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_summary_stock_level
    ADD CONSTRAINT fk_ssl_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 J   ALTER TABLE ONLY erp.trn_summary_stock_level DROP CONSTRAINT fk_ssl_hcid;
       erp          postgres    false    5278    439    238            ?           2606    215353 '   mst_subtestmaster fk_subtestmaster_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_subtestmaster
    ADD CONSTRAINT fk_subtestmaster_hcid FOREIGN KEY (test_id) REFERENCES erp.mst_testmaster(test_id);
 N   ALTER TABLE ONLY erp.mst_subtestmaster DROP CONSTRAINT fk_subtestmaster_hcid;
       erp          postgres    false    5334    278    280            	           2606    215358    trn_user_roles fk_todo_userid    FK CONSTRAINT     ~   ALTER TABLE ONLY erp.trn_user_roles
    ADD CONSTRAINT fk_todo_userid FOREIGN KEY (user_id) REFERENCES erp.mst_user(user_id);
 D   ALTER TABLE ONLY erp.trn_user_roles DROP CONSTRAINT fk_todo_userid;
       erp          postgres    false    287    5344    440            ?           2606    215363    trn_po fk_trn_po    FK CONSTRAINT     u   ALTER TABLE ONLY erp.trn_po
    ADD CONSTRAINT fk_trn_po FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 7   ALTER TABLE ONLY erp.trn_po DROP CONSTRAINT fk_trn_po;
       erp          postgres    false    5278    238    414            ?           2606    215368    trn_grn_info fk_trn_po    FK CONSTRAINT     {   ALTER TABLE ONLY erp.trn_grn_info
    ADD CONSTRAINT fk_trn_po FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 =   ALTER TABLE ONLY erp.trn_grn_info DROP CONSTRAINT fk_trn_po;
       erp          postgres    false    238    398    5278            ?           2606    215373    trn_bpa_info fk_trn_po    FK CONSTRAINT     {   ALTER TABLE ONLY erp.trn_bpa_info
    ADD CONSTRAINT fk_trn_po FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 =   ALTER TABLE ONLY erp.trn_bpa_info DROP CONSTRAINT fk_trn_po;
       erp          postgres    false    238    384    5278            ?           2606    215378    trn_dc_info fk_trn_po    FK CONSTRAINT     z   ALTER TABLE ONLY erp.trn_dc_info
    ADD CONSTRAINT fk_trn_po FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 <   ALTER TABLE ONLY erp.trn_dc_info DROP CONSTRAINT fk_trn_po;
       erp          postgres    false    5278    238    389            ?           2606    215383    trn_invoice_info fk_trn_po    FK CONSTRAINT        ALTER TABLE ONLY erp.trn_invoice_info
    ADD CONSTRAINT fk_trn_po FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 A   ALTER TABLE ONLY erp.trn_invoice_info DROP CONSTRAINT fk_trn_po;
       erp          postgres    false    5278    402    238            ?           2606    215388    trn_so fk_trn_so    FK CONSTRAINT     u   ALTER TABLE ONLY erp.trn_so
    ADD CONSTRAINT fk_trn_so FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 7   ALTER TABLE ONLY erp.trn_so DROP CONSTRAINT fk_trn_so;
       erp          postgres    false    238    5278    428            ?           2606    215393    mst_unit fk_unit    FK CONSTRAINT     u   ALTER TABLE ONLY erp.mst_unit
    ADD CONSTRAINT fk_unit FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 7   ALTER TABLE ONLY erp.mst_unit DROP CONSTRAINT fk_unit;
       erp          postgres    false    284    238    5278            
           2606    215398 "   trn_user_roles fk_userroles_roleid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.trn_user_roles
    ADD CONSTRAINT fk_userroles_roleid FOREIGN KEY (role_id) REFERENCES erp.mst_role(role_id);
 I   ALTER TABLE ONLY erp.trn_user_roles DROP CONSTRAINT fk_userroles_roleid;
       erp          postgres    false    440    5316    265            ?           2606    215403 -   mst_vehicle_insurance fk_veh_insurance_veh_id    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vehicle_insurance
    ADD CONSTRAINT fk_veh_insurance_veh_id FOREIGN KEY (veh_id) REFERENCES erp.mst_vehicle(veh_id);
 T   ALTER TABLE ONLY erp.mst_vehicle_insurance DROP CONSTRAINT fk_veh_insurance_veh_id;
       erp          postgres    false    290    292    5348            ?           2606    215408    mst_vehicle fk_vehicle_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vehicle
    ADD CONSTRAINT fk_vehicle_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 B   ALTER TABLE ONLY erp.mst_vehicle DROP CONSTRAINT fk_vehicle_hcid;
       erp          postgres    false    290    238    5278            ?           2606    215413    mst_vehicle fk_vehicle_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vehicle
    ADD CONSTRAINT fk_vehicle_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 C   ALTER TABLE ONLY erp.mst_vehicle DROP CONSTRAINT fk_vehicle_intid;
       erp          postgres    false    241    290    5282            ?           2606    215418    mst_vendor fk_vendor_hcid    FK CONSTRAINT     ~   ALTER TABLE ONLY erp.mst_vendor
    ADD CONSTRAINT fk_vendor_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 @   ALTER TABLE ONLY erp.mst_vendor DROP CONSTRAINT fk_vendor_hcid;
       erp          postgres    false    5278    238    296            ?           2606    215423    mst_vendor fk_vendor_intid    FK CONSTRAINT        ALTER TABLE ONLY erp.mst_vendor
    ADD CONSTRAINT fk_vendor_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 A   ALTER TABLE ONLY erp.mst_vendor DROP CONSTRAINT fk_vendor_intid;
       erp          postgres    false    241    5282    296            ?           2606    215428 "   mst_vendor_contact fk_vendor_intid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vendor_contact
    ADD CONSTRAINT fk_vendor_intid FOREIGN KEY (int_id) REFERENCES erp.mst_integrator(int_id);
 I   ALTER TABLE ONLY erp.mst_vendor_contact DROP CONSTRAINT fk_vendor_intid;
       erp          postgres    false    298    241    5282            ?           2606    215433 "   mst_vendor fk_vendor_vendorstateid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vendor
    ADD CONSTRAINT fk_vendor_vendorstateid FOREIGN KEY (vendor_state_id) REFERENCES erp.mst_state(state_id);
 I   ALTER TABLE ONLY erp.mst_vendor DROP CONSTRAINT fk_vendor_vendorstateid;
       erp          postgres    false    296    276    5328            ?           2606    215438 (   mst_vendor_contact fk_vendorcontact_hcid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vendor_contact
    ADD CONSTRAINT fk_vendorcontact_hcid FOREIGN KEY (hc_id) REFERENCES erp.mst_host_company(hc_id);
 O   ALTER TABLE ONLY erp.mst_vendor_contact DROP CONSTRAINT fk_vendorcontact_hcid;
       erp          postgres    false    298    5278    238            ?           2606    215443 ,   mst_vendor_contact fk_vendorcontact_vendorid    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_vendor_contact
    ADD CONSTRAINT fk_vendorcontact_vendorid FOREIGN KEY (vendor_id) REFERENCES erp.mst_vendor(vendor_id);
 S   ALTER TABLE ONLY erp.mst_vendor_contact DROP CONSTRAINT fk_vendorcontact_vendorid;
       erp          postgres    false    296    5356    298            ?           2606    215448 5   mst_employee_contact mst_employee_contact_emp_id_fkey    FK CONSTRAINT     ?   ALTER TABLE ONLY erp.mst_employee_contact
    ADD CONSTRAINT mst_employee_contact_emp_id_fkey FOREIGN KEY (emp_id) REFERENCES erp.mstempl_info(emp_id);
 \   ALTER TABLE ONLY erp.mst_employee_contact DROP CONSTRAINT mst_employee_contact_emp_id_fkey;
       erp          postgres    false    5372    230    301            ?           0    214459    v_ticket    MATERIALIZED VIEW DATA     +   REFRESH MATERIALIZED VIEW public.v_ticket;
          public          postgres    false    502    6115            ?      x?????? ? ?      ?   G   x?3??K-W(I-.?4?43?0751? 29??u?u????̭?M?L,,??҆???\1z\\\ ???      ?   `   x???!?0DQ??????4Prn?????D 0_?ٷ. W?Jd???V?k?6?=?,	G[??A-?????ԙo?5????@kI)?_w@?      ?   ?   x???M
?0??/???^??g?Е?n?-?Z????"m,:d1d?7C4@?Y??"???T?D??+??	c??޿ώa"m/?<v??YS?Z???ͩm'??????-j?p(]n?+~?C7??&????q?^?????5P???? ~*\d9ZOғdנ*?=4????ܦϘ?ۯ????k?{?`d?      ?   [   x?3?4?t?+?(?1?4䴄df"X?,? ??4/?!=713G/9????????P??B??D????????B?????҄db??r??qqq Y\?      ?      x?????? ? ?          ;   x?3?,H?,Ʌ?朆@hd`d?k`?kl?`haedhej?g`lfdh?64???????? ?VQ         ?  x?Ř_o?6???OA`??b??I?i???F?h?v?"Dv?%?II?o?#%Ye;???g???#????HQ?4-?E??E?Ht5?<?[D???H?<???FG???T?L?D?FQ(A?q?pضh?&?輾%?@I??????c6???8?Ij?lw????^???=jt???;$?%>?[??#?5?/<^gE??^??uv?$??sPxY??A%?'9?xr6????.>???'?$O?e?'?F?&?H?%?<$?&?px?ё?Fj?c????Ն????z??u???OVw???~c?5J????????%??΃??{R<f?œK?????L?_l?]???ݴrۊ?
?)???????-Vh]C??T?LĂ????+h?-?=B)xmGPї>?̻?U?GaJ-?????0'???"#/nѳ?v??sc?՞P?+H?Ay????kF?(??U???j?0Ոj?|0R!B??j?jc{'*?E?a&??g??]Z???n?<<?uȀ?<?????*?
BOX ????()?9??l??????l???<?u??b????$M?yQ4U+?U?b1????B?F?ƞ?1Pl?pW]b??Y???<???*?w???g?p????E!s??:?:?3?1?]????n???&;¶?*????Uv?|NҦ?L??:?u5?[?D?????t,!2"??L?cl_??Nn?6~3??.@??"M?e{wɸ?$Ix??3???6XK?`??
??*?v[?t?????6???~?J???O"?dWTK???j	͈*?\??k2g?B?AF؊ABB@?V!?}R??F?:? ??Ggt?G????:߁?A?}t?K?눃?]?E]Lxu?AХ?.貏?&??x5N???yW?rk?z?ZcUL?A?j?B?3?}?_nW6???L???j?*ص??]?3?0f??ߋ?(?}???????vV???7;???Og???`;<|vјF!?2????N?[x5t]?2?]??F???w????}f?h??1?3?????Amq0f?a>???E 6??`̺?,}f?3?@?F[??t???l|f@???9s?a6>s?3??fT????I?9????Bm2#;3??????Ua/??@?F??CY?uW??{??@?6?鶓?~b?ڂe??BÄ$Ѷ՚??6k1?-򷮯n??????[?m?n?0?C??VB?>>	???(߲?v>?????p ?ĺ?%?i???/u???|d?⮜??ǫbD?=ȓ<?&?ԝ0Q??4]?:UFH?" h???ƫg0???Ǜ?NB)???><???<??!???|2???f?o??t??dv
?ſ?????????????????{B??){ʤ?Q3?D??gxڱUU?????W',7"~kBf$U?Y?i??WU!??+???`n6g??????+\??VJ??t-???(L??H)b??H
#k:w&???????Xn??=?[e7;???????O?)xYk???B??:??ʇh??jt???Wa?=??         2  x?ř_O?8???Oa??{??v??٧c?V[
????/IiHQ@|?'N?8?? ?L4???y<???<??c!C?Y??&&"????|tE?????= (2???g?ᔳC?? ,?$?'??2&??KF??t@)??̊d$?(I?d??bV̒?̶?Jƨ?ȓ?a?????O? `Jp??????_?????X?8???????|{s??sjRU??:ʊ??圜?-????????YQ????b???q?_

/˧T?4?ɗ??!?g?6?????x?q1/??Xt??dJ"???K??^?UJ-?F?se>?|U?k???
?i?pg??us/?????Q?.?h3B?˸x??JFSr?TȸLl?????ݬ?v-?+<T?v??ߜo??n?P??E6˷ycಎ??-m>?+?????+AeK?????=Sۼ??>T?op??A?<7?~_??7t????gC+*Ӣ$0?q?B??>ESxcվ.????cnc??d??W???L??9]???z?*???>͉-????)??$O??)W?.??Q?????IJ?\??խ??YX_?????5x???m?t*?8?6?C?-~.?rtH????_e??"????I?6???M??w]׃?6?q\?4??l??h?8????EWɴ^?ŵ?qR?[oF?4B???Yc????kr?????O?????ɷﬞ????j??Yٺ3q?NB?Rn61??Ī?=	T?9?
?^????;???p?@?w???n????D/???n?pK̅W@??-}n???w???bg`?>3?????^l?^p*?C?*vF'?h:|_????w??՘+?4v?h[tج???Ҡ??i?ݜ??G?-C~ɸs?d?ْ?ΖQ??{`?-`?mT?ހ????`?U??t??,[?????X9??V-??Յ??X;???-`????{?`?G-`???D??L???-??p5???9s?a??3??0?B5???ec?.+???v?\??z?-??o?s?>Lu??6`?Z0X?oEwn????=NwO,???v?????싫?g???Xv?A???f=?J?b[?WopJ^???|??rC??r??6?`???n P??g??ZU?????)׷a?4???????d?㌜L?MN???O2<?L????4???'?M<??F??Yw?.???zb?m	pgTv?3?jvb??<??????U??	%?Wb9?p?0?hNs??W9???5??}?"??:?V???????Ykk?e?4K??ЬH>DcȵFC?|5????            x?????? ? ?            x?????? ? ?      	      x?????? ? ?      
     x???QN?0???S??b?I?<qv??D?j?[A?6??q5J???????i84Hi? ??????????@ M?ռ?a????P???+o????x?	?Fr?x?$??.t/G??H??д㹃??z???)?,??????y?????sk?PG??q?d??>??f3?6???K?ԕ????Q?'@S??,???|??6?"????D??{?MB???/Ix1?o??IY_r?ɭ?.T???/e?????P??            x????qC!೩?5 ?]I????_Gp?{??`Ň?,??cϢY?????????B$??FV??U?|?3??e?>2?p̊]?0	Eq4cK?????3%^82?%#??(?G??|??y82??g??ZL?VOu???pf???ln?k??????~?e??l^?????>B{??	?|y??gof???{+??g{??<??3????y?a^?Am??B۟??T??k??BJ???HЅ????????Y?????URJ?h??            x?????? ? ?            x?????? ? ?         ?   x???;?0Dk???=?7?[j??)I(B??Ä??@???*?f<??0#?/C?n5? FM??/ƛ(?H??A)?
?@F??????x???;[jU]z??@Ԅ?Q?1?-????Q?"mQ?s???E+W?sWq?>7         ?   x?Œ?
?0???S?V??M?@P?A<?R?? "?????q??Iɡ?????%߯?Xk?3g 0?????_?'?~&?R???%A?D?Rsp??M?ᘞ??9?G????,?67??v?h???W??@U???
???????{%Q?R2?e??!h??1?4?8?Ռ?EY??D??Ꮠs??JFfPjY?????         d   x?3?q?,).???Î?????P??B??\????????R???????ȗː?3?$5?(?$???a(???(?XZX????Z?͋???? A?"?            x?????? ? ?         i   x?3?q???É?????P??B??D????????@??????Ɨː3,??4/%#?(Q?3D!??DO??$E?(?u?,?L??LM??LLM??F??qqq ??%
         ?  x???mo?H???_???V?p???R;i,_'מ??iQma?????7?,?R??Â?0????̲$?(?N?|??^?-<l???>?J???PL?	O0E8?y3??PF4Pw4????!8 ?*???'?(?׷??<]????!x??1I(i??{m??	ԣ?[??{?X?6??>???<u;???0??A???? ?ؗ??$Rw?????F?2?x??M??ڳ????0?z\-j??_'S?????H?	?p!"c?cN}"I@t???=??????SqU?#??Va?&\???	?9x??^S?.VI$?5??v???x?n,3R#?m?zIB???w`??ԶcHq?a?C*I?d5??v??%?????/y}?FPߛJ?BE%?i,????@D 1?1?>%?EĆPߡZd??NX?D?O#\z????ZTsل?&?X}?
??B?쉦&?????'^?F?? ?s?ׁwq?^"&L???Yr?????k}Ř?$??2?X|L\?[68??x???l:?3u?,'??lpqs?Z_?|?k??:?pڲ????k?=d??????h9?`???????;E??????????)??xm&Q3?s??P'?????:B?و??@?N?????"?o??ZӤ?Q}O뇤?Z?BCc?8??B??^??_1J/????2?dh???!?O?O(?x?Aw??6W??>>f%z?.?8_??*?????R??	?Ix(?wF???????#?@*|μHuF7?[Q????Cd??bF?L???"?A?Q}?p/Q?
S???&V?~?E???R@?P??CWސ??Oh0?׳-???%-3=bI?oa|??*C?oi?5ۡ?O%Zf??@?-???????!?oo???o??wj??t??u??v????9?~4??=d??[?????*E???ŋ?l >RK\ m+t??gh?n?ۼ*JxH?D}4-??ʋ?2?v?-T,?? zLw????GU?<???2/?v?	??n???R?|t???Z??aP?,U??h?ᾱG??(~??A)????]Ul?R= |tU??Κ9-6??m?2v??/kc?M????Exr?!?	<????RyLa}?iz]|ߺ??'??Ƚ?lWA?`Q??皆Q??R?0?1??یY?R??T????????m?ņ?&??.6Tӌ??`???X???B????m?j0?W?Ͳݪ??'?4I?gM??ٺw??-?೘59L?Vn?N?????:???dO????g??Z?6{
lhB??Ā&\1?@?ӂ-pi?Ф>???M?4fh?>???Z?????D?8???p?Zk?]???I?^??????b1?M?E???? CXLa?F~@?t????0껵?:??
?9?[ێ,9{m?_0??H@?׊??.??쒓?,l@w??h?~I?%'??mi?Na'???S?u?ˡ^??-]????%?H%?s?8,]?<yU?T?ɔ?x??U???[?&P?P??A?Ceģ}b̪Sdg??M?DC>By-???N?f7Զ???O?P3D??ߗ?]p?5?? [??ҁh[<?$??_zoa??.???A?(?U??jltz;?%ă?Fup??b?B?\T&??zѰr??0ˢ??????????<&b?}"???̡?_.??s????װF?w?????4cw?u5??J??VQ^K?-#ȸj?d?T???g?ۇ?h?????B??~?O&??	2?I         ?  x??S?n?0=O??????|c?f)?Q@?K/H??@D????	.???$???yc#l??LtEەՉ@ |?p??h?4?T	??????BBi?i??K??Z;?lvQ?k?A??*???u?϶?H?2??(?ȡa?DV???m[?I??7J???*f??????????p????+?EE?,??y0J??? ?M?_?????#?:?|?B???14?(rG?3?NViW?????????E?5?eB?-??00ң?s???<m?B???1??3?$??t?p?V??*k?? ?*\?3??&(
??G2?? r?<ʸc?`?$??2?D?5?mQ@~?v8?W?)fl???Jtl6ۗm???&?__??4??K?Ð=
?q}'?.lۇ??????w_????O????ԧ???!??X&?@?A{D}?ڂ??$$?)?Kµ??pAe?Z?????B?5˷?g???\1??*??"'???^??w???b???$?         8   x?32?rcC 4202?5??52U04?24?2??37?426K??qzr??qqq .
         ?  x??\?n?H}V???	????d??c;???kX?d0h&!F?@???b?~?/?H%????\??i?OuU??ꪦ???@$??(?-
(???͉Qs?p3???
?!?'T'2
??t??皃O?????'??!Ʉ????%??9ౠ???@(??6?;S???B?G ?B?p?γ?z<%g?٧e?Ze?9?MW?l??Ǔ??<%O???y????}?҄?vv?h?Yp?~??R2???????M?lF??w?????ӧtI~!??z=????<=]s?rD??d??g???o??ׯ|?m'????)??z4a"?UՉ??NaUȕM??vj??
???<*??G7?i;N\???m????y?m?7?笇.??	F-?2/˒.?v??IJ$??ڦ?????Ђ=?ф??=???՛?s?\eLSr????a??????-ޯ??tps>$?/?o?q6???瓔L>???Y?'??%??Ϯ?????\?9'?z?>?ߞ??ry{v?̨$?R25j?,??t??>g?/E{?K?>]C| ???1?????!02?????|M^e?A|s?l1?֋%|???r?L?kc\??
D?2V?ߑO???a?|G֋?????2[ܯ&|hjچ??4??\???/??C?FR??7?8y?-??!???Q? N?W??,]???\/???\rv??&N?????|;?#@?=gl??aCE>?_P???i?!4.?j0|????vr?????q??$Q ??>PrYu?b???????l<x
-??autw\5z(?6.?*y(??wT??wL?ʄ:R?i?;+?Vj????yA!?1U*?|ϣ???^rA???P???u?v?K?:*d?xB?y??We0????z8??,?#~x`?
mo?^W??t?SR?l??FH.?0???+????x??F4????j/c?8r?Ng?f?P??<]M??'C??p?g??ɮ?%b??A??(<a!a"1+?8?QX???5??}????' tU@ ?w???D???"??H????\v???2'^ؾ&)?(???&I]?xm7:H?K8R8Jj????R?[%*?P????'??./??`?*?????]???l[??Q?]xXG???d???J???j??ߚF??DJ??*??U?
,U-"?&???ڊV???N&kcoو???2????^+('?,?rⅹ?k?I?`e????N4AE4h??8????Km}??U???=}??8aa"X?j?????X?8K?????Ml?x<?	X7?'?-?'????????I*vv*?TSs???T?@YGG??\%?K:sl0?*f?7?U???	D??\W?^?VG?^
Hl
q]???>??"?v/]Evm??f;Od?;?õ)??4??hT? ?auq*Y?ߖ)?+@??C??t???Z?X?Ad?v'??????rv̱? n???,?B??ញ?)??|EƄA????????h??;?P??
X$??R?E??U?????`G???????N???rBC?2?3Ev????B??Y??{x?Z?+0B;?8Qő??֏???Rw??M??6??z?????.??n^?^????y?mwp%j&??q?w?*c?͍?G?Nq?Zn?Y????V???K?m??h??̍,fv?ZΤ(?3=???t?޼?{?sB???C?ʌV???'7ovt?QM밚??d?0^YȬ+Ac?΢?L? n'???SV?d?`??$?$X??'??%XXx<??;???x?{?B?$X???yW?xK<??1??F9<?ϻ?TK<??8(DA?y<?ϻ?d[?y?S?y ???'??]????x"??:Gd??.??!?&V?I?Q?????7""??s????H????5D?az?7"???h	??\'D??z?:2?Y?k$?ޖ!ba???bxqu?o??S'???=,???)??"ґt(?t?)???M?H??so????®??$???I?7?m?aUa[?D@0?}?????%9??X?ɯ???]??z??u<?K??%وƱe?m-[)I;?anV?׾?~oQ?x?E???c y?Ft??E??8????D?I??HΉ#DNZ$i?c 9??'A h??=???VG?!?Rh?c ?Uf??Gq???H.?!?Q?!??8?KE?_?????.?>?E???9B?^?zuquu?zH.?^\^]\܌????L?l??:??;LL?koU?(??j?7
Ż	?ɧ͉?4#???????<?
b?U%????ǎ.?;)??jD?i%???BS_|??ә??;P??m@??Kh%c?rr?X<?t?).^???????*`+<׎??|?f@htH???X??J??y?Y???z??3??Q?x???2j????Y??18M?P???O?M|g?a?M?l*w6o*?0?8??q?l?빈]x?G#??]??F?????iv??ʦݲ?ީ4???N?Z????]?n?k??=???Vôa??F?W??oUa???kE?C???V??߸?e??Z??_??ѱܷɕ?4?F????#??}?}?}?a??>?'?ܯ??חm)
??V?00S&0\K???T?Ņ?J~m???n????5???<?/???E?????G???_?o?hQ?c???~?q?e?Fq?G?o?h^?c?qz????gq?G?o?`^?cqR???~????.??????a?~?oz?ڸ??"???^տV??׌{??Z?N?Z\7?U?k?>????q?`+????ǽ+?m?[?Wcz? ????+N??????ܶ?Q?"?~ܢh???q?
?_?]U@?X?Vl?? ???Nչ6P??8.8w*ϵ????Kv?%???m??ҙ???_?r ?&?@???k߄b?%??3??=???8*=8΋?ɹ?I??Q?lhB,????>?????c$?p?Q|?B9?vfWW??rl??!????:?:hC???v????*?w????8p?A(???8p?A(???8p?A(???d??1
?;3y!?	?۠s%w?䦒?
???:?νw?R'?<?ӷ??tS?dы????B`??Y??Pմ9?9?\?????vh?~??"?B?wE??J??z???\??c?.az>d}?(????#+?C?C??u?R??5<?b???l
??!??-?k?8?%?G?????!??-)d??.x???? ?"??      !   ?   x??NA
?0<???ٍ&ƛX??Ƌ?R?"%???`???o???^?evg??a?Z??͒)?&?zGT?.?????ھ? ?s?ZtU??????*NS????0?????@??ϰ8?????&^?W{??ȫ/va???>>??	*>qUJ?73e????;n/?$y	'8?      "   ?   x???1?0???+?:)wW??M,ҡq?C)???!+????$C?t)?????}????8=cd<(?"??e?x]Ơ????}	(?cDA\d<?<C?C&#\???p?yL ??p(?*VpW.?+oҾ?? D9??=??~?{7??m&?[m??ޝ.???q?Z?$????k?????a???kP?,K??????FQ??Z?      $      x?????? ? ?      %      x?????? ? ?      '   ?   x???M
?0?u<E.`??$j??? ???.?h???j???	??pa??#????f	C???ΕŖW?;:f Y]???wc??_????0,6aiLGiIZ%?F???R?}?(\s??;7ϟM???-k$?? ???????ZB?????????Y????????? M?傢Q}?qVN      (   ?   x????j?0??????????p??Aa??1v՛?t0?Ү??%,?;?d?ϒ0??ms:????ؘ??i???f?i}n^?*R?	o'?X???11J?A?2??.Uw?z/?D??N?Ea??誫??u?????nO?S.?;2ַ??dr?<???d?,?)x?\??e?Z^????????a??B??@2Kvb9$????az,g?q???D\?1??ux*)Ѥ??SWdA?,??K????o?6?(???«      *   ?  x????n?0 ?k?)?A?w]?u??mZ/vS	y???? c?fO???4IgH??(???ۄq????Ħ???}??([])?Z?u?FF?Eo?zD?#??bJ8^`>'<?8'?h?e???{=???d
*?RN?d&?Rζr9??m ?-u?????@??j??@?c??8J{?ҭ5?? w*즓pٽ?rm??l?;?.h2'Y??????xI?10???hO}??G?i?Ȣ?v萲?9?wswG?"c??|?iN??S??')??u??q?9?Xɸŝ??t܊?X?q+A?ҍ?yH??q/=x5?x?[?????	?ȸ???Jr???ｐ??j脪Q/A?M4?/$????.ށ!?DW@'??p?5??U?J?Mtt?c=???ەwP?tT?6]?ݢ????????`-?|???ɠR9??>N???I?'x3??J?B?*2?@2? ?0??T v??\9?.*???_?B?Y???E][????++??k'}?Kr?QY????m/=??"ԋ0??^<	?l7?Ja*?N?1?_??ʾ????PXJӈ?ӵ??????}?$?]??
?F>]?S?BPi?F?,??m]?????????[?J?j?Ŷ?=-???wف??Y????	Z?6/P?????&?.?b?C???Fʳz]?1???G{??6M???h6?????      +   M   x?341??-.?ON,J??y????F?.E??y@???u,t?L??L,?L??L?,?9c?@ȗ+F??? !?      -   ?   x??P?N?0?ݧ?Բ?oH,0 ?۠?J\?}?^Es??؈?????O?a???p!ᖤ?`8?e?>8=-??a?{;??t??G?Х?q?m?/?ݺ?w?????e?-Q!F'?4T???????rƔ?F?0??????E??7|Z??b?p???.??ő0???!;???DȾ?;`?·?2m0????T?a???J-??~Ր?Q=KC???s¦i??q??      .   @   x?34???IU(I-.Q0??4B##C]]#SCC++S3=C3K33????????? ??H      0   R  x????N?0??O????9?z??uK?r7u?l?6&?D???7?h4?%&~???? ?G?ñ??H??RR	*#?%/
F0?a???ց???????DF!?bn?C?l}{O*??a???އh?F'?&?LV?B S0oN??祄3.u?2?֝?u?o??????X??Xcq????????͡?B??v??4????rt??Z?H	
#????Ҭw???=???+0??uJe????GI???jv1?}??η>k???>y?J???A???1??.8?a&??ȍȹ?C?$ղ?~??_?`2???p5?aٮ?ݺٍR-O???F??5xF??1??_(      2   	  x????n?0E??W?l?3|J??E?,Rp?n?amv?H%??ߗC;?K??E(Bi??KΐȀI?O?????}dM??a&?L?"???mtt?8t????)??DVX??$?a?js )M??!+j?.??:<????)?rP-6??B?&?y?h?@??y?????m?Z??"??f?:d??m??g??%???_???4??.????0??r??ݔ?>怟?.??.?????????=O??m?߷??1?? ??ڬ-f??a???9?n???q?-?
???!k$?hޭV)??
<Ū?/P?"))4S???J?_-?????S???<ôm?FWvRK6fMMk???Z酷??E??7LI??R?@ ?vv?;????E}L?
??gtJT?Qx*?"??Ŗ?E???P?(U1W?]?H'<h???{ʽ??K?/??خb???}?7?k?7\??d8j??c?S?)h?~2???1?KBk?8?:8? ??+???ǧ>?? ?r??FE??~'&??/??      4   ,  x???=n?0?g??@??7?蔡E??Y?$N
?1Z9?/?*-?f??`Sx?<??]???c?
̭b???r?QB?	?ڬ5?0$r?H9? l_??,???L????D1??6sJ???|?????=?"?A??Ǿ}?????a?4)J?Qy?9?????4?m/???j????WD?}?^?h??CA???q?W.?	*????h?#8B???ݍ???<\$??'?x?J?lۄ^E???d?]?x?Φ!;???H???\??]???MJ??7?Vj??????8      5   M   x?-??	?0?_?p??$4&v?:A?%??hQ8??S8???Xۛ-_-ǻ?U
GQ?Ļy?V?9bM?<?JD?4?      6   T   x?32?BS??̒T0??u,t????L,???,?,-,8c?8?L98J?R??% 59????AJ8=?b???? ??p      8   W   x?3??M?H,J,?()J????4B##C]#]#C+C3+#c=CscSK.#?????D???Ĕ??"?s??f%??4F??? I m      :      x?????? ? ?      <      x?????? ? ?      >   ?   x?m??
AE??+?v?d?0;???????G????}qYe?pns?~?,????7;`?a?82??[??R?,KD;??4?j???2?.?2M????%?h??P`{|?U?ϑCTX?͋?]?Qʢ?X?`?O/???c
?????o]O??      @   &  x???Mn? ???Sp#??m????U??&?IC?????/qS????F#????7??H6>?, pƱe]?8A??u\Rkx?Aؽ¦??^?@?qY?kF;?7?u???E_??,??u?ZQ?+??)??!??#?~:???B*Kբ"?9D??J.?????B???*????4???}?H.~?ͣ'???1a:??|??O??ny?"{+'-???!B????? ?6$???5?F[?~??&??硿??2?Iƨ?Р??.?9?,??x??8)jj?0??2?5?!??????7E??2?m??`.??      A   =   x????$pf?pZrr?X?Y(ZX?陘?X%9c?8}?b???? {?I!      C   ?   x?M?A
?0@????@??$?$Y??rY?T?L+Z<?+?_~x????\?4B?[g?򹖩k.7s?+?#?F??
	C?d?e??v????1??0?w\ݫ,????<??6????!???^o?Ro2?%+      D   X   x??A@0???)\????԰rV?VDBB????}S6,ϫ?*????a??o{?=?? ???<?P6Z6?!?	???أscp??s6      F   ?   x??ѽn? ??{
?????fJGQ?L??vi??}??ȦF^2X ݝ??o??B?d1?&+m2w9?????Ǎ{????k??}?p????i?4?yb???c??:?\?Ҡl?|j?5:yv???
l'?⭧رd?L2??R?/??????????l@?,?0?_?<ü!?-,ְ̰lK+?ޝ1?Z_e9td?k?8$??Ce???{? p?čC      H   ^   x?]??? ??] ?D&??N??b?
??ʖe?l???????	-B~?׋??1Ǚ?Я???l<?O?֪????b??{D?g;?      I   Z   x?]??? ??] G? Ct?b?	J_UN?ur@JsN??,????:?H{YD?{?ׇ?,?~??-RK?`1'??=???       J   W   x?]L??0???`?D?&??t4??@D)?-Y?lW??T7U3/0Η?ED?-???;!?D?$6???]???Y?u?v8???7P      L   ?  x??Tak?0?,?
??D?d˖??Y??e4??d?(?9k"?????I??8Iו?l!??޻???kS?va?F/ %m??뺶#\])|^????e???T??v??N???ŗ?s?F??>=????תRV5UkN (Iu??,&????З#?װ8?i&$??p&:??Q?5Y֛a????2?xC?3??@x??L8???ٚ?πmw??n??<?3??n]G	ju???!t??IYZ?4}?̝_=?CB
??????2YN!??P!???5P??NWv?Ej?p@Fvi???p?O??7????Ks?Ĺ?9??sG?H? ?]r??:PapzXϯ?;S?p	??Ɣc?9?9 ?b??բ???X????????H??ו?????t7??Z?S?X?c"?o??_g??S*C??p7??=z7?9#????K9勫ٻK|{3?x{S?s???\C?X???i*?G???4?STJ??l??*?'Q??1?      N   g   x?3?4?K?K?/?O??+IL.?7?B#cS3sKdfX?Cznbf?^r~.H!???????????????????????9X.??|??1-2"?"K?-????? 3J      P      x?????? ? ?      Q   ?  x???Kr?0D׭S?F?+_ )?$???)?NI??Т?bYib??MO??`???%????4	/sW?????T?\>;xH.??O<τ
F?????s9?6?7I(??:֠)+:0K??ED06H?t.?U?b???V??U?Y?S:?<C??-S???qJ:?)????ϸ_?4?? =N}߯??x5?5cݢ?Pj[??9?6?+8bfq?[H???b????,$uM-;?X}?f?%?B$bap?_8?????&^<)s??s?|~&???hytJ?a?G?a?+JI???E?LμI+"1??S?0??1??n????=?????ښ??b}ط???e$߂9?i* 4(댼?2?????~B4?<hôH[)?8?Ռ?vZ?? ??@.h??KQX??ZS?M?????n?F?CRr?d??(B_{E??O????[???Kf\
??m6?????      T      x?????? ? ?      U      x?????? ? ?      W      x?????? ? ?      Y      x?????? ? ?      [      x?????? ? ?      ]      x?????? ? ?      _   2   x?3?4202?5??54?42?21?20?,I-.?4NS3S???=... ʷ?      a   3   x?3?4?4202?5??52??LL?8KR?K8-,,8M?L9c??b???? ???      ?      x?????? ? ?      ?   D   x?3???4?4"N#NC ?30?4??PP?????P??L??B????????X???ٗ+F??? ??      ?   E   x?3???4????44?4?44 =NSah	???????????????????????%H?/W? ?6      ?   F   x???4?4202?50?5? rL9?8??????????	U`T?`hjejbe`?gli	?????\1z\\\ ?e?      ?   Y   x?????0?3Taa?1?? ??a>^?zaa?y????%XG&?`u`/?꡹??%??_????O?K<[???3?_?3?_?R      ?      x?????? ? ?      ?   p   x?u???0?7=E?!Z?Rk?v?L?f?wU???h?)?h4i\D??k?FUwlO???????/?t??c???q???	Y?~??+6i#?????_o]?S?j)?8i)'      ?   K   x?%???0??Q????0=8??:?(?m? ??????꜍??+l?I??e?n٘?Y?=}????3D?:?      ?   l   x?uM??0{?Y >??[??	?k????>'?t?(??;|???H? ???#?|????:q,J-????W????_???r?L??͟?C7{??w?ړ?~??%       ?   u   x????	?0??)?@?{?c?ڡ? ??3?II?:8?B?B9??? d?"*?}?r????z??}sz?h?Z????S????[??e??UO??Z?E6????j?(v?uI!?	???      ?   w   x?U??	?0C??)?@?t9?>??N?O;A??:-?I-"!)??C4?h??fk?Z??????`???,?[B?%???(?zWl??????kq??M????c͑n???V??=???k3U      ?   \   x????? ??] '???@'`?9
??ZY?-99?A4P?g?2N??F?8????\?6s??????????AϽK??$?b?D?,"??-K      ?   `   x?U??? ?a?. ??P;???%H}?q,;>
?,???g?ъB??Y????Z?Q??꟤??Ĩ??m???????l?]M{?͙%??1{?      ?   R   x?3?4AC=,d?X????P??B??B????????D??????(	TD?\F?RR??e??$??2?;*F??? R''-      ?     x????k?0?g????`????G޶ec}?[?S?Z???B??????4??]???"???k?O̷????????????????????acM??r????????4??97"???M????@?9?zo??'cGk?:???:???"??=č??Fb*????._??n o?9???pV(??A?\?*q+?oY?z???#̥.*???????]v??`?\^?s<?????9.???a??s?7;???>???o???~?o???_ܿ??s?_???-??n??2?%?u?e?z???C&? I?w??%???,?8@?6?6Fl????	?t?lm??g?:ԙ???2A?%?LP2A?d??Wf???dm?c?1??6??~P~?~?~X???A? ~???eM ??a?S?e?????????????ŏ?G???Q????v?N~?QY?T??K?)?i?i???I??\@????O-~j???????w????;?w???߭???????????]?ߵ??????ϵ?]?Y?Y?Y?y???g???Y?,~n?s??'訬}_?????k??~?????????????-~?????vT?~??q????hX???????h??ɟ:*k?֖????*????q??????[????????,?T/??}iq ? ? ??$?$$	 I IH-?? ?> ?(??n?啟??<ک6???? ]??@RI???p`~??^Ş????l?????~f????????S?y?;ԁ?m?B?;????M?k????d???7W*ޔ      ?   ?  x????n?6 ?g?+?87^??d?[mЧ ????&rA??%??????? u]??Zi?:??.8H????8?~??2??O~9@????A??{??????????????~?#??FH??Ì8Q?r?x?w	?b/?^ȽP^<?<A????bO???=?WBxx&??,? ???`"?L????3Ezf??r?ť7?1?????????????????????2?f?9<2I????8>	q??pn????g扄?ht???PR?'z?????,??vb?]?????L~???B?Uj?0????t????;?Xk.	sM*??咒? ??????^?c??????
j??.??UV??8?>?o?NI?8le??6?Je??ɟ?????/??ۛ?Oó????????3?1>?m??ƧG3>}+?Fs??Y??ͨ͠?tۄ?>?cXo.??????l?{@i?8?*?x?8q?)???˜ݱ??O?h?h?h??fG???Q??vT??????w?K???Zp0v?! kk?5;?Ԯ?4??A?[?a??(rqc??nv
?֎֎kvT;?ՎjG??;??GG5ߩ'c'c'k'k?5;?]h$???I???N???l???[p6v6v?v?v^???Y??vV;????y?=;??.-???X?X???E??vQ??]?.[??ێ?Q???B?؃?k???A?A?A?A?A?a?=췃??ﱅ??Gc???=?٣ڣڣڣڣ??{?oGG5?S?????ؓ?'kOk????????????Ş???Q???B?س?gk?֞??Y?Y?Y?Y?Y?y?=ﷳ????ן?Jy??V:?T?????-o֪-n????????????K?_???P7?ҴY8IX???w?׾9????S??>׋?.?????????{=????$c?      ?      x?????? ? ?      ?   u  x???a?? ??S??$???	z?sl??.j?3?ic????&y???CG? K?p@????C????q???B!??䪋i?^?.??Ey&?ɏ!????????[??[V:???J ??r˳?ܹ??΋;???@?B+G|[|?ԩP;??q??F?nǻ?ޘ??lq-Ҟٍr???;?E?
??r?~???????~??߬ܡp#?Ʀ.3v?G?????I??????v9?L"?????????OZZ?4??_U???K3??9?ɿ|K?`??_U?????}|5??n7
_<?????t?f7??؇??4?x7??r??a?e?w'???߹?M?-?׹??kL?0?N[??s??\???      ?   7  x?՘?n?0???S?"?)?z??ðc/;???? {?Q??ڍ??.??Z?,?????ɡ# <@<P?????????v-" ????ŵ?7'b?^g???!?#??.c?p??(???{?????S?????A??A??A???r??6?`?O??qGg??	????????????Ͽw?K?X$xU?(???|L????????????p+x*?>??Q?>???^?d?xJή??%????ނjְg??t)r??q?$?GT????U?@?????=?65???_Q?4Ǉ??7"K!????g??l?	rZC?XP}?{?5?5&?yR/xiu?aMH??@`??9A?-ة??}H?#?:r??0??`$????S???܉?????逺7?`eL=b?81?=?Gx%|7WH-h?Ok?0? ?b?2??4??????'??<????Z1ē"?^?|?]???a????|???J?mJ???BM???? Vó*?
??U?;xɅ?5?-?X?tE=+?.W???????|???.hG<??VΖ?R˳v???S??:lJ??ǬA??]]??N*[йvz?-??ڍ|?8L???/?1???CH
i?xA*\[Y?)?9?%?????l-?h?d+E?Em???ӂP?ضM?X\,;8o
G6ih݋?SX?c[@n??mluݐ=fT?}?!s+ې??!?%?B?a[[??_xX,??D?8T?Q0숸?$w?P`???????W`?"?Z?K'?G?h??9?%,-?ڲ?7孚+? zI???ԩ???uf<	[?.%u?$??v?m򳙙)Hn??\'Ց4??[?'????o\      ?      x?????? ? ?      ?      x?????? ? ?      ?   w   x?]N??0{?)?@r??$?}?d?|????\r?????`4fY8ޟ?+
?4#8????Sjv???+e?{a?{8?o???w?E?ߥ???\?????2????<??>??	f?#?      ?   ?   x?????0??^???L[?H&?iRf?X4?4)?`?$GLMc̺??????Q??@?!v){?ϟI????,????u?Ҳ???J??qA?į??"w>????/waӜ??????z??ޓ?| z?PL      ?   w   x?U???0C??)?@#?rI{١LP????%R**??e??O04H:?I???a4?\??I???????8??????N[2x?????=):??r?n?`???:'?e_z?-??SJo??       ?   g   x?????0E?0???mlw?t?9???h<@~?/?@J? ?i-????Ո"ɞL6????7??4??_???@?#?/??M??R_ȃl??W?'??~ff>?~.?      ?   h   x?M???@C?sS? ';.??@'??????U?lɖE?#?????x????B9#憉}X??k?&??kQi?ߛ?C?U?돓jb?0־??????R?	??C      ?   c   x??λ? ?O?@g?3??? ??X(J)?????رW?i ޣ??9??????KO???+k???9H~6e??-W??ŏ?u^?kU|V?@D7??(?      ?   Q   x?-??	?0??] F???ݠ??і?qp ?L?.?=j{Xr1??4@>|.?
+*Q?????0c3lb?|㩗??W\?      ?   k   x????	1?;St?3?????u???????"?>2ʤe?YmΉ@N?"?mg?*	??"|??8$??{ay?yIh????s?/?"=?C˗ހ??xC7??1?$L4?      ?   >  x????n?0Eg?+?e???li?&Y\??vm???J?nrڦ'?W?W!????*???#S?}??AL%?k??֨O??c??`????4?p~n?e? ?Kch9\?;<lK?BTs?KU????C?Y!??4M??ſ7k?K?BҘ??p ?Ui=Y?q?n?ݎ?[????{M?]?g??OR??3?<??x8Uŷ0?KKam?R???%?F???Q(??3f<?L,??~??J?k?){????~{?x%??a2??Yf?C?>ςl?M[??㠘P??i_?]PȠ8r?dG,???!??J?-R?09????`Ze???i>???K      ?   ?   x???9n?0?zt
]???p=??&??Zmڤ???J?#????>8?@?P?'JĎa\0?F?J?uґ??	?_?^?mɈ??"bc?i>\?M?i:?
??=bnÇ~?'???/?VTs???z;???,^?B?{z???/??B=`-?|??[????? p?p.ybQg?<q??nSi??nSy??nShEkI?#????򙣽??Y?g??P??#Rh?????"???      ?   N   x?]??? ?s?, i? ?^p??C?h?M?ABCŸ#/p:W[???Yǽ)???A???(?????o?Lf?I??      ?   P   x?=??? C??S? ?a/8?????ޡI?
r潬(W`Á?DO?F?W,??;?!sS?ڻU(???w،f? ??g      ?   ?  x???M?? F???@(>?#???>Ao??????
6i??Cŋ؆??P]J.;
?{???Bpp??S??|????S??=WnT??>-?4< ????ـf?Қ(M?4Dy?? 8A????u???;?-???<?Zn?:ZP??6P0??kQ?)?<DED0EeMT&Q"?"^?$?!?"??????$?C?D?LQ[?It&4?e??[1ɴ?	?4AL?%?iZ+SLe??L!uJl?Dk&?Lt?????ԫi??0??Z???{?b
SL??IB?v{?k?8??%??k"L"?"???X?ۘ?6ξi?1>?C??ֲ?????????pnۥ?6}??u?;??`(;;t?|?<=Fa?{?41? ??jO????n????u????b??K????e?|?Tz??{a$?????qleXf ?+ ????}i????;@?!wO???&?>?K`?J҃<5??Q??M$?D?*?&???{$w??B??^????o????j      ?   ?  x???=n?0?g??@????R?:4C?????S?M?8n ??<H??D??ՙ?N????Cp?I? @v!?$o%7K-???t??yW???????4.n"?ŕm???J7?o\??.8?8w????e}?%??C?Y ??V??OU+?.??aG?b????c??
?]?t?V????	w#Q??T?q?,???????????ӗ??J$.-\?$ҘwG;?,?Tne?3S????-&????x;>lէty?ߚ՜wg?~(?mGm?????p]?,FL)]? v?N?f!??=Ħ??c?$
l??Aln`??a??ȃ??5???^
V??+>i?,?+??????g??????g??????g????b?????wT???m=s??mg݊??l??_?e?eo??l?7???N~??|^d??      ?   ?  x?헻n?@E??W????>;?q??ti?$???X?I?v-`S	h?$??y쒀?H~???O?OF??㖸16?@X????~????|o=><=?????????M???
?>?pKڸ4? ??.V????*2??c?،??HC??qv??u?\??)hJ??-ǧ????Xϩ?X? 6m?l?Mj`???-8??[?%u*:W?iGyK?ir"???DF?P`??2K#j?????N??W?f?"ZU5?dqbv?k?Ki'[??n??E?????2o?%?$?*C$?3wj???k?R?\?j?>q??>q??>q????i??]??U??[?/-{,?RT;r??^Yc?Z???w????m?6?Py?^?Ԗu?????????\?ĕI\[??Z84?*?TN-??di?????>>|??????q6ܗ?x?F? ?d????(ˌ???????a?G?T??5??'	T;?%m??Za? OO`??Ju??8??f'	(??&?4?jw???%?@???Ƞ??O??h??cd@@?fRH?????????N?I !ؼ#???lch??H'?&?`??D?.??[Rw?Xv??f?T???ޯ?a??o??????C?W7?վ!<\?23=Q?W?9聛Ƹ???H9_??Oa???j??      ?   n   x?}???@Dc?
X4c???.?
H? ?ˁ?8??~D?!Q? ?-2OG??\??蘪?
??!??r??W?꯲???ؖu{Bb`??????X???ν??Xe#?      ?   B   x?34?4?H??))?(??4?4B##C]]cC++C=3#K????????? ???      ?   Y   x?3?44?4?H??))?(??4?4B##C]]cC+SK+#=SsS3S??(??2B?]?E;P???????????	??=... ?      ?   j  x???Mn? ????@?? ?R??JmU?]?????Il'??ZBF?????? ??$???{"t|n?L??????ҁmd?!??>???gkCt?M?w???\?+%̥9??p,Ӫ<???T??<R?HT?? y?$???p??e? 226??է?3??͛^?dh?+'/VfDv?o$???/?????nU???"?????Y???K??I	?NB0s???T????#_Ǘ?????????DӪ??8l!?NVsv????D-?|???*G?%??*}PأPT???(???@iT*tA?-?
q?~?/??K?Cr??nW?-?I???$Hκ???(?]w?}??n?o??v??H??g?)???a?]JC      ?   [  x???K?1E?f????֑2??D??a???@?B??*????????*v?E?????>?).?Mr??%???O??8???R<????}kf??q??Q|???S?4???9????T?????Ĵp@jM?8??>Rm<Hy)6?[#$??<n?<???b?%-??Hb?|D????#?@?E?!?c??^??? 5M`??C.,? C????bS(Iƾpp?$ K;mG?S%?ېґ?¹?de?$cR??z?ԉPtI	??sڔPe!¨??˨o?.aI?H?V????6V?????.?0???8?j??K?#?ew/?{????????`=,??$s?y4<r?y?Xq????l5}??D??W$ң?Skz)?I????Gt?k?????.W~?}y????????̝?Mcðsq?'x????-?r??r?,T"??kY=? ?@?,^?)??g?ÈL?a???????Ѧf;"?g#?16?xxc3?f?/??L??e??Y?P85?!????????V??&?????ã?????ǃ?A?Ywxx3	cl6??#.??*??q??zyy9?e ??|}??????n??      ?   j  x???k??(??{iy??;+??_?$Z*Zv??)??KB
?  A(??=!|C????c?^X???J)??i???Q\p?lM?l??	??*Rsq???ݺ? ??Pȩ??s????%?ښ!???~9E???+??+?X?W????Z~?Z?CV:??ݮ??p?/?Y1?Ak??'??1?b?	!???G??WD?V?^?s?b1??6????+'I(??3?M?????"???dܐ??Tz`???X?u N?|??	??66??,kJ????)?6??&$V??TȔ?م?lf3w?{m)6R׻??9?{??Zݥ??*o?u Ll?e#????垗/y?̛.x?-o?????[x???e???N?|y#g? ???j?XAWb?l>i?_?z|??L?s??Hzjwj@p?L?J?$"ц?L:??p??Gn?u4?9?t???&??Kn????u঑;o?-2=???[/?y?].???sl????4??W!?f??{???*?8K=?pIԖgHm6?*2??9{?)[???????e?P?.?f<5??pه5???mk9c??ܱ??XS?z????h?????
#hm????<?Vn?V????B=?g?{??*ٳ?zVw?W?쮼^??L0mnY?K8?kוl?????5ھ??:??\k?i??	?????k?=4?Z.??-?u}??[S?9?????T?Uu9-X?T??.م??ed&ZD??z?J&?R66X*??׻???C?Ȓ?ڦ?芧8?IK,1???8aL?sG?=?\Ä?\??H?1?????????q?@?@|*ʈZ??K?????wTl?P?]?s?b??oZ?j?H?<??~'??]]??????????K????'0????d???#q?qB?M?=??;^??M/_??{^y?{*Ècz?$??Sēޑ???R??2??!??s???U??P????px??[????ց?u???Ќʈ}?X1f?>??r.ø???}lf?WصÆ?c?%6O??W?R?c??0͝_??z;ӷ?J?:?={????2????z???@V??l?ɸ?xW?J?~????ܗ?,?q??_?ܮ??-??????[??<E?U:T?B??CT?E???	??????/??      ?      x?????? ? ?      ?   n  x?՗?n?@??7OaqM???ٓ?B(?????@H(jE	
?>??$?*?8????]?:?Ͽ??BE??(L绗????A.4 r???Vf?)qL?!PФF??????v?P??>?V?'Cedm<?2[?}ȿ????Aw?4??????)[?>b?`?5t8%=?T?QC?6?q????׳??^??Ư.^?'???LN????????`?h??yy?\?/??V??Cu??U?ˏ??????{???ڨ?_????m5?????ׂ???zr3??}???/d?g??N?egr/?m?ɳr`T:hېg?AP,k??{C?[?Isq|Pذ?m?;??@?;8/e|?x??4?Zoh<??{??	????&!l}????@K????	=e??Z_[????/9???u?3???7??Yi??\	I@'b(3???A????`???by]}I?D2-u???$~]?0?ܣ2/???:?AG{??'?w=5re????|??z??YM柧??7?ռMo?K?׭@w?4?N/??3@?,?u??`u?; ?? ?=?	?????h??,?{?6?[Ģ_s?b[??ky??N?????EԴy?m????P?=?X?3??K???Jh0?r?%?ۢ??bL???8??s??&y???|?>_
w??C??4??&X
?M?w?v/?I??0q??"	?]?rr	?=??j}???:?}?0PQ??S?k??????? ?'#6???ٛ?ۘ????R/?zmd>W[ى=???B?ij?A???'hc?UJ/p?2???Js??????m?K?*???X?5Y?6??0lT????K?v?z??$?????_,?1??>#???.5.??y%?m???]???~ &Z      ?      x?????? ? ?      ?   	  x??Ի?0???L??Y?-?????G$')?PA?wp??????#@???'ܑ^@`&??w?}?7hl_WZqB??/3#(l?IBZ=????+??3$??Xf?X?dcA.???+*k?FW?~???B?=i?J>??I?k?VF2N@???|?S??&B,H???)?ĢϢؼ?~?Yl?Y?@???uf?@??D?
?GI?9f?&??lgv.̤#U?Es??'???QfZ?5]}?l?LgcX??%?ʡ]???Gܶ? ???      ?   ?   x?}???0??X???填??_G?F??|r ?zRXZ{?]cC???????R )X?J?L?3?m????_9?ٴ??C?$?}}=???7???ǘ?@!?kR??Hr?#IQi?|Z:6w_?O??{C?ǝ??d?<W{%ZH????,uױ?M&f\.z??5A?_?o{?%?<ͦMTI|I^YD?Yi?      ?   H  x??QKj?0]K??dfF_kۚ?;&mv?Ѕ???
?}%?qi7۲g??g?0?4# ??$????tooXz?ڠl [9gb'??q/??(Nobx???K?~?޿????????f"??\eK?TH|P?"?b??	??g?0Z?n?,S]?AC??c???c???ڙ=?XHQF ???Cs??????v׉?_?}?l??rFb- ??\??V>??	8?f2??4r?ȧ?$@P?X?AkFT??M?vRV??nX4?'
?Agλ????g???;?ʒ??ݖ?????z?. +?$?~l	??????????ȠK?????΋?      ?   :   x??A? D??????x????A?4f?$F?????Tzh??u?N???7??7d      ?   L  x???Ko?0???W̩?=`??u[QT!?*?zA??`?h??C????"JQ[??3??g&A?'"?2F?P?&???!S?y)d?
?%??es?
??X???tc?????g??Lnn?an??x?^k??\?_??ժ?o?p=???h?.`jtk`?XD8kM?]?????2?~n?,uР??z?^it?n?QldL???˘?q?	?cQLF???8?ZT????%???}u~	???N??m۾'?#??E??0???u???????????>]???/ųa?z??1>(
????v?9r???6u?]??u/|?)??;?Ǹ??N?T?p?Y?h?&̏&,$???i?R?e*V????g瞚??g]????D??I?~??B?`?GW?I??l2dpQ???	J~'??J??%???j:?|q?2a??t???b_t?
??}????El<+?,??O+?!?A??&hO?"	??W"$M???NX?"-EASL+??z?&??x6??U0?]Mf??͜H.Uh?E?S?>,ޱ?cOqQ???<˲3g:?????7??I??OC??p?O??:{X??+?Ⱥ:???'Q      ?   |  x???Mo?8??ʯ??h?r?M݊$??AҠ=X???
kK??$?????Ӕ?Z?]??X?`?A>|IΌ8??H,A;ÅH?m~??Eή??s??????Ă???o˂?????5{?.?'?9Ϛ?\???????ho??(i??K??b????:??I?N??@/n'???ZA?m?>?25???|??}p5???.??}p}?72?k6sw??w*b?=0??R?P?3?S???????R?N??^?R??
??pkd???ےC*l
?J?d?YZ?:v???=M??l???dP)h?B???????H?K??Fw????v#+He???l?????Zd??(??;X?*5?{???֓[X?q?p?jZ????N,??U??????T ???b????VvR???:??j?<euފgE?R?r???׬??/Y5c?Cͮ??q??e??x????
?{???l?????)ϖ9?%"??̧M?X4?^x??f???~-?/?.k2?????z??8??PGe?.?ǜ?R?EUMUc#?$9;???)???,Qڄ?=+??}?\>U?k??{???zX???Fsbc???8;+??[??ac?R???:????U"??p?Pv8}X6?"????첮???̓j?x(??J?4?<_	??}渌bm??o^b?Xˍ?7??P??Eld??P?J?????????u??????3ܑ
Ijm?wx?gτ/???U:J,?????gw?=צ¥֮?\??/??y-XaF??=ճe?E?n???`???3˅?g????{?j?`pm2?)???????	~?k	???r,??????	~??Z??????b?S?|??0?[??? ???ӧA>?
?	????~M0]?n?o,????9?-?0???ޞ?.󰑋??$?'?6HH?_Jdg??)?c?h??:???
?[rf?Ό????\??U??d??3?z?&*Щ?8:ƺar=K?_P??9??>?s??h:q1Z*L?W?1??ǣ????dt3fg???????:Q?7??????_???o??'?p?">t,xH?~??-ޟ?ږ?????7X?b?_Ƈ?????6eR????5?etdd???????n5p?±p??X?>
???G?o???????C!      ?   `  x???oO?0?_??"_ ????/o??!?R1?iڋnC ?ķ??i????I%?M?????g_P??
a?V7k?,????L??C?.??|??rX-H???ɪ?X??4?j???2?^??kR?j?TCG?c???IUW???Y?1????T???	?I?P?:?ٞT????è=Ɠ?岆4Q?%#?G?qD?????????2??ݱ9v????????????Ws????#,??t?????>?5??͏??????????ۿ?Ǘ??_??S????<?H??u(???*#c???9흩22V/ʌX;?铍???#h??kC???XU?f?6????P??c????/Qc]h?=^Um/??0?1?&?]n?Q?J?X?5?}S?=?v???!?k??l??V??k?C%?琍?Ȯ?lɘ*?a?XKvsȒaf??g?}1Y??u?Bm?C1?????q????ȡ?j?9???Z?J???i*?@	46??O{W?Ed&????
?L(C?? P??CM!??l?6?+?????:(?? ?͇?(??
q>?B%? ??}?9ꋡV??>7?3??*?????!*?????,?N?:r?\?`?U?????=P?D?U?I??~q???oH?RJjN??Ĥ?*?0QӃ???&EV?%I?j1??*?&?,?V??\>z??eP??
YtA??~_?_\,???o?f?>;_/?W_?a??؀l'B?Q?&?N}?;?v?O????n.?/?-?A ??Ht??;?7?$'msvu?mst????Y?9{??Ǿ???L???;9?6e??f#逤a????H??ɏc@??<Ew??H?^*3???(c?20$?e`?ר?p?????F/??\?      ?      x?????? ? ?      ?   ?   x???Kj?0???)|????>??;L??@??:!Sg?*	???$Q?Rk	?0 ???پ@=?&???S2I?)??ٶ\H??w?(/???	?'6,&8?`T???~3??HO٢R {0B)??8?wB?L?j?????zO҂?[i???R?Z??unmy?~n??????4???8א8j??%X3?[????.?????0?M?֜?G{??7??^?      ?   ?  x???[N#1E?;???\/??#?d#??f????N????'"J#'9._?z?ēN?ќ??_߮+??=Ӄ??{JE?>?O??x?x?n???86HE?BR?Lh??dݐ\(?(?Bl
a?VH?b/?'r??&qJ?-?.q\!i?1?A?D?????̑????b???F????b??!?ˢ?e??H
?????>????Eř?F?H??mC??2???T??(?????K.?MLq??????{??f??R?? q?JJ??\IyL'?N?N?5&?c?I?#$?J?U??:h??x?4?F?I"~?ʤ??6?n??/P?7????6?.?????i???\Ii??B7)?	m,?N?֌?q???ţ'?4R?V|&	
&??6??#?8+????^Ź<?j?O[??X?d??A??H??9???[????I???:??I??/$HE(????,????+	^??!7H?;_?]+*u4I?I0-??{9Ჲ??|q?j?fZ,<c*?????l0?????nr?Zo?b??D??,??Z$?ǉZە?J?V?x??m????jC???@jk'???????|>???????|8??????Pn(?]`??6*??p???u???????????T???	!?8RSmD?v?d?G>?CtGů?:"?y.H?`???-r?@?qP?5???D?s?? ??0??w?ƻ???F???????_#??n??CG??      ?   Y   x?M˱?0D?ڞ??9	1??2-??"?З~?(???"????y?3?????????Q????d???8?0r???L?{DӑT??'      ?   ?   x???K?1D??)?@??c?N1+?l???E??QOd?+??*??$? ?~???3"W???RP??/??߿??3??c?????J?+!;H??\UmE???b?Zq???|?",?????]??56
?\?|!	щ̵???b?????]??cK?F|???.?????~??3٭???? N%?t??l?      ?      x?????? ? ?      ?      x?????? ? ?      ?   @   x?M?? !?7Ta?]???r??q?/3ߡ??
i??n?N?Jꔒx?2??j??t???U??       ?   ?   x?͐K? ???^?LH?????????Z??}????ր??6?Ҍ?n ͭg D???????R
?3??N??զ??̨??3c̤????#??af1???.???8?;??u?'K???vqĖ???o????-?k?+
l~de?3?	?17?1?r?+?Vm?Q?d,V?X<?x?Gq?????=/:??P?x?7?????4=???      ?      x?????? ? ?      ?   [   x?M?1?@D?z8?t)M?ml??9Dwl?V(?q???`?*??@?z?%??(?$?5t?p??5n?&e??q?l??????1?^??]}?      ?      x?????? ? ?      ?      x?????? ? ?     