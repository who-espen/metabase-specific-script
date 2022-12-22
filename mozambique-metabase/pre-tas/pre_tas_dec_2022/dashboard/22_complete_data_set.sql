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
 * Variable to rename v_espen_mz_lf_pretas_3_resultat_fts_202209_v1, espen_mz_lf_pretas_2_participant_202209_v1, update_lf_tas_orphaned_table_from_diag_result_202212
 */
SELECT 
  c_eu "UE", 
  c_cluster_name "Site", 
  c_cluster_id "Código do site", 
  c_cluster_leader "Responsable Site", 
  c_consent "Consentement Responsable", 
  c_gps_lat "Latitude", 
  c_gps_lng "Dongitude",
  p_consent "Consentement Particiapnt",
  p_sex "Sexo", 
  p_age_yrs "Age en année", 
  p_how_long_lived "Années vécues dans le site", 
  p_barcode_id1 "Code Participant",
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
  d_final_result "Resultado final", 

  c_start "Date"
FROM public.espen_mz_lf_pretas_2_participant_202209_v1 c, espen_mz_lf_pretas_2_participant_202209_v1 p, v_espen_mz_lf_pretas_3_resultat_fts_202209_v1 d
where p.p_cluster_id = c.c_cluster_id and p.p_barcode_id1 = d.d_barcode_id;
