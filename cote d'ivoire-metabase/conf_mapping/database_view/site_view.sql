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
 * Variable to rename  v_espen_ci_202302_lf_conf_1_sites, espen_ci_202302_lf_conf_1_sites
 */


create view v_espen_ci_202302_lf_conf_1_sites as

SELECT 
id, 
 c_recorder,
 c_region_name, 
 c_district,
 c_district_id, 
 
 case when c_cluster_name = 'Autre' then c_cluster_name2 else c_cluster_name end c_cluster_name,
 case when  c_cluster_name = 'Autre' then c_cluster_id2 else c_cluster_id end c_cluster_id,
 
 c_cluster_leader_name,
 c_consent, 
 c_population, 
 c_present, 
 c_gps_lat, 
 c_gps_lng,
 c_gps_acc, 
 c_cluster_notes,
 c_start

FROM public.espen_ci_202302_lf_conf_1_sites c


