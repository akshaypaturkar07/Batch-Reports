select * from "public".trn_rmc_batch;

select * from "public".trn_rmc_batch_detail;

select * from "public".mst_plant;

select * from "public".mst_name_setup;

select * from "public".mst_customer_vendor;

select b.batch_date,b.batch_start_time,b.batch_end_time,b.batch_no,b.site,b.recipe_code,
b.recipe_name,b.truck_no,b.truck_driver,b.order_no,b.batcher_name,b.ordered_qty,b.production_qty,
b.withthisload,b.mixer_capacity,b.batch_size
from trn_rmc_batch b
inner join trn_rmc_batch_detail bd on
b.batch_no =  bd.batch_no
where b.batch_no = 4965

select
gate1_actual,
gate2_actual,
gate3_actual,
gate4_actual,
gate5_actual,
cement1_actual,
filler1_actual,
water1_actual,
water1_target,
water2_actual,
silica_actual,
adm1_actual1,
adm2_actual1
 from trn_rmc_batch_detail
 where batch_no = 4965

select plant_reg_no from mst_plant

select cust_vendor_name from mst_customer_vendor