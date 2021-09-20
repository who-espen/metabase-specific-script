/*
 * File: 5_list_orphaned_errors.sql
 * File Created: Tuesday, 12th May 2020 11:24:00 am
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 1:33:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to get will list all orphaned records found
 * Variable to rename v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1, metabase_sch_sth_ao_ias_orphaned_202107,
 * v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2, v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca
 */
SELECT

  p.p_school_id "School Id",
  s.w_school_name "School Name",
  barcode_participant "Barcode Id",
  p.p_recorder_id "Recorder Id",
  p.p_age_yrs "Age",
  p.p_sex "Sex",
  orphaned_type "Missing records",
  p.p_date "Date"

FROM metabase_sch_sth_ao_ias_orphaned_202107 m
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1 p ON p.id = m.id_participant
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 s ON s.w_school_id = p.p_school_id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

UNION

SELECT

  p.k_school_id "School Id",
  s.w_school_name "School Name",
  barcode_participant "Barcode Id",
  p.k_recorder_id "Recorder Id",
  null "Age",
  null "Sex",
  orphaned_type "Missing records",
  null "Date"

FROM metabase_sch_sth_ao_ias_orphaned_202107 m
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2 p ON p.id = m.id_results_kk
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 s ON s.w_school_id = p.k_school_id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

UNION

SELECT

  p.u_school_id "School Id",
  s.w_school_name "School Name",
  barcode_participant "Barcode Id",
  p.u_recorder_id "Recorder Id",
  null "Age",
  null "Sex",
  orphaned_type "Missing records",
  null "Date"

FROM metabase_sch_sth_ao_ias_orphaned_202107 m
LEFT JOINv_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca p ON p.id = m.id_results_kk
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 s ON s.w_school_id = p.u_school_id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
