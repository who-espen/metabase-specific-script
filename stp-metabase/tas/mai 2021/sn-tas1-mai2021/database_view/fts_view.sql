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
 * Variable to rename  v_espen_st_lf_tas1_3_fts_result_202204_3, espen_st_lf_tas1_3_fts_result_202204_3, espen_st_lf_tas1_1_sites_202204_3
 */
create view v_espen_st_lf_tas1_3_fts_result_202204_3 as

SELECT 

id, 
d_recorder_id, 
d_district, 
d_cluster_name, 
d_cluster_id, 
d_generatedid, 
d_lotnumber1, 
d_result1, 
d_why_invalido1 d_why_invalide1, 
d_notes, 
d_start
FROM public.espen_st_lf_tas1_3_fts_result_202204_3 d
