
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
 * Variable to rename espen_bf_lf_tas3_1_sites_202109, v_espen_bf_lf_tas3_2_enrolement_202109
 */
SELECT
DISTINCT ON  (c.nb_grappe)
	c.code_operateur "Code Opérateur",
	drs "District",
	c.nb_grappe "Cluster ID",
  c.nom_de_la_grappe "Nom du Site",
	count (p.id) "Total Participants"
FROM v_espen_bf_lf_tas3_1_sites_202109 c
JOIN v_espen_bf_lf_tas3_2_enrolement_202109 p ON p.nb_grappe::INT = c.nb_grappe

WHERE c.id IS NOT NULL

GROUP BY c.code_operateur, c.nb_grappe, drs, c.nom_de_la_grappe