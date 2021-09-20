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
 * Variable to rename v_espen_mz_lf_tas1_2_participant_202011_v3, v_espen_mz_lf_tas1_3_resultat_fts_202011_v3, metabase_lf_tas_orphaned_202012
 */

    SELECT
      p.p_cluster_id "Código do site",
      NULL "Nome do site",
      p_code_id "ID do participante",
      p_recorder_id "Código do Operador",
      p_age_yrs "Idade em anos",
      p_sex "Sexo",
      NULL "Resultados de Diagnóstico",
      'Participant data' "Registro ausente",
      p_end "Date",
      status "Status"

    FROM v_espen_mz_lf_tas1_2_participant_202011_v3 p
      LEFT JOIN v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 d on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_tas_orphaned_202012 m on m.id_participant = p.id
      WHERE d.id isnull --and survey_designation ='TAS2'

    UNION ALL

    SELECT
      d_cluster_id "Código do site",
      NULL "Nome do site",
      d_code_id "ID do participante",
      d_recorder_id::int "Código do Operador",
      NULL "Idade em anos",
      NULL "Sexo",
      d_final_result "Resultados de Diagnóstico",
      'FTS results' "Registro ausente",
      d_end "Date",
      status "Status"

    FROM v_espen_mz_lf_tas1_3_resultat_fts_202011_v3 d
      LEFT JOIN v_espen_mz_lf_tas1_2_participant_202011_v3 p on p.p_code_id = d.d_code_id
      LEFT JOIN metabase_lf_tas_orphaned_202012 m on m.id_results = d.id
      WHERE p.id isNULL  --and survey_designation ='TAS2'

