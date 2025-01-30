
    SELECT
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder_id"Code Opérateur",
      p_age_yrs "Age en années",
      p_sex "Sexe",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      d_start "Date"

    FROM v_espen_ci_lf_tas1_2409_2_partcipants p
      LEFT JOIN v_espen_ci_lf_tas1_2409_3_fts_result d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_ci_lf_2406_ems_orphaned m on m.id_participant = p.id
      WHERE d.id isNULL


    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder_id::int "Code Opérateur",
      NULL "Age en années",
      NULL "Sexe",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date"

    FROM v_espen_ci_lf_tas1_2409_3_fts_result d
      LEFT JOIN v_espen_ci_lf_tas1_2409_2_partcipants p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_ci_lf_2406_ems_orphaned m on m.id_results_fts = d.id
      WHERE p.id isNULL

