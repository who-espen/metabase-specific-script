/*
 * File: 7_inacurrate_gps.sql
 * File Created: Friday, 1st May 2020 10:47:45 pm
 * Author: Dyesse YUMBA
 * Last Modified: Friday, 1st May 2020 10:53:23 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename espen_gn_oncho_pre_stop_202311_1_site
 */

SELECT
    c_recorder_id,
    c_district,
    c_cluster_name_id,
    c_gps_lat,
    c_gps_lng,
    c_gps_acc
FROM
    v_espen_gn_oncho_pre_stop_202311_1_site
WHERE
    c_gps_acc > 20
    