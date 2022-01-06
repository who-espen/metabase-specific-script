/*
 * File: 3_number_duplicate_per_day.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:08:49 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */




/*
 * A query to display the total records of duplicates per day
 * Variable to rename metabase_oncho_oias_duplicates_202112, v_espen_ng_oncho_oem_2_participant_202112_v2_2
 */
 SELECT
 COUNT(barcode_participant),
 p.p_date::date
FROM metabase_oncho_oias_duplicates_202112 AS m, v_espen_ng_oncho_oem_2_participant_202112_v2_2 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_date::DATE

-- UNION ALL

-- SELECT
--  COUNT(barcode_participant),
--  d.p_date::date
-- FROM metabase_oncho_oias_duplicates_202112 AS m, <%v_ab_cde_fgh_3_rdt_ov16%> AS d
-- WHERE m.id IS NOT NULL AND m.id_results = d.id

-- GROUP BY d.d_date::DATE
