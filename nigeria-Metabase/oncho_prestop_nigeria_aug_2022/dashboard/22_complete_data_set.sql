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
 * Variable to rename v_espen_ng_ng_oncho_prestop_3_resultat_fts_202208_v2, v_espen_ng_oncho_prestop_2_participant_202208, espen_ng_ng_oncho_prestop_1_site_202208_v2
 */
SELECT 
  c_district "District", 
  c_cluster_name "Site", 
  c_cluster_id "Code Site", 
  c_cluster_leader "Responsable Site", 
  c_consent "Consentement Responsable", 
  c_gps_lat "Latitude", 
  c_gps_lng "Dongitude",
  p_consent "Consentement Particiapnt",
  p_sex "Sex", 
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
  d_final_result "Final Result", 

  c_date "Date"
FROM public.v_espen_ng_oncho_prestop_1_site_202208 c, v_espen_ng_oncho_prestop_2_participant_202208 p, v_espen_ng_ng_oncho_prestop_3_resultat_fts_202208_v2 d
where p.p_cluster_id = c.c_cluster_id and p.p_code_id = d.d_code_id;
