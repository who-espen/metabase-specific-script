
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
 * Variable to rename espen_ng_ng_oncho_oias_1_site_202207_v2, v_espen_lr_oncho_ias_2_participant_202112_v2_2
 */
SELECT
DISTINCT ON  (c_site_id)
	c_recorder_id "Recorder ID",
	c_district "LGA",
	c_site_id "Site IF",
  c_site_name "Site",
	count (p.id) "Total Participants"

FROM public.v_espen_lr_oncho_ias_1_site_202112_v2_1 c
JOIN v_espen_lr_oncho_ias_2_participant_202112_v2_2 p ON p.p_cluster_id = c.c_site_id


GROUP BY c_recorder_id, c_site_id, c_site_name, c_district