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
 * Variable to rename  espen_bf_lf_pretas_2_enrollement_202007_v2, v_espen_bf_lf_pretas_2_enrollement_202007_v2
 */
CREATE OR REPLACE VIEW public.v_espen_bf_lf_pretas_2_enrollement_202007_v2
AS
  SELECT p.id,
    p.p_recorder_id,
    p.ds,
    p.csps,
    p.p_cluster_name,
    p.p_cluster_id,
    p.p_consent,

    
        CASE
            WHEN p_id_method = 'scanner' THEN p_barcode_id
            ELSE manual_code
        END AS p_barcode_id,

    p.numero_famille,
    p.numero_enquete,
    p.numero_enquete_complet,
    p.p_age_yrs,
    p.p_sex,
    p.status,
    p.ivm_alb,
    p.avm_alb_derniere_campagne,
    p.nb_fois_ivm_alb,
    p.migration,
    p.migration_autre,
    p.lymphoedeme,
    p.hydrocele,
    p.p_ending_survey_note,
    p.commentaires,
    p.p_start AS p_date
   FROM espen_bf_lf_pretas_2_enrollement_202007_v2 p;
