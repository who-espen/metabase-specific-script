
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
 * Variable to rename metabase_oncho_stop_duplicates_202204, espen_tg_oncho_stop_3_elisa_202204, espen_tg_oncho_stop_2_participants_202204
 */
 SELECT
 COUNT(barcode_participant),
 p.p_start_time::date
FROM metabase_oncho_stop_duplicates_202204 AS m, v_espen_tg_oncho_stop_2_participants_202204 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start_time::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.d_start_time::date
FROM metabase_oncho_stop_duplicates_202204 AS m, v_espen_tg_oncho_stop_3_elisa_202204 AS d
WHERE m.id IS NOT NULL AND m.id_results = d.id

GROUP BY d.d_start_time::DATE

