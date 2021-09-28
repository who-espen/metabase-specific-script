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
 * Variable to rename Pre TAS, v_espen_bf_lf_tas3_3_resultat_fts_202109, v_espen_bf_lf_tas3_2_enrolement_202109,
 * espen_bf_lf_tas3_1_sites_202109
 */
 SELECT

  'Pre TAS' "Survey of survey",
  null "Evaluation Unit",
  ds "Implementation Unit",
  nom_de_la_grappe "Survey Site",
  TO_CHAR(c.created_at, 'Month') "Month",
  EXTRACT(YEAR FROM c.created_at) "Year",
  gps_lat "Latitude",
  gps_lng "Longitude",
  NULL "Date of 1st PC Round",
  NULL "Number of PC Round",
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(age), ' - ', max(age)) "Age group(Min - Max)",
  'école' "Survey Site",
  'grappes' "Survey Type", -- TODO: Update the survey type
  300 "Target Sample Size",-- TODO: Update the sample size
  count(p.id) "Examinded",
  COUNT(CASE WHEN resultat_fts1 = 'Positif' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN resultat_fts1 = 'Positif' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positive",
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

FROM v_espen_bf_lf_tas3_3_resultat_fts_202109 d
JOIN espen_bf_lf_tas3_1_sites_202109 c on d.d_cluster_id = c.nb_grappe
JOIN v_espen_bf_lf_tas3_2_enrolement_202109 p on p.barcode = d.barcode

GROUP BY ds, nom_de_la_grappe, "Month", "Year", gps_lat, gps_lng


