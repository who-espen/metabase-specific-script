/*
 * File: urine_result_view.sql
 * File Created: Monday, 11th May 2020 1:35:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:38:48 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1, v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1
 */
CREATE OR REPLACE VIEW v_espen_tg_sch_sth_impact_6_controle_urine_202304
AS SELECT u1.meta_instance_id,
    u1.u_recorder,
    u1.u_district,
    u1.u_subdistrict,
    u1.u_site_name,
    u1.u_barcodeid,
    u1.u_barcode_ok,
    u1.u_manual_code_id,
    u1.u_urine_vol,
    u1.u_sh_egp_10ml,
        CASE
            WHEN u1.u_sh_egp_10ml >= 50 THEN 1
            ELSE 0
        END AS is_haem_heavy_intensity,
        CASE
            WHEN u1.u_sh_egp_10ml > 0 AND u1.u_sh_egp_10ml < 50 THEN 1
            ELSE 0
        END AS is_haem_low_intensity,
    u1.k_sch_man,
    u1.u_remarks,
    u1.u_start,
    u1.u_end,
    u1.created_at,
    u1.updated_at
   FROM public.espen_tg_sch_sth_impact_6_controle_urine_202304 u1

UNION ALL

 SELECT u2.meta_instance_id,
    u2.u_recorder,
    u2.u_district,
    u2.u_subdistrict,
    u2.u_site_name,
    u2.u_barcodeid,
    u2.u_barcode_ok,
    u2.u_manual_code_id,
    u2.u_urine_vol,
    u2.u_sh_egp_10ml,
        CASE
            WHEN u2.u_sh_egp_10ml >= 50 THEN 1
            ELSE 0
        END AS is_haem_heavy_intensity,
        CASE
            WHEN u2.u_sh_egp_10ml > 0 AND u2.u_sh_egp_10ml < 50 THEN 1
            ELSE 0
        END AS is_haem_low_intensity,
    u2.k_sch_man,
    u2.u_remarks,
    u2.u_start,
    u2.u_end,
    u2.created_at,
    u2.updated_at
   FROM public.espen_tg_sch_sth_impact_6_controle_urine_202304_v6_2 u2
  ORDER BY u_start;

