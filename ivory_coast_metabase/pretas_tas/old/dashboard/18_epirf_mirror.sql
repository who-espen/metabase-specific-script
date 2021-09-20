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
 * Variable to rename <%Epirf_Survey_Type%>, v_espen_ci_pretas_lf_resultats_v7, v_espen_ci_pretas_lf_enrollement_v7,
 * <%ab_cde_fgh_1_site%>
 */
 SELECT

  '<%Epirf_Survey_Type%>' "Survey of survey",
  c_eu_code "Evaluation Unit",
  c_district "Implementation Unit",
  c_cluster_name "Survey Site",
  TO_CHAR(c.created_at, 'Month') "Month",
  EXTRACT(YEAR FROM c.created_at) "Year",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date of 1st PC Round",
  NULL "Number of PC Round",
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age group(Min - Max)",
  c_site_type "Survey Site",
  NULL "Survey Type", -- TODO: Update the survey type
  100 "Target Sample Size",-- TODO: Update the sample size
  count(p.id) "Examinded",
  COUNT(CASE WHEN d_final_result = '1_Positif" THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = '1_Positif" THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positive",
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

FROM v_espen_ci_pretas_lf_resultats_v7 d
LEFT JOIN <%ab_cde_fgh_1_site%> c on d.d_cluster_id::int = c.c_cluster_id1
RIGHT JOIN v_espen_ci_pretas_lf_enrollement_v7 p on p.code_id = d.code_id

GROUP BY c_eu_code, c_district, c_cluster_name, "Month", "Year", c_gps_lat, c_gps_lng, c_site_type


