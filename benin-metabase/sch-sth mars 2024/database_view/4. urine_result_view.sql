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

create view v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 as

SELECT 

id,
u_recorder,
u_district, 
u_subdistrict, 
u_site_name, 
u_site_code, 
u_urine_filtrer,
u_urine_vol, 
u_urine_vol_sup, 
u_sh_egp_10ml, 
u_sh_egp_10ml_sup, 
u_sch_man_a, 
u_sch_man_b, 
u_sch_man_sup, 
u_remarks, 
u_start

FROM public.espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 u