SELECT
    "Opérateurs",
    sum("Total Doulons") "Total Doulons"
FROM (
        SELECT
            k.k_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates m
            JOIN public.v_espen_tg_sch_sth_impact_202309_3_kato_katz_v2 k ON k.id = m.id_results_kk:: int
        GROUP BY k.k_recorder
        UNION
        SELECT
            p.p_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates m
            JOIN public.v_espen_tg_sch_sth_impact_202309_2_child_v2 p ON (p.id = m.id_participant:: int)
        group by p.p_recorder
        UNION
        SELECT
            u.u_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates m
            JOIN public.v_espen_tg_sch_sth_impact_202309_4_urine_filtration_v2_1 u ON u.id = m.id_results_urine:: int
        GROUP BY
            u.u_recorder
    ) src
WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"
ORDER BY "Total Doulons" DESC