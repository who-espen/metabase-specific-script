
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
 * Variable to rename espen_mz_lf_tas1_1_site_202011, v_espen_mz_lf_tas1_2_participant_202011_v3
 */
SELECT
--DISTINCT ON  (c_cluster_id1)
	c_recorder "Código do Operador",
	c_eu "UE",
	c_cluster_id1 "Identificação de site",
    c.c_cluster_name "Nome do site",
	count (p.id) "Total de participantes",
	c_population "População total"

FROM espen_mz_lf_tas1_1_site_202011 c
JOIN v_espen_mz_lf_tas1_2_participant_202011_v3 p ON p.p_cluster_id::INT = c.c_cluster_id1

WHERE p.id IS NOT NULL

GROUP BY c_recorder, c_cluster_id1, c_eu, c_population, c_cluster_name

