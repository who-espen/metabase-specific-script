 create view v_espen_demo_lf_itas_9999_3_fts as

SELECT 

c.id, 
p.d_recorder, 
p.d_admin1, 
p.d_iu, 
p.d_site, 
p.d_site_id, 
p.d_id_type, 
p.d_warning_note, 

c.parent_id,
c.d_code_id,
c.d_lotnumber1, 
c.d_fts_result1, 
c.d_why_invalid1, 
c.d_why_invalid_other1, 
c.d_second_fts_note, 
c.d_lotnumber2, 
c.d_fts_result2,
c.d_why_invalid2, 
c.d_why_invalid_other2,
c.d_final_result, 
c.follow_up_note, 
c.d_lenght_stay_district, 
c.d_village_origin, 
c.d_swallowed_lf_med,
c.d_nd_med_taked, 
c.d_have_bed_net, 
c.d_sleep_bed_net,
c.d_mf_note, 
c.d_mf_date, 
c.d_mf_time, 
c.d_blood_vol_micro_l,
c.d_mf_result, 
c.d_mf_per_60micro_l, 
c.d_mf_species, 
c.d_mf_species_other, 
c.d_comments, 

p.d_start

FROM espen_demo_lf_itas_9999_3_fts p, espen_demo_lf_itas_9999_3_fts_d9999 c

where p.id = c.parent_id::int