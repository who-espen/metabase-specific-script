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
 * Variable to rename v_espen_cv_pretas_lf_village_v7, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.gps_lat , src.gps_lng , dest.gps_lat , dest.gps_lng,  'K') "Distances in KM",
  src.code_operateur "Opérateur 1",
  src.code_site "Code Site 1",
  src.site "Site 1",
  dest.code_operateur "Opérateur 2",
  dest.code_site "Code Site 2",
  dest.site  "Site 2",
  src.gps_lat "Latitude 1",
  src.gps_lng "Longitude 1",
  dest.gps_lat "Latitude 2",
  dest.gps_lng "Longitude 2"

FROM v_espen_cv_pretas_lf_village_v7 src
  JOIN v_espen_cv_pretas_lf_village_v7 dest on (
    SELECT calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') < 5
    AND src.c_cluster_id1 <> dest.c_cluster_id1
  )

WHERE IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]];

