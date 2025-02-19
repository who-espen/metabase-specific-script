create view v_espen_demo_lf_tas_9999_2_part_v2 as

SELECT 

c.id, 
p.p_recorder,
p.p_district,
p.p_community, 
p.p_site, 
p.p_site_id,

c.parent_id,

c.p_consent, 
c.p_sex,
c.p_age_yrs, 
c.p_how_long_lived,
c.p_code_id, 
c.p_notes, 
p.c_start

FROM public.espen_demo_lf_tas_9999_2_part_v2 p, public.espen_demo_lf_tas_9999_2_part_v2_demo_tas_p_9999 c

where p.id = c.parent_id::int



