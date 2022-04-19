

/*
 * This query will display the number of Positifs and the percentage of Positifs in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ci_lf_pretas_2_participant_202204_v1, v_espen_ci_lf_pretas_3_resultat_fts_202204_v1
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_result = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_ci_lf_pretas_2_participant_202204_v1 p
  LEFT JOIN v_espen_ci_lf_pretas_3_resultat_fts_202204_v1 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

