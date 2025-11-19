create view v_espen_demo_oncho_epi_9999_2_part as

SELECT 

id, 
p_recorder_id,
p_admin1,
p_district,
p_site, 
p_site_id,
p_id_type, 
p_code_id,
p_sex, 
p_age_yrs,
p_how_long_lived, 
p_travel, 
p_ever_taken_ivm,
p_ivm_where, 
p_ivm_last_time_month,
p_ivm_last_time_year,
p_sample_collected, 
p_start

FROM public.espen_demo_oncho_epi_9999_2_part p


