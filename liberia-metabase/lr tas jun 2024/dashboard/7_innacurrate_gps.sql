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
	c_recorder "Enumerator",
	c_eu "EU",
	c_cluster_id "Code Site",
	c_gps_lat "Latitude",
	c_gps_lng "Longitude",
 	c_gps_acc "Accuracy",
    c_start "Date"
FROM v_espen_lr_lf_tas1_1_site_202406_v1
WHERE c_gps_acc > 20
