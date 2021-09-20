/*
 * File: site_view.sql
 * File Created: Monday, 4th May 2020 3:24:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 4th May 2020 3:47:58 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_bf_lf_pretas_1_sites_202007, espen_bf_lf_pretas_1_sites_202007
 */
CREATE OR REPLACE VIEW public.v_espen_bf_lf_pretas_1_sites_202007
AS SELECT c.id,
    c.c_recorder,
    c.drs,
    c.c_district,
    c.csps,
    c.c_cluster_name,
    c.c_cluster_id1,
    c.c_population,
    c.couverture_tdm_2019,
    c.gps_lat,
    c.gps_lng,
    c.gps_alt,
    c.gps_acc,
    c.commentaires,
    c.c_end AS c_date
   FROM espen_bf_lf_pretas_1_sites_202007 c;
