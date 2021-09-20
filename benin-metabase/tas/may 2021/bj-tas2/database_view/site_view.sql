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
 * Variable to rename  v_espen_bj_lf_tas2_4_sites_202104, espen_bj_lf_tas2_4_sites_202104
 */
create view v_espen_bj_lf_tas2_4_sites_202104 as
SELECT 

id, 
c_recorder, 
c_eu_name, 
c_commune, 
c_cluster_name, 
c_cluster_id1, 
c_cluster_leader_name, 
c_cluster_leader_contact, 
c_consent, 
c_population, 
c_present, 
c_absent, 
c_gps_lat, 
c_gps_lng,  
c_gps_acc, 
c_cluster_notes, 
c_start

FROM public.espen_bj_lf_tas2_4_sites_202104 c
