
    SELECT
      p.p_site_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder "Code Opérateur",
      p_age_yrs "Age en années",
      p_sex "Sexe",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      d_date "Date"

    FROM v_espen_ci_lf_pretas_2406_3_part_v4 p
      LEFT JOIN v_espen_ci_lf_pretas_2406_4_fts_v4 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_ci_lf_2406_ems_orphaned m on m.id_participant = p.id
      WHERE d.id isNULL


    UNION ALL

    SELECT
      d_site_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder::int "Code Opérateur",
      NULL "Age en années",
      NULL "Sexe",
      d_result1 "Diagnostic Results",
      'FTS results' "Missing Record",
      d_date "Date"

    FROM v_espen_ci_lf_pretas_2406_4_fts_v4 d
      LEFT JOIN v_espen_ci_lf_pretas_2406_3_part_v4 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_ci_lf_2406_ems_orphaned m on m.id_results_fts = d.id
      WHERE p.id isNULL

