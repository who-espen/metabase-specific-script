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
 * Variable to rename  v_espen_tg_oncho_stop_3_elisa_202209_v1, espen_tg_oncho_stop_3_elisa_202209_v1, espen_tg_oncho_stop_1_site_202209_v1
 */
CREATE OR REPLACE VIEW public.v_espen_tg_oncho_stop_3_elisa_202209_v1 as
SELECT d.id,
    d.d_recorder_id,
    d.c_district d_district,
    d.c_site d_site,
    d.c_site_id d_site_id,
    d.c_bassin_fluvial d_bassin_fluvial,
    d.c_nom_riviere_fleuve d_nom_riviere_feluve,
    d.d_code_id,
    d.d_lab_elisa,
    d.d_notes,
    d.d_start_time
   FROM espen_tg_oncho_stop_3_elisa_202209_v1 d;