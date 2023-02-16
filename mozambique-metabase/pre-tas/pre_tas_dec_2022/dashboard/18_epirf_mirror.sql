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
 * Variable to rename Pre TAS, v_espen_mz_lf_pretas_3_resultat_fts_202209_v1, espen_mz_lf_pretas_2_participant_202209_v1,
 * update_lf_tas_orphaned_table_from_diag_result_202212
 */
 

  select
 
 distinct on (c_district, c_cluster_name)

  c_site_type "Type enquête",
  null "Unité Evaluation",
  c_district "Implementation Unit",
  c_cluster_name "Survey Site",
  TO_CHAR(c_start, 'Month') "Month",
  EXTRACT(YEAR FROM c_start) "Year",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  

  null "Date of 1st PC Round",

  null "Number of PC Round",
  
  'FTS (Ag)' "Test Diag",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Groupe d'âge(Min - Max)",
  'Communauté' "Site enquete",
  'Cluster' "Méthode de sélection des sites", -- TODO: Update the survey type
  null "Target Sample Size",-- TODO: Update the sample size
  count(*) "Nbr Examinées",
  COUNT(CASE WHEN d_result1 = '1_Positif' and d_result2 = '1_Positif' THEN 1 ELSE NULL END) "Nbr Positifs",
  ROUND(COUNT(CASE WHEN d_result1 = '1_Positif' and d_result2 = '1_Positif' THEN 1 ELSE NULL END) * 100.0 / count(*), 2) "% positifs",
  COUNT(CASE WHEN (d_result1 = '3_Invalide' or d_result2 = '3_Invalide') THEN 1 ELSE NULL END) "Nbr invalide", --TODO: Update the number of invalid test
  null "Decision", --TODO: Update the decision
  null "Lymphoedema Total Patient Number", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patient Number", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Comments" --TODO: Update the comments

from public.v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 p
left join public.v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 d on p.p_barcode_id = d.d_barcode_id 
left join public.v_espen_bf_lf_pretas_1_village_202212_v2 v on v.c_cluster_id1 = p.p_cluster_id 

GROUP BY c_district, c_cluster_name, "Month", "Year", c_gps_lat, c_gps_lng, c_site_type

order by c_district, c_cluster_name