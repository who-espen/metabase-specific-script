SELECT 

id, 
n_recorder_id,
n_region, 
n_district, 
n_cluster_name, 

case when n_id_type = 'Scanner' then n_barecode_id else n_manual_id end n_barecode_id,

n_type_test, 
n_result_ddtd, 
n_result_not_clear_reason,
n_result_not_clear_reason_other,
n_result_gadx,
n_line,
n_gadx_invalid_reason,
n_gadx_invalid_reason_other,
n_result_dbs,
n_dbs_invalid_reason,
n_dbs_invalid_reason_other,
n_photo,
n_notes,
n_start_time n_start

FROM public.espen_bj_oncho_stop_5_202306_new_reacti_v2 n


