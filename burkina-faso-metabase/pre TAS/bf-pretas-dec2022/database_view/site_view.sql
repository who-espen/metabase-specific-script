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
 * Variable to rename  v_espen_bf_lf_pretas_1_sites_202106_v2, espen_bf_lf_pretas_1_sites_202106_v2
 */
CREATE OR REPLACE VIEW v_espen_bf_lf_pretas_1_sites_202106_v2

as

SELECT 
id, 
c_recorder, 
c_drs, 
c_district, 
c_csps, 
c_cluster_name, 
c_site, 
c_site_type, 
c_cluster_id11, 
c_population, 
couverture_tdm_2020, 
gps_lat, 
gps_lng, 
gps_acc,
commentaires, 
c_start
FROM public.espen_bf_lf_pretas_1_sites_202106_v2
