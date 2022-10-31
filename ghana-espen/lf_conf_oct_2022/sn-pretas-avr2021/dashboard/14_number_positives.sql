

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_gn_lf_pretas_1_site_participant_202210, v_espen_gn_lf_pretas_2_resultat_fts_202210_fts
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2),
	' %)')
FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts d 
