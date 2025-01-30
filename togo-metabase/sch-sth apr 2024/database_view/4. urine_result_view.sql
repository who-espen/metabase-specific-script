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
 * Variable to rename  v_espen_tg_sch_sth_ia_202404_3_ur_v3_1, v_espen_tg_sch_sth_ia_202404_3_ur_v3_1
 */
create view v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 as

SELECT 

c.id, 
p.u_recorder, 
p.u_district, 
p.u_usp, 
p.u_site_name, 
p.u_nb_children, 

c.u_barcodeid, 
c.u_urine_vol, 
c.u_sh_egg, 
c.u_sh_egg_per_10ml, 
c.u_sch_man, 
c.u_sch_man_per_10ml, 
c.u_control, 
c.u_barcodeid3, 
c.u_urine_vol_control, 
c.u_sh_egg_control, 
c.u_sh_egg_per_10ml_control, 
c.u_sch_man_control, 
c.u_sch_man_per_10ml_control, 
c.u_remarks,

p.u_start

FROM public.espen_tg_sch_sth_ia_202404_3_ur_v3_1 p, public.espen_tg_sch_sth_ia_202404_3_ur_v3_1_tg_sc_st_u_2404_v3_1 c
where p.id = c.parent_id::int

