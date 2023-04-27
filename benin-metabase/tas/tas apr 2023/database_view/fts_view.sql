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
 * Variable to rename  v_espen_bj_lf_tas3_202304_3_fts_result_v1, espen_bj_lf_tas3_202304_3_fts_result_v1, espen_bj_lf_tas3_202304_1_sites
 */
create view v_espen_bj_lf_tas3_202304_3_fts_result_v1 as 

SELECT 

id, 
d_recorder_id, 
d_eu_name,
d_commune, 
d_cluster_name, 
d_cluster_id,
d_id_sequence,
--d_id_sequence2, 
d_code_id, 
d_lotnumber1, 
d_result1, 
d_why_invalid1, 
d_why_invalid_other1, 
d_display_result1, 
d_need_second_test, 
d_lotnumber2, 
d_result2,
d_why_invalid2,
d_why_invalid_other2,
d_display_result2,
d_need_third_test, 
d_lotnumber3, 
d_result3, 
d_why_invalid3, 
d_why_invalid_other3, 
d_display_result3,
d_final_result, 
d_start

FROM public.espen_bj_lf_tas3_202304_3_fts_result_v1 d

