/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_tg_oncho_stop_2_participants_202204, v_espen_tg_oncho_stop_2_participants_202204
 */
create view v_espen_bj_oncho_bsa_2_capture_form_202207_v3 as

SELECT 

id, 
b_recorder_id "Enregistreur", 
b_district "District", 
b_site "Site", 
b_site_id "Code du site",
b_capture_point "Point de capture",
b_health_area "Aire de santé", 
b_date "Date", 
b_gps_lat "Latitude", 
b_gps_lng "Longitude", 
b_gps_acc "Précision", 
b_hour "Heure", 
b_nb_blackflies1 "Nombre des mouches noires", 
b_weather "Observation climatique", 
b_notes "Notes", 
b_start "Date d'enregistrement"

FROM public.espen_bj_oncho_bsa_2_capture_form_202207_v3 b;


