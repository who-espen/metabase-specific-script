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
 * Variable to rename  v_espen_bj_lf_tas2_6_fts_result_202104_v2, espen_bj_lf_tas2_6_fts_result_202104_v2, espen_bj_lf_tas2_4_sites_202104
 */
 CREATE view v_espen_bj_lf_tas2_6_fts_result_202104_v2
AS

SELECT 

id,
d_recorder_id, 
d_eu_name, 
d_commune,
d_cluster_name, 
d_cluster_id, 
d_id_sequence, 
d_code_id, 
d_lotnumber1,
d_result1,

case when d_why_invalid1 = 'Other' then d_why_invalid_other1 else d_why_invalid1 end as d_why_invalid1,

d_lotnumber2, 
d_result2,

case when d_why_invalid2 = 'Other' then d_why_invalid_other2 else d_why_invalid2 end as d_why_invalid2,

d_lotnumber3,
d_result3,

case when d_why_invalid3 = 'Other' then d_why_invalid_other3 else d_why_invalid3 end as d_why_invalid3,


d_final_result,
d_start

FROM public.espen_bj_lf_tas2_6_fts_result_202104_v2 d
