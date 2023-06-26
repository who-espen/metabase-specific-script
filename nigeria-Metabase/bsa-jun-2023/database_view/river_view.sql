/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_tg_oncho_stop_1_site_202204, espen_tg_oncho_stop_1_site_202204
 */
create view v_espen_bj_oncho_bsa_1_river_assessment_202207_v3 as 

SELECT 

id, 
s_recorder_id "Enregistreur",
s_zone_transmission "Zone de transmission", 
s_region "Region", 
s_district "District",
s_health_facility "Aire Sanitaire", 
s_site "Site", 
s_site_id "Code du site",
s_river_basin_name "Bassin", 
s_river_name "Rivière", 
s_river_distance "Distance du point de capture (M)", 
s_vegetation_type "Végétation", 
s_tidc_date "Date lancement TIDC",
s_capture_point "Point de capture", 
s_close_breeding "Gîte",
s_type_close_breeding_site "Type de gîte",
s_close_village "Village", 
s_close_village_population "Population", 

case when s_close_village_activity = 'Other' then s_close_village_activity_other else s_close_village_activity end "Activité", 

s_gps_lat "Latitude", 
s_gps_lng "Longitude", 
s_gps_acc "Accuracy",

case when s_notes = 'Other' then s_notes_other else s_notes end "Notes",

s_start "Date"

FROM public.espen_bj_oncho_bsa_1_river_assessment_202207_v3 s