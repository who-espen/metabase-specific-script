create view v_espen_st_lf_tas2_2412_3_fts_result_v2 as

select

id, 
d_recorder, 
d_eu, 
d_district, 
d_cluster_name, 
d_cluster_id, 
d_code_id,
d_lotnumber1, 
d_result1, 
d_why_invalido1,
d_why_invalido_other1,
d_notes,
d_start

FROM public.espen_st_lf_tas2_2412_3_fts_result_v2 d