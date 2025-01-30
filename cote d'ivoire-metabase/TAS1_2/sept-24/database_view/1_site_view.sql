create view v_espen_ci_lf_tas1_2409_1_sites as

SELECT 

id,
c_recorder,
c_region,
c_eu_name, 
c_district,
c_district_id, 
c_cluster_name,
c_cluster_id, 
c_cluster_leader_name, 
c_consent, 
c_population,
c_present,
c_gps_lat,
c_gps_lng, 
c_gps_acc,
c_cluster_notes, 
c_start

FROM public.espen_ci_lf_tas1_2409_1_sites c

