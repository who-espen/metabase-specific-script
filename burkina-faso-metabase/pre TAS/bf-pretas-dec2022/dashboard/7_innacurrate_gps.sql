/*
 * File: 7_innacurrate_gps.sql
 * File Created: Tuesday, 5th May 2020 6:36:35 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 6:37:59 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This card will list all records with innacurate GPS
 * Variable to rename <%ab_cde_fgh_1_cluster%>
 */
 SELECT
	c_recorder "Opérateur",
	c_district "District",
	c_cluster_id11 "Code Site",
	gps_lat "Latitude",
	gps_lng "Longitude",
 	gps_acc "Précision",
    c_start "Date"
FROM v_espen_bf_lf_pretas_1_sites_202106_v2
WHERE gps_acc > 20

  ------ Metabase filter -------
  -- [[and {{c_cluster_id1}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]