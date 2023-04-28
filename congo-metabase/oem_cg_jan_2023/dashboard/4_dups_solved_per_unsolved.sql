/*
 * File: 4_dups_solved_per_unsolved.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:17:46 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * A query to get the the number/percentages of duplicates fix by the number/percentages of duplicates unfixed
 * Variable to rename metabase_oncho_cg_oem_202304_duplicates
 */
SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total


FROM metabase_oncho_cg_oem_202304_duplicates

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM metabase_oncho_cg_oem_202304_duplicates
