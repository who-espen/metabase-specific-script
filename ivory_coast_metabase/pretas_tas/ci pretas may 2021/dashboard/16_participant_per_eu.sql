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
 * This query will display the number of participant per EU by the total population
 * Variable to rename v_espen_ci_pretas_lf_enrollement_v7, espen_ci_lf_pretas_1_site_202105_v3
 */
 SELECT

  c.c_cluster_id1 "Site ID",
  c_eu_code "EU",
  c_district "EU",
  c_site "Site Name",
  COUNT(p.id) "Enrolled",
  COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
  COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female",
  SUM (DISTINCT c_population)

FROM v_espen_ci_pretas_lf_enrollement_v7 p
LEFT JOIN espen_ci_lf_pretas_1_site_202105_v3 c ON p.p_cluster_id::INT = c.c_cluster_id1

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_cluster_id1, c_eu_code, c_district, c_site
