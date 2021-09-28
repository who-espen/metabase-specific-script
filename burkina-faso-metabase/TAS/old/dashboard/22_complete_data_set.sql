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
 * Variable to rename v_espen_bf_lf_tas1_3_resultat_fts_202010, v_espen_bf_lf_tas1_2_enrolement_202010, espen_bf_lf_tas1_1_sites_202010
 */
SELECT 
  ds "District", 
  nom_grappe "Site", 
  nb_grappe "Code Site", 
  c_cluster_leader "Responsable Site", 
  c_consent "Consentement Responsable", 
  gps_lat "Latitude", 
  gps_lng "Dongitude",
  p_consent "Consentement Particiapnt",
  sexe "Sexe", 
  age "Age en année", 
  scolarise "Années vécues dans le site", 
  barcode "Code Participant",
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
  resultat_fts1 "Résultat Final", 

  date_enregistrement "Date"
FROM public.v_espen_bf_lf_tas1_1_sites_202010 c, v_espen_bf_lf_tas1_2_enrolement_202010 p, v_espen_bf_lf_tas1_3_resultat_fts_202010 d
where p.nb_grappe = c.nb_grappe and p.barcode = d.barcode;