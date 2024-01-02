/*
 * File: 6_orphaned_solved_by_unsolved.sql
 * File Created: Tuesday, 12th May 2020 1:32:57 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:33:59 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to get number of orphaned errors solved by the number of orphaned records unsolved
 * Variable to rename metabase_tg_202309_sch_sth_impact_orphaned
 */

SELECT
    'Solved' status,
    count(
        CASE
            WHEN status = 'Solved' THEN 1
            ELSE NULL
        END
    ) total
FROM
    metabase_tg_202309_sch_sth_impact_orphaned
UNION
SELECT
    'Unsolved' status,
    count(
        CASE
            WHEN status = 'Unsolved' THEN 1
            ELSE NULL
        END
    ) total
FROM metabase_tg_202309_sch_sth_impact_orphaned