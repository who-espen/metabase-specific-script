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
 * Variable to rename  espen_bf_lf_tas3_2_enrolement_202307, v_espen_bf_lf_tas1_202306_2_participant_v4
 */


CREATE OR REPLACE VIEW public.v_espen_bf_lf_tas1_202306_2_participant_v4 AS 
SELECT p.id,
    p.p_code_operateur,
    p.p_ue,
    p.p_ds,
    p.p_commune,
    p.p_nom_csps,
    p.p_site,
    p.p_numero_ordre_grappe,
    p.p_classe,
    
    case when p.p_id_methode = 'Scanner' then p_barcode_id1 else p_barcode_id2 end p_barcode_id,
    
    p.p_num_menage,
    p.p_age,
    p.p_sexe,
    p.p_scolarise,
    p.p_recu_avm_alb,
    p.p_commentaire,
    p.p_debut_enreg
   FROM espen_bf_lf_tas1_202306_2_participant_v4 p;
