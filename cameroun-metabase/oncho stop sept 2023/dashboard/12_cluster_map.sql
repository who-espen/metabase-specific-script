/*
 * File: 12_village_map.sql
 * File Created: Saturday, 2nd May 2020 1:45:11 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:48:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_cm_oncho_pre_stop_1_202309_village_v2
 */




SELECT distinct on(c_village )
    c_district,
    c_village_id,
    c_village,
    c_gps_lat,
    c_gps_lng,
    c_start
FROM
     public.v_espen_cm_oncho_pre_stop_1_202309_village_v2
    
    