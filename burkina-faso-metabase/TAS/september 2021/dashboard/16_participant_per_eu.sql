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
 * Variable to rename v_espen_bf_lf_tas1_2_enrolement_202010, espen_bf_lf_tas1_1_sites_202010
 */
 SELECT

  c.nb_grappe "Site ID",
  c_eu_code "EU",
  ds "District",
  nom_grappe "Site Name",
  COUNT(p.id) "Enrolled",
  COUNT(CASE WHEN sexe = 'Male' THEN 1 ELSE NULL END) "Male",
  COUNT(CASE WHEN sexe = 'Female' THEN 1 ELSE NULL END) "Female",
  SUM (DISTINCT c_population)

FROM v_espen_bf_lf_tas1_2_enrolement_202010 p
LEFT JOIN espen_bf_lf_tas1_1_sites_202010 c ON p.nb_grappe::INT = c.nb_grappe

WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{nb_grappe}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY nb_grappe, c_eu_code, ds, nom_grappe
