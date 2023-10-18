/*
 * File: 1_participant_per_village.sql
 * File Created: Thursday, 7th May 2020 11:30:31 am
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 7th May 2020 11:33:12 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return a table that will contain the number of participants per village surveyed the day before.
 * Variable to rename v_espen_ng_oncho_202301_prestop_1_site, v_espen_ng_oncho_202301_prestop_2_participant
 */
 SELECT
  p_recorder_id "Recorder ID",
  c_district "Duistrict",
  c_cluster_id "Cluster ID",
  c_cluster_name "Nom du Site",
  COUNT(p.id) "# Participant"

FROM v_espen_ng_oncho_202301_prestop_1_site c
LEFT JOIN v_espen_ng_oncho_202301_prestop_2_participant p ON c.c_cluster_id = p.p_cluster_id::INT

where p.p_date > CURRENT_DATE - 1

GROUP BY p_recorder_id, c_district, c_cluster_id, c_cluster_name
