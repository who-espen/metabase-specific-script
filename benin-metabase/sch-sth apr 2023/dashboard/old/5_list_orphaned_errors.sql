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
 * Variable to rename v_espen_bj_sch_sth_impact_202304_1_school, v_espen_bj_sch_sth_impact_202304_2_child, metabase_sch_sth_ia_orphaned_202304,
 * v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1, v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1
 */
SELECT

  p.p_school_id "School Id",
  s.w_school_name "Village",
  barcode_participant "Barcode Id",
  p.p_recorder "Opérateur",
  p.p_age_yrs "Age",
  p.p_sex "Sexe",
  orphaned_type "Enregistrement manquant",
  p.p_date "Date"

FROM metabase_sch_sth_ia_orphaned_202304 m
LEFT JOIN v_espen_bj_sch_sth_impact_202304_2_child p ON p.id = m.id_participant
LEFT JOIN v_espen_bj_sch_sth_impact_202304_1_school s ON s.w_school_id = p.p_school_id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

UNION

SELECT

  p.k_school_id "School Id",
  s.w_school_name "Village",
  barcode_participant "Barcode Id",
  p.k_recorder "Opérateur",
  null "Age",
  null "Sexe",
  orphaned_type "Enregistrement manquant",
  null "Date"

FROM metabase_sch_sth_ia_orphaned_202304 m
LEFT JOIN v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1 p ON p.id = m.id_results_kk
LEFT JOIN v_espen_bj_sch_sth_impact_202304_1_school s ON s.w_school_id = p.k_school_id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

UNION

SELECT

  p.u_school_id "School Id",
  s.w_school_name "Village",
  barcode_participant "Barcode Id",
  p.u_recorder "Opérateur",
  null "Age",
  null "Sexe",
  orphaned_type "Enregistrement manquant",
  null "Date"

FROM metabase_sch_sth_ia_orphaned_202304 m
LEFT JOINv_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 p ON p.id = m.id_results_kk
LEFT JOIN v_espen_bj_sch_sth_impact_202304_1_school s ON s.w_school_id = p.u_school_id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
