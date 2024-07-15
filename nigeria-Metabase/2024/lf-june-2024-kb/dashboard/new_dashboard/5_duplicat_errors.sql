

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

    FROM v_espen_ng_lf_tas_2406_1_sit_part_kb_v31 p
      LEFT JOIN v_espen_ng_lf_tas_2406_2_fts_kb_v31 d on p.p_code_id = d.d_code_id
      WHERE d_code_id isNULL 

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

    FROM public.v_espen_ng_lf_tas_2406_2_fts_kb_v31 d
      LEFT JOIN v_espen_ng_lf_tas_2406_1_sit_part_kb_v31 p on p.p_code_id = d.d_code_id
      WHERE p_code_id isNULL
