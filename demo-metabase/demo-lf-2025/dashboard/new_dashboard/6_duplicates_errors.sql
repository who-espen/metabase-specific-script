

    SELECT
      p.c_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      c_recorder "Recorder ID",
      p_age_yrs "Age (yrs)",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      c_start "Date"

    FROM v_espen_demo_lf_tas_9999_2_part_v2 p
      LEFT JOIN v_espen_demo_lf_tas_202404_3_fts_ben_oy_v2 d on p.p_code_id = d.d_code_id
      WHERE d.id isNULL --and p_start > '2020-09-25'

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder "Recorder ID",
      NULL "Age (yrs)",
      NULL "Sex",
      d_final_result "Diagnostic Results",
      'FTS results' "Missing Record",
      d_start "Date"

    FROM public.v_espen_demo_lf_tas_9999_3_fts_v2 d
      LEFT JOIN v_espen_demo_lf_tas_9999_2_part_v2 p on p.p_code_id = d.d_code_id
      WHERE p.id isNULL --and p_start > '2020-09-25'
