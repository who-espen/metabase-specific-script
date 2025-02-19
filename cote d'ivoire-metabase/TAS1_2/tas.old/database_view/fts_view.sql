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
 * Variable to rename  v_espen_ci_202302_lf_tas1_3_fts_result, espen_ci_202302_lf_tas1_3_fts_result, espen_ci_202302_lf_tas1_1_sites
 */

create view v_espen_ci_202302_lf_tas1_3_fts_result as 
SELECT 

id,
 d_recorder_id,
 d_eu_name, 
 d_district, 
 d_district_id, 

case when d_cluster_name = 'Autre' then d_cluster_name2 else d_cluster_name end d_cluster_name,

case when d_cluster_name = 'Autre' then d_cluster_id2 else d_cluster_id end d_cluster_id,

d_num,
d_code_id,
d_sex,
d_age_yrs,
d_lotnumber1,
d_result1,
d_why_invalid1,
d_why_invalid_other1,
d_image_1,
d_need_second_test, 
d_lotnumber2, 
d_result2, 
d_why_invalid2,
d_why_invalid_other2,
d_final_result,
 d_image_2, 
  c_start d_start

FROM public.espen_ci_202302_lf_tas1_3_fts_result d



