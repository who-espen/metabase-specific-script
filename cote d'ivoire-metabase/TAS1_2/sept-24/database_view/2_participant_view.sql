create view v_espen_ci_lf_tas1_2409_2_partcipants as 

SELECT 

id, 
p_recorder_id,
p_eu_name,
p_district,
p_district_id, 
p_cluster_name, 
p_cluster_id, 
p_consent, 
p_sex, 
p_age_yrs, 
p_how_long_lived, 
p_num,
p_code_id,
p_notes, 
c_start

FROM public.espen_ci_lf_tas1_2409_2_partcipants p
