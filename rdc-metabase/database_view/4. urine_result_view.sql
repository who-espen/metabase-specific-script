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
 * Variable to rename  v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1, v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1
 */
create view v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 
as
SELECT 

id, 
u_recorder_id, 
u_zone_sante, 
u_village, 
u_ecole, 
u_code_ecole, 
u_generate_id, 
u_generate_id2, 
u_grading, 
u_hematurie, 
u_urine_vol, 
u_microscope, 
u_sh_egp_10ml, 
u_remarks, 
u_start

FROM public.espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 u