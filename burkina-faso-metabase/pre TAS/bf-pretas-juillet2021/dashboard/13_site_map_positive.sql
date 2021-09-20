
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bf_lf_pretas_3_resultat_202106_v2_1
 */
 SELECT
  c_district,
  c_cluster_id1,
  c_cluster_name,
  gps_lat,
  gps_lng,
  c_start

FROM v_espen_bf_lf_pretas_1_sites_202106_v2 c
LEFT JOIN v_espen_bf_lf_pretas_3_resultat_202106_v2_1 d on c.c_cluster_id1 = d.d_cluster_id

where d_result1 = '1_Positif' and d_result2 = '1_Positif'

  ------ Metabase filter -------
  -- [[and {{c_cluster_id1}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
