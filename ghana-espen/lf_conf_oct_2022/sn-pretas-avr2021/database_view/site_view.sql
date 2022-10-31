create view v_espen_gn_lf_pretas_1_site_202210 as

SELECT 

id, 
c_recorder, 
c_region, 
c_district, 
c_sub_district, 
c_cluster_name, 
c_cluster_id, 
c_cluster_leader, 
c_consent, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc, 
created_at


FROM public.espen_gn_lf_pretas_1_site_participant_202210 c
