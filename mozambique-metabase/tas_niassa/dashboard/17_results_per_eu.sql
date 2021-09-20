/*
 * File: 17_results_per_eu.sql
 * File Created: Wednesday, 6th May 2020 11:28:59 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 11:49:05 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the FTS result by sex and result.
 * Variable to rename v_espen_mz_lf_tas1_2_participant_202011_v3, espen_mz_lf_tas1_1_site_202011
 */
 SELECT
c_cluster_id "Site ID",
c_eu_code "EU",
c_eu "UE",
c_cluster_name "Site Name",
COUNT(p.id) "Enrolled",
COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female",
COUNT(CASE WHEN (p_sex = 'Male' and d_final_result = 'Positivo') THEN 1 ELSE NULL END) "Positive Male",
COUNT(CASE WHEN (p_sex = 'Female' and d_final_result = 'Positivo') THEN 1 ELSE NULL END) "Positive Female",
COUNT(CASE WHEN (d_final_result = 'Positivo') THEN 1 ELSE NULL END) "Total Positive",
COUNT(CASE WHEN (p_sex = 'Male' and d_final_result = 'Negativo') THEN 1 ELSE NULL END) "Negative Male",
COUNT(CASE WHEN (p_sex = 'Female' and d_final_result = 'Negativo') THEN 1 ELSE NULL END) "Negative Female",
COUNT(CASE WHEN ( d_final_result = 'Negativo') THEN 1 ELSE NULL END) "Total Negative",
COUNT(CASE WHEN ( d_final_result = 'Invalid') THEN 1 ELSE NULL END) "Total Invalid"

FROM v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 d
LEFT JOIN espen_mz_lf_tas1_1_site_202011 c on d.d_cluster_id::int = c.c_cluster_id
RIGHT JOIN v_espen_mz_lf_tas1_2_participant_202011_v3 p on p.p_code_id = d.d_code_id

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_cluster_id, c_eu_code, c_eu, c_cluster_name
