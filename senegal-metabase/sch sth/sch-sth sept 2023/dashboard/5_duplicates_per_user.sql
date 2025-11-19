SELECT
    COUNT(*),
    p.p_start:: date
FROM
    public.metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    public.v_espen_sn_sch_sth_impact_2_child_202308_v3_2 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant:: int = p.id

GROUP BY p.p_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.r_start:: date
FROM
    metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    public.v_espen_sn_sch_sth_impact_3_resultats_202308_v3 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_diag_kk_urine:: int = d.id

GROUP BY d.r_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.u_start:: date
FROM
    metabase_sn_sch_sth_202309_mapping_duplicates AS m,
    public.v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine:: int = d.id

GROUP BY d.u_start::DATE 