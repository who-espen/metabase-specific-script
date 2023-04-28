
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
 * Variable to rename espen_bj_lf_tas3_202304_1_sites, v_espen_bj_lf_tas3_202304_2_partcipants_v1_1
 */
SELECT
--DISTINCT ON  (c_cluster_id1)
	c_recorder "Code Opérateur",
	c_eu_name "UE",
	c_cluster_id "Cluster ID",
    c.c_cluster_name "Nom du Site",
	count (p.id) "Total Participants",
	c_population "Total Population"

FROM v_espen_bj_lf_tas3_202304_1_sites c
JOIN v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 p ON p.p_cluster_id = c.c_cluster_id

WHERE p.id IS NOT NULL

GROUP BY c_recorder, c_cluster_id, c_eu_name, c_population, c_cluster_name
