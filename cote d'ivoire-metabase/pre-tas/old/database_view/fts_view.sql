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
 * Variable to rename  v_espen_ci_lf_pretas_3_resultat_fts_202302, espen_ci_lf_pretas_3_resultat_fts_202302, espen_ci_lf_pretas_1_site_202302
 */

create view v_espen_ci_lf_pretas_3_resultat_fts_202302 as 

select

id, 
d_recorder_id,
d_district, 

 d_site, 

case when d_site = 'Autre' then d_site_id2 else d_site_id end d_site_id, 


d_num,
 d_age_yrs,
 d_sex,
 d_code_id,
 d_num_test, 
 d_lotnumber,
 d_result, 
 d_why_invalid,
 d_why_invalid_other,
 d_image,
 notes_part, 
 c_start d_start

FROM public.espen_ci_lf_pretas_3_resultat_fts_202302 d


