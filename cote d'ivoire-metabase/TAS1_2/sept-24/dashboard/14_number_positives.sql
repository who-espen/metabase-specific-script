

/*
 * This query will display the number of Positifs and the percentage of Positifs in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ci_lf_tas1_2409_2_partcipants, v_espen_ci_lf_tas1_2409_3_fts_result
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_ci_lf_tas1_2409_2_partcipants p
  LEFT JOIN v_espen_ci_lf_tas1_2409_3_fts_result d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

