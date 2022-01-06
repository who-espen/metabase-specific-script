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
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */
 SELECT
	recorder_id,
	district,
	cluster_id,
	gps_lat,
	gps_lng,
 	gps_acc
FROM v_espen_cg_oncho_oem_full_202112
WHERE gps_acc > 20

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
