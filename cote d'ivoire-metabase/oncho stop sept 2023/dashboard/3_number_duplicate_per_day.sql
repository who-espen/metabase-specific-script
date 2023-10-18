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
 * Variable to rename metabase_oncho_stop_ci_202309_duplicates, v_espen_civ_oncho_ia_202309_2_participant_v4
 */

SELECT
    COUNT(barcode_participant),
    p.p_start:: date
FROM
    public.metabase_oncho_stop_ci_202309_duplicates AS m,
    public.v_espen_civ_oncho_ia_202309_2_participant_v4 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant = p.id

GROUP BY p.p_start::DATE 