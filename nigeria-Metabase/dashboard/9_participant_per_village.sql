
/*
 * File: 9_participant_per_village.sql
 * File Created: Tuesday, 5th May 2020 8:04:12 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 8:06:16 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename espen_ng_lf_pretas_1_site_202102_v2, v_espen_ng_lf_pretas_2_participant_202102_v2
 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder "Recorder ID",
	c_district "LGA",
	c_cluster_id "Site IF",
  c_cluster_name "Site",
	count (p.id) "Total Participants",
	c_village_pop "Total Population"

FROM espen_ng_lf_pretas_1_site_202102_v2 c
JOIN v_espen_ng_lf_pretas_2_participant_202102_v2 p ON p.p_cluster_id::INT = c.c_cluster_id

WHERE id IS NOT NULL

GROUP BY c_recorder, c_cluster_id, c_district, c_village_pop
