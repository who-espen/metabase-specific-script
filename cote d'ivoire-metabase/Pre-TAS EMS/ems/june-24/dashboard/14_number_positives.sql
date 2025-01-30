

/*
 * This query will display the number of Positifs and the percentage of Positifs in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ci_lf_pretas_2406_3_part_v4, v_espen_ci_lf_pretas_2406_4_fts_v4
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_result = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_ci_lf_pretas_2406_3_part_v4 p
  LEFT JOIN v_espen_ci_lf_pretas_2406_4_fts_v4 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

