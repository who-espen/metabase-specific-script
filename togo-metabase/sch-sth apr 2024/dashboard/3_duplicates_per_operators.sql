SELECT
    "Opérateurs",
    sum("Total Doulons") "Total Doulons"
FROM (
        SELECT
            k.k_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates m
            JOIN public.v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 k ON k.id = m.id_results_kk:: int
        GROUP BY k.k_recorder
        UNION
        SELECT
            p.p_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates m
            JOIN public.v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p ON (p.id = m.id_participant:: int)
        group by p.p_recorder
        UNION
        SELECT
            u.u_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_tg_202309_sch_sth_impact_duplicates m
            JOIN public.v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 u ON u.id = m.id_results_urine:: int
        GROUP BY
            u.u_recorder
    ) src
WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"
ORDER BY "Total Doulons" DESC