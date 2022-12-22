
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
 * Variable to rename metabase_sr_oncho_oem_duplicates_202212, espen_ng_ng_oncho_oias_3_resultat_fts_202212_v2, espen_ng_ng_oncho_oias_2_participant_202212_v2
 */
 SELECT
 COUNT(barcode_participant),
 p.p_start::date
FROM metabase_sr_oncho_oem_duplicates_202212 AS m, v_espen_sr_oncho_oem_2_participant_202211_v1_3 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE


