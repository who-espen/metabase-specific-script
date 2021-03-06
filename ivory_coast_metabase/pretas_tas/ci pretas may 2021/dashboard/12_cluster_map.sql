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
 * Variable to rename espen_ci_lf_pretas_1_site_202105_v3
 */
 SELECT

 c_district_id,
 c_cluster_id1,
 c_site,
 c_gps_lat,
 c_gps_lng,
 created_at

FROM espen_ci_lf_pretas_1_site_202105_v3

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
