create view v_espen_demo_lf_tas_9999_3_fts_v2 as

SELECT 

c.id,
p.d_recorder, 
p.d_district, 
p.d_community, 
p.d_site, 
p.d_site_id, 

c.parent_id,

c.d_code_id, 
c.d_lotnumber1, 
c.d_result1, 
c.d_why_invalid1, 
c.d_why_invalid_other1, 

c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2, 
c.d_why_invalid_other2, 

c.d_final_result, 

c.follow_up_note, 
c.d_lenght_stay_lga, 
c.d_village_community, 
c.d_swallowed_lf_med, 
c.d_nd_med_taked, 
c.d_have_bed_net, 
c.d_sleep_bed_net,
c.notes_part, 
p.c_start

FROM public.espen_demo_lf_tas_9999_3_fts_v2 p, public.espen_demo_lf_tas_9999_3_fts_v2_demo_tas_d_9999_4 c

where p.id = c.parent_id::int

