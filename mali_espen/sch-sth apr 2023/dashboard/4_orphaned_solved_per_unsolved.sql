SELECT
    'Solved' status,
    count(
        CASE
            WHEN status = 'Solved' THEN 1
            ELSE NULL
        END
    ) total
FROM
    public.metabase_ml_sch_sth_impact_202305_orphaned
UNION
SELECT
    'Unsolved' status,
    count(
        CASE
            WHEN status = 'Unsolved' THEN 1
            ELSE NULL
        END
    ) total
FROM public.metabase_ml_sch_sth_impact_202305_orphaned