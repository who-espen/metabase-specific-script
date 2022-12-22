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
 * Variable to rename Pre TAS, v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y, v_espen_bf_lf_tas3_2_participant_202209_v1_y,
 * espen_bf_lf_tas3_1_sites_202209_y
 */

 
 SELECT

  'TAS3' "Survey of survey",
  c_ue "Evaluation Unit",
  c_ds "Implementation Unit",
  c_nom_grappe "Survey Site",
  TO_CHAR(c.created_at, 'Month') "Mois",
  EXTRACT(YEAR FROM c.created_at) "Année",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date of 1st PC Round",
  NULL "Number of PC Round",
  'FTS (Ag)' "Diagnostic Test",
  CONCAT(min(p_age), ' - ', max(p_age)) "Age group(Min - Max)",
  'école' "Survey Site",
  'grappes' "Survey Type", -- TODO: Update the survey type
  null "Target Sample Size",-- TODO: Update the sample size
  count(p.id) "Examinded",
  COUNT(CASE WHEN d_resultat_fts1 = '1_Positif' and d_resultat_fts2 = '1_Positif' THEN 1 ELSE NULL END) "Number of Positive",
  ROUND(COUNT(CASE WHEN d_resultat_fts1 = '1_Positif' and d_resultat_fts2 = '1_Positif' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% positive",

  COUNT(CASE WHEN (d_resultat_fts1 = '3_Invalide' or d_resultat_fts1 = '3_Invalide') THEN 1 ELSE NULL END) "Number of invalid tests", --TODO: Update the number of invalid test
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

from v_espen_bf_lf_tas3_2_participant_202209_v1_y p 
left join public.v_espen_bf_lf_tas3_1_site_202209_v1_y c on p.p_nom_grappe = c.c_nom_grappe
left JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on p.p_barcode_id = d.d_barcode_id

GROUP BY c_ue, c_ds, c_nom_grappe, "Mois", "Année", c_gps_lat, c_gps_lng

