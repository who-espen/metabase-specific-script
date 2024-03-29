
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
 * Variable to rename metabase_bf_lf_pretas_duplicates_202212, espen_bf_lf_pretas_3_resultats_2022_06122022_v2, espen_bf_lf_pretas_2_enrolement_2022_061222_v2
 */
 SELECT
 COUNT(barcode_participant),
 p.p_date::date
FROM metabase_bf_lf_pretas_duplicates_202212 AS m, v_espen_bf_lf_pretas_2_enrolement_2022_061222_v2 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_date::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_date::date
FROM metabase_bf_lf_pretas_duplicates_202212 AS m, v_espen_bf_lf_pretas_3_resultats_2022_06122022_v2 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_date::DATE

