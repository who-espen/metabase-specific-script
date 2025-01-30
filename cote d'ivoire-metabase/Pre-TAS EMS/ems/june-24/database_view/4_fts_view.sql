create view v_espen_ci_lf_pretas_2406_4_fts_v4 as

select

id, 
d_recorder, 
d_region, 
d_district, 
d_site, 
d_site_id, 
d_num, 
d_code_id, 
d_sex, 
d_age_yrs, 
d_lotnumber1, 
d_result1,
d_why_invalid1,
d_why_invalid_other1,
 d_image_1, 
 notes_part, 
 c_start d_date

FROM public.espen_ci_lf_pretas_2406_4_fts_v4 d