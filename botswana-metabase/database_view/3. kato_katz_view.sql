/*
 * File: kato_katez_view.sql
 * File Created: Monday, 11th May 2020 1:29:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:31:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2, v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2
 */
CREATE view v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2 as

SELECT 
  id, 
  k_recorder_id, 
  k_region, 
  k_district, 
  k_school_name, 
  k_school_id, 
  k_generate_id, 
  k_generate_id2, 
  k_sch_man_sa, 
  k_sch_man_sb, 
  (k_sch_man_sa + k_sch_man_sb) * 12 as k_sch_man_intensity,
  CASE
            WHEN (k_sch_man_sa + k_sch_man_sb) * 12 >= 400 THEN 1
            ELSE 0
        END AS k_sch_man_heavy_intensity,
        CASE
            WHEN (k_sch_man_sa + k_sch_man_sb) * 12 >= 100 AND (k_sch_man_sa + k_sch_man_sb) * 12 < 400 THEN 1
            ELSE 0
        END AS k_sch_man_moderate_intensity,

  k_ascaris_lumb_sa, 
  k_ascaris_lumb_sb,
  (k_ascaris_lumb_sa + k_ascaris_lumb_sb) * 12 as k_ascaris_lumb_intensity, 
        CASE
            WHEN (k_ascaris_lumb_sa + k_ascaris_lumb_sb) * 12 >= 50000 THEN 1
            ELSE 0
        END AS k_ascaris_heavy_intensity,
        CASE
            WHEN (k_ascaris_lumb_sa + k_ascaris_lumb_sb) * 12 >= 5000 AND (k_ascaris_lumb_sa + k_ascaris_lumb_sb) * 12 < 50000 THEN 1
            ELSE 0
        END AS k_ascaris_moderate_intensity,

  k_hookworm_sa, 
  k_hookworm_sb, 
  (k_hookworm_sa + k_hookworm_sb) * 12 as k_hookworm_intensity,
        CASE
            WHEN (k_hookworm_sa + k_hookworm_sb) * 12 >= 40000 THEN 1
            ELSE 0
        END AS k_hookworm_heavy_intensity,
        CASE
            WHEN (k_hookworm_sa + k_hookworm_sb) * 12 >= 20000 AND (k_hookworm_sa + k_hookworm_sb) * 12 < 40000 THEN 1
            ELSE 0
        END AS k_hookworm_medium_intensity,

  k_trichuris_sa, 
  k_trichuris_sb, 
  (k_trichuris_sa + k_trichuris_sb) * 12 as k_trichuris_intensity,
        CASE
            WHEN (k_trichuris_sa + k_trichuris_sb) * 12 >= 100000 THEN 1
            ELSE 0
        END AS k_trichuris_heavy_intensity,
        CASE
            WHEN (k_trichuris_sa + k_trichuris_sb) * 12 >= 100000 AND (k_trichuris_sa + k_trichuris_sb) * 12 < 10000 THEN 1
            ELSE 0
        END AS k_trichuris_moderate_intensity,

  k_other_name_1, 
  k_other_quantity_1, 
  k_other_name_2, 
  k_other_quantity_2, 
  k_remarks, 
  k_start
FROM public.espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2 k

