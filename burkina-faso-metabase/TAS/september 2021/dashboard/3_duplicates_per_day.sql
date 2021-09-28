
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
 * Variable to rename metabase_lf_tas3_duplicates_202109, espen_bf_lf_tas3_3_resultat_sth_202109, espen_bf_lf_tas3_2_enrolement_202109
 */
 SELECT
 COUNT(barcode_participant),
 p.date_enregistrement::date
FROM metabase_lf_tas3_duplicates_202109 AS m, v_espen_bf_lf_tas3_2_enrolement_202109 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.date_enregistrement::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.date_enregistrement::date
FROM metabase_lf_tas3_duplicates_202109 AS m, v_espen_bf_lf_tas3_3_resultat_fts_202109 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.date_enregistrement::DATE

