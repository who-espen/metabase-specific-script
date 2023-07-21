/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_ng_oncho_stop_6_rdtov16_202206
 */

SELECT
    distinct on (c_cluster_id) c_district,
    c_cluster_id,
    c_cluster_name,
    c_gps_lat,
    c_gps_lng,
    created_at
FROM
    espen_ng_ng_oncho_prestop_1_site_202304_v2 c
    LEFT JOIN v_espen_ng_oncho_stop_6_rdtov16_202206 d on c.c_cluster_id = d.d_cluster_id
where
    d_final_result = 'Positive' ------ Metabase filter -------
    -- [[and {{c_cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]