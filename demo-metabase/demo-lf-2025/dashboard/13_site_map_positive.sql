
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_demo_lf_tas_9999_3_fts_v2
 */
 
 SELECT
  distinct on (c_cluster_id)
  c_district,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  c_start

FROM v_espen_demo_lf_tas_9999_2_part_v2 c
LEFT JOIN v_espen_demo_lf_tas_9999_3_fts_v2 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positive'

