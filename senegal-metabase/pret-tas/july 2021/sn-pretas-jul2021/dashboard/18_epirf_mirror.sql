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

  'Pré-TAS' "Survey of survey",
  null "Evaluation Unit",
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
  'école' "Survey Site",
  'grappes' "Survey Type", -- TODO: Update the survey type
  350 "Target Sample Size",-- TODO: Update the sample size
  count(p.id) "Examinded",
  COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positive",
  null "Decision", --TODO: Update the decision
  null "Number of invalid tests", --TODO: Update the number of invalid test
  null "Lymphoedema Total Patient Number", --TODO: Update the Total Patient Number
  null "Lymphoedema Method Estimation", --TODO: Update the  Method Estimation
  null "Lymphoedema Date Estimation", --TODO: Update the Date Estimation
  null "Lymphoedema Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Hydrocoele Total Patient Number", --TODO: Update the Total Patient Number
  null "Hydrocoele Method Estimation", --TODO: Update the  Method Estimation
  null "Hydrocoele Date Estimation", --TODO: Update the Date Estimation
  null "Hydrocoele Nbr Health Facilities", --TODO: Update the Nbr Health Facilities
  null "Comments" --TODO: Update the comments

FROM v_espen_bj_lf_pretas_3_fts_result_202107_v2 d
LEFT JOIN v_espen_sn_lf_pretas_1_sites_202107_v2 c on d.d_cluster_id = c.c_cluster_id
RIGHT JOIN v_espen_sn_lf_pretas_2_partcipants_202107_v2 p on p.p_code_id = d.d_code_id

GROUP BY c_district, c_cluster_name, "Month", "Year", c_gps_lat, c_gps_lng


