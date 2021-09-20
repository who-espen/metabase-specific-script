
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_bj_lf_pretas_3_resultat_fts_202009_v3
 */
 SELECT
  c_district,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  created_at

FROM espen_bj_lf_pretas_1_site_202009_v3 c
LEFT JOIN v_espen_bj_lf_pretas_3_resultat_fts_202009_v3 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positive'

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
