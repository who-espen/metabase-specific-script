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
 * Variable to rename espen_civ_oncho_ia_202309_1_site_v4
 */

SELECT
    s_recorder_id,
    s_district,
    s_site,
    s_gps_lat,
    s_gps_lng,
    s_gps_acc
FROM
    espen_civ_oncho_ia_202309_1_site_v4
WHERE s_gps_acc > 20