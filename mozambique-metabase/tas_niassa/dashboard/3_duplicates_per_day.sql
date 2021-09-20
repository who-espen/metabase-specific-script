
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
 * Variable to rename metabase_lf_tas_duplicates_202012, espen_mz_lf_tas1_3_resultat_fts_202011_v3, espen_mz_lf_tas1_2_participant_202011_v3
 */
 SELECT
 COUNT(barcode_participant),
 p.p_end::date
FROM metabase_lf_tas_duplicates_202012 AS m, v_espen_mz_lf_tas1_2_participant_202011_v3 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id -- and survey_designation ='TAS2'

GROUP BY p.p_end::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_end::date
FROM metabase_lf_tas_duplicates_202012 AS m, v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id --and survey_designation ='TAS2'

GROUP BY d.d_end::DATE

