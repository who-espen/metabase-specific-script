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



create view v_espen_tg_oncho_bsa_1_river_assessment_202209_v2 as

SELECT 

id, 
s_recorder_id "Enregistreur", 
c_district "District",
c_site "Site", 
c_site_id "Code du site",
c_bassin_fluvial "Bassin", 
c_nom_riviere_fleuve  "Rivière", 
s_date "Date",
b_gps_lat "Latitude",
b_gps_lng "Longitude", 
b_gps_acc "Précision",
r_site_suitable "Est un gîte larvaire", 
r_evidence_of_larvae "Evidence des larves",
r_larvae_rate "Taux", 
s_notes "Note",
s_start


FROM public.espen_tg_oncho_bsa_1_river_assessment_202209_v2 s


