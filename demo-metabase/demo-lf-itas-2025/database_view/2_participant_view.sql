create view v_espen_demo_lf_itas_9999_2_part as

SELECT 
c.id, 
p.p_recorder, 
p.p_admin1, 
p.p_iu,
p.p_site, 
p.p_site_id, 
p.p_id_type, 
p.p_warning_note1, 

c.parent_id,
c.p_code_id,
c.p_sex,
c.p_id_household,
c.p_id_surveyed,
c.p_id_surveyed_full, 
c.p_age_yrs, 
c.p_how_long_lived,
c.p_come_from_another_location,
c.p_origine_location,
c.p_profession,
c.p_education_level, 
c.p_swallow_med,
c.p_time_taken_med, 
c.p_why_never_treated, 
c.p_mosquito_net, 
c.p_sleep_mosq_net, 
c.p_lymphoedeme, 
c.p_hydrocele, 
c.p_comments, 

p.p_start

FROM espen_demo_lf_itas_9999_2_part p, espen_demo_lf_itas_9999_2_part_pi999 c

where p.id = c.parent_id::int