
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
 * Variable to rename espen_lr_lf_tas1_1_site_202406_v1, v_espen_lr_lf_tas1_2_child_202406_v1
 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder "Operator",
	c_district "District",
	c_cluster_id "Site ID",
  c_cluster_name "Site Name",
	count (p.id) "Total Participants"
	--c_population "Total Population"

FROM v_espen_lr_lf_tas1_1_site_202406_v1 c
JOIN v_espen_lr_lf_tas1_2_child_202406_v1 p ON p.p_cluster_id = c.c_cluster_id

WHERE c.id IS NOT NULL

GROUP BY c_recorder, c_cluster_id, c_district, c_cluster_name