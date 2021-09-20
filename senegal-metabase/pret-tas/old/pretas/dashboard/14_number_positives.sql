

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_sn_lf_tas1_2_partcipants_202009_manual, v_espen_bj_lf_tas1_3_fts_result_202009
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_sn_lf_tas1_2_partcipants_202009_manual p
  LEFT JOIN v_espen_bj_lf_tas1_3_fts_result_202009 d on d.d_generate_id = p.p_generate_id
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
