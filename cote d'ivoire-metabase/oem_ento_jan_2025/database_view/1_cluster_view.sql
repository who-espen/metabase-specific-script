/*
 * File: cluster_view.sql
 * File Created: Wednesday, 22nd April 2020 2:51:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 30th April 2020 9:57:12 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bj_oncho_stop_1_202306_site_v3, espen_bj_oncho_stop_1_202306_site_v3
 */

create view v_espen_bj_oncho_stop_1_202306_site_v3 as

SELECT 

id, 
c_recorder_id,
c_region,
c_district,
c_cluster_name, 
c_gps_lat,
c_gps_lng, 
c_gps_acc, 
c_cluster_notes, 
c_start_time c_start

FROM public.espen_bj_oncho_stop_1_202306_site_v3 c

