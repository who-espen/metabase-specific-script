

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bj_lf_tas3_202304_2_partcipants_v1_1, v_espen_bj_lf_tas3_202304_3_fts_result_v1
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 p
  LEFT JOIN v_espen_bj_lf_tas3_202304_3_fts_result_v1 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL
