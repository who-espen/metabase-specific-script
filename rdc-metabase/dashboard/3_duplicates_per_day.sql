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
 * Variable to rename metabase_sch_sth_mapping_duplicates_202204, v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1, v_espen_cd_sch_sth_baseline_2_child_202202_v2_1,
 * v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1
 */
 SELECT
 COUNT(*),
 p.p_start::date
FROM metabase_sch_sth_mapping_duplicates_202204 AS m, v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 AS p
WHERE m.id IS NOT NULL AND m.id_participant::int = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(*),
 d.k_start::date
FROM metabase_sch_sth_mapping_duplicates_202204 AS m, v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 AS d
WHERE m.id IS NOT NULL AND m.id_results_kk::int = d.id

GROUP BY d.k_start::DATE

UNION ALL

SELECT
 COUNT(*),
 d.u_start::date
FROM metabase_sch_sth_mapping_duplicates_202204 AS m, v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 AS d
WHERE m.id IS NOT NULL AND m.id_results_urine::int = d.id

GROUP BY d.u_start::DATE
