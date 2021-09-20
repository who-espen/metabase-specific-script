

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bj_lf_tas2_5_partcipants_202104_v2, v_espen_bj_lf_tas2_6_fts_result_202104_v2
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_bj_lf_tas2_5_partcipants_202104_v2 p
  LEFT JOIN v_espen_bj_lf_tas2_6_fts_result_202104_v2 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL
