SELECT
    'Solved' status,
    count(
        CASE
            WHEN status = 'Solved' THEN 1
            ELSE NULL
        END
    ) total

FROM metabase_lr_sch_sth_202401_ia_duplicates 

UNION 

SELECT
    'Unsolved' status,
    count(
        CASE
            WHEN status = 'Unsolved' THEN 1
            ELSE NULL
        END
    ) total

FROM metabase_lr_sch_sth_202401_ia_duplicates 