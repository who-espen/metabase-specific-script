
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
 * Variable to rename espen_ci_202302_lf_tas1_1_sites, v_espen_ci_202302_lf_tas1_2_partcipants
 */

SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder "Code Opérateur",
	c_eu_name "EU",
	--c_cluster_name "Commune",
	c_cluster_id "Cluster ID",
  c_cluster_name "Nom du Site",
	count (p.id) "Total Participants",
	c_population "Total Population"

FROM v_espen_ci_202302_lf_tas1_1_sites c
JOIN v_espen_ci_202302_lf_tas1_2_partcipants p ON p.p_cluster_id = c.c_cluster_id



GROUP BY c_recorder, c_cluster_id, c_eu_name, c_population,  c_cluster_name
