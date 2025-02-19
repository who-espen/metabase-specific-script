create view v_espen_st_lf_tas2_2412_1_sites as

SELECT 

id, 
c_recorder, 
c_eu, 
c_district, 
c_cluster_name, 
c_cluster_id, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc, 
c_cluster_notes, 
c_start

FROM public.espen_st_lf_tas2_2412_1_sites c