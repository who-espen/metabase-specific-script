/*
 * File: 9_participant_per_village.sql
 * File Created: Saturday, 2nd May 2020 11:05:52 am
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:10 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename v_espen_cg_oncho_oem_full_202112, v_espen_cg_oncho_oem_full_202112
 */
SELECT
DISTINCT ON  (c_cluster_id)
	c_recorder_id "Recorder ID",
	c_district "District",
	c_cluster_id "Cluster ID",
  c_cluster_name "Cluster Name",
	count (p.id) "Total Participants",
	 c_population "Total Population"

FROM v_espen_cg_oncho_oem_full_202112 c
JOIN v_espen_cg_oncho_oem_full_202112 p ON p.p_cluster_id = c.cluster_id


GROUP BY c_recorder_id, c_cluster_id, c_district, c_population, c_cluster_name
