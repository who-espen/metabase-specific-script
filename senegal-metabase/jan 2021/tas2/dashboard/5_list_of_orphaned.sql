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
 * Variable to rename v_espen_sn_lf_tas2_2_partcipants_202101, v_espen_sn_lf_tas2_3_fts_result_202101, metabase_lf_pretas_orphaned_202101_tas2
 */

    SELECT
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_barcode_id "ID Participant",
      p_recorder_id "Code Opérateur",
      p_age_yrs "Age en années",
      p_sex "Sexe",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_date "Date",
      status "Statut"

    FROM v_espen_sn_lf_tas2_2_partcipants_202101 p
      LEFT JOIN v_espen_sn_lf_tas2_3_fts_result_202101 d on p.p_barcode_id = d.d_barcode_id
      LEFT JOIN metabase_lf_pretas_orphaned_202101_tas2 m on m.id_participant = p.id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_barcode_id "ID Participant",
      d_recorder_id::int "Code Opérateur",
      NULL "Age en années",
      NULL "Sexe",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_date "Date",
      status "Statut"

    FROM v_espen_sn_lf_tas2_3_fts_result_202101 d
      LEFT JOIN v_espen_sn_lf_tas2_2_partcipants_202101 p on p.p_barcode_id = d.d_barcode_id
      LEFT JOIN metabase_lf_pretas_orphaned_202101_tas2 m on m.id_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
