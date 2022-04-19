/*
 * File: 12_site_map.sql
 * File Created: Wednesday, 6th May 2020 10:55:50 am
 * Author: Dyesse YUMBA
 * Last Modified: Wednesday, 6th May 2020 10:56:54 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename espen_ci_lf_pretas_1_site_202204
 */
 SELECT

 c_region,
 c_district,
 c_site_id,
 c_site,
 c_gps_lat,
 c_gps_lng,
 c_start

FROM v_espen_ci_lf_pretas_1_site_202204

