/*
 * File: 12_cluster_map.sql
 * File Created: Saturday, 2nd May 2020 1:45:11 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:48:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_bj_oncho_stop_1_202306_site_v3
 */




SELECT distinct on(c_cluster_name )
    c_district,
    -- c_cluster_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c_start
FROM
     public.v_espen_bj_oncho_stop_1_202306_site_v3
    
    