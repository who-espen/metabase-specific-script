

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_mz_lf_tas1_2_participant_202209_v1, v_espen_mz_lf_tas1_3_resultat_fts_202209_v1
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = 'Positivo' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_mz_lf_tas1_2_participant_202209_v1 p
  LEFT JOIN v_espen_mz_lf_tas1_3_resultat_fts_202209_v1 d on d.d_barcode_id = p.p_barcode_id
  WHERE p.id IS NOT NULL
