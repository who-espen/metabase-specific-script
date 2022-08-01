
/*
 * File: 4_duplicates_solved_per_unsolved.sql
 * File Created: Tuesday, 5th May 2020 5:13:19 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 5:15:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to get the the number/percentages of duplicates fix by the number/percentages of duplicates unfixed
 * Variable to rename metabase_lf_pretas_duplicates_202009
 */
SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total


FROM metabase_lf_pretas_duplicates_202009

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM metabase_lf_pretas_duplicates_202009
