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
 * Variable to rename v_espen_ci_lf_pretas_2_participant_202204_v1, v_espen_ci_lf_pretas_3_resultat_fts_202204_v1, metabase_lf_pretas_orphaned_202204
 */

    SELECT
      p.p_site_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder_id "Code Opérateur",
      p_age_yrs "Age en années",
      p_sex "Sexe",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Statut"

    FROM v_espen_ci_lf_pretas_2_participant_202204_v1 p
      LEFT JOIN v_espen_ci_lf_pretas_3_resultat_fts_202204_v1 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_pretas_orphaned_202204 m on m.id_participant = p.id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

    UNION ALL

    SELECT
      d_site_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder_id::int "Code Opérateur",
      NULL "Age en années",
      NULL "Sexe",
      d_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date",
      status "Statut"

    FROM v_espen_ci_lf_pretas_3_resultat_fts_202204_v1 d
      LEFT JOIN v_espen_ci_lf_pretas_2_participant_202204_v1 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_pretas_orphaned_202204 m on m.id_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
