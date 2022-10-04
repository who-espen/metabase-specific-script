

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bf_lf_tas3_2_participant_202209_v1_y, v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_resultat_fts1 = '1_Positif' and d_resultat_fts2 = '1_Positif' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN d_resultat_fts1 = '1_Positif' and d_resultat_fts2 = '1_Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_bf_lf_tas3_2_participant_202209_v1_y p
  LEFT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y d on d.d_barcode_id = p.p_barcode_id
  WHERE p.id IS NOT null

