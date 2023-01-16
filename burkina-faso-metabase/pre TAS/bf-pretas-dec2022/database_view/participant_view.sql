/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_bf_lf_pretas_2_enrolement_2022_061222_v2, v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2
 */

CREATE OR REPLACE VIEW public.v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 AS 
SELECT p.id,
    p.p_recorder_id,
    p.p_district,
    p.p_formation_sanitaire,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_consent,

case when p_id_method = 'scanner' then p_barcode_id else p_code_id end p_barcode_id,

    p.p_numero_famille,
    p.p_numero_enquete,
    p.p_numero_enquete_complet,
    p.p_age_yrs,
    p.p_sex,
    p.p_status,
    p.p_nb_fois_ivm_alb,
    p.p_jamais_ivm,
    p.p_migration,
    p.p_migration_autre,
    p.p_lymphoedeme,
    p.p_hydrocele,
    p.p_ending_survey_note,
    p.p_commentaires,
    p.p_start
   FROM espen_bf_lf_pretas_2_enrolement_2022_061222_v2 p;
   
  
  





