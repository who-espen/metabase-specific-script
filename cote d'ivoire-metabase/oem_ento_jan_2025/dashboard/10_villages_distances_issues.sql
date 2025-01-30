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
 * Variable to rename espen_bj_oncho_stop_1_202306_site_v3, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') "Distances in KM",
  src.c_recorder_id "Recorder1 ID",
--  src.c_cluster_id "Cluster1 ID",
  src.c_cluster_name "Cluster1 Name",
  dest.c_recorder_id "Recorder2 ID",
 -- dest.c_cluster_id "Cluster2 ID",
  dest.c_cluster_name  "Cluster2 Name",
  src.c_gps_lat "Latitude1",
  src.c_gps_lng "Longitude1",
  dest.c_gps_lat "Latitude2",
  dest.c_gps_lng "Longitude2"

FROM public.v_espen_bj_oncho_stop_1_202306_site_v3 src
  JOIN public.v_espen_bj_oncho_stop_1_202306_site_v3 dest on (
    SELECT calculate_distance(src.c_gps_lat , src.c_gps_lng , dest.c_gps_lat , dest.c_gps_lng,  'K') < 5
    AND src.c_cluster_name <> dest.c_cluster_name
  )
  
  order by "Distances in KM" desc

