/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_tg_oncho_stop_1_site_202204, espen_tg_oncho_stop_1_site_202204
 */
-- public.v_espen_bi_couverture_2_couverture_202210 source

-- public.v_espen_bi_couverture_2_couverture_202210 source

CREATE OR REPLACE VIEW public.v_espen_bi_couverture_2_couverture_202210
AS SELECT e.id,
    p.c_date,
    p.c_code_enqueteur,
    p.c_district,
    p.c_centre_sante,
    p.c_colline,
    p.c_colline_id,
    p.c_num_menage,
    p.c_membre_present,
    e.code_participant,
    e.sexe,
    e.age,
    e.present_campagne,
    e.non_present_campagne,
    e.non_present_campagne_autre,
    e.menage_enregistre,
    e.non_menage_enregistre,
    e.ivm_recu_medicament1,
    e.ivm_pourquoi_pas_recu1,
    e.ivm_pourquoi_pas_recu_autre1,
    e.ivm_avale1,
    e.ivm_pourquoi_avale1,
    e.ivm_pourquoi_avale_autre1,
    e.ivm_pourquoi_pas_avale1,
    e.ivm_pourquoi_pas_avale_autre1,
    e.ivm_lieu_prise_mectizan1,
    e.ivm_lieu_prise_mectizan_autre1,
    e.alb_recu_medicament2,
    e.alb_pourquoi_pas_recu2,
    e.alb_pourquoi_pas_recu_autre2,
    e.alb_avale2,
    e.alb_pourquoi_avale2,
    e.alb_pourquoi_avale_autre2,
    e.alb_pourquoi_pas_avale2,
    e.alb_pourquoi_pas_avale_autre2,
    e.canaux_com,
    e.canaux_com_autre,
    created_at c_start,
    updated_at c_end
   FROM espen_bi_couverture_2_couverture_202210 p,
    espen_bi_couverture_2_couverture_202210_c_questions e
  WHERE p.id = e.parent_id::integer;