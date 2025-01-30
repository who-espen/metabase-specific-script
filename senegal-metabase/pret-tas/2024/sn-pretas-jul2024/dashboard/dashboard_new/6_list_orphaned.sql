
    SELECT
      p.c_cluster_id "Code Site",
      NULL "Nom du Site",
      p.p_code_id "ID Participant",
      p.c_recorder "Code Opérateur",
      p.p_age_yrs "Age en années",
      p.p_sex "Sexe",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p.c_start "Date"

    FROM v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
      LEFT JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_sn_lf_2407_pretas_orphaned m on m.id_participant = p.id
      WHERE d.id isNULL


    UNION ALL

    SELECT
      d.d_cluster_id "Code Site",
      NULL "Nom du Site",
      d.d_code_id "ID Participant",
      d.d_recorder_id::int "Code Opérateur",
      NULL "Age en années",
      NULL "Sexe",
      d.d_result1 "Diagnostic Results",
      'FTS results' "Missing Record",
      d.d_start "Date"

    FROM v_espen_sn_lf_pretas_20407_2_fts_v3 d
      LEFT JOIN v_espen_sn_lf_pretas_2407_1_sit_part_v3 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_sn_lf_2407_pretas_orphaned m on m.id_results_fts = d.id
      WHERE p.id isNULL

