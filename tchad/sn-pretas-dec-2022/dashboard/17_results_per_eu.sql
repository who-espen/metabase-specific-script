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
 * Variable to rename v_espen_td_lf_pretas_2_participant_202208_v2, espen_td_lf_pretas_1_site_202208_v2
 */
 SELECT
c_site_id1 "Site ID",
c_eu_code "EU",
c_district "District",
c_site "Site Name",
COUNT(p.id) "Enrolled",
COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female",
COUNT(CASE WHEN (p_sex = 'Male' and d_result = 'Positive') THEN 1 ELSE NULL END) "Positive Male",
COUNT(CASE WHEN (p_sex = 'Female' and d_result = 'Positive') THEN 1 ELSE NULL END) "Positive Female",
COUNT(CASE WHEN (d_result = 'Positive') THEN 1 ELSE NULL END) "Total Positive",
COUNT(CASE WHEN (p_sex = 'Male' and d_result = 'Negative') THEN 1 ELSE NULL END) "Negative Male",
COUNT(CASE WHEN (p_sex = 'Female' and d_result = 'Negative') THEN 1 ELSE NULL END) "Negative Female",
COUNT(CASE WHEN ( d_result = 'Negative') THEN 1 ELSE NULL END) "Total Negative",
COUNT(CASE WHEN ( d_result = 'Invalid') THEN 1 ELSE NULL END) "Total Invalid"

FROM v_espen_td_lf_pretas_3_resultat_fts_202208_v2 d
LEFT JOIN espen_td_lf_pretas_1_site_202208_v2 c on d.d_site_id::int = c.c_site_id1
RIGHT JOIN v_espen_td_lf_pretas_2_participant_202208_v2 p on p.p_code_id = d.d_code_id

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_site_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_site_id1, c_eu_code, c_district, c_site
