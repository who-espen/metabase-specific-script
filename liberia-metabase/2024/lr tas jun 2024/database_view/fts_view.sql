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
 * Variable to rename  v_espen_lr_lf_tas1_3_fts_202406, espen_ke_lf_pretas_3_resultat_fts_202203_v4, espen_lr_lf_tas1_1_site_202406_v1
 */


create view v_espen_lr_lf_tas1_3_fts_202406 as

SELECT 

c.id, 
p.d_recorder, 
p.d_eu, 
p.d_cluster_name,
p.d_cluster_id,

c.parent_id, 
c.d_add_record, 
c.d_espen_code_id, 
c.d_espen_code_id2,
c.d_lotnumber1, 
c.d_result1, 
c.d_why_invalid1, 
c.d_why_invalid_other1, 
-- c.d_display_result1, 
c.d_need_second_test, 
c.d_lotnumber2, 
c.d_result2, 
c.d_why_invalid2, 
c.d_why_invalid_other2, 
c.d_display_result2 d_final_result,
c.d_comments,

p.d_start

FROM public.espen_lr_lf_tas1_3_site_202206_v1 p, espen_lr_lf_tas1_3_site_202206_v1_lr3tas1_202406 c
where p.id = c.parent_id::int