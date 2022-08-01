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
 * Variable to rename v_espen_lr_oncho_ias_2_participant_202112_v2_2, espen_ng_ng_oncho_oias_1_site_202207_v2
 */
 SELECT

  c.c_site_id "Site ID",
  c_eu_code "EU",
  c_district "District",
  c_site_name "Site Name",
  COUNT(p.id) "Enrolled",
  COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
  COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female",
  SUM (DISTINCT c_population)

FROM v_espen_lr_oncho_ias_2_participant_202112_v2_2 p
LEFT JOIN espen_ng_ng_oncho_oias_1_site_202207_v2 c ON p.p_cluster_id::INT = c.c_site_id

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_site_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY c_site_id, c_eu_code, c_district, c_site_name
