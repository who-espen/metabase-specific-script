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
 * Variable to rename  v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1, v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1
 */
 create view v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 as
SELECT 

id, 
k_recorder_id, 
k_zone_sante, 
k_village,
k_ecole, 
k_code_ecole,
k_generate_id, 
k_generate_id2,
k_sch_man_sa,
k_sch_man_intensity,
k_ascaris_lumb_sa,
k_ascaris_lumb_intensity, 
k_hookworm_sa, 
k_hookworm_intensity,
k_trichuris_sa, 
k_trichuris_intensity,
k_other_name_1,
k_other_quantity_1,
k_other_quantity1_intensity,
k_other_name_2, 
k_other_quantity_2,
k_other_quantity2_intensity,
k_remarks,
k_start


FROM public.espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 k