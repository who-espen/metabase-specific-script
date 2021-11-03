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
 * Variable to rename <%Epirf_Survey_Type%>, v_espen_bj_lf_pretas_3_fts_result_202107_v2, v_espen_sn_lf_pretas_2_partcipants_202107_v2,
 * espen_sn_lf_pretas_1_sites_202107_v2
 */
 SELECT

  null "Type d'ênquestes",
  null "Unité d'évaluation",
  c_district "Unité d'Implémentation",
  c_cluster_name "Site de l'enquête",
  TO_CHAR(c.c_start, 'Month') "Mois",
  EXTRACT(YEAR FROM c.c_start) "Année",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date 1ère Tournée DMM",
  NULL "Nombre de Tournée DMM",
  'FTS (Ag)' "Test Diagnostique",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Tranche d'âge(Min - Max)",
  'école' "Site enquete",
  'grappes' "Type enquete", -- TODO: Update the survey type
  350 "Taille de la Population Cible",-- TODO: Update the sample size
  count(p.id) "Nombre Examiné",
  COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) "Nombre de Positifs",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% de positifs",
  COUNT(CASE WHEN d_final_result = 'Indeterminate' THEN 1 ELSE NULL END) "Nombre de Test Invalide", --TODO: Update the number of invalid test
  null "Decision", --TODO: Update the decision
  null "Lymphoedema Total de Patient", --TODO: Update the Total Patient Number
  null "Lymphoedema Method d'Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date d'Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Centre de Santé", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total de Patient", --TODO: Update the Total Patient Number
  null "Hydrocoele Method d'Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date d'Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Centre de santé", --TODO: Update the Nbr Health Facilities
  null "Commentaires" --TODO: Update the comments

FROM v_espen_bj_lf_pretas_3_fts_result_202107_v2 d
LEFT JOIN v_espen_sn_lf_pretas_1_sites_202107_v2 c on d.d_cluster_id = c.c_cluster_id
RIGHT JOIN v_espen_sn_lf_pretas_2_partcipants_202107_v2 p on p.p_code_id = d.d_code_id

GROUP BY c_district, c_cluster_name, "Mois", "Année", c_gps_lat, c_gps_lng


