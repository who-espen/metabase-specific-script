

/*
 * This query will display the number of Positivos and the percentage of Positivos in 1st line clusters and second-line clusters
 * Variable to rename v_espen_st_lf_tas1_2_partcipants_202204_3, v_espen_st_lf_tas1_3_fts_result_202204_3
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_result1 = 'Positivo' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_result1 = 'Positivo' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_st_lf_tas1_2_partcipants_202204_3 p
  LEFT JOIN v_espen_st_lf_tas1_3_fts_result_202204_3 d on d.d_generatedid = p.p_generate_id
  WHERE p.id IS NOT NULL

