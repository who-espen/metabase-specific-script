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
	c_recorder "Gravador",
	c_eu "UE",
	c_cluster_id "Código do site",
	c_gps_lat "Latitude",
	c_gps_lng "Longitude",
 	c_gps_acc "Précision",
    c_end "Date"
FROM v_espen_mz_lf_tas2_1_site_202101
WHERE c_gps_acc > 20

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]