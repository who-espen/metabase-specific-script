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
 * Variable to rename v_espen_bj_lf_retas1_2_partcipants_202104_v3, v_espen_bj_lf_retas1_3_fts_result_202104_v3, metabase_lf_retas1_orphaned_202105_2
 */

    SELECT
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_code_id "ID Participant",
      p_recorder_id "Code Opérateur",
      p_age_yrs "Age en années",
      p_sex "Sexe",
      NULL "Diagnostic Results",
      'Participant data' "Missing Record",
      p_start "Date",
      status "Statut"

    FROM v_espen_bj_lf_retas1_2_partcipants_202104_v3 p
      LEFT JOIN v_espen_bj_lf_retas1_3_fts_result_202104_v3 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_retas1_orphaned_202105_2 m on m.id_participant = p.id
      WHERE d.id isnull and survey_designation ='TAS2'

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
      d_start "Date",
      status "Statut"

    FROM v_espen_bj_lf_retas1_3_fts_result_202104_v3 d
      LEFT JOIN v_espen_bj_lf_retas1_2_partcipants_202104_v3 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_retas1_orphaned_202105_2 m on m.id_results = d.id
      WHERE p.id isNULL  and survey_designation ='TAS2'

