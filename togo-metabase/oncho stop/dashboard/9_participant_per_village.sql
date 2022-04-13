
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
 * Variable to rename espen_tg_oncho_stop_1_site_202204, v_espen_tg_oncho_stop_2_participants_202204
 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder_id "Code Opérateur",
	c_district "District",
	c_cluster_id "Code Site",
  c_cluster_name "Site",
	count (p.id) "Total de Participants"

FROM v_espen_tg_oncho_stop_1_site_202204 c
JOIN v_espen_tg_oncho_stop_2_participants_202204 p ON p.p_cluster_id = c.c_cluster_id



GROUP BY c_recorder_id, c_cluster_id, c_district, c_cluster_name