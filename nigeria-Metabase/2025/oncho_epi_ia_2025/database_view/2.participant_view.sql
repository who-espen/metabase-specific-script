create view v_espen_ng_oncho_stop_2507_2_part_ia_ba as 


SELECT 

c.id, 
 p_recorder_id,
 p_district, 
 p_cluster_name,
 p_cluster_id,
 p_date, 
 c.parent_id,
 c.p_consent,
 c.p_id_method,
 c.p_barcode_id, 
 c.p_num, 
 c.p_code_id, 
 c.p_sex, 
 c.p_age_yrs, 
 c.p_yrs_in_location,
 c.p_travel_more_than_15_km, 
 c.p_ivm_last_12_month, 
 c.p_ivm_location,
 c.p_sample_collected,
c.p_additional_notes, 

p_start,

'v1_ba' version


FROM public.espen_ng_oncho_stop_2507_2_part_ia_ba p, public.espen_ng_oncho_stop_2507_2_part_ia_ba_ng2507part3 c
where p.id = c.parent_id::int

union all 

SELECT 

c.id, 
 p_recorder_id,
 p_district, 
 p_cluster_name,
 p_cluster_id,
 p_date, 
 c.parent_id,
 c.p_consent,
 c.p_id_method,
 c.p_barcode_id, 
 c.p_num, 
 c.p_code_id, 
 c.p_sex, 
 c.p_age_yrs, 
 c.p_yrs_in_location,
 c.p_travel_more_than_15_km, 
 c.p_ivm_last_12_month, 
 c.p_ivm_location,
 c.p_sample_collected,
c.p_additional_notes, 

p_start,

'v2_rs' version


FROM public.espen_ng_oncho_stop_2507_2_part_ia_rs_v2 p, public.espen_ng_oncho_stop_2507_2_part_ia_rs_v2_ng2507part2 c
where p.id = c.parent_id::int

union all 

SELECT 

c.id, 
 p_recorder_id,
 p_district, 
 p_cluster_name,
 p_cluster_id,
 p_date, 
 c.parent_id,
 c.p_consent,
 c.p_id_method,
 c.p_barcode_id, 
 c.p_num, 
 c.p_code_id, 
 c.p_sex, 
 c.p_age_yrs, 
 c.p_yrs_in_location,
 c.p_travel_more_than_15_km, 
 c.p_ivm_last_12_month, 
 c.p_ivm_location,
 c.p_sample_collected,
c.p_additional_notes, 

p_start,

'v3_rs' version


FROM public.espen_ng_oncho_stop_2507_2_part_ia_rs_v3 p, public.espen_ng_oncho_stop_2507_2_part_ia_rs_v3_ng2507part3 c
where p.id = c.parent_id::int








