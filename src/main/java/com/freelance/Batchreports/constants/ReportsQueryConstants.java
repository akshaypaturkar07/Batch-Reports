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

    public static final String GET_PO_REPORT_DATA = "select mst_host_company.comp_name,mst_host_company.comp_addr,mst_host_company.mob_no1, " +
            " trn_po.po_id,trn_po.po_date,mst_plant.plant_name,mst_plant.plant_address, mst_customer_vendor.gst_no,mst_customer_vendor.cust_vendor_code,mst_customer_vendor.cust_vendor_name, " +
            " mst_customer_vendor.gst_no,mst_customer_vendor.cust_vendor_firm_name,mst_customer_vendor.mob_no1, " +
            " mst_item.item_code,mst_item.item_desc,mst_item.hsn_code, trn_po_item.item_qty,trn_po_item.unit_rate,trn_po_item.cgst_rate,trn_po_item.sgst_rate,trn_po_item.igst_rate " +
            " from mst_host_company inner join trn_grn_info on mst_host_company.hc_id = trn_grn_info.hc_id inner join trn_po on " +
            " trn_grn_info.po_id = trn_po.po_id inner join trn_po_item on trn_po_item.po_id =  trn_po.po_id inner join mst_plant on " +
            " mst_plant.plant_id = trn_po.plant_id inner join mst_customer_vendor on mst_customer_vendor.cust_vendor_id = trn_po.vendor_id " +
            " inner join mst_item on mst_item.item_id = trn_grn_info.item_id where trn_po.po_id = :id ";

    public static final String GET_TAX_INVOICE_REPORT_DATA = "select mst_host_company.comp_name,mst_host_company.comp_addr,mst_host_company.mob_no1, " +
            " trn_invoice_info.invoice_code,trn_invoice_info.invoice_date,trn_so.so_date,trn_so.so_id,mst_customer_vendor.cust_vendor_code, " +
            " mst_customer_vendor.cust_vendor_Name,mst_customer_vendor.gst_no, " +
            " mst_customer_vendor.mob_no1,mst_customer_vendor.cust_vendor_name,trn_po_item.item_qty,trn_po_item.unit_rate, " +
            " trn_po_item.cgst_rate,trn_po_item.sgst_rate,trn_po_item.igst_rate,mst_item.item_code,mst_item.hsn_code " +
            " from mst_host_company " +
            " inner join trn_grn_info on trn_grn_info.hc_id = mst_host_company.hc_id " +
            " inner join trn_invoice_info on trn_invoice_info.hc_id = trn_grn_info.hc_id " +
            " inner join mst_plant on mst_plant.int_id = mst_host_company.int_id " +
            " inner join trn_so on trn_so.plant_id = mst_plant.plant_id " +
            " inner join trn_po on mst_plant.plant_id = trn_po.plant_id " +
            " inner join trn_po_item on trn_po_item.po_id =  trn_po.po_id " +
            " inner join mst_item on mst_item.item_id = trn_po_item.item_id " +
            " inner join mst_customer_vendor on mst_customer_vendor.cust_vendor_id = trn_po.vendor_id;";

}
