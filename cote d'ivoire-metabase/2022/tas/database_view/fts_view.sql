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
 * Variable to rename  v_espen_ci_lf_tas1_3_fts_result_202110_v3, espen_ci_lf_tas1_3_fts_result_202110_v3, espen_ci_lf_tas1_1_sites_202110_v3
 */
create view v_espen_ci_lf_tas1_3_fts_result_202110_v3 as

SELECT 

id,
d_recorder_id, 
d_eu_name, 
d_district, 
d_district_id, 
d_cluster_name, 
d_cluster_id, 
d_num, 
d_code_id, 
d_lotnumber1, 
d_result1, 

case when d_why_invalid1 = 'Other' then d_why_invalid_other1 else d_why_invalid1 end d_why_invalid1, 

d_image_1, 
d_need_second_test, 
d_lotnumber2, 
d_result2, 

case when d_why_invalid2 = 'Other' then d_why_invalid_other2 else d_why_invalid2 end d_why_invalid2, 

d_final_result, 

d_image_2, 
notes_part, 
c_start d_start

FROM public.espen_ci_lf_tas1_3_fts_result_202110_v3 d
