

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ci_202302_lf_conf_2_partcipants_v1, v_espen_ci_202302_lf_conf_3_fts_result
 */

 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_ci_202302_lf_conf_2_partcipants_v1 p
  LEFT JOIN v_espen_ci_202302_lf_conf_3_fts_result d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

