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
 * Variable to rename  v_espen_tg_oncho_stop_202304_1_site, espen_tg_oncho_stop_202304_1_site
 */
create view v_espen_tg_oncho_stop_202304_1_site as 
SELECT 

id, 
c_recorder_id, 
c_region, 
c_district, 
c_subdistrict,
c_site, 
c_gps_lat, 
c_gps_lng, 
c_gps_alt, 
c_gps_acc,
c_date,
c_cluster_notes,
c_start_time

FROM public.espen_tg_oncho_stop_202304_1_site c

