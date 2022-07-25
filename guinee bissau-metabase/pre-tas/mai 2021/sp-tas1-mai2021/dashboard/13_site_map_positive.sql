
/*
 * This query will will display a pin Map of clusters with Positivo cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_gw_lf_pretas_3_fts_result_202206_v2

 */
 SELECT
 
 c_region,
 c_district,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c.c_start


FROM v_espen_gw_lf_pretas_1_sites_202206_v2_1
 c
LEFT JOIN v_espen_gw_lf_pretas_3_fts_result_202206_v2
 d on c.c_cluster_id = d.d_cluster_id

where d_result1 = 'Positivo'

