/*
 * File: 6_orph_solved_by_unsolved.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:18:09 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * A query to get number of orphaned errors solved by the number of orphaned records unsolved
 * Variable to rename <%metabase_oncho_oem_orphaned_202004%>
 */
SELECT
    'Solved' status,
	count(CASE WHEN status = 'Solved' THEN 1 ELSE NULL END) total


FROM <%metabase_oncho_oem_orphaned_202004%>

UNION

SELECT
    'Unsolved' status,
	count(CASE WHEN status = 'Unsolved' THEN 1 ELSE NULL END) total

FROM <%metabase_oncho_oem_orphaned_202004%>
