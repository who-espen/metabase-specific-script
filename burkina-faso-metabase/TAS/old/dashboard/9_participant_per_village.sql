
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
 * Variable to rename espen_bf_lf_tas1_1_sites_202010, v_espen_bf_lf_tas1_2_enrolement_202010
 */
SELECT
DISTINCT ON  (nb_grappe)
	code_operateur "Code Opérateur",
	ds "District",
	nb_grappe "Cluster ID",
  nom_grappe "Nom du Site",
	count (p.id) "Total Participants",
	c_village_pop "Total Population"

FROM espen_bf_lf_tas1_1_sites_202010 c
JOIN v_espen_bf_lf_tas1_2_enrolement_202010 p ON p.nb_grappe::INT = c.nb_grappe

WHERE id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY code_operateur, nb_grappe, ds, c_village_pop
