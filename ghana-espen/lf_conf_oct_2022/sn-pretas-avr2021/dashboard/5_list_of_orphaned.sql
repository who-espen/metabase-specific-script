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
 * Variable to rename v_espen_gn_lf_pretas_1_site_participant_202210, v_espen_gn_lf_pretas_2_resultat_fts_202210_fts, metabase_gn_lf_pretas_orphaned_202209
 */

    SELECT
      p.c_cluster_id "Code Site",
      NULL "Site Name",
      p_code_id "ID Participant",
      c_recorder "Operator",
      p_age_yrs "Age",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Status"

    FROM v_espen_gn_lf_pretas_1_site_participant_202210 p
      LEFT JOIN v_espen_gn_lf_pretas_2_resultat_fts_202210_fts d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_gn_lf_pretas_orphaned_202209 m on m.id_participant = p.id
      WHERE d.id isNULL

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Site Name",
      d_code_id "ID Participant",
      d_recorder_id::int "Operator",
      NULL "Age",
      NULL "Sex",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date",
      status "Status"

    FROM v_espen_gn_lf_pretas_2_resultat_fts_202210_fts d
      LEFT JOIN v_espen_gn_lf_pretas_1_site_participant_202210 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_gn_lf_pretas_orphaned_202209 m on m.id_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
