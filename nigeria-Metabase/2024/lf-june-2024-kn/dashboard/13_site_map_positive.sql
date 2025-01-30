
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_ng_lf_tas_2406_2_fts_kn_v31
 */
 
 SELECT
  distinct on (c_cluster_id)
  c_district,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  c_start

FROM v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 c
LEFT JOIN v_espen_ng_lf_tas_2406_2_fts_kn_v31 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positive'

