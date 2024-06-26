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
 * Variable to rename  v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1, v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1
 */




create view v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1 as select

id,
k_recorder,
k_district, 
k_subdistrict,
k_site_name,
k_site_code, 
k_espen_code_id, 
k_sch_man_sa, 
k_sch_man_sb, 
k_sch_man_sup, 
k_ascaris_lumb_sa,
k_ascaris_lumb_sb,
k_ascaris_lumb_sup,
k_hookworm_sa, 
k_hookworm_sb, 
k_hookworm_sup,
k_trichuris_sa,
k_trichuris_sb, 
k_trichuris_sup,
k_sch_hae_sa,
k_sch_hae_sb, 
k_sch_hae_sup, 
k_remarks, 
k_start

FROM public.espen_bj_sch_sth_impact_202304_3_kato_katz_v1 k
