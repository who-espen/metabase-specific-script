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
 * Variable to rename metabase_ng_oncho_stop_duplicates_202404, espen_ng_oncho_stop_3_rdtov16_202404, espen_ng_ng_oncho_stop_2_participant_202304_v2
 */

SELECT
    COUNT(barcode_participant),
    p.p_start:: date
FROM
    metabase_ng_oncho_stop_duplicates_202404 AS m,
    v_espen_ng_oncho_stop_202404_2_part_adam_v2 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant = p.id
GROUP BY p.p_start:: DATE