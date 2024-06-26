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
 * Variable to rename  v_espen_tg_sch_sth_ia_202404_2_kk_v3_1, v_espen_tg_sch_sth_ia_202404_2_kk_v3_1
 */

create view v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 as

select

c.id,
p.k_recorder,
p.k_district, 
p.k_usp, 
p.k_site_name, 
p.k_nb_children, 

c.parent_id, 
c.k_barcodeid, 
c.k_sch_man_sa, 
c.k_sch_man_sb, 
c.k_ascaris_lumb_sa, 
c.k_ascaris_lumb_sb, 
c.k_hookworm_sa, 
c.k_hookworm_sb, 
c.k_trichuris_sa, 
c.k_trichuris_sb, 
c.k_sch_hae_sa, 
c.k_sch_hae_sb, 
c.k_control, 

c.k_barcodeid3, 

c.k_sch_man_control, 
c.k_ascaris_lumb_control,
c.k_hookworm_control, 
c.k_trichuris_control, 
c.k_sch_hae_control, 
c.k_remarks,

p.k_start

FROM public.espen_tg_sch_sth_ia_202404_2_kk_v3_1 p, espen_tg_sch_sth_ia_202404_2_kk_v3_1_tg_sch_sth_k_2404_v3_1 c

where p.id = c.parent_id::int