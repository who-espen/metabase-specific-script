/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_sn_lf_tas2_20306_3_fts_result
 */

SELECT
    c_eu_name,
    c_commune,
    c_cluster_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c.c_start
FROM
    v_espen_sn_lf_tas2_20306_1_site c
    LEFT JOIN v_espen_sn_lf_tas2_20306_3_fts_result d on c.c_cluster_id = d.d_cluster_id
where d_final_result = 'Positive'