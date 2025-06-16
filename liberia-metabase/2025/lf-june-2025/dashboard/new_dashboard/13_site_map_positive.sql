
/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename espen_bj_oncho_prestop_1_site,  v_espen_lr_lf_pretas_3_results_fts_mf_202506
 */
 
WITH d_final_result AS (
 SELECT
  distinct on (p_cluster_id)
  c.p_district_eu,
  c.p_cluster_id,
  c.p_cluster_name,
  c.c_gps_lat,
  c.c_gps_lng,
  c.c_start,
  
  CASE 
      WHEN d.d_fts_result1 = 'Positive' AND d.d_fts_result2 = 'Positive' THEN 'Positive'
      WHEN d.d_fts_result1 = 'Positive' AND d.d_fts_result2 = 'Negative' THEN 'Negative'
      WHEN d.d_fts_result1 = 'Positive' AND d.d_fts_result2 = 'Invalid' THEN 'Positive'
      WHEN d.d_fts_result1 = 'Invalid' AND d.d_fts_result2 = 'Invalid' THEN 'Indeterminate'
      WHEN d.d_fts_result1 = 'Invalid' AND d.d_fts_result2 = 'Negative' THEN 'Negative'
      ELSE 'Negative' 
    END AS "Diagnostic Results"
	
FROM v_espen_lr_lf_pretas_site_participant_202506 c
LEFT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d 
	ON c.p_cluster_id = d.d_cluster_id )
SELECT * FROM d_final_result

WHERE "Diagnostic Results" = 'Positive';