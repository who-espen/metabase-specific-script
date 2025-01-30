/*
 * File: 12_school_map.sql
 * File Created: Tuesday, 12th May 2020 2:01:53 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:04:26 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
 */

SELECT 

w_region,
w_district,
w_site_name,
w_usp,
w_gps_lat,
w_gps_lng

FROM
    v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
WHERE w_gps_lat IS NOT NULL