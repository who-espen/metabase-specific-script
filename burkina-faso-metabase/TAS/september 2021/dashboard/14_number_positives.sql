

/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_bf_lf_tas3_2_enrolement_202109, v_espen_bf_lf_tas3_3_resultat_fts_202109
 */
 SELECT
	CONCAT(COUNT(CASE WHEN resultat_fts1 = '1_Positif' and resultat_fts2 = '1_Positif' THEN 1 ELSE NULL END),' (', 
	round(count(CASE WHEN resultat_fts1 = '1_Positif' and resultat_fts2 = '1_Positif' THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM v_espen_bf_lf_tas3_2_enrolement_202109 p
  LEFT JOIN v_espen_bf_lf_tas3_3_resultat_fts_202109 d on d.barcode = p.barcode
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{nb_grappe}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
