package com.freelance.Batchreports.constants;

public class ReportsQueryConstants {
    public static final String GET_AGGREGATED_DATA_BATCH_REPORTS = "select distinct b.batch_date,b.batch_start_time,b.batch_end_time,b.batch_no," +
            "m.plant_address,b.recipe_code," +
            "b.recipe_name,b.truck_no,b.truck_driver,b.order_no,b.batcher_name,b.ordered_qty,b.production_qty," +
            "b.withthisload,b.mixer_capacity,b.batch_size,m.plant_reg_no,mcv.cust_vendor_name," +
            "mns.agg1_name,mns.agg2_name,mns.agg3_name,mns.agg4_name,mns.agg5_name," +
            "mns.cement1_name,mns.cement2_name,mns.fill_name,mns.water1_name,mns.water2_name,mns.silica_name," +
            "mns.admix1_name,mns.admix2_name ," +
            "b.gate1_target ,b.gate2_target ,b.gate3_target ,b.gate4_target ,b.gate5_target ," +
            "b.cement1_target,b.cement2_target,b.filler_target,b.water1_target,b.water2_target," +
            "b.silica_target,b.adm1_target1,b.adm2_target2," +
            "bd.gate1_actual,bd.gate2_actual,bd.gate3_actual,bd.gate4_actual," +
            "bd.gate5_actual, bd.cement1_actual,bd.cement2_actual,bd.filler1_actual,bd.water1_actual,bd.water2_actual," +
            "bd.silica_actual,bd.adm1_actual1,bd.adm2_actual1, " +
            "bd.water1_correction,m.plant_name" +
            " from br2.trn_rmc_batch b" +
            " inner join br2.trn_rmc_batch_detail bd on b.batch_no =  bd.batch_no" +
            " inner join br2.mst_plant m on m.int_id = b.int_id" +
            " inner join br2.mst_name_setup mns on mns.int_id = b.int_id" +
            " inner join br2.mst_customer_vendor mcv on mcv.plant_id = m.plant_id" +
            " where b.batch_no = :batchNo and b.int_id = :id and bd.con_id = :conId and m.plant_id = :plantId";

    public static final String GET_BATCH_BY_BATCHNO = "select distinct b.batch_date,b.batch_start_time,b.batch_end_time,b.batch_no,b.site," +
            "b.recipe_code,b.recipe_name,b.truck_no,b.truck_driver,b.order_no,b.batcher_name,b.ordered_qty,b.production_qty,b.withthisload," +
            "b.mixer_capacity,b.batch_size from trn_rmc_batch b " +
            "inner join trn_rmc_batch_detail bd on b.batch_no =  bd.batch_no " +
            "where b.batch_no = :batchNo and b.int_id = :id";

    public static final String GET_BATCH_DETAIL_BY_BATCHNO = "select gate1_actual,gate2_actual,gate3_actual,gate4_actual,gate5_actual," +
            "cement1_actual,filler1_actual,water1_actual,water1_target,water2_actual,silica_actual,adm1_actual1," +
            "adm2_actual1 from trn_rmc_batch_detail where batch_no = :batchNo and int_id = :id";

    public static final String GET_PLANT_SERIAL_NO = "select plant_reg_no from mst_plant where int_id = :id limit 1";

    public static final String GET_CUSTOMER_NAME = "select cust_vendor_name from mst_customer_vendor where int_id = :id limit 1";

    public static final String GET_GRN_REPORT_DATA = "select distinct m.comp_name,m.comp_addr,m.mob_no1, " +
            " tgi.grn_code,tgi.grn_date,tgi.po_id,tp.po_date, mp.plant_name,tgi.ref_challan_no,tpoi.veh_no, " +
            " mcv.cust_vendor_name,mcv.cust_vendor_addr,mcv.gst_no as gstNo,m.gst_no as gstNum, mi.item_code,mi.item_desc,mu.unit_name,tgi.item_qty,tgi.unit_rate, " +
            " tgi.cgst_rate,tgi.sgst_rate,tgi.igst_rate,tgi.disc_percent,tgi.freight_charges, ms.statename,ms.statecode " +
            " from br2.mst_host_company  m " +
            " inner join br2.trn_grn_info tgi on m.hc_id = tgi.hc_id  " +
            " inner join br2.trn_po tp on  tgi.po_id = tp.po_id  " +
            " inner join br2.mst_plant mp on mp.plant_id = tgi.plant_id " +
            " inner join br2.trn_plant_office_inward tpoi on tpoi.po_id=tgi.po_id " +
            " inner join br2.mst_customer_vendor mcv on  mcv.cust_vendor_id = tgi.vendor_id " +
            " inner join br2.mst_item mi on  mi.item_id = tgi.item_id  " +
            " inner join br2.mst_unit mu on mu.unit_id = mi.unit_id " +
            " inner join br2.mst_state ms on ms.id = m.comp_state_id " +
            " where m.hc_id = :hcId and tgi.plant_id = :plantId and mcv.cust_vendor_id = :vendorId and tpoi.po_iw_id = :poId and tp.con_id = :conId";

    public static final String GET_PO_REPORT_DATA = "select m.comp_name, m.comp_addr ,m.email_id1 ,m.mob_no1,  " +
            " tp.po_id ,tp.po_date ,mp.plant_name  , mp.plant_address, mp.plant_contact_mobile_no ,mp.register_mob_no,mp.email , m.gst_no , mcv.cust_vendor_code ,mcv.cust_vendor_name , mcv.cust_vendor_addr , mcv.gst_no as supplierGST , " +
            " mcvc.con_name , mcvc.mob_no1 as vendorContactNo, mi.item_code , mi.item_desc , mi.hsn_code, tpi.item_qty , mu.unit_name , " +
            " tpi.disc_percent ,tpi.unit_rate , tpi.cgst_rate , tpi.sgst_rate ,tpi.igst_rate,tpi.freight_charges ,tpi.tax" +
            " from br2.mst_host_company m" +
            " inner join br2.trn_grn_info tgi on m.hc_id = tgi.hc_id " +
            " inner join br2.trn_po tp on m.hc_id=tp.hc_id  " +
            " inner join br2.trn_po_item tpi on  tpi.po_id=tp.po_id " +
            " inner join br2.mst_plant mp on tp.plant_id= mp.plant_id  " +
            " inner join br2.mst_customer_vendor mcv on tp.vendor_id=mcv.cust_vendor_id " +
            " inner join br2.mst_cust_vendor_contact mcvc on tp.vendor_id=mcvc.cust_vendor_id " +
            " inner join br2.mst_item mi on tpi.item_id=mi.item_id " +
            " inner join br2.mst_unit mu on mu.unit_id = mi.unit_id " +
            " where mcv.is_customer=0 and tp.po_id = :poId";

    public static final String GET_TAX_INVOICE_REPORT_DATA = "select m.comp_name,m.comp_addr,m.email_id1,m.mob_no1,m.gst_no, " +
            " tii.invoice_no,tii.invoice_date,ts.so_date,ts.so_id,trb.truck_no, trb.truck_driver,ts.ref_po_no,mp.plant_name,mcv.cust_vendor_name,mcv.cust_vendor_addr, " +
            " mcv.gst_no,mst.site_name,mst.site_address,mcv.gst_no,ms.statecode,ms.statename,m.bank_branch,m.bank_acc_no,m.ifsc_code,m.pan_no, " +
            " mi.item_code,mi.hsn_code,tiit.item_qty,tiit.unit_rate,mu.unit_name,tiit.cgst_rate,tiit.sgst_rate,tiit.igst_rate,tiit.freight_charges " +
            " from mst_host_company m  " +
            " inner join trn_grn_info tgi on m.hc_id = tgi.hc_id " +
            " inner join trn_invoice_info tii on m.hc_id = tii.hc_id " +
            " inner join trn_so ts on ts.so_id= tii.so_id " +
            " inner join trn_rmc_batch trb on tii.batch_id=trb.trans_id " +
            " inner join trn_po tp on tp.po_id = ts.import_trans_id " +
            " inner join mst_plant mp on  mp.plant_id=tii.plant_id " +
            " inner join mst_customer_vendor mcv on tii.cust_id=mcv.cust_vendor_id " +
            " inner join mst_state ms on ms.id = m.comp_state_id " +
            " inner join mst_site mst on mst.site_id=ts.site_id " +
            " inner join trn_invoice_item tiit on tiit.invoice_id=tii.invoice_id " +
            " inner join mst_item mi on tiit.item_id=mi.item_id " +
            " inner join mst_unit mu on mu.plant_id = tii.plant_id " +
            " where mcv.is_customer=1 and tgi.hc_id = :hc_id";

}
