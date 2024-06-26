

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_lr_lf_tas1_2_child_202406_v1, v_espen_lr_lf_tas1_3_fts_202406
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2),
	' %)')
FROM v_espen_lr_lf_tas1_2_child_202406_v1 p
  LEFT JOIN v_espen_lr_lf_tas1_3_fts_202406 d on d.d_espen_code_id = p.p_espen_code_id
  WHERE p.id IS NOT NULL

