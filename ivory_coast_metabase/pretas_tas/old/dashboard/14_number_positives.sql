

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ci_pretas_lf_enrollement_v7, v_espen_ci_pretas_lf_resultats_v7
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = '1_Positif" THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = '1_Positif" THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_ci_pretas_lf_enrollement_v7 p
  LEFT JOIN v_espen_ci_pretas_lf_resultats_v7 d on d.code_id = p.code_id
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
