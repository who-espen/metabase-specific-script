/*
 * File: 18_epirf_mirror.sql
 * File Created: Wednesday, 6th May 2020 11:49:40 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 1:36:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query is a sample of EPIRF mirror
 * Variable to rename <%Epirf_Survey_Type%>, v_espen_tg_oncho_stop_3_elisa_202204, v_espen_tg_oncho_stop_2_participants_202204,
 * espen_tg_oncho_stop_1_site_202204
 */
  SELECT

  'TAS1' "Type d'enquête",
  INITCAP(c_eu_name) "Unité d'Evaluation",
  initcap(c_commune) "Unité d'implémentation",
  initcap(c_cluster_name) "Site d'enquête",
  TO_CHAR(c.c_start_time, 'Month') "Mois",
  EXTRACT(YEAR FROM c.c_start_time) "Années",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date 1ère tournées TMM",
  NULL "Nombre de tournées TMM",
  'FTS (Ag)' "Test Diagnostic",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Tranche d'âge(Min - Max)",
  'école' "Site enquete",
  'grappes' "Type d'enquête", -- TODO: Update the survey type
  350 "Taille Population cible",-- TODO: Update the sample size
  count(p.id) "Examiné",
  COUNT(CASE WHEN d_lab_elisa = 'Positive' THEN 1 ELSE NULL END) "Number de Positif",
  ROUND(COUNT(CASE WHEN d_lab_elisa = 'Positive' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positif",
  null "Number of invalid tests", --TODO: Update the number of invalid test
  null "Décision", --TODO: Update the decision
  null "Lymphoedema Total Patient Number", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patient Number", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Commentaires, --TODO: Update the comments"
 
FROM v_espen_tg_oncho_stop_3_elisa_202204 d
LEFT JOIN v_espen_tg_oncho_stop_1_site_202204 c on d.d_cluster_id = c.c_cluster_id
RIGHT JOIN v_espen_tg_oncho_stop_2_participants_202204 p on p.p_code_id = d.d_code_id

GROUP BY c_eu_name, c_commune, c_cluster_name, "Mois", "Années", c_gps_lat, c_gps_lng

order by c_eu_name, c_commune, c_cluster_name















 SELECT

  'TAS1' "Type d'enquête",
  INITCAP(c_eu_name) "Unité d'Evaluation",
  null "Unité d'implémentation",
  null "Site d'enquête",
  TO_CHAR(c.c_start_time, 'Month') "Mois",
  EXTRACT(YEAR FROM c.c_start_time) "Années",
  null "Latitude",
  null "Longitude",
  NULL "Date 1ère tournées TMM",
  NULL "Nombre de tournées TMM",
  'FTS (Ag)' "Test Diagnostic",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Tranche d'âge(Min - Max)",
  'école' "Site enquete",
  'grappes' "Type d'enquête", -- TODO: Update the survey type
  count(distinct c.c_cluster_id)*50 "Taille Population cible",-- TODO: Update the sample size
  count(p.id) "Examiné",
  COUNT(CASE WHEN d_lab_elisa = 'Positive' THEN 1 ELSE NULL END) "Number de Positif",
  ROUND(COUNT(CASE WHEN d_lab_elisa = 'Positive' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positif",
  null "Décision", --TODO: Update the decision
  null "Number of invalid tests", --TODO: Update the number of invalid test
  null "Lymphoedema Total Patient Number", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patient Number", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Commentaires" --TODO: Update the comments
  

FROM v_espen_tg_oncho_stop_3_elisa_202204 d
LEFT JOIN v_espen_tg_oncho_stop_1_site_202204 c on d.d_cluster_id = c.c_cluster_id
RIGHT JOIN v_espen_tg_oncho_stop_2_participants_202204 p on p.p_code_id = d.d_code_id

GROUP BY c_eu_name,  "Mois", "Années"

order by c_eu_name 


