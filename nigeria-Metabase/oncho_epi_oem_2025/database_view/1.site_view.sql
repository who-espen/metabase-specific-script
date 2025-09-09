create view v_espen_ng_oncho_stop_2507_1_site_oem as

SELECT 

id,
c_recorder_id, 
c_region, 
c_district, 
c_cluster_name, 
c_cluster_id, 
c_supervisor,
c_date,
c_health_facility, 
c_type_health_facility, 
c_gps_lat, 
c_gps_lng, 
 c_gps_acc, 
 c_admin_level,
 c_river, 
 c_distance_community,
 c_population, 
 c_hh_number,
 c_receiving_ivm, 
 c_lengh_period_ivm,
 c_month_dist,
 c_year_dist,
 c_last_dist, 
 c_notes, 
 c_start,
 'v1' as version

FROM public.espen_ng_oncho_stop_2507_1_site_oem c 

union all

SELECT 

id,
c_recorder_id, 
c_region, 
c_district, 
c_cluster_name, 
c_cluster_id, 
c_supervisor,
c_date,
c_health_facility, 
c_type_health_facility, 
c_gps_lat, 
c_gps_lng, 
 c_gps_acc, 
 c_admin_level,
 c_river, 
 c_distance_community,
 c_population, 
 c_hh_number,
 c_receiving_ivm, 
 c_lengh_period_ivm,
 c_month_dist,
 c_year_dist,
 c_last_dist, 
 c_notes, 
 c_start,
 'v2' as version

FROM public.espen_ng_oncho_stop_2507_1_site_oem_v2 c