
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename <%ab_cde_fgh_1_cluster%>,  v_espen_td_lf_pretas_3_resultat_fts_202208_v2
 */
 SELECT
  c_district,
  c_site_id,
  c_site,
  c_gps_lat,
  c_gps_lng

FROM v_espen_td_lf_pretas_1_site_202208_v2 c
LEFT JOIN v_espen_td_lf_pretas_3_resultat_fts_202208_v2 d on c.c_site_id = d.d_site_id

where d_result = 'Positive'
