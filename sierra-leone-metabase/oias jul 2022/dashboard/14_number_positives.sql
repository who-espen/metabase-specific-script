

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_sr_oncho_oem_2_participant_202211_v1_3, v_espen_ng_ng_oncho_oias_3_resultat_fts_202212_v2
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END),' (', ROUND(count(CASE WHEN d_final_result = 'Positive' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_sr_oncho_oem_2_participant_202211_v1_3 p
  LEFT JOIN v_espen_ng_ng_oncho_oias_3_resultat_fts_202212_v2 d on d.d_code_id = p.p_code_id
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
