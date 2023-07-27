/*
 * This query will will display a pin Map of clusters with Positivo cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bi_oncho_prestop_3_202307_diag_v2
 */


SELECT
    c_district,
    --c_site_id,
    d_cluster_name,
    c_gps_lat,
    c_gps_lng,
    c.c_start
FROM
    v_espen_bi_oncho_prestop_1_202307_site_v3 c
    LEFT JOIN v_espen_bi_oncho_prestop_3_202307_diag_v2 d on c.c_cluster_name = d.d_cluster_name
where d_elisa_result = 'Positif' or d_elisa_result_2 = 'Positif'