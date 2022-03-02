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
 * Variable to rename Pre TAS, v_espen_mz_lf_pretas_3_resultat_fts_202111_2_1, espen_mz_lf_pretas_2_participant_202111_v2_1,
 * update_lf_tas_orphaned_table_from_diag_result_202112
 */
  select
 
 distinct on (c_district, c_cluster_name, c_gps_lat)

  'Spot check' "Survey of survey",
  null "Evaluation Unit",
  c_district "Implementation Unit",
  c_cluster_name "Survey Site",
  TO_CHAR(d_start, 'Month') "Month",
  EXTRACT(YEAR FROM d_start) "Year",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  

  null "Date of 1st PC Round",

  null "Number of PC Round",
  
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age group(Min - Max)",
  'Community' "Survey Site",
  'Cluster' "Survey Type", -- TODO: Update the survey type
  300 "Target Sample Size",-- TODO: Update the sample size
  count(*) "Examinded",
  COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) * 100.0 / count(*), 2) "% positive",
  null "Decision", --TODO: Update the decision
  COUNT(CASE WHEN (d_result1 = 'Invalido' or d_result2 = 'Invalido') THEN 1 ELSE NULL END) "Number of invalid tests", --TODO: Update the number of invalid test
  null "Lymphoedema Total Patient Number", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patient Number", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Comments" --TODO: Update the comments

from public.v_espen_mz_lf_pretas_4_fullataset_202111

GROUP BY c_district, c_cluster_name, "Month", "Year", c_gps_lat, c_gps_lng

order by c_district, c_cluster_name