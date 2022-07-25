

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ke_lf_pretas_2_participant_202203_v4, v_espen_ke_lf_pretas_3_resultat_fts_202203_v4
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2),
	' %)')
FROM v_espen_ke_lf_pretas_2_participant_202203_v4 p
  LEFT JOIN v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 d on d.d_barcode_id = p.p_barcode_id
  WHERE p.id IS NOT NULL

