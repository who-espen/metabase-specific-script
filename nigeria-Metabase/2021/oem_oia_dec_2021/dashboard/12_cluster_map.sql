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
 * Variable to rename v_espen_ng_oncho_oem_1_site_202112_v2_2
 */
 SELECT

 c_district,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c_start

FROM v_espen_ng_oncho_oem_1_site_202112_v2_2

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
