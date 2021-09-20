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
 * Variable to rename metabase_sch_sth_mapping_duplicates_202107, v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2, v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1,
 * v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca
 */
 SELECT
 COUNT(barcode_participant),
 p.p_start::date
FROM metabase_sch_sth_mapping_duplicates_202107 AS m, v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.p_start::date
FROM metabase_sch_sth_mapping_duplicates_202107 AS m, v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2 AS d
WHERE m.id IS NOT NULL AND m.id_results_kk = d.id

GROUP BY d.d_start::DATE

UNION ALL

SELECT
 COUNT(barcode_results),
 d.p_start::date
FROM metabase_sch_sth_mapping_duplicates_202107 AS m, v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca AS d
WHERE m.id IS NOT NULL AND m.id_results_urine = d.id

GROUP BY d.d_start::DATE
