/*
 * File: 1_duplicates_per_recorder.sql
 * File Created: Tuesday, 5th May 2020 3:50:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 3:56:53 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the number of duplicates per recorder
 * Variable to rename metabase_oncho_prestop_202307_duplicates? espen_bi_oncho_prestop_3_202307_diag_v2
 */

SELECT
    "Opérateurs",
    sum("Total des doublants") as "Total des doublants"
FROM (
        SELECT
            d.d_recorder_id "Opérateurs",
            count(m.id) "Total des doublants"
        FROM
            public.metabase_oncho_prestop_202307_duplicates m
            JOIN v_espen_bi_oncho_prestop_3_202307_diag_v2 d ON d.id = m.id_results
        GROUP BY
            d.d_recorder_id
        UNION
        SELECT
            p.p_recorder_id "Opérateurs",
            count(m.id) "Total des doublants"
        FROM
            public.metabase_oncho_prestop_202307_duplicates m
            JOIN v_espen_bi_oncho_prestop_2_202307_questions_v3 p ON p.id = m.id_participant
        group by
            p.p_recorder_id
    ) src
WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"
ORDER BY
    "Total des doublants" DESC