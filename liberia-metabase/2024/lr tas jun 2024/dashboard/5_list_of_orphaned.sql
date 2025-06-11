/*
 * File: 5_list_of_orphaned.sql
 * File Created: Tuesday, 5th May 2020 6:29:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 6:33:56 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename v_espen_lr_lf_tas1_2_child_202406_v1, v_espen_lr_lf_tas1_3_fts_202406, metabase_lr_lf_pre_orphaned_202406
 */

    SELECT
      p.p_cluster_id "Code Site",
      NULL "Site Name",
      p_espen_code_id "ID Participant",
      p_recorder"Operator",
      p_age_yrs "Age",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Status"

    FROM v_espen_lr_lf_tas1_2_child_202406_v1 p
      LEFT JOIN v_espen_lr_lf_tas1_3_fts_202406 d on p.p_espen_code_id = d.d_espen_code_id
      LEFT JOIN metabase_lr_lf_pre_orphaned_202406 m on m.id_participant = p.id
      WHERE d.id isNULL

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Site Name",
      d_espen_code_id "ID Participant",
      d_recorder::int "Operator",
      NULL "Age",
      NULL "Sex",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date",
      status "Status"

    FROM v_espen_lr_lf_tas1_3_fts_202406 d
      LEFT JOIN v_espen_lr_lf_tas1_2_child_202406_v1 p on p.p_espen_code_id = d.d_espen_code_id
      LEFT JOIN metabase_lr_lf_pre_orphaned_202406 m on m.id_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
