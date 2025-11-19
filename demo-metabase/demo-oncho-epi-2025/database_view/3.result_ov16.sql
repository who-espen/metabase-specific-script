create view v_espen_demo_oncho_epi_9999_3_ov16 as

SELECT 

id, 
d_recorder_id,
d_admin1, 
d_iu, 
d_site,
d_site_id, 
d_id_type, 
d_code_id,
d_lotnumber,
d_ov16_result, 
d_ov16_invalid, 
d_ov16_invalid_other,
d_notes, 
d_start

FROM public.espen_demo_oncho_epi_9999_3_ov16 d