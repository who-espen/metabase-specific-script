/*
 * File: fts_view.sql
 * File Created: Monday, 4th May 2020 4:21:23 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 4:26:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * Variable to rename  v_espen_ng_lf_pretas_202404_3_fts_v2, espen_ng_lf_tas_202404_3_resultat_fts_jgw_v3, espen_ng_lf_pretas_202404_1_site_v2
 */


create view v_espen_ng_lf_pretas_202404_3_fts_v2 as

SELECT 

c.id, 
p.d_recorder_id,
p.d_region,
p.d_district, 
p.d_cluster_name,
p.d_cluster_id, 

c.d_add_results, 
c.d_code_id, 
c.d_lotnumber1, 
c.d_result1,
c.d_why_invalid1, 
c.d_why_invalid_other1, 
c.d_lotnumber2,
c.d_result2, 
c.d_why_invalid2,
c.d_why_invalid_other2, 
c.d_display_result2, 
c.d_final_result, 
c.follow_up_note, 
c.d_parent_name, 
c.d_lenght_stay_lga,
c.d_village_community, 
c.d_swallowed_lf_med,
c.d_nd_med_taked, 
c.d_have_bed_net,
c.d_sleep_bed_net, 
c.notes_part,

 p.c_start d_start

FROM public.espen_ng_lf_pretas_202404_3_fts_v2 p, espen_ng_lf_pretas_202404_3_fts_v2_ng_pretas_fts_202404_v2 c
where p.id = c.parent_id::int
