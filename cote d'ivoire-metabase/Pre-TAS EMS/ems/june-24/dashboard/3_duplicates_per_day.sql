
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
 * Variable to rename metabase_ci_lf_2407_ems_duplicates, espen_ci_lf_pretas_3_resultat_fts_202302, espen_ci_lf_pretas_2406_3_part_v4
 */
 SELECT
 COUNT(barcode_participant),
 p.p_start::date
FROM metabase_ci_lf_2407_ems_duplicates AS m, v_espen_ci_lf_pretas_2406_3_part_v4 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_start::date
FROM metabase_ci_lf_2407_ems_duplicates AS m, v_espen_ci_lf_pretas_2406_4_fts_v4 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_start::DATE

