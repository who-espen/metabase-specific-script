SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total


FROM metabase_bf_202301_sch_sth_mapping_duplicates_202304

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM metabase_bf_202301_sch_sth_mapping_duplicates_202304