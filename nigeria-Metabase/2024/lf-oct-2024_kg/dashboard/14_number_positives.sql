

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_ng_lf_tas_2410_1_sit_part_kg, v_espen_ng_lf_tas_2410_2_fts_kg
 */
 
 SELECT
	CONCAT(TO_CHAR(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END), '999 999'),' (', ROUND(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_ng_lf_tas_2410_1_sit_part_kg p
  LEFT JOIN v_espen_ng_lf_tas_2410_2_fts_kg d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL