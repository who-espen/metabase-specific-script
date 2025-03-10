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
 * Variable to rename v_espen_gw_lf_tas1_202402_3_fts_result_v2
, v_espen_gw_lf_tas1_202402_3_fts_result_v2
, metabase_lf_tas1_orphaned_20402
 */

    SELECT
      p.p_cluster_id "Código do sítio",
      NULL "Nom du Site",
      p_code_id "ID Participante",
      p_recorder_id "Código Opérateur",
      p_age_yrs "Idade em anos",
      p_sex "Género",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Estado"

    FROM v_espen_gw_lf_tas1_202402_3_fts_result_v2
 p
      LEFT JOIN v_espen_gw_lf_tas1_202402_3_fts_result_v2
 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_tas1_orphaned_20402 m on m.id_participant = p.id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

    UNION ALL

    SELECT
      d_cluster_id "Código do sítio",
      NULL "Nom du Site",
      d_code_id "ID Participante",
      d_recorder_id::int "Código Opérateur",
      NULL "Idade em anos",
      NULL "Género",
      d_result1 "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date",
      status "Estado"

    FROM v_espen_gw_lf_tas1_202402_3_fts_result_v2
 d
      LEFT JOIN v_espen_gw_lf_tas1_202402_3_fts_result_v2
 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_tas1_orphaned_20402 m on m.id_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
