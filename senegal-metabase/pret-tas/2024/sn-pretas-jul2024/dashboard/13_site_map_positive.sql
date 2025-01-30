/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_sn_lf_pretas_3_fts_result_202307
 */

SELECT distinct on (c_cluster_id)
    c_district,
    c_cluster_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng
FROM
    v_espen_sn_lf_pretas_20407_2_fts_v3 c
    LEFT JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d on c.c_cluster_id = d.d_cluster_id
where
    d_final_result = 'Positive' 