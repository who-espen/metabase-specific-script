SELECT
    "Opérateurs",
    sum("Total Doulons") "Total Doulons"
FROM (
        SELECT
            k.d_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_bf_202301_sch_sth_mapping_duplicates_202304 m
            JOIN public.v_espen_bf_202305_sch_impact_assessment_3_resultat_selles k ON k.id = m.id_results_kk:: int
        GROUP BY k.d_recorder
        UNION
        SELECT
            p.p_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_bf_202301_sch_sth_mapping_duplicates_202304 m
            JOIN public.v_espen_bf_202305_sch_impact_assessment_2_enrolement_v1_1 p ON (p.id = m.id_participant:: int)
        group by p.p_recorder
        UNION
        SELECT
            u.u_recorder "Opérateurs",
            count(m.id) "Total Doulons"
        FROM
            public.metabase_bf_202301_sch_sth_mapping_duplicates_202304 m
            JOIN public.v_espen_bf_202305_sch_impact_assessment_4_resultat_urines_v1_1 u ON u.id = m.id_results_urine:: int
        GROUP BY
            u.u_recorder
    ) src
WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"
ORDER BY "Total Doulons" DESC