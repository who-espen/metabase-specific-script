
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
 * Variable to rename espen_bf_lf_tas3_1_sites_202209_y, v_espen_bf_lf_tas3_2_participant_202209_v1_y
 */
SELECT
DISTINCT ON  (c.c_num_grappe)
	c.c_code_operateur "Code Opérateur",
	c_ds "District",
	c.c_num_grappe "Cluster ID",
  c.c_nom_grappe "Nom du Site",
	count (p.id) "Total Participants"
FROM v_espen_bf_lf_tas3_1_site_202209_v1_y c
JOIN v_espen_bf_lf_tas3_2_participant_202209_v1_y p ON p.p_nom_grappe = c.c_nom_grappe

WHERE c.id IS NOT NULL

GROUP BY c.c_code_operateur, c.c_num_grappe, c_ds, c.c_nom_grappe