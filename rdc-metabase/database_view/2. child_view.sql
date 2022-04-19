/*
 * File: child_view.sql
 * File Created: Monday, 11th May 2020 1:05:59 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:11:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_cd_sch_sth_baseline_2_child_202202_v2_1, v_espen_cd_sch_sth_baseline_2_child_202202_v2_1
 */
create view v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 as

SELECT 

id, 
p_consent_note, 
p_recorder_id, 
p_zone_sante, 
p_village, 
p_ecole,
p_code_ecole, 
p_consent,
p_generate_id, 
p_age, 
p_sexa p_sexe, 
p_classe, 
p_tps_vecu, 
p_acces_src_eau,
p_defeq_ecole, 
p_apprend_hygiene,
p_selles_collect,
p_urine_urine, 
p_note_fin_enquete, 
p_remarks, 
p_start

FROM public.espen_cd_sch_sth_baseline_2_child_202202_v2_1 p