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
 * Variable to rename espen_ci_lf_tas1_1_sites_202110_v3
 */
 SELECT

 c_eu_name,
 c_commune,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c_start

FROM v_espen_ci_lf_tas1_1_sites_202110_v3

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
