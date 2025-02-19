create view v_espen_demo_lf_tas_9999_1_site_v2 as

SELECT 

id,
c_recorder, 
c_eu,
c_district, 
c_community, 
c_site,
c_site_id,
c_cluster_leader,
c_consent, 
c_population,
c_present, 
c_toilet,
c_type_toilet, 
c_has_water, 
c_src_water_school, 
c_gps_lat,
c_gps_lng, 
c_gps_acc, 
p_notes, 
c_start

FROM public.espen_demo_lf_tas_9999_1_site_v2