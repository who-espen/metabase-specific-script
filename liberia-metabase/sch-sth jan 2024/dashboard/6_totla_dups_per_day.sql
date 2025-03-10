SELECT
    COUNT(*),
    p.p_start:: date
FROM
    public.metabase_lr_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant:: int = p.id

GROUP BY p.p_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.k_start:: date
FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk:: int = d.id

GROUP BY d.k_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.u_start:: date
FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_lr_sch_sth_impact_202401_4_urine_v2_1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine :: int = d.id

GROUP BY d.u_start::DATE 



