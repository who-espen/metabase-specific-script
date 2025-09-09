create view v_espen_ng_oncho_stop_2507_2_part_oem as
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

p_start


FROM public.espen_ng_oncho_stop_2507_2_part_oem p, public.espen_ng_oncho_stop_2507_2_part_oem_ng2507poem c
where p.id = c.parent_id::int

