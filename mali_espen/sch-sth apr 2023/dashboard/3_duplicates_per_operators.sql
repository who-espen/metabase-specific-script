SELECT
    "Opérateurs",
    sum("Total Doulons") "Total Doulons"
FROM (
        SELECT
            k.k_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_ml_sch_sth_impact_202305_duplicates m
            JOIN public.v_espen_ml_sch_sth_impact_202304_3_kato_katz k ON k.id = m.id_results_kk :: int
        GROUP BY k.k_recorder
        UNION
        SELECT
            p.p_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_ml_sch_sth_impact_202305_duplicates m
            JOIN public.v_espen_ml_sch_sth_impact_202304_2_child p ON (p.id = m.id_participant :: int)
        group by p.p_recorder
        UNION
        SELECT
            u.u_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_ml_sch_sth_impact_202305_duplicates m
            JOIN public.v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 u ON u.id = m.id_results_urine :: int
        GROUP BY
            u.u_recorder
    ) src
WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"
ORDER BY "Total Doulons" DESC