SELECT
    COUNT(*),
    p.p_start:: date
FROM
    public.metabase_tz_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_202311_2_child_v4 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant:: int = p.id

GROUP BY p.p_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.k_start:: date
FROM
    metabase_tz_sch_sth_202401_ia_duplicates AS m,
    public.v_espen_tz_sch_sth_impact_202311_3_kk_v4 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk:: int = d.id

GROUP BY d.k_start::DATE 
