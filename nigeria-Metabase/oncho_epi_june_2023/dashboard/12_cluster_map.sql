/*
 * File: 12_cluster_map.sql
 * File Created: Wednesday, 6th May 2020 10:55:50 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 10:56:54 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_ng_ng_oncho_prestop_1_site_202304_v2
 */

SELECT
    distinct on (c_cluster_id) c_district,
    c_cluster_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c_start
FROM v_espen_ng_oncho_stop_4_site_202306