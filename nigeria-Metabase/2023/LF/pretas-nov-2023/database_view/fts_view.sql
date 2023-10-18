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
 * Variable to rename  v_espen_ng_lf_pretas_202309_3_resultat_fts_v3, espen_ng_lf_pretas_202309_3_resultat_fts_v3, espen_ng_lf_pretas_202309_1_site_v3
 */

create view v_espen_ng_lf_pretas_202309_3_resultat_fts_v3 as

SELECT 

id, 
d_recorder_id,
d_region,
d_district,
d_cluster_name,
d_cluster_id,
d_code_id, 
d_lotnumber1,
d_result1,
d_why_invalid1,
d_why_invalid_other1,

d_need_second_test, 
d_lotnumber2,
d_result2,
d_why_invalid2, 
d_why_invalid_other2,
 d_final_result, 
notes_part, 
c_start d_start

FROM public.espen_ng_lf_pretas_202309_3_resultat_fts d

union all

SELECT 

id, 
d_recorder_id,
d_region,
d_district,
d_cluster_name,
d_cluster_id,
d_code_id, 
d_lotnumber1,
d_result1,
d_why_invalid1,
d_why_invalid_other1,

d_need_second_test, 
d_lotnumber2,
d_result2,
d_why_invalid2, 
d_why_invalid_other2,
 d_final_result, 
notes_part, 
c_start d_start

FROM public.espen_ng_lf_pretas_202309_3_resultat_fts_v3 d



