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
 * Variable to rename Pre TAS, v_espen_bj_lf_tas3_202304_3_fts_result_v1, v_espen_bj_lf_tas3_202304_2_partcipants_v1_1,
 * espen_bj_lf_tas3_202304_1_sites
 */
  SELECT

  'TAS3' "Type d'enquete",
  INITCAP(c_eu_name) "Unité d'évaluation",
  initcap(c_commune) "Unité d'implémentation",
  INITCAP(c_cluster_name) "Site",
  TO_CHAR(c.created_at, 'Month') "Mois",
  EXTRACT(YEAR FROM c.created_at) "Année",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date 1ère tournée",
  NULL "nombre total de tournée",
  NULL "nombre total de tournée avec couverture effective",
  'Ecole' "Site enquêté",
  'Systématique' "Methode sélection des sites",
  'Méthode selection personnes' "Commodité",
  
  50 "Target Sample Size",-- TODO: Update the sample size
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age group(Min - Max)",  
  'FTS (Ag)' "Diagnostic Test",
  
  count(p.id) "Examinded",
  COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positive",
  null "Decision", --TODO: Update the decision
  COUNT(CASE WHEN (d_result1 = 'Invalide' or d_result2 = 'Invalide' or d_result3 = 'Invalide') THEN 1 ELSE NULL END) "Number of invalid tests", --TODO: Update the number of invalid test
  null "Lymphoedema Total Patient Number", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patient Number", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Comments" --TODO: Update the comments

FROM v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 p
left join v_espen_bj_lf_tas3_202304_3_fts_result_v1 d on d.d_code_id = p.p_code_id 
left join espen_bj_lf_tas3_202304_1_sites c on p.p_cluster_id = c.c_cluster_id

GROUP BY c_eu_name, c_commune, c_cluster_name, "Mois", "Année", c_gps_lat, c_gps_lng

order by c_eu_name, c_commune, c_cluster_name
