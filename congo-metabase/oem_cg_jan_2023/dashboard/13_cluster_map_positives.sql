/*
 * File: 13_cluster_map_positives.sql
 * File Created: Saturday, 2nd May 2020 1:50:50 pm
 * Author: Dyesse YUMBA
 * Last Modified: Saturday, 2nd May 2020 1:53:33 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename v_espen_cg_oncho_oem_full_202112, v_espen_cg_oncho_oem_202303_2_biopsiev_2
 */
 SELECT
	CONCAT(COUNT(CASE WHEN "MFS Gauche" > 0 or "MFS Droite" > 0 THEN 1 ELSE NULL END),' (', round(count(CASE WHEN "MFS Gauche" > 0 or "MFS Droite" > 0 THEN 1 ELSE NULL END) * 100.0 / COUNT(*),2), ' %)')
FROM public.v_espen_cg_oncho_oem_202303_2_biopsiev_2 p
  WHERE p.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_cluster_id}}]]
  -- [[and {{"Village"}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
