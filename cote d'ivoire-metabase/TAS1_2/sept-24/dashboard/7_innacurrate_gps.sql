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
	c_site "Site",
	c_cluster_id "Code Site",
	c_gps_lat "Latitude",
	c_gps_lng "Longitude",
 	c_gps_acc "Précision",
    c_start "Date"
FROM v_espen_ci_lf_tas1_2409_1_sites
WHERE c_gps_acc > 20

