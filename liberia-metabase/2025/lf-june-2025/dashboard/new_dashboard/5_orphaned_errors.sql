
 
 select
  
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder "Recorder ID",
      p_age_yrs "Age (yrs)",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Record",
      p_start "Date"

    FROM v_espen_lr_lf_pretas_2_child_202506 p
    where (select count(*) from v_espen_lr_lf_pretas_2_child_202506 k where p.p_code_id = k.p_code_id) > 1

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
      'FTS results' "Record",
      d_start "Date"

    FROM public.v_espen_lr_lf_pretas_3_results_fts_mf_202506 d
    where (select count(*) from v_espen_lr_lf_pretas_3_results_fts_mf_202506 r where d.d_code_id = r.d_code_id) > 1