
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_mz_lf_tas2_3_resultat_fts_202101
 */
 SELECT
  c_eu,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  created_at

FROM v_espen_mz_lf_tas2_1_site_202101 c
LEFT JOIN v_espen_mz_lf_tas2_3_resultat_fts_202101 d on c.c_cluster_id = d.d_cluster_id

where d_final_result = 'Positivo'