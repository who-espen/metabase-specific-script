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
 * Variable to rename  v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1, v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1
 */

create view v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1 as

SELECT 

id, 
u_recorder,
u_region,
u_district,
u_usp, 
u_site_name, 
u_barcodeid, 
--u_barcodeid2, 
u_urine_vol, 
u_sh_egg, 
u_sh_egg_per_10ml, 
k_sch_man u_sch_man, 
u_remarks, 
u_start

FROM public.espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1 u

