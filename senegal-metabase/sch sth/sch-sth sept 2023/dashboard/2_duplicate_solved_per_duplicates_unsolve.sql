SELECT
    'Solved' status,
    count(
        CASE
            WHEN status = 'Solved' THEN 1
            ELSE NULL
        END
    ) total

FROM metabase_sn_sch_sth_202309_mapping_duplicates 

UNION 

SELECT
    'Unsolved' status,
    count(
        CASE
            WHEN status = 'Unsolved' THEN 1
            ELSE NULL
        END
    ) total

FROM metabase_sn_sch_sth_202309_mapping_duplicates 