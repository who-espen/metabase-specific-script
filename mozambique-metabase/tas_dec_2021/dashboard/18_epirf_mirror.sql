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
 * Variable to rename Pre TAS, v_espen_mz_lf_tas2_3_resultat_fts_202111_v2, espen_mz_lf_tas2_2_participant_202111_v2_1,
 * update_lf_tas2_orphaned_table_from_diag_result_202112
 */
 SELECT

  'TAS2' "Survey of survey",
  c_eu "Evaluation Unit",
  c_communr "Implementation Unit",
  c_cluster_name "Survey Site",
  TO_CHAR(c.c_start, 'Month') "Month",
  EXTRACT(YEAR FROM c.c_start) "Year",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  
--  case 
--  	when c_district = 'Mecula' or c_district = 'Maua' then 2009
--  	when c_district = 'Marrupa' then 2010  	
--  	when c_district = 'Lichinga' then 2012
--  end "Date of 1st PC Round",

  null "Date of 1st PC Round",
  
--  case 
--  	when c_district = 'Mecula' or c_district = 'Maua' then 8
--  	when c_district = 'Marrupa' then 7  	
--  	when c_district = 'Lichinga' then 6
--  end  "Number of PC Round",

  null "Number of PC Round",
  
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(p_age_yrs), ' - ', max(p_age_yrs)) "Age group(Min - Max)",
  'Community' "Survey Site",
  'Cluster' "Survey Type", -- TODO: Update the survey type
  c_starting_survey_note::int "Target Sample Size",-- TODO: Update the sample size
  count(p.id) "Examinded",
  COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) * 100.0 / c_starting_survey_note::int, 2) "% positive",
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

FROM v_espen_mz_lf_tas2_3_resultat_fts_202111_v2 d
JOIN v_espen_mz_lf_tas2_1_site_202111_v2 c on d.d_cluster_id = c.c_cluster_id
JOIN v_espen_mz_lf_tas2_2_participant_202111_v2_1 p on p.p_code_id = d.d_code_id

GROUP BY c_eu, c_communr, c_cluster_name, "Month", "Year", c_gps_lat, c_gps_lng, c_starting_survey_note

order by c_eu, c_communr, c_cluster_name



