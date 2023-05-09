SELECT
    COUNT(*),
    p.p_start :: date
FROM
    public.metabase_ml_sch_sth_impact_202305_duplicates AS m,
    public.v_espen_ml_sch_sth_impact_202304_2_child AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant :: int = p.id
GROUP BY p.p_start :: DATE
UNION ALL
SELECT
    COUNT(*),
    d.k_start :: date
FROM
    metabase_ml_sch_sth_impact_202305_duplicates AS m,
    public.v_espen_ml_sch_sth_impact_202304_3_kato_katz AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk :: int = d.id
GROUP BY d.k_start :: DATE
UNION ALL
SELECT
    COUNT(*),
    d.u_start :: date
FROM
    metabase_ml_sch_sth_impact_202305_duplicates AS m,
    public.v_espen_ml_sch_sth_impact_202304_4_hemastix_v2 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine :: int = d.id
GROUP BY d.u_start :: DATE