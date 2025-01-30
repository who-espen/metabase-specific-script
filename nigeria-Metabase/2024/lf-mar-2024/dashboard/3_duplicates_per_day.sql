
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
 * Variable to rename metabase_ng_lf_pretas_duplicates_202402_bay, espen_ng_lf_tas_202402_bay_3_resultat_fts_jgw_v3, espen_ng_lf_tas_202403_2_participant_bay_v2
 */
 SELECT
 COUNT(barcode_participant) "Total duplicates",
 p.p_start::date "Date"
FROM metabase_ng_lf_pretas_duplicates_202402_bay AS m, v_espen_ng_lf_tas_202403_2_participant_bay_v2 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results) "Total duplicates",
 d.d_start::date "Date"
FROM metabase_ng_lf_pretas_duplicates_202402_bay AS m, v_espen_ng_lf_tas_202403_3_fts_bay_v2_2 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_start::DATE

order by "Total duplicates"

