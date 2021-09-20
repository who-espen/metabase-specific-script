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
 * Variable to rename espen_bj_oncho_prestop_1_site
 */
 SELECT
	c_recorder_id,
	c_district_id,
	c_cluster_id,
	c_gps_lat,
	c_gps_lng,
 	c_gps_acc
FROM espen_bj_oncho_prestop_1_site
WHERE c_gps_acc > 20

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
