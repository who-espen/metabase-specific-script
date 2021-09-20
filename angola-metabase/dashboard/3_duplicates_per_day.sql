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
 * Variable to rename metabase_sch_sth_mapping_duplicates_2021005, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8,
 * v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8
 */
 SELECT
 COUNT(barcode_participant),
 p.p_date::date
FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 AS p
WHERE m.id IS NOT NULL AND m.id_participant = p.id

GROUP BY p.p_date::DATE

UNION ALL

SELECT
 COUNT(barcode_results_kk),
 d.k_date::date
FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 AS d
WHERE m.id IS NOT NULL AND m.id_results_kk = d.id

GROUP BY d.k_date::DATE

UNION ALL

SELECT
 COUNT(barcode_results_urine),
 d.u_date::date
FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 AS d
WHERE m.id IS NOT NULL AND m.id_results_urine = d.id

GROUP BY d.u_date::DATE


UNION

SELECT
 COUNT(barcode_results_cca),
 d.h_date::date
FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, public.v_espen_ao_sch_sth_baseline_5_hemastix_cca_202105_v5_8 AS d
WHERE m.id IS NOT NULL AND m.id_results_urine = d.id

GROUP BY d.h_date::DATE