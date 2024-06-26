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
 * Variable to rename v_espen_sn_lf_itas_2405_1_sit_part_v3_1
 */

SELECT
    DISTINCT ON (c_cluster_id) c_eu_name,
    c_commune,
    c_cluster_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c_start
FROM v_espen_sn_lf_itas_2405_1_sit_part_v3_1