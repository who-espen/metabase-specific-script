
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
 * Variable to rename espen_bf_lf_pretas_1_sites_202106_v2, v_espen_bf_lf_pretas_2_enrolement_202106_v2_2
 */
SELECT
DISTINCT ON  (c_cluster_id11)
	c_recorder "Code Opérateur",
	c_district "District",
	c_cluster_id11 "Cluster ID",
  c_cluster_name "Nom du Site",
	count (p.id) "Total Participants",
	c_population "Total Population"

FROM v_espen_bf_lf_pretas_1_sites_202106_v2 c
JOIN v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 p ON p.p_cluster_id = c.c_cluster_id11



GROUP BY c_recorder, c_cluster_id11, c_district, c_population,c_cluster_name
