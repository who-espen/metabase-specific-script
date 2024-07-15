create view v_espen_ng_lf_tas_2406_2_fts_ng_v31 as

SELECT 

c.id,
p.d_recorder, 
p.d_eu, 
p.d_district, 
p.d_cluster_name,
p.d_cluster_id, 
p.d_nbr_participant, 

c.parent_id, 
c.d_code_id, 
c.d_lotnumber1, 
c.d_result1, 
c.d_why_invalid1, 
c.d_why_invalid_other1, 
c.d_need_second_test, 
c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2, 
c.d_why_invalid_other2, 
c.d_final_result, 
c.follow_up_note, 
c.d_parent_name, 
c.d_lenght_stay_lga, 
c.d_village_community, 
c.d_swallowed_lf_med, 
c.d_nd_med_taked, 
c.d_have_bed_net, 
c.d_sleep_bed_net, 
c.notes_part, 
p.c_start d_start

FROM espen_ng_lf_tas_2406_2_fts_ng_v31 p, espen_ng_lf_tas_2406_2_fts_ng_v31_ng_tas_fts_2406_ng_31 c

where p.id = c.parent_id::int