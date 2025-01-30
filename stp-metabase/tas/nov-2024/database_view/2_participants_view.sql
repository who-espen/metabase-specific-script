create view v_espen_st_lf_tas2_2412_2_partcipants_v2 as

SELECT 

id, 
p_recorder, 
p_eu,
p_district,
p_cluster_name,
p_cluster_id,
p_consent,
p_sex, 
p_age_yrs,
p_how_long_lived,
p_index, 
p_code_id, 
p_lymphod, 
p_lymph_location,
p_hydrocele,
p_notes, 
p_start

FROM public.espen_st_lf_tas2_2412_2_partcipants_v2 p