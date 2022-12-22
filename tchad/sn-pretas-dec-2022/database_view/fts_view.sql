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
 * Variable to rename  v_espen_td_lf_pretas_3_resultat_fts_202208_v2, espen_td_lf_pretas_3_resultat_fts_202208_v2, espen_td_lf_pretas_1_site_202208_v2
 */
create view v_espen_td_lf_pretas_3_resultat_fts_202208_v2 as

select

id, 
 d_recorder_id, 
 d_district, 
 d_site, 
 d_site_id, 
 d_age_annee,
 d_sex, 
 d_id_type, 
 d_barcode_id, 
 d_num, 
 d_num2,
 d_code_id, 
 d_num_test, 
 d_lotnumber,
 d_result, 
 
 case when d_why_invalid = 'other' then d_why_invalid_other else d_why_invalid end d_why_invalid,

 d_image,
 notes_part, 
 c_start d_start


FROM public.espen_td_lf_pretas_3_resultat_fts_202208_v2 d

