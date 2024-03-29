/*
 * File: 1_participant_per_village.sql
 * File Created: Monday, 4th May 2020 2:18:07 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:55 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will return a table that will contain the number of participants per village surveyed the day before.
 * Variable to rename <%ab_cde_fgh_3_rdt_ov16%>, v_espen_cg_oncho_oem_full_202112
 */
 SELECT
  p_recorder_id "Recorder ID",
  c_district "Duistrict",
  c_cluster_id "Cluster ID",
  c_"Village" "Cluster Name",
  COUNT(p.id) "# Participant"

FROM <%v_ab_cde_fgh_1_cluster%> p
LEFT JOIN v_espen_cg_oncho_oem_full_202112 c ON c.cluster_id = p.p_cluster_id::INT

where p.p_date > CURRENT_DATE - 1

GROUP BY p_recorder_id, c_district, c_cluster_id, c_"Village"
