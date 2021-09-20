

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bf_lf_pretas_2_enrollement_202007_v2, v_espen_bf_lf_pretas_3_resultat_202007_v2
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_bf_lf_pretas_2_enrollement_202007_v2 p
  LEFT JOIN v_espen_bf_lf_pretas_3_resultat_202007_v2 d on d.d_barcode_id = p.p_barcode_id
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
