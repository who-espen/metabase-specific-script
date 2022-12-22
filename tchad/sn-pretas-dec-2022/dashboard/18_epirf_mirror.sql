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
 * Variable to rename <%Epirf_Survey_Type%>, v_espen_td_lf_pretas_3_resultat_fts_202208_v2, v_espen_td_lf_pretas_2_participant_202208_v2,
 * espen_td_lf_pretas_1_site_202208_v2
 */
 SELECT
 with src as (select 
distinct on (c_site_id)
c_region,
c_district,
c_site,
c_site_id,
c_gps_lat,
c_gps_lng,
c_start
from public.v_espen_td_lf_pretas_1_site_202208_v2)

SELECT

  case when (c_site_id = '101' or c_site_id = '103' or c_site_id = '107' or c_site_id = '109' or c_site_id = '111' or c_site_id = '113')
  then 'sentinelle' else 'contrôle ponctuel' end "Type d'ênquestes",
  null "Unité d'évaluation",
  c_district "Unité d'Implémentation",
  c_site "Site de l'enquête",
  TO_CHAR(c.c_start, 'Month') "Mois",
  EXTRACT(YEAR FROM c.c_start) "Année",
  c_gps_lat "Latitude",
  c_gps_lng "Longitude",
  NULL "Date 1ère Tournée DMM",
  NULL "Nombre de Tournée DMM",
  'FTS (Ag)' "Test Diagnostique",
  CONCAT(min(p_age_annee), ' - ', max(p_age_annee)) "Tranche d'âge(Min - Max)",
  'école' "Site enquete",
  'grappes' "Type enquete", -- TODO: Update the survey type
  null "Taille de la Population Cible",-- TODO: Update the sample size
  count(p.id) "Nombre Examiné",
  COUNT(CASE WHEN d_result = 'Positive' THEN 1 ELSE NULL END) "Nombre de Positifs",
  ROUND(COUNT(CASE WHEN d_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / count(p.id), 2) "% de positifs",
  COUNT(CASE WHEN d_result = 'Indeterminate' THEN 1 ELSE NULL END) "Nombre de Test Invalide", --TODO: Update the number of invalid test
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

FROM v_espen_td_lf_pretas_3_resultat_fts_202208_v2 d
LEFT JOIN src c on d.d_site_id = c.c_site_id
LEFT JOIN v_espen_td_lf_pretas_2_participant_202208_v2 p on p.p_code_id = d.d_code_id

GROUP BY c_district, c_site, "Mois", "Année", c_gps_lat, c_gps_lng, c_site_id



