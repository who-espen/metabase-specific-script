
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
 * Variable to rename espen_ci_lf_pretas_1_site_202105_v3, v_espen_ci_pretas_lf_enrollement_v7
 */
SELECT
	c.code_id "Code Operateur",
	c.ue "UE",
	c.code_site "Code Site",
    c.site "Site",
	count (p.id) "Total Participants",
	population_2019 "Total Population 2019"

FROM v_espen_ci_lf_pretas_1_site_202105_v3 c
JOIN v_espen_ci_pretas_lf_enrollement_v7 p ON p.code_site::INT = c.code_site

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_recorder_id, c_cluster_id, c_district_id, c_village_pop
