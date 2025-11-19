SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total


FROM metabase_sppa_mapping_duplicates_2511

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM metabase_sppa_mapping_duplicates_2511