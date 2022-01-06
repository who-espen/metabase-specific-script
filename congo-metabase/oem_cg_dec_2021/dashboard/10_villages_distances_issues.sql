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
 * Variable to rename v_espen_cg_oncho_oem_full_202112, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.gps_lat , src.gps_lng , dest.gps_lat , dest.gps_lng,  'K') "Distances in KM",
  src.recorder_id "Recorder1 ID",
  src.cluster_id "Cluster1 ID",
  src.cluster_name "Cluster1 Name",
  dest.recorder_id "Recorder2 ID",
  dest.cluster_id "Cluster2 ID",
  dest.cluster_name  "Cluster2 Name",
  src.gps_lat "Latitude1",
  src.gps_lng "Longitude1",
  dest.gps_lat "Latitude2",
  dest.gps_lng "Longitude2"

FROM v_espen_cg_oncho_oem_full_202112 src
  JOIN v_espen_cg_oncho_oem_full_202112 dest on (
    SELECT calculate_distance(src.gps_lat , src.gps_lng , dest.gps_lat , dest.gps_lng,  'K') < <%village_dist_required%>
    AND src.cluster_id <> dest.cluster_id
  )

WHERE IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  ;

