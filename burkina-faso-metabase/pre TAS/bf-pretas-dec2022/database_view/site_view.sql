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
 * Variable to rename  v_espen_bf_lf_pretas_1_village_202212_v2, espen_bf_lf_pretas_1_village_202212_v2
 */

create view v_espen_bf_lf_pretas_1_village_202212_v2 as

SELECT 

id, 
c_recorder, 
c_drs,
c_district, 
c_formation_sanitaire, 
c_cluster_name, 
c_site, 
c_site_type, 
c_cluster_id1, 
c_population,
c_couverture_tdm_2022, 
c_gps_lat, 
c_gps_lng, 
c_gps_acc,
c_commentaires, 
c_start

FROM public.espen_bf_lf_pretas_1_village_202212_v2 c



