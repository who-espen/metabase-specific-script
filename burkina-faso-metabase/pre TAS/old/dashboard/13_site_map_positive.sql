
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bf_lf_pretas_3_resultat_202007_v2
 */
 SELECT
  c_district,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  created_at

FROM espen_bf_lf_pretas_1_sites_202007 c
LEFT JOIN v_espen_bf_lf_pretas_3_resultat_202007_v2 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positif'

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
