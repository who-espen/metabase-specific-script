
/*
 * File: 3_duplicates_per_day.sql
 * File Created: Tuesday, 5th May 2020 5:05:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 5:12:53 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the total records of duplicates per day
 * Variable to rename metabase_lf_pretas_duplicates_202106, espen_bf_lf_pretas_3_resultat_202007_v2_1, espen_bf_lf_pretas_2_enrolement_202106_v2_2
 */
 SELECT
 COUNT(barcode_participant),
 p.p_date::date
FROM metabase_lf_pretas_duplicates_202106 AS m, v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_date::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_date::date
FROM metabase_lf_pretas_duplicates_202106 AS m, v_espen_bf_lf_pretas_3_resultat_202106_v2_1 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_date::DATE

