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
 * Variable to rename  v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca, v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca
 */
create view v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca as

SELECT 
  id, 
 
  u_recorder_id, 
  u_region, 
  u_district, 
  u_school_name, 
  u_school_id, 
  u_id_type, 
  u_generate_id, 
  u_generate_id, 
  u_generate_id2, 
  u_exam, 
  u_sh_egp_10ml, 
        CASE
            WHEN u.u_sh_egp_10ml >= 50 THEN 1
            ELSE 0
        END AS is_haem_heavy_intensity,
        CASE
            WHEN u.u_sh_egp_10ml > 0 AND u.u_sh_egp_10ml < 50 THEN 1
            ELSE 0
        END AS is_haem_low_intensity,
  u_haematuria, 
  u_grading, 
  u_cca, 
u_remarks, 
u_start
FROM public.espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca u

