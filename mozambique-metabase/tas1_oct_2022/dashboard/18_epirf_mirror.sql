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
 * Variable to rename Pre TAS, v_espen_mz_lf_tas1_3_resultat_fts_202209_v1, v_espen_mz_lf_tas1_2_participant_202209_v1,
 * espen_mz_lf_tas1_1_site_202209_v1
 */
 
 SELECT

  'TAS1' "Survey of survey",
  c_cluster_notes "Evaluation Unit",
  c_district "Implementation Unit",
  c_cluster_name "Survey Site",
  TO_CHAR(c.c_start, 'Month') "Month",
  EXTRACT(YEAR FROM c.c_start) "Year",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date of 1st PC Round",
  NULL "Number of PC Round",
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age group(Min - Max)",
  'school' "Survey Site",
  'cluster' "Survey Type", -- TODO: Update the survey type
  300 "Target Sample Size",-- TODO: Update the sample size
  count(p.id) "Examinded",
  COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positive",
   COUNT(CASE WHEN (d_result1 = 'Invalido' or d_result2 = 'Invalido' ) THEN 1 ELSE NULL END) "Number of invalid tests", --TODO: Update the number of invalid test
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

 from public.v_espen_mz_lf_tas1_2_participant_202209_v1 p
 left join public.v_espen_mz_lf_tas1_1_site_202209_v1 c on c.c_cluster_id = p.p_cluster_id 
 left join public.v_espen_mz_lf_tas1_3_resultat_fts_202209_v1 d on d.d_barcode_id = p.p_barcode_id 

GROUP BY c_cluster_notes, c_district, c_cluster_name, "Month", "Year", c_gps_lat, c_gps_lng


