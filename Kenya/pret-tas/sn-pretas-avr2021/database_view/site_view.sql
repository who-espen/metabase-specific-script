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
 * Variable to rename  v_espen_ke_lf_pretas_1_site_202203_v4, espen_ke_lf_pretas_1_site_202203_v4
 */
create view v_espen_ke_lf_pretas_1_site_202203_v4 as

SELECT 

id, 
c_date_visit, 
c_enumerator, 
c_county,
c_subcounty, 
c_cluster_name, 
c_cluster_id, 
c_site_type, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc, 
c_cluster_notes, 
c_start

FROM public.espen_ke_lf_pretas_1_site_202203_v4 c
