

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ng_lf_pretas_202404_2_participant_v2, v_espen_ng_lf_pretas_202404_3_fts_v2
 */
 
 SELECT
	CONCAT(TO_CHAR(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END), '999 999'),' (', ROUND(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_ng_lf_pretas_202404_2_participant_v2 p
  LEFT JOIN v_espen_ng_lf_pretas_202404_3_fts_v2 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL