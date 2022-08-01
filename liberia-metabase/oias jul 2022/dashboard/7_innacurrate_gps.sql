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
 * Variable to rename espen_bj_oncho_prestop_1_site
 */
 SELECT
	c_recorder_id "Recorder",
	c_district "District",
	c_site_id "Code Site",
	c_gps_lat "Latitude",
	c_gps_lng "Longitude",
 	c_gps_acc "Accuracy",
    c_date "Date"
FROM v_espen_lr_oncho_ias_1_site_202112_v2_1
WHERE c_gps_acc > 20

