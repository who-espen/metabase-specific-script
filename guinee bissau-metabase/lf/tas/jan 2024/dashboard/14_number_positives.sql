

/*
 * This query will display the number of Positivos and the percentage of Positivos in 1st line clusters and second-line clusters
 * Variable to rename v_espen_gw_lf_tas1_202402_3_fts_result_v2
, v_espen_gw_lf_tas1_202402_3_fts_result_v2

 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_result1 = 'Positivo' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_result1 = 'Positivo' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_gw_lf_tas1_202402_2_partcipants_v2
 p
  LEFT JOIN v_espen_gw_lf_tas1_202402_3_fts_result_v2
 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

