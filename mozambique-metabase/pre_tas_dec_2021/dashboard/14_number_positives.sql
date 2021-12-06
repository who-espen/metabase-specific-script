

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename espen_mz_lf_pretas_2_participant_202111_v2_1, v_espen_mz_lf_pretas_3_resultat_fts_202111_2_1
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_mz_lf_pretas_2_participant_202111_v2_1 p
  LEFT JOIN v_espen_mz_lf_pretas_3_resultat_fts_202111_2_1 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL
