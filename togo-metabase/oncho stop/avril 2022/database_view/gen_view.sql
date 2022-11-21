create view v_espen_tg_oncho_stop_3_elisa_202204 as

SELECT 

id, 
d_recorder_id, 
d_district,
d_formation_sanitaire,
d_cluster_name,
d_cluster_id,
d_code_id,
d_lab_elisa, 
d_notes, 
d_start_time

FROM public.espen_tg_oncho_stop_3_elisa_202204 d
