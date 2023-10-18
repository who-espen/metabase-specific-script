/*
 * File: 12_cluster_map.sql
 * File Created: Saturday, 2nd May 2020 1:45:11 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:48:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_civ_oncho_ia_202309_1_site_v4
 */

SELECT
    distinct on(s_site) s_district,
    -- s_cluster_id,
    s_site,
    s_gps_lat,
    s_gps_lng,
    s_start
FROM public.v_espen_civ_oncho_ia_202309_1_site_v4