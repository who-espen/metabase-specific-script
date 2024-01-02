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
	cluster_name,
	lat,
	lng,
 	gps_acc
FROM public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1
WHERE gps_acc > 20

union all

 SELECT
	c_recorder_id,
	c_district,
	c_cluster_name,
	c_lat lat,
	c_lng lng,
 	c_gps_acc
FROM public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1
WHERE c_gps_acc > 20

