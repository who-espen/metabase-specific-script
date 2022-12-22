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
 * Variable to rename  v_espen_sr_oncho_oem_1_site_202211_v_3, espen_ng_ng_oncho_oias_1_site_202212_v2
 */
create view v_espen_sr_oncho_oem_1_site_202211_v_3 as

SELECT 

id, 
c_recorder_id,
c_district, 

case when c_cluster_name like '%Spare%' then c_cluster_name_other else c_cluster_name end c_cluster_name,

c_cluster_id,
c_date, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc, 
c_population, 
c_black_fly, 
c_notes, 
c_start

FROM public.espen_sr_oncho_oem_1_site_202211_v_3 c

