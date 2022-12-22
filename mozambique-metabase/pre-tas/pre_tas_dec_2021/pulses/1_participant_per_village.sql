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
 * Variable to rename espen_mz_lf_pretas_2_participant_202111_v2_1, espen_mz_lf_pretas_2_participant_202111_v2_1
 */
 SELECT
  p_recorder_id "Código do Operador",
  c_eu "Duistrict",
  c_cluster_id "Identificação de site",
  c_cluster_name "Nome do site",
  COUNT(p.id) "# Participant"

FROM espen_mz_lf_pretas_2_participant_202111_v2_1 c
LEFT JOIN espen_mz_lf_pretas_2_participant_202111_v2_1 p ON c.c_cluster_id = p.p_cluster_id::INT

where p.p_start > CURRENT_start - 1

GROUP BY p_recorder_id, c_eu, c_cluster_id, c_cluster_name
