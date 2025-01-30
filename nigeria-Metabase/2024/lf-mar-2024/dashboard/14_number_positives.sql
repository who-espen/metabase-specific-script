

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ng_lf_tas_202403_2_participant_bay_v2, v_espen_ng_lf_tas_202403_3_fts_bay_v2_2
 */
 
 SELECT
	CONCAT(TO_CHAR(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END), '999 999'),' (', ROUND(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_ng_lf_tas_202403_2_participant_bay_v2 p
  LEFT JOIN v_espen_ng_lf_tas_202403_3_fts_bay_v2_2 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL