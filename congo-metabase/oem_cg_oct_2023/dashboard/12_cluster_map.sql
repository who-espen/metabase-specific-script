/*
 * File: 12_cluster_map.sql
 * File Created: Saturday, 2nd May 2020 1:45:11 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:48:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will use the GPS data to display a pin map of clusters.
 * Variable to rename v_espen_cg_oncho_oem_full_202112
 */

 select
 distinct on (district,
	cluster_name)
	recorder_id,
	district,
	cluster_name,
	lat,
	lng,
 	gps_acc
FROM public.v_espen_cg_oncho_oem_202310_2_biopsie_v4_1
WHERE lng is not null and lat is not null

union all

 SELECT
 distinct on (c_district,
	c_cluster_name)
	c_recorder_id,
	c_district,
	c_cluster_name,
	c_lat lat,
	c_lng lng,
 	c_gps_acc
FROM public.v_espen_cg_oncho_oem_202310_1_site_dbs_v4_1
WHERE c_lng is not null and c_lat is not null


