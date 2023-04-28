
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
 * Variable to rename metabase_bj_lf_tas_202304_duplicates, espen_bj_lf_tas3_202304_3_fts_result_v1, espen_bj_lf_tas3_202304_2_partcipants_v1_1
 */
 SELECT
 COUNT(barcode_participant),
 p.p_start::date
FROM metabase_bj_lf_tas_202304_duplicates AS m, v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id and survey_designation ='TAS2'

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_start::date
FROM metabase_bj_lf_tas_202304_duplicates AS m, v_espen_bj_lf_tas3_202304_3_fts_result_v1 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id and survey_designation ='TAS2'

GROUP BY d.d_start::DATE

