
 
 select
  
      p.c_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      c_recorder "Recorder ID",
      p_age_yrs "Age (yrs)",
      p_sex "Sex",
      NULL "Diagnostic Results",
      'Participant data' "Record",
      c_start "Date"

    FROM v_espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23 p
    where (select count(*) from v_espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23 k where p.p_code_id = k.p_code_id) > 1

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_code_id "ID Participant",
      d_recorder "Recorder ID",
      NULL "Age (yrs)",
      NULL "Sex",
      d_final_result "Diagnostic Results",
      'FTS results' "Record",
      d_start "Date"

    FROM public.v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 d
    where (select count(*) from v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 r where d.d_code_id = r.d_code_id) > 1