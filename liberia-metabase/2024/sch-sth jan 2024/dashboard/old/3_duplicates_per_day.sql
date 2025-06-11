/*
 * File: 3_duplicates_per_day.sql
 * File Created: Monday, 11th May 2020 8:26:28 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:56 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the total records of duplicates per day
 * Variable to rename metabase_lr_sch_sth_202401_ia_duplicates, v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1, v_espen_lr_sch_sth_impact_202401_2_child_v2_1,
 * v_espen_lr_sch_sth_impact_202401_4_urine_v2_1
 */

SELECT
    COUNT(*),
    p.p_start:: date
FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 AS p
WHERE
    m.id IS NOT NULL
    AND m.id_participant = p.id

GROUP BY p.p_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.r_start:: date
FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_kk = d.id

GROUP BY d.r_start::DATE 

UNION ALL 

SELECT
    COUNT(*),
    d.u_start:: date
FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    v_espen_lr_sch_sth_impact_202401_4_urine_v2_1 AS d
WHERE
    m.id IS NOT NULL
    AND m.id_results_urine = d.id

GROUP BY d.u_start::DATE 