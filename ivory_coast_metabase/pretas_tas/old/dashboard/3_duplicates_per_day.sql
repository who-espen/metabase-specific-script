
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
 * Variable to rename metabase_lf_pretas_duplicates_202008, <%ab_cde_fgh_3_fts%>, espen_ci_pretas_lf_enrollement_v7
 */
 SELECT
 COUNT(code_id_enrollement),
 p.date_end::date
FROM metabase_lf_pretas_duplicates_202008 AS m, v_espen_ci_pretas_lf_enrollement_v7 AS p
WHERE m.id IS NOT NULL AND m.id_enrollement = p.id

GROUP BY p.date_end::DATE

UNION ALL

SELECT
 COUNT(code_id_fts_results),
 d."end"::date
FROM metabase_lf_pretas_duplicates_202008 AS m, v_espen_ci_pretas_lf_resultats_v7 AS d
WHERE m.id IS NOT NULL AND m.id_fts_results = d.id

GROUP BY d."end"::DATE
