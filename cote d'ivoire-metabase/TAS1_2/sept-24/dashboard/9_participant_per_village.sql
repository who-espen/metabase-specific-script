
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
 * Variable to rename espen_ci_lf_tas1_2409_1_sites, v_espen_ci_lf_tas1_2409_2_partcipants
 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder "Code Opérateur",
	c_region "Region",
	c_district "District",
	c_cluster_id "Cluster ID",
    c_site "Nom du Site",
	count (p.id) "Total Participants",
	c_population "Total Population"

FROM v_espen_ci_lf_tas1_2409_1_sites c
JOIN v_espen_ci_lf_tas1_2409_2_partcipants p ON p.p_cluster_id = c.c_cluster_id



GROUP BY c_recorder, c_cluster_id, c_region, c_population, c_district, c_site
