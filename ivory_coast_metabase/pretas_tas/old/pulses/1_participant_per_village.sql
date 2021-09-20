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
 * Variable to rename v_espen_cv_pretas_lf_village_v7, v_espen_ci_pretas_lf_enrollement_v7
 */
 SELECT
  code_operateur "Code Operateur",
  c_district "Duistrict",
  c_cluster_id Code Site",
  c_cluster_name "Site",
  COUNT(p.id) "# Participant"

FROM v_espen_cv_pretas_lf_village_v7 p
LEFT JOIN v_espen_ci_pretas_lf_enrollement_v7 c ON c.c_cluster_id = p.p_cluster_id::INT

where p.p_date > CURRENT_DATE - 1

GROUP BY code_operateur, c_district, c_cluster_id, c_cluster_name
