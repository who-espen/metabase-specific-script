
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_ci_202302_lf_tas1_3_fts_result
 */
 SELECT
 
 c_eu_name,
 c_district,
 c_cluster_id,
 c_cluster_name,
 c_gps_lat,
 c_gps_lng,
 c.c_start


FROM v_espen_ci_202302_lf_tas1_1_sites c
LEFT JOIN v_espen_ci_202302_lf_tas1_3_fts_result d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positif'

