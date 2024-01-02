/*
 * File: 12_village_map.sql
 * File Created: Saturday, 2nd May 2020 1:45:11 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:48:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_gn_oncho_pre_stop_202311_1_site
 */


SELECT distinct on(c_cluster_name )
    c_district,
    c_cluster_id,
    -- c_cluster_name_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c_start
FROM
     public.v_espen_gn_oncho_pre_stop_202311_1_site
    
    