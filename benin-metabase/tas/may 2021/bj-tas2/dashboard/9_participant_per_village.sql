
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
 * Variable to rename espen_bj_lf_tas2_4_sites_202104, v_espen_bj_lf_tas2_5_partcipants_202104_v2
 */
SELECT
--DISTINCT ON  (c_cluster_id1)
	c_recorder "Code Opérateur",
	c_eu_name "UE",
	c_cluster_id1 "Cluster ID",
    c.c_cluster_name "Nom du Site",
	count (p.id) "Total Participants",
	c_population "Total Population"

FROM v_espen_bj_lf_tas2_4_sites_202104 c
JOIN v_espen_bj_lf_tas2_5_partcipants_202104_v2 p ON p.p_cluster_id::INT = c.c_cluster_id1

WHERE p.id IS NOT NULL

GROUP BY c_recorder, c_cluster_id1, c_eu_name, c_population, c_cluster_name

