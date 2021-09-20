

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename espen_mz_lf_tas2_2_participant_202101, v_espen_mz_lf_tas2_3_resultat_fts_202101
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM espen_mz_lf_tas2_2_participant_202101 p
  LEFT JOIN v_espen_mz_lf_tas2_3_resultat_fts_202101 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL
