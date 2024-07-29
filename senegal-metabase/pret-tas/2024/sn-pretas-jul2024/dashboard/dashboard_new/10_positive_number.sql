 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_final_result = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
  LEFT JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL