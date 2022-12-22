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
 * Variable to rename espen_mz_lf_pretas_2_participant_202209_v1, v_espen_mz_lf_pretas_3_resultat_fts_202209_v1, metabase_mz_lf_pretas_orphaned_202212
 */

    SELECT
      p.p_cluster_id "Código do site",
      NULL "Nome do site",
      p_barcode_id1 "ID do participante",
      p_recorder_id "Código do Operador",
      p_age_yrs "Idade em anos",
      p_sex "Sexo",
      NULL "Resultados de Diagnóstico",
      'Participant data' "Registro ausente",
      p_start "Date",
      status "Status"

    FROM espen_mz_lf_pretas_2_participant_202209_v1 p
      LEFT JOIN v_espen_mz_lf_pretas_3_resultat_fts_202209_v1 d on p.p_barcode_id1 = d.d_barcode_id
      LEFT JOIN metabase_mz_lf_pretas_orphaned_202212 m on m.id_participant = p.id
      WHERE d.id isnull --and survey_designation ='TAS2'

    UNION ALL

    SELECT
      d_cluster_id "Código do site",
      NULL "Nome do site",
      d_barcode_id "ID do participante",
      d_recorder_id "Código do Operador",
      NULL "Idade em anos",
      NULL "Sexo",
      d_final_result "Resultados de Diagnóstico",
      'FTS results' "Registro ausente",
      d_start "Date",
      status "Status"

    FROM v_espen_mz_lf_pretas_3_resultat_fts_202209_v1 d
      LEFT JOIN espen_mz_lf_pretas_2_participant_202209_v1 p on p.p_barcode_id1 = d.d_barcode_id
      LEFT JOIN metabase_mz_lf_pretas_orphaned_202212 m on m.id_results = d.id
      WHERE p.id isNULL  --and survey_designation ='TAS2'

