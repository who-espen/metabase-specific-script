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
 * Variable to rename <%Epirf_Survey_Type%>, v_espen_lr_lf_tas1_3_fts_202406, v_espen_lr_lf_tas1_2_child_202406_v1,
 * espen_lr_lf_tas1_1_site_202406_v1
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

FROM v_espen_lr_lf_tas1_3_fts_202406 d
LEFT JOIN v_espen_lr_lf_tas1_1_site_202406_v1 c on d.d_cluster_id = c.c_cluster_id
RIGHT JOIN v_espen_lr_lf_tas1_2_child_202406_v1 p on p.p_espen_code_id = d.d_espen_code_id

GROUP BY c_district, c_cluster_name, "Mois", "Année", c_gps_lat, c_gps_lng


with sites as (select distinct on (c_cluster_id) c_cluster_id, c_site_type, c_iu, c_cluster_name, c_start, c_gps_lat, c_gps_lng
	from  v_espen_lr_lf_tas1_1_site_202406_v1),
     dignostic as (select distinct on (d_espen_code_id) d_espen_code_id, d_final_result from v_espen_lr_lf_tas1_3_fts_202406)
     
SELECT

  c.c_site_type "Type of survey",
  null "EU",
  c_iu "Implementation unit",
  c_cluster_name "Site",
  TO_CHAR(c.c_start, 'Month') "Month",
  EXTRACT(YEAR FROM c.c_start) "Years",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date 1st MDA",
  NULL "Number of MDA",
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age(Min - Max)",
  'school' "Survey Site",
  'cluster' "Survey Type", -- TODO: Update the survey type
  null "Target sample size",-- TODO: Update the sample size
  count(p.id) "Number Examined",
  COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% of positive",
  COUNT(CASE WHEN d_final_result = 'Indeterminate' THEN 1 ELSE NULL END) "Number of invalid tests", --TODO: Update the number of invalid test
  null "Decision", --TODO: Update the decision
  null "Lymphoedema Total patients", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facility", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patients", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facility", --TODO: Update the Nbr Health Facilities
  null "Comments" --TODO: Update the comments
  
from v_espen_lr_lf_tas1_2_child_202406_v1 p
  LEFT JOIN sites c on p.p_cluster_id = c.c_cluster_id
  left JOIN dignostic d on p.p_espen_code_id = d.d_espen_code_id

GROUP BY c.c_site_type, c_iu, c_cluster_name, c_start, "Month", "Years", c_gps_lat, c_gps_lng


