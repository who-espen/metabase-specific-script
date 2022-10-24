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
 * Variable to rename  v_espen_mz_lf_tas1_3_resultat_fts_202209_v1, espen_mz_lf_tas1_3_resultat_fts_202209_v1, espen_mz_lf_tas1_1_site_202209_v1
 */
create view v_espen_mz_lf_tas1_3_resultat_fts_202209_v1 as 

SELECT 

id,
d_recorder_id,
d_province, 
d_district, 
d_cluster_name, 
d_cluster_id,

case when d_id_method = 'Manual' then d_barcode_id2 else d_barcode_id1 end d_barcode_id,

d_lotnumber1,
d_result1, 
d_why_invalid1,

d_need_second_test, 
d_lotnumber2,
d_result2, 
d_why_invalid2, 
d_final_result,
 d_positive_why_no_tx, 
 notes_part, 
 d_start

FROM public.espen_mz_lf_tas1_3_resultat_fts_202209_v1 d