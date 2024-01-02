/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_civ_oncho_ia_202309_1_site_v4, espen_civ_oncho_ia_202309_1_site_v4
 */

create view v_espen_civ_oncho_ia_202309_1_site_v4 as

SELECT 

id
s_recorder_id,
s_region,
s_district,
s_district_id,
s_village_1ere_ligne,
s_site, 
s_site_dist_village, 
s_site_id, 
s_population, 
s_simulie, 
s_village_pratique_tdm, 
s_tdm_mois, 
s_tdm_annee, 
s_river_name, 
s_gps_lat, 
s_gps_lng, 
-- s_gps_alt,
s_gps_acc, 
s_notes, 
s_start

FROM public.espen_civ_oncho_ia_202309_1_site_v3 s

union all

SELECT 

id
s_recorder_id,
s_region,
s_district,
s_district_id,
s_village_1ere_ligne,
s_site, 
s_site_dist_village, 
s_site_id, 
s_population, 
s_simulie, 
s_village_pratique_tdm, 
s_tdm_mois, 
s_tdm_annee, 
s_river_name, 
s_gps_lat, 
s_gps_lng, 
-- s_gps_alt,
s_gps_acc, 
s_notes, 
s_start

FROM public.espen_civ_oncho_ia_202309_1_site_v4 s
