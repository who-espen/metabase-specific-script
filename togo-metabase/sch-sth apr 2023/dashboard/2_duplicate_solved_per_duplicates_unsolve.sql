SELECT
    'Solved' status,
    count(
        CASE
            WHEN status = 'Solved' THEN 1
            ELSE NULL
        END
    ) total
FROM
    metabase_tg_202309_sch_sth_impact_duplicates
UNION
SELECT
    'Unsolved' status,
    count(
        CASE
            WHEN status = 'Unsolved' THEN 1
            ELSE NULL
        END
    ) total
FROM metabase_tg_202309_sch_sth_impact_duplicates