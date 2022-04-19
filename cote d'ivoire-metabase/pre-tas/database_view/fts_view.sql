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
 * Variable to rename  v_espen_ci_lf_pretas_3_resultat_fts_202204_v1, espen_ci_lf_pretas_3_resultat_fts_202204_v1, espen_ci_lf_pretas_1_site_202204
 */
create view v_espen_ci_lf_pretas_3_resultat_fts_202204_v1 as

SELECT 

id,
d_recorder_id, 
d_district, 

 d_site, 
case when d_site_id = 'Autre' then d_site_id2 else d_site_id end d_site_id, 

d_num,
 d_age_yrs, 
 d_sex, 
 d_code_id,
 d_num_test, 
 d_lotnumber, 
 d_result,
 
 case when d_why_invalid = 'Autre' then d_why_invalid_other else d_why_invalid end as d_why_invalid,

 d_image,
 notes_part, 
 c_start d_start
FROM public.espen_ci_lf_pretas_3_resultat_fts_202204_v1 d


