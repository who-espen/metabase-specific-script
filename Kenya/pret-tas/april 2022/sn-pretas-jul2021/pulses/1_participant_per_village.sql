/*
 * File: 1_participant_per_village.sql
 * File Created: Thursday, 7th May 2020 11:30:31 am
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 7th May 2020 11:33:12 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return a table that will contain the number of participants per village surveyed the day before.
 * Variable to rename v_espen_ke_lf_pretas_1_site_202203_v4, v_espen_ke_lf_pretas_2_participant_202203_v4
 */
 SELECT
  p_enumerator "Operator",
  c_subcounty "Duistrict",
  c_cluster_id "Cluster ID",
  c_cluster_name "Site Name",
  COUNT(p.id) "# Participant"

FROM v_espen_ke_lf_pretas_1_site_202203_v4 c
LEFT JOIN v_espen_ke_lf_pretas_2_participant_202203_v4 p ON c.c_cluster_id = p.p_cluster_id::INT

where p.p_start > CURRENT_start - 1

GROUP BY p_enumerator, c_subcounty, c_cluster_id, c_cluster_name
