/*
 * File: 4_duplicates_solved_per_unsolves.sql
 * File Created: Monday, 11th May 2020 8:30:17 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:41:03 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * A query to get the the number/percentages of duplicates fix by the number/percentages of duplicates unfixed
 * Variable to rename metabase_sch_sth_mapping_duplicates_202107
 */
SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total


FROM metabase_sch_sth_mapping_duplicates_202107

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM metabase_sch_sth_mapping_duplicates_202107
