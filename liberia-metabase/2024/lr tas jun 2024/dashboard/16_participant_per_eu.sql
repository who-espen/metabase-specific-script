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
 * Variable to rename v_espen_lr_lf_tas1_2_child_202406_v1, espen_lr_lf_tas1_1_site_202406_v1
 */
 SELECT

  c.c_cluster_id1 "Site ID",
  c_eu_code "EU",
  c_district "District",
  c_cluster_name "Site Name",
  COUNT(p.id) "Enrolled",
  COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
  COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female",
  SUM (DISTINCT c_population)

FROM v_espen_lr_lf_tas1_2_child_202406_v1 p
LEFT JOIN espen_lr_lf_tas1_1_site_202406_v1 c ON p.p_cluster_id::INT = c.c_cluster_id1

WHERE p.id IS NOT NULL


GROUP BY c_cluster_id1, c_eu_code, c_district, c_cluster_name
