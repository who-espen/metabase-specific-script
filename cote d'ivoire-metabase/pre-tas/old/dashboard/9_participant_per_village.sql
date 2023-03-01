
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
 * Variable to rename espen_ci_lf_pretas_1_site_202302, v_espen_ci_lf_pretas_2_participant_202302
 */
SELECT
DISTINCT ON  (c_site_id)
	c_recorder "Code Opérateur",
	c_region "Region",
	c_district "District",
	c_site_id "Cluster ID",
    c_site "Nom du Site",
	count (p.id) "Total Participants",
	c_population "Total Population"

FROM v_espen_ci_lf_pretas_1_site_202302 c
JOIN v_espen_ci_lf_pretas_2_participant_202302 p ON p.p_site_id = c.c_site_id



GROUP BY c_recorder, c_site_id, c_region, c_population, c_district, c_site
