SELECT
    COUNT(*),
    p.p_start:: date
FROM
    public.metabase_bf_sch_sth_mapping_duplicates_202403 AS m,
    public.v_espen_bf_202403_sch_ia_2_enrolement AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant:: int = p.id
GROUP BY p.p_start:: DATE
UNION ALL
SELECT
    COUNT(*),
    d.d_start:: date
FROM
    metabase_bf_sch_sth_mapping_duplicates_202403 AS m,
    public.v_espen_bf_202403_sch_ia_3_resultat_selles AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk:: int = d.id
GROUP BY d.d_start:: DATE
UNION ALL
SELECT
    COUNT(*),
    d.u_start:: date
FROM
    metabase_bf_sch_sth_mapping_duplicates_202403 AS m,
    public.v_espen_bf_202403_sch_ia_4_resultat_urines AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine:: int = d.id
GROUP BY d.u_start:: DATE