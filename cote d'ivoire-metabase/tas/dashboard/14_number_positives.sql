

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ci_lf_tas1_2_partcipants_202110_v3, v_espen_ci_lf_tas1_3_fts_result_202110_v3
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_ci_lf_tas1_2_partcipants_202110_v3 p
  LEFT JOIN v_espen_ci_lf_tas1_3_fts_result_202110_v3 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

