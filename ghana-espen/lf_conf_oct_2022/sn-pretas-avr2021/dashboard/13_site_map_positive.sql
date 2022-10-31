
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_gn_lf_pretas_2_resultat_fts_202210_fts
 */
 SELECT
  c_district,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng

FROM  v_espen_gn_lf_pretas_1_site_202210 c
LEFT JOIN public.v_espen_gn_lf_pretas_2_resultat_fts_202210_fts d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positive'
