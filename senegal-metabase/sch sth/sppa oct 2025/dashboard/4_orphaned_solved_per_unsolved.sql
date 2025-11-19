SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total

FROM public.metabase_sch_sth_ia_orphaned_202304

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM public.metabase_sch_sth_ia_orphaned_202304