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
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */
 SELECT

 district,
 --cluster_id,
 cluster_name,
 gps_lat,
 gps_lng,
 start

FROM v_espen_cg_oncho_oem_full_202112

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
