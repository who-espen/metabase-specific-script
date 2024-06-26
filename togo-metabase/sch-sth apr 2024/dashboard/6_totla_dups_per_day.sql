SELECT
    COUNT(*),
    p.p_start:: date
FROM
    public.metabase_tg_202309_sch_sth_impact_duplicates AS m,
    public.v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant:: int = p.id
GROUP BY p.p_start:: DATE
UNION ALL
SELECT
    COUNT(*),
    d.k_start:: date
FROM
    metabase_tg_202309_sch_sth_impact_duplicates AS m,
    public.v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk:: int = d.id
GROUP BY d.k_start:: DATE
UNION ALL
SELECT
    COUNT(*),
    d.u_start:: date
FROM
    metabase_tg_202309_sch_sth_impact_duplicates AS m,
    public.v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine:: int = d.id
GROUP BY d.u_start:: DATE