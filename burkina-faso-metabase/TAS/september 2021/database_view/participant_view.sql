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
 * Variable to rename  espen_bf_lf_tas3_2_enrolement_202109, v_espen_bf_lf_tas3_2_enrolement_202109
*/
CREATE OR REPLACE VIEW public.v_espen_bf_lf_tas3_2_enrolement_202109
AS SELECT p.id,
    p.code_operateur,
    p.ue,
    p.type_tas,
    p.ds,
    p.nb_grappe,
    p.nb_menage,
    p.id_methode,
        CASE
            WHEN p.id_methode = 'Scanner'::text THEN p.barcode
            ELSE p.id_manuel
        END AS barcode,
    p.age,
    p.sexe,
    p.scolarise,
    p.ivm_alb,
    p.selectionne_sth,
    p.commentaires,
    p.debut_enregistrement AS date_enregistrement,
    p.created_at AS date_telechargement
   FROM espen_bf_lf_tas3_2_enrolement_202109 p;