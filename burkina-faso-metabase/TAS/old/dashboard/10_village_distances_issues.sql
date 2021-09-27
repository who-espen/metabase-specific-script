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
 * Variable to rename espen_bf_lf_tas1_1_sites_202010, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.gps_lat , src.gps_lng , dest.gps_lat , dest.gps_lng,  'K') "Distances in KM",
  src.code_operateur "Code Opérateur 1",
  src.nb_grappe "Code Site 1",
  src.nom_grappe "Site 1",
  dest.code_operateur "Code Opérateur 2",
  dest.nb_grappe "Code Site 2",
  dest.nom_grappe  "Site 2",
  src.gps_lat "Latitude1",
  src.gps_lng "Longitude1",
  dest.gps_lat "Latitude2",
  dest.gps_lng "Longitude2"

FROM espen_bf_lf_tas1_1_sites_202010 src
  JOIN espen_bf_lf_tas1_1_sites_202010 dest on (
    SELECT calculate_distance(src.gps_lat , src.gps_lng , dest.gps_lat , dest.gps_lng,  'K') < 5
    AND src.nb_grappe <> dest.nb_grappe
  )

WHERE src.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]];

