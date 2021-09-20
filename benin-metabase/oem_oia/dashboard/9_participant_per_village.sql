/*
 * File: 9_participant_per_village.sql
 * File Created: Saturday, 2nd May 2020 11:05:52 am
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:10 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename espen_bj_oncho_prestop_1_site, v_espen_bj_oncho_prestop_2_participants
 */
SELECT
DISTINCT ON  (c_cluster_id1)
	c_recorder_id "Recorder ID",
	c_district_id "District",
	c_cluster_id "Code Site",
  c_cluster_name "Site",
	count (p.id) "Total Participants",
	c_village_pop "Total Population"

FROM espen_bj_oncho_prestop_1_site c
JOIN v_espen_bj_oncho_prestop_2_participants p ON p.p_cluster_id::INT = c.c_cluster_id

WHERE id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_recorder_id, c_cluster_id, c_district_id, c_village_pop
