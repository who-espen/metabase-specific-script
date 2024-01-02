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
 * Variable to rename  v_espen_bi_oncho_prestop_1_202307_site_v3, espen_bi_oncho_prestop_1_202307_site_v3
 */

CREATE VIEW v_espen_bi_oncho_prestop_1_202307_site_v3 as

SELECT 

id, 
c_date,
c_recorder_id, 
c_chef_equipe, 
c_region,
c_district,
c_commune,
c_centre_sante,
c_cluster_name, 
c_gps_lat, 
c_gps_lng, 
 c_gps_acc, 
 c_cluster_notes,
 c_start_time c_start

FROM public.espen_bi_oncho_prestop_1_202307_site_v3 c
