/*
 * File: 16_participant_per_eu.sql
 * File Created: Wednesday, 6th May 2020 11:06:30 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:28:36 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will display the number of participant per EU by the População total
 * Variable to rename espen_mz_lf_tas2_2_participant_202111_v2_1, update_lf_tas2_orphaned_table_from_diag_result_202112
 */
 SELECT

  c.c_cluster_id "Site ID",
  c_eu_code "EU",
  c_eu "UE",
  c_cluster_name "Site Name",
  COUNT(p.id) "Enrolled",
  COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
  COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female",
  SUM (DISTINCT c_population)

FROM espen_mz_lf_tas2_2_participant_202111_v2_1 p
LEFT JOIN update_lf_tas2_orphaned_table_from_diag_result_202112 c ON p.p_cluster_id::INT = c.c_cluster_id

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_cluster_id, c_eu_code, c_eu, c_cluster_name
