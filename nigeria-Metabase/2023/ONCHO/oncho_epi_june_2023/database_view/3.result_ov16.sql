create view v_espen_ng_oncho_stop_6_rdtov16_202206 as

SELECT 

id, 
d_recorder_id, 
d_region,
d_district,
d_cluster_name, 
d_cluster_id,
d_lab_ov162nd_test,
d_lotnumber,
d_serial_number1,
d_serial_number2,
d_code_id, 
d_lab_ov16, 
d_lab_ov16_invalid, 
d_lab_ov16_invalid_other, 
d_notes,
d_start_time d_start

FROM public.espen_ng_oncho_stop_6_rdtov16_202206 d
