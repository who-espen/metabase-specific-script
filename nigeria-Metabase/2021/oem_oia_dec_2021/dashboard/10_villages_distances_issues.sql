/*
 * File: 10_villages_distances_issues.sql
 * File Created: Saturday, 2nd May 2020 11:13:12 am
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 11:44:07 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will will display the list of nearby villages less than <%village_dist_required%> KM
 * Variable to rename v_espen_ng_oncho_oem_1_site_202112_v2_2, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') "Distances in KM",
  src.c_recorder_id "Recorder1 ID",
  src.c_cluster_id "Cluster1 ID",
  src.c_cluster_name "Cluster1 Name",
  dest.c_recorder_id "Recorder2 ID",
  dest.c_cluster_id "Cluster2 ID",
  dest.c_cluster_name  "Cluster2 Name",
  src.c_gps_lat "Latitude1",
  src.c_gps_lng "Longitude1",
  dest.c_gps_lat "Latitude2",
  dest.c_gps_lng "Longitude2"

FROM v_espen_ng_oncho_oem_1_site_202112_v2_2 src
  JOIN v_espen_ng_oncho_oem_1_site_202112_v2_2 dest on (
    SELECT calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') < <%village_dist_required%>
    AND src.c_cluster_id <> dest.c_cluster_id
  )

WHERE IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  ;

