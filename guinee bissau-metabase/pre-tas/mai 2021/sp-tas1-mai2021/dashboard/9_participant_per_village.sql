
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
 * Variable to rename espen_gw_lf_pretas_1_sites_202206_v2_1
, v_espen_gw_lf_pretas_2_partcipants_202206_v2_1

 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder "Código do operador",
	c_district "Distrito",
	c_cluster_id "Código do sítio",
  c_cluster_name "sítio",
	count (p.id) "Total de Participantes"

FROM v_espen_gw_lf_pretas_1_sites_202206_v2_1
 c
JOIN v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
 p ON p.p_cluster_id = c.c_cluster_id



GROUP BY c_recorder, c_cluster_id, c_district, c_cluster_name