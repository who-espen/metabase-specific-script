/*
 * File: 14_number_of_positives.sql
 * File Created: Saturday, 2nd May 2020 2:02:04 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:31 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will display the number of positives and the percentage of positives in 1st line clusters and second-line clusters
 * Variable to rename v_espen_cg_oncho_oem_full_202112, v_espen_cg_oncho_oem_2_biopsie_202207_v2_full
 */
 SELECT
	CONCAT(COUNT(CASE WHEN d_lab_ov16 = 'Positive' THEN 1 ELSE NULL END),' (', count(CASE WHEN d_lab_ov16 = 'Positive' THEN 1 ELSE NULL END) * 100 / COUNT(*), ' %)')
FROM v_espen_cg_oncho_oem_full_202112 p
  LEFT JOIN v_espen_cg_oncho_oem_2_biopsie_202207_v2_full d on d.barcode_id = p.p_barcode_id
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{"Village"}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
