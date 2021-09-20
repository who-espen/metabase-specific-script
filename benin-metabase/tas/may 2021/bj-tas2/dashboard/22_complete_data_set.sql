/*
 * File: 22_complete_data_set.sql
 * File Created: Wednesday, 6th May 2020 1:54:52 pm
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 1:59:28 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * The result from three from joint
 * Variable to rename v_espen_bj_lf_tas2_6_fts_result_202104_v2, v_espen_bj_lf_tas2_5_partcipants_202104_v2, espen_bj_lf_tas2_4_sites_202104
 */
SELECT 
  c_eu_name "UE", 
  c_cluster_name "Site", 
  c_cluster_id1 "Code Site", 
  c_cluster_leader_name "Nom du Résponsable Site", 
  
  c_cluster_leader_contact "Contact Résponsable Site", 
  
  c_consent "Consentement du Responsable", 
  c_gps_lat "Latitude", 
  c_gps_lng "Longitude",
  p_consent "Consentement du Particiapnt",
  p_sex "Sexe", 
  p_age_yrs "Age en année", 
  p_how_long_lived "Années vécues dans le site", 
  p_code_id "Code Participant",
  p_notes "Observations",
  d_lotnumber1 "N° Lot 1er Test", 
  d_result1 "Résultat 1er Test", 
  d_why_invalid1 "Raison invalidité 1er Test", 
  d_lotnumber2 "N° Lot 2ème Test", 
  d_result2 "Résultat 2ème Test", 
  d_why_invalid2 "Raison invalidité 2ème Test", 
  d_lotnumber3 "N° Lot 3ème Test", 
  d_result3 "Résultat 3ème Test", 
  d_why_invalid3 "Raison invalidité 3ème Test",  
  d_final_result "Résultat Final", 

  c_start "Date"
FROM public.v_espen_bj_lf_tas2_4_sites_202104 c, v_espen_bj_lf_tas2_5_partcipants_202104_v2 p, v_espen_bj_lf_tas2_6_fts_result_202104_v2 d
where p.p_cluster_id::int = c.c_cluster_id1 and p.p_code_id = d.d_code_id;
