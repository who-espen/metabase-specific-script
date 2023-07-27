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
 * Variable to rename metabase_oncho_prestop_202307_duplicates, espen_bi_oncho_prestop_3_202307_diag_v2, espen_bi_oncho_prestop_2_202307_questions_v3
 */


SELECT
    COUNT(barcode_participant),
    p.c_start:: date
FROM
    metabase_oncho_prestop_202307_duplicates AS m,
    v_espen_bi_oncho_prestop_2_202307_questions_v3 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant = p.id
GROUP BY p.c_start:: DATE
UNION ALL
SELECT
    COUNT(barcode_results),
    d.d_start:: date
FROM
    metabase_oncho_prestop_202307_duplicates AS m,
    v_espen_bi_oncho_prestop_3_202307_diag_v2 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results = d.id
GROUP BY d.d_start:: DATE