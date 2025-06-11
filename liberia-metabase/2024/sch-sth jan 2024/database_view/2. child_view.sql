create view v_espen_lr_sch_sth_impact_202401_2_child_v2_1 as

SELECT 

 c.id, 
 p.p_recorder,
 p.p_district,
 p.p_location, 
 p.p_school_name,
 p.p_schoo_id,
 
c.p_consent, 
c.p_assent, 
c.p_index,
c.p_code_id, 
c.p_age_yrs, 
c.p_sex, 
c.p_stoolsucces, 
c.p_urinesucces,
c.p_child_treat, 
c.p_always_lived, 
c.p_long_lived, 
c.p_water_play, 
c.p_water_fish, 
c.p_remarks,

 
 p.p_start

FROM public.espen_lr_sch_sth_impact_202401_2_child_v2_1 p, espen_lr_sch_sth_impact_202401_2_child_v2_1_lr_p_202401_v2_1 c
where p.id::text = c.parent_id