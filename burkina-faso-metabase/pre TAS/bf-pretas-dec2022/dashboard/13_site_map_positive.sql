
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2
 */
 
 SELECT
 distinct on (c_cluster_id1)
  c_district,
  c_cluster_id1,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng,
  c_start

FROM v_espen_bf_lf_pretas_1_village_202212_v2 c
LEFT JOIN v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 d on c.c_cluster_id1 = d.d_cluster_id

where d_result1 = '1_Positif' and d_result2 = '1_Positif'

