create view v_espen_civ_oncho_bsa_2_capture_form_202208_v4 as

SELECT 

id, 
b_recorder_id, 
b_region, 
b_district, 
b_health_area,
b_site, 
b_capture_point, 
b_date, 
b_gps_lat, 
b_gps_lng, 
b_gps_acc,
b_hour, 
b_nb_blackflies1, 
b_weather, 
b_notes, 
b_start

FROM public.espen_civ_oncho_bsa_2_capture_form_202208_v4 b