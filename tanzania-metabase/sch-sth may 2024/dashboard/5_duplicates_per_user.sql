SELECT
    COUNT(*),
    p.p_start:: date
FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_2405_2_child AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant:: int = p.id

GROUP BY p.p_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.r_start:: date
FROM
    metabase_tz_sch_sth_202405_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_2405_3_kato_katz AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk:: int = d.id

GROUP BY d.r_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.u_start:: date
FROM
    metabase_tz_sch_sth_202405_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_2405_4_urine_filtration AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine:: int = d.id

GROUP BY d.u_start::DATE 