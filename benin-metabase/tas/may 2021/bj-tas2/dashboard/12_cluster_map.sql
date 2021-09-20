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
 * Variable to rename espen_bj_lf_tas2_4_sites_202104
 */
 SELECT

 c_eu_name,
 c_cluster_id1,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 created_at

FROM v_espen_bj_lf_tas2_4_sites_202104
