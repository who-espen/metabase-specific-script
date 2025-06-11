

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_lr_lf_tas1_2_participant_202210_v0, v_espen_lr_lf_tas1_3_resultat_fts_202210
 */
 SELECT
	CONCAT(COUNT(CASE WHEN final_result = 'Positive' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2),
	' %)')
FROM v_espen_lr_lf_tas1_2_participant_202210_v0 p
  LEFT JOIN v_espen_lr_lf_tas1_3_resultat_fts_202210 d on d.d_barcode_id = p.p_barcode_id
  WHERE p.id IS NOT NULL

