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
 * Variable to rename espen_bf_lf_pretas_1_sites_202106_v2
 */
 SELECT

 c_district,
 c_cluster_id1,
 c_cluster_name,
 gps_lat,
 gps_lng,
 created_at

FROM espen_bf_lf_pretas_1_sites_202106_v2

  ------ Metabase filter -------
  -- [[and {{c_cluster_id1}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
