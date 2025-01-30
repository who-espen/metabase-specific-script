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
 * Variable to rename v_espen_ng_lf_pretas_202404_2_participant_v2, v_espen_ng_lf_pretas_202404_3_fts_v2, metabase_ng_lf_pretas_orphaned_202404
 */

    SELECT
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder_id "Recorder ID",
      p_age_yrs "Age (yrs)",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Status"

    FROM v_espen_ng_lf_pretas_202404_2_participant_v2 p
      LEFT JOIN v_espen_ng_lf_pretas_202404_3_fts_v2 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_ng_lf_pretas_orphaned_202404 m on m.id_participant = p.id
      WHERE d.id isNULL --and p_start > '2020-09-25'


    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder_id::int "Recorder ID",
      NULL "Age (yrs)",
      NULL "Sex",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date",
      status "Status"

    FROM v_espen_ng_lf_pretas_202404_3_fts_v2 d
      LEFT JOIN v_espen_ng_lf_pretas_202404_2_participant_v2 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_ng_lf_pretas_orphaned_202404 m on m.id_results = d.id
      WHERE p.id isNULL --and p_start > '2020-09-25'
