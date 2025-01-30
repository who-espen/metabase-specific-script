create view v_espen_bj_oncho_stop_7_202306_diag_elisa as

SELECT 

id,
d_recorder_id,
d_region, 
d_district,
d_cluster_name, 

case when d_id_type = 'Scanner' then d_barecode_id else d_manual_id end d_barecode_id,

d_elisa_value_od, 
d_elisa_result, 
d_elisa_value_od_2,
d_elisa_result_2,
d_cluster_notes,
d_start_time d_start

FROM public.espen_bj_oncho_stop_7_202306_diag_elisa d
