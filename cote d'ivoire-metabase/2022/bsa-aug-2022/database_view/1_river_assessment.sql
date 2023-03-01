create view v_espen_civ_oncho_bsa_1_river_assessment_202208_v4

as

SELECT 

id, 
s_recorder_id, 
s_region, 
s_district,
s_health_facility,
s_site, 
s_river_basin_name,
s_river_name, 
s_river_distance,
s_gps_lat, 
s_gps_lng, 
s_gps_acc, 
s_vegetation_type, 
s_tidc_date, 
s_capture_point, 
s_close_breeding, 
s_type_close_breeding_site,
s_close_village,
s_close_village_population, 
s_close_village_activity,
s_close_village_activity_other, 
s_notes, 
s_start


FROM public.espen_civ_oncho_bsa_1_river_assessment_202208_v4 s
