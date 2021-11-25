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
 * Variable to rename  v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6, v_espen_tg_sch_sth_impact_3_kato_katz_202110_v6
 */
CREATE OR REPLACE VIEW v_espen_tg_sch_sth_impact_5_control_kato_katz_202110
AS SELECT k1.meta_instance_id,
    k1.k_recorder,
    k1.k_district,
    k1.k_subdistrict,
    k1.k_site_name,
    k1.k_barcodeid,
    k1.k_barcode_ok,
    k1.k_manual_code_id,
    k1.k_sch_man_sa,
    k1.k_sch_man_sb,
    (k1.k_sch_man_sa + k1.k_sch_man_sb) * 12 AS k_sch_man_intensity,
        CASE
            WHEN ((k1.k_sch_man_sa + k1.k_sch_man_sb) * 12) >= 400 THEN 1
            ELSE 0
        END AS k_sch_man_heavy_intensity,
        CASE
            WHEN ((k1.k_sch_man_sa + k1.k_sch_man_sb) * 12) >= 100 AND ((k1.k_sch_man_sa + k1.k_sch_man_sb) * 12) < 400 THEN 1
            ELSE 0
        END AS k_sch_man_moderate_intensity,
    k1.k_ascaris_lumb_sa,
    k1.k_ascaris_lumb_sb,
    (k1.k_ascaris_lumb_sa + k1.k_ascaris_lumb_sb) * 12 AS k_ascaris_lumb_intensity,
        CASE
            WHEN ((k1.k_ascaris_lumb_sa + k1.k_ascaris_lumb_sb) * 12) >= 50000 THEN 1
            ELSE 0
        END AS k_ascaris_heavy_intensity,
        CASE
            WHEN ((k1.k_ascaris_lumb_sa + k1.k_ascaris_lumb_sb) * 12) >= 5000 AND ((k1.k_ascaris_lumb_sa + k1.k_ascaris_lumb_sb) * 12) < 50000 THEN 1
            ELSE 0
        END AS k_ascaris_moderate_intensity,
    k1.k_hookworm_sa,
    k1.k_hookworm_sb,
    (k1.k_hookworm_sa + k1.k_hookworm_sb) * 12 AS k_hookworm_intensity,
        CASE
            WHEN ((k1.k_hookworm_sa + k1.k_hookworm_sb) * 12) >= 40000 THEN 1
            ELSE 0
        END AS k_hookworm_heavy_intensity,
        CASE
            WHEN ((k1.k_hookworm_sa + k1.k_hookworm_sb) * 12) >= 20000 AND ((k1.k_hookworm_sa + k1.k_hookworm_sb) * 12) < 40000 THEN 1
            ELSE 0
        END AS k_hookworm_medium_intensity,
    k1.k_trichuris_sa,
    k1.k_trichuris_sb,
    (k1.k_trichuris_sa + k1.k_trichuris_sb) * 12 AS k_trichuris_intensity,
        CASE
            WHEN ((k1.k_trichuris_sa + k1.k_trichuris_sb) * 12) >= 100000 THEN 1
            ELSE 0
        END AS k_trichuris_heavy_intensity,
        CASE
            WHEN ((k1.k_trichuris_sa + k1.k_trichuris_sb) * 12) >= 100000 AND ((k1.k_trichuris_sa + k1.k_trichuris_sb) * 12) < 10000 THEN 1
            ELSE 0
        END AS k_trichuris_moderate_intensity,
    k1.k_sch_hae_sa,
    k1.k_sch_hae_sb,
    k1.k_remarks,
    k1.k_start,
    k1.k_end,
    k1.created_at,
    k1.updated_at
   FROM espen_tg_sch_sth_impact_5_control_kato_katz_202110 k1
UNION ALL
 SELECT k2.meta_instance_id,
    k2.k_recorder,
    k2.k_district,
    k2.k_subdistrict,
    k2.k_site_name,
    k2.k_barcodeid,
    k2.k_barcode_ok,
    k2.k_manual_code_id,
    k2.k_sch_man_sa,
    k2.k_sch_man_sb,
    (k2.k_sch_man_sa + k2.k_sch_man_sb) * 12 AS k_sch_man_intensity,
        CASE
            WHEN ((k2.k_sch_man_sa + k2.k_sch_man_sb) * 12) >= 400 THEN 1
            ELSE 0
        END AS k_sch_man_heavy_intensity,
        CASE
            WHEN ((k2.k_sch_man_sa + k2.k_sch_man_sb) * 12) >= 100 AND ((k2.k_sch_man_sa + k2.k_sch_man_sb) * 12) < 400 THEN 1
            ELSE 0
        END AS k_sch_man_moderate_intensity,
    k2.k_ascaris_lumb_sa,
    k2.k_ascaris_lumb_sb,
    (k2.k_ascaris_lumb_sa + k2.k_ascaris_lumb_sb) * 12 AS k_ascaris_lumb_intensity,
        CASE
            WHEN ((k2.k_ascaris_lumb_sa + k2.k_ascaris_lumb_sb) * 12) >= 50000 THEN 1
            ELSE 0
        END AS k_ascaris_heavy_intensity,
        CASE
            WHEN ((k2.k_ascaris_lumb_sa + k2.k_ascaris_lumb_sb) * 12) >= 5000 AND ((k2.k_ascaris_lumb_sa + k2.k_ascaris_lumb_sb) * 12) < 50000 THEN 1
            ELSE 0
        END AS k_ascaris_moderate_intensity,
    k2.k_hookworm_sa,
    k2.k_hookworm_sb,
    (k2.k_hookworm_sa + k2.k_hookworm_sb) * 12 AS k_hookworm_intensity,
        CASE
            WHEN ((k2.k_hookworm_sa + k2.k_hookworm_sb) * 12) >= 40000 THEN 1
            ELSE 0
        END AS k_hookworm_heavy_intensity,
        CASE
            WHEN ((k2.k_hookworm_sa + k2.k_hookworm_sb) * 12) >= 20000 AND ((k2.k_hookworm_sa + k2.k_hookworm_sb) * 12) < 40000 THEN 1
            ELSE 0
        END AS k_hookworm_medium_intensity,
    k2.k_trichuris_sa,
    k2.k_trichuris_sb,
    (k2.k_trichuris_sa + k2.k_trichuris_sb) * 12 AS k_trichuris_intensity,
        CASE
            WHEN ((k2.k_trichuris_sa + k2.k_trichuris_sb) * 12) >= 100000 THEN 1
            ELSE 0
        END AS k_trichuris_heavy_intensity,
        CASE
            WHEN ((k2.k_trichuris_sa + k2.k_trichuris_sb) * 12) >= 100000 AND ((k2.k_trichuris_sa + k2.k_trichuris_sb) * 12) < 10000 THEN 1
            ELSE 0
        END AS k_trichuris_moderate_intensity,
    k2.k_sch_hae_sa,
    k2.k_sch_hae_sb,
    k2.k_remarks,
    k2.k_start,
    k2.k_end,
    k2.created_at,
    k2.updated_at
   FROM espen_tg_sch_sth_impact_5_control_kato_katz_202110_v6_2 k2
  ORDER BY k_start;