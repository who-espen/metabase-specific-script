/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  espen_sn_lf_itas_20305_2_fts_v4
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
    v_espen_sn_lf_itas_2405_1_sit_part_v3_1 c
    LEFT JOIN v_espen_sn_lf_itas_20305_2_fts_v4 d on c.c_cluster_id = d.d_cluster_id
where d_final_result = 'Positive'