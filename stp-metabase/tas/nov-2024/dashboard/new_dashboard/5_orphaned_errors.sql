
 
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

    FROM v_espen_st_lf_tas2_2412_2_partcipants_v2 p
    where (select count(*) from v_espen_st_lf_tas2_2412_2_partcipants_v2 k where p.p_code_id = k.p_code_id) > 1

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder "Recorder ID",
      NULL "Age (yrs)",
      NULL "Sex",
      d_result1 "Diagnostic Results",
      'FTS results' "Record",
      d_start "Date"

    FROM public.v_espen_st_lf_tas2_2412_3_fts_result_v2 d
    where (select count(*) from v_espen_st_lf_tas2_2412_3_fts_result_v2 r where d.d_code_id = r.d_code_id) > 1