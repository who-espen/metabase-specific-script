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
 * Variable to rename  v_espen_tg_oncho_stop_202304_3_elisa, espen_tg_oncho_stop_202304_3_elisa, espen_tg_oncho_stop_202304_1_site
 */
 
 create view v_espen_tg_oncho_stop_202304_3_elisa as SELECT 

id, 
d_recorder_id, 
d_region, 
d_district, 
d_subdistrict,
d_site, 
d_code_id, 
d_lab_elisa, 
d_notes, 
d_start_time

FROM public.espen_tg_oncho_stop_202304_3_elisa d
