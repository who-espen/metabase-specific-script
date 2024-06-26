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
 * Variable to rename metabase_sn_lf_itas_20405_orphaned
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
    metabase_sn_lf_itas_20405_orphaned
UNION
SELECT
    'Unsolved' status,
    count(
        CASE
            WHEN status = 'Unsolved' THEN 1
            ELSE NULL
        END
    ) total
FROM metabase_sn_lf_itas_20405_orphaned