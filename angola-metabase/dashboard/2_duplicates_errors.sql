/*
 * File: 2_duplicates_errors.sql
 * File Created: Monday, 11th May 2020 8:13:38 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:48 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_sch_sth_mapping_duplicates_2021005, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8,
 * v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8
 */
SELECT
  "Form",
  school_id,
  school_name,
  "Barcode ID",
  "Recorder ID",
  "Age in Years",
  "Sex",
  date,
  "Status"

FROM (
  SELECT
  m.form "Form",
  p.p_school_id school_id,
  p.p_school_name school_name,
  m.barcode_participant "Barcode ID",
  p.p_recorder_id "Recorder ID",
  p.p_age_yrs "Age in Years",
  p.p_sex "Sex",
  p.p_date date,
  status "Status"

FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Form",
  k.k_school_id school_name,
  k.k_school_name school_name,
  m.barcode_results "Barcode ID",
  k.k_recorder_id "Recorder ID",
  null "Age in Years",
  null "Sex",
  k.k_date date,
  status "Status"

FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 AS k
  WHERE k.id = m.id_results_kk

UNION ALL

SELECT
  m.form "Form",
  u.u_school_id school_name,
  u.u_school_name school_name,
  m.barcode_results "Barcode ID",
  u.u_recorder_id "Recorder ID",
  null "Age in Years",
  null "Sex",
  u.u_date date,
  status "Status"

FROM metabase_sch_sth_mapping_duplicates_2021005 AS m, v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 AS k
  WHERE u.id = m.id_results_urine
) src

WHERE "Form" IS NOT NULL
------ Metabase filter -------
-- [[and {{school_id}}]]
-- [[and {{school_name}}]]
-- [[and {{district}}]]
-- [[and {{date}}]]
