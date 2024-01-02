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
 * Variable to rename metabase_sn_lf_pretas_202307_duplicates? espen_sn_lf_pretas_3_fts_result_202307
 */

SELECT
    "Opérateurs",
    sum("Total des doublants") as "Total des doublants"
FROM (
        SELECT
            d.d_recorder_id "Opérateurs",
            count(m.id) "Total des doublants",
            d_district district,
            d_cluster_id cluster_id,
            d_cluster_name cluster_name
        FROM
            public.metabase_sn_lf_pretas_202307_duplicates m
            JOIN v_espen_sn_lf_pretas_3_fts_result_202307 d ON d.id = m.id_results
        GROUP BY
            d.d_recorder_id,
            d_district,
            d_cluster_id,
            d_cluster_name
        UNION
        SELECT
            p.p_recorder_id "Opérateurs",
            count(m.id) "Total des doublants",
            p_district district,
            p_cluster_id cluster_id,
            p_cluster_name cluster_name
        FROM
            public.metabase_sn_lf_pretas_202307_duplicates m
            JOIN v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p ON p.id = m.id_participant:: int
        group by
            p.p_recorder_id,
            p_district,
            p_cluster_id,
            p_cluster_name
    ) src
WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"
ORDER BY
    "Total des doublants" DESC