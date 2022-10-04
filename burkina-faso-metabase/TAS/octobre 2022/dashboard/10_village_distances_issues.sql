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
 * Variable to rename espen_bf_lf_tas3_1_sites_202209_y, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') "Distances in KM",
  src.c_code_operateur "Code Opérateur 1",
  src.c_num_grappe "Code Site 1",
  src.c_nom_grappe "Site 1",
  dest.c_code_operateur "Code Opérateur 2",
  dest.c_num_grappe "Code Site 2",
  dest.c_nom_grappe  "Site 2",
  src.c_gps_lat "Latitude1",
  src.c_gps_lng "Longitude1",
  dest.c_gps_lat "Latitude2",
  dest.c_gps_lng "Longitude2"

FROM public.v_espen_bf_lf_tas3_1_site_202209_v1_y src
  JOIN v_espen_bf_lf_tas3_1_site_202209_v1_y dest on (
    SELECT calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') < 5
    AND src.c_num_grappe <> dest.c_num_grappe
  )

WHERE src.id IS NOT NULL


