
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
 * Variable to rename metabase_lf_tas1_duplicates_202402, espen_gw_lf_tas1_202402_3_fts_result_v2
, espen_gw_lf_tas1_202402_3_fts_result_v2

 */
 SELECT
 COUNT(barcode_participant),
 p.p_start::date
FROM metabase_lf_tas1_duplicates_202402 AS m, v_espen_gw_lf_tas1_202402_2_partcipants_v2
 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_start::date
FROM metabase_lf_tas1_duplicates_202402 AS m, v_espen_gw_lf_tas1_202402_3_fts_result_v2
 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_start::DATE

