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
 * Variable to rename  v_espen_td_lf_pretas_1_site_202208_v2, espen_td_lf_pretas_1_site_202208_v2
 */
create view v_espen_td_lf_pretas_1_site_202208_v2 as
SELECT 

id,
c_recorder,
c_region, 
c_district,
c_type_site, 
c_site, 
c_site_id, 
c_population, 
c_site_leader, 
c_site_leader_contact, 
c_consent, 
c_gps_lat,
c_gps_lng, 
 c_gps_acc,
 c_cluster_notes, 
 c_start

FROM public.espen_td_lf_pretas_1_site_202208_v2 c
