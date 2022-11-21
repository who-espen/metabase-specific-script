

/*
 * This query will display the number of Positivos and the percentage of Positivos in 1st line clusters and second-line clusters
 * Variable to rename v_espen_tg_oncho_stop_2_participants_202209_v1, v_espen_tg_oncho_stop_3_elisa_202209_v1
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_lab_elisa = 'Positif' THEN 1 ELSE NULL END),' (', round(count(CASE WHEN d_lab_elisa = 'Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_tg_oncho_stop_2_participants_202209_v1 p
  LEFT JOIN v_espen_tg_oncho_stop_3_elisa_202209_v1 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

