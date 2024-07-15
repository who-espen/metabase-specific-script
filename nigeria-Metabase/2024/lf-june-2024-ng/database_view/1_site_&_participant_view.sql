create view v_espen_ng_lf_tas_2406_1_sit_part_ng_v31 as

SELECT 

c.id,
p.c_recorder, 
p.c_eu, 
p.c_district, 
p.c_cluster_name,
p.c_cluster_id,
p.c_cluster_leader,
p.c_consent, 
p.c_total_primaries, 
p.c_enrolment_primaries,
p.c_toilet, 
p.c_type_toilet,
p.c_has_water,
p.c_src_water_school,
p.c_gps_lat, 
p.c_gps_lng, 
p.c_gps_acc, 
p.c_nbr_participant, 

c.parent_id, 
c.p_consent, 
c.p_sex, 
c.p_age_yrs, 
c.p_how_long_lived, 
c.p_code_id,
c.p_notes, 
p.c_start

FROM espen_ng_lf_tas_2406_1_sit_part_ng_v31 p, espen_ng_lf_tas_2406_1_sit_part_ng_v31_ng_tas_p_2406_ng_31 c

where p.id = c.parent_id::int

