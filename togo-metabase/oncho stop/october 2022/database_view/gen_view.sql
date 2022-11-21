create view v_espen_tg_oncho_stop_3_elisa_202209_v1 as

SELECT 

id, 
d_recorder_id, 
d_district,
d_formation_sanitaire,
d_site,
d_site_id,
d_code_id,
d_lab_elisa, 
d_notes, 
d_start_time

FROM public.espen_tg_oncho_stop_3_elisa_202209_v1 d
