create view v_espen_ng_oncho_stop_3_rdtov16_202310 as

SELECT 

id,
d_recorder_id, 
d_region, 
d_district, 
d_cluster_name, 
d_cluster_id, 
d_serial_number1, 
d_serial_number2, 
d_code_id, 
d_elisa_value_od, 
d_elisa_result,
d_notes, 
d_start_time

FROM public.espen_ng_oncho_stop_3_rdtov16_202310 d

