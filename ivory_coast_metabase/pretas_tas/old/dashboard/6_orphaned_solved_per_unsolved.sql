/*
 * File: 6_orphaned_solved_per_unsolved.sql
 * File Created: Tuesday, 5th May 2020 6:33:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 6:35:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to get number of orphaned errors solved by the number of orphaned records unsolved
 * Variable to rename metabase_lf_pretas_orphaned_202008
 */
SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total

FROM metabase_lf_pretas_orphaned_202008

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM metabase_lf_pretas_orphaned_202008
