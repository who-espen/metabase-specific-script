
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
 * Variable to rename espen_sn_lf_tas_1_sites_202101_v3, v_espen_sn_lf_tas_2_partcipants_202101_v3
 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder "Code Opérateur",
	c_district "District",
	c_cluster_id "Cluster ID",
  c_cluster_name "Nom du Site",
	count (p.id) "Total Participants",
	c_village_pop "Total Population"

FROM espen_sn_lf_tas_1_sites_202101_v3 c
JOIN v_espen_sn_lf_tas_2_partcipants_202101_v3 p ON p.p_cluster_id::INT = c.c_cluster_id

WHERE id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_recorder, c_cluster_id, c_district, c_village_pop
