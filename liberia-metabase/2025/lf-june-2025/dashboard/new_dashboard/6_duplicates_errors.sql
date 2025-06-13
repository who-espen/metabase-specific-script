SELECT
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder "Recorder ID",
      p_age_yrs "Age (yrs)",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p.p_start "Date"

    FROM v_espen_lr_lf_pretas_2_child_202506 p
      LEFT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d on p.p_code_id = d.d_code_id
      WHERE d.id isNULL 

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder "Recorder ID",
      NULL "Age (yrs)",
      NULL "Sex",
      CASE WHEN d_fts_result1= 'Positive' AND d_fts_result2 = 'Positive' THEN 'Positive'
      WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Negative' THEN 'Negative'
      WHEN d_fts_result1 = 'Positive' AND d_fts_result2 = 'Invalid' THEN 'Positive'
      WHEN d_fts_result1 = 'Invalid' AND d_fts_result2 = 'Invalid' THEN 'Indeterminate'
      WHEN d_fts_result1 = 'Invalid' AND d_fts_result2 = 'Negative' THEN 'Negative'
      ELSE 'Negative' END AS "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date"

FROM public.v_espen_lr_lf_pretas_3_results_fts_mf_202506 d
      LEFT JOIN v_espen_lr_lf_pretas_2_child_202506 p on p.p_code_id = d.d_code_id
      WHERE p.id isNULL
