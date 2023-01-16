

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2, v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_result1 = '1_Positif' and d_result2 = '1_Positif' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN d_result1 = '1_Positif' and d_result2 = '1_Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2) , ' %)')
FROM v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 p
  LEFT JOIN v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 d on d.d_barcode_id = p.p_barcode_id
  WHERE p.id IS NOT NULL

