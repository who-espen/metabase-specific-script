
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
 * Variable to rename metabase_lf_pretas_duplicates_202009, espen_bj_lf_pretas_3_resultat_fts_202009_v3, espen_bj_lf_pretas_2_participant_202009_v3
 */
 SELECT
 COUNT(barcode_participant),
 p.p_date::date
FROM metabase_lf_pretas_duplicates_202009 AS m, v_espen_bj_lf_pretas_2_participant_202009_v3 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_date::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_date::date
FROM metabase_lf_pretas_duplicates_202009 AS m, v_espen_bj_lf_pretas_3_resultat_fts_202009_v3 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_date::DATE

