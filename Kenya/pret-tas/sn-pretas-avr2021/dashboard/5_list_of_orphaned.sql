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
 * Variable to rename v_espen_ke_lf_pretas_2_participant_202203_v4, v_espen_ke_lf_pretas_3_resultat_fts_202203_v4, metabase_lf_pretas_orphaned_202204
 */

    SELECT
      p.p_cluster_id "Code Site",
      NULL "Site Name",
      p_barcode_id "ID Participant",
      p_enumerator "Operator",
      p_age_yrs "Age",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Status"

    FROM v_espen_ke_lf_pretas_2_participant_202203_v4 p
      LEFT JOIN v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 d on p.p_barcode_id = d.d_barcode_id
      LEFT JOIN metabase_lf_pretas_orphaned_202204 m on m.id_participant = p.id
      WHERE d.id isNULL

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Site Name",
      d_barcode_id "ID Participant",
      d_enumerator::int "Operator",
      NULL "Age",
      NULL "Sex",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date",
      status "Status"

    FROM v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 d
      LEFT JOIN v_espen_ke_lf_pretas_2_participant_202203_v4 p on p.p_barcode_id = d.d_barcode_id
      LEFT JOIN metabase_lf_pretas_orphaned_202204 m on m.id_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
