
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_lr_lf_tas1_3_resultat_fts_202210
 */
 SELECT
  c_district,
  c_cluster_id,
  c_cluster_name,
  c_gps_lat,
  c_gps_lng

FROM v_espen_lr_lf_tas1_1_site_202210 c
LEFT JOIN v_espen_lr_lf_tas1_3_resultat_fts_202210 d on c.c_cluster_id = d.d_cluster_id

where final_result = 'Positive'

