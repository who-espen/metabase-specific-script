
/*
 * File: 10_school_distance_issue.sql
 * File Created: Tuesday, 12th May 2020 1:53:38 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:55:36 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will will display the list of nearby villages less than <%village_dist_required%> KM
 * Variable to rename v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, <%village_dist_required%>
 */
SELECT

  calculate_distance(src.w_gps_lat , src.w_gps_lng , dest.w_gps_lat , dest.w_gps_lng,  'K') "Distances in KM",
  src.w_recorder_id "Recorder1 ID",
  src.w_school_id1 "School1 ID",
  src.w_school_name "School1 Name",
  dest.w_recorder_id "Recorder2 ID",
  dest.w_school_id1 "School2 ID",
  dest.w_school_name  "School2 Name",
  src.w_gps_lat "Latitude1",
  src.w_gps_lng "Longitude1",
  dest.w_gps_lat "Latitude2",
  dest.w_gps_lng "Longitude2"

FROM v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 src
  JOIN v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 dest on (
    SELECT calculate_distance(src.w_gps_lat , src.w_gps_lng , dest.w_gps_lat , dest.w_gps_lng,  'K') < <%village_dist_required%>
    AND src.w_school_id1 <> dest.w_school_id1
  )

WHERE IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]];
