
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
 * Variable to rename metabase_ng_lf_2407_tas1_duplicates_kn, espen_ng_lf_tas_2406_3_resultat_fts_ng_v3, espen_ng_lf_tas_2406_2_part_ben_oy_v2
 */
 SELECT
 COUNT(barcode_participant) "Total duplicates",
 p.p_start::date "Date"
FROM metabase_ng_lf_2407_tas1_duplicates_kn AS m, v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results) "Total duplicates",
 d.d_start::date "Date"
FROM metabase_ng_lf_2407_tas1_duplicates_kn AS m, v_espen_ng_lf_tas_2406_2_fts_kn_v31 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_start::DATE

order by "Total duplicates"

