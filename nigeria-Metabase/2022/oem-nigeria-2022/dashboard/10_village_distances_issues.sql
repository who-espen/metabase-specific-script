/*
 * File: 10_village_distances_issues.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:57:33 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will will display the list of nearby villages less than <%village_dist_required%> KM
 * Variable to rename espen_ng_ng_oncho_oem_1_site_202204_v2, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') "Distances in KM",
  src.c_recorder "Code Opérateur 1",
  src.c_cluster_id "Code Site 1",
  src.c_cluster_name "Site 1",
  dest.c_recorder "Code Opérateur 2",
  dest.c_cluster_id "Code Site 2",
  dest.c_cluster_name  "Site 2",
  src.c_gps_lat "Latitude1",
  src.c_gps_lng "Longitude1",
  dest.c_gps_lat "Latitude2",
  dest.c_gps_lng "Longitude2"

FROM espen_ng_ng_oncho_oem_1_site_202204_v2 src
  JOIN espen_ng_ng_oncho_oem_1_site_202204_v2 dest on (
    SELECT calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') < 5
    AND src.c_cluster_id <> dest.c_cluster_id
  )

WHERE src.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]];

