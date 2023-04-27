
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_bj_lf_tas3_202304_3_fts_result_v1
 */
 SELECT
  c_eu_name,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  c_start

FROM v_espen_bj_lf_tas3_202304_1_sites c
LEFT JOIN v_espen_bj_lf_tas3_202304_3_fts_result_v1 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positif'