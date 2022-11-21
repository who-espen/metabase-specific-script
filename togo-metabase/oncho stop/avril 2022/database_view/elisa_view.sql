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
 * Variable to rename  v_espen_tg_oncho_stop_3_elisa_202204, espen_tg_oncho_stop_3_elisa_202204, espen_tg_oncho_stop_1_site_202204
 */
create view v_espen_tg_oncho_stop_3_elisa_202204 as

SELECT 

id, 
d_recorder_id, 
d_district, 
d_cluster_name, 
d_cluster_id, 
d_code_id, 
d_lotnumber1, 
d_lab_elisa, 
d_why_invalido1 d_why_invalide1, 
d_notes, 
d_start_time
FROM public.espen_tg_oncho_stop_3_elisa_202204 d
