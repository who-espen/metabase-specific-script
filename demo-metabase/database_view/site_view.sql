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
 * Variable to rename  v_espen_ng_lf_pretas_1_site_202211_v1, espen_ng_lf_pretas_1_site_202211_v1
 */
create view v_espen_ng_lf_pretas_1_site_202211_v1 as

SELECT 

id,
c_recorder,
c_region, 
c_district,
c_cluster_name, 
c_site_type, 
c_cluster_id, 
c_cluster_leader, 
c_consent, 
c_gps_lat, 
c_gps_lng, 
 c_gps_acc,
c_cluster_notes,
c_start

FROM public.espen_ng_lf_pretas_1_site_202211_v1 c
