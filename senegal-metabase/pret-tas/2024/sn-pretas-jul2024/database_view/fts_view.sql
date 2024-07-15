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
 * Variable to rename  v_espen_sn_lf_pretas_3_fts_result_202307, espen_sn_lf_pretas_3_fts_result_202307, espen_sn_lf_pretas_1_sites_202307
 */

create view v_espen_sn_lf_pretas_3_fts_result_202307 as 

SELECT 

id,
d_recorder_id, 
d_district,
d_cluster_name,
d_cluster_id, 

case when d_id_type = 'Scanner' then d_barcode_id else d_generatedid end d_barcode_id,
    
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
d_final_result, 
d_display_final_result, 
d_positive_why_no_tx, 
notes_part, 
c_start d_start

FROM public.espen_sn_lf_pretas_3_fts_result_202307 d
