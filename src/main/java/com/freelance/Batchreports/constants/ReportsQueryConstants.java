package com.freelance.Batchreports.constants;

public class ReportsQueryConstants {
    public static final String GET_AGGREGATED_DATA_BATCH_REPORTS = "select distinct b.batch_date,b.batch_start_time,b.batch_end_time,b.batch_no," +
            "m.plant_address,b.recipe_code," +
            "b.recipe_name,b.truck_no,b.truck_driver,b.order_no,b.batcher_name,b.ordered_qty,b.production_qty," +
            "b.withthisload,b.mixer_capacity,b.batch_size,m.plant_reg_no,mcv.cust_vendor_name," +
            "mns.agg1_name,mns.agg2_name,mns.agg3_name,mns.agg4_name,mns.agg5_name," +
            "mns.cement1_name,mns.cement2_name,mns.fill_name,mns.water1_name,mns.water2_name,mns.silica_name," +
            "mns.admix1_name,mns.admix2_name, " +
            "bd.gate1_actual,bd.gate2_actual,bd.gate3_actual,bd.gate4_actual," +
            "bd.gate5_actual, bd.cement1_actual,bd.filler1_actual,bd.water1_actual,bd.water1_target,bd.water2_actual," +
            "bd.silica_actual,bd.adm1_actual1,bd.adm2_actual1,m.plant_name " +
            " from trn_rmc_batch b" +
            " inner join trn_rmc_batch_detail bd on b.batch_no =  bd.batch_no" +
            " inner join mst_plant m on m.int_id = b.int_id" +
            " inner join mst_name_setup mns on mns.int_id = b.int_id" +
            " inner join mst_customer_vendor mcv on mcv.int_id = b.int_id" +
            " where b.batch_no = :batchNo and b.int_id = :id";
            
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
}
