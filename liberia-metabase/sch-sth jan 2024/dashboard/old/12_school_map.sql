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
 * Variable to rename v_espen_lr_sch_sth_impact_202401_1_school_v2
 */

SELECT 

w_region,
w_district,
w_site_name,
w_subdistrict,
w_gps_lat,
w_gps_lng

FROM
    v_espen_lr_sch_sth_impact_202401_1_school_v2
WHERE w_gps_lat IS NOT NULL