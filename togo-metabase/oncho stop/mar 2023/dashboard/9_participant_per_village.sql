
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
 * Variable to rename espen_tg_oncho_stop_202304_1_site, v_espen_tg_oncho_stop_202304_2_participants
 */
SELECT
DISTINCT ON  (c_site_id)
	c_recorder_id "Code Opérateur",
	c_district "District",
	c_site_id "Code Site",
  c_site "Site",
	count (p.id) "Total de Participants"

FROM v_espen_tg_oncho_stop_202304_1_site c
JOIN v_espen_tg_oncho_stop_202304_2_participants p ON p.p_site_id = c.c_site_id



GROUP BY c_recorder_id, c_site_id, c_district, c_site