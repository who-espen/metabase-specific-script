
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_ng_ng_oncho_oias_3_resultat_fts_202207_v2
 */
 SELECT
  distinct on (c_site_id)
  c_district,
  c_site_id,
  c_site_name,
  c_gps_lat,
  c_gps_lng,
  created_at

FROM espen_ng_ng_oncho_oias_1_site_202207_v2 c
LEFT JOIN v_espen_ng_ng_oncho_oias_3_resultat_fts_202207_v2 d on c.c_site_id = d.d_cluster_id

where d_final_result = 'Positive'

  ------ Metabase filter -------
  -- [[and {{c_site_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
