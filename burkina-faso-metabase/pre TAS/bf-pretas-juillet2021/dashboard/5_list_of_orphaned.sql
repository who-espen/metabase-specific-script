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
 * Variable to rename v_espen_bf_lf_pretas_2_enrolement_202106_v2_2, v_espen_bf_lf_pretas_3_resultat_202106_v2_1, metabase_lf_pretas_orphaned_202106
 */

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
 * Variable to rename v_espen_bf_lf_pretas_2_enrolement_202106_v2_2, v_espen_bf_lf_pretas_3_resultat_202106_v2_1, metabase_lf_pretas_orphaned_202106
 */

    SELECT
      p.p_cluster_id "Code Site",
      NULL "Nom du Site",
      p_barcode_id "ID Participant",
      p_recorder_id "Code Opérateur",
      p_age_yrs "Age en années",
      p_sex "Sexe",
      NULL "Diagnostic Results 1",
      NULL "Diagnostic Results 2",
      'Participant data' "Missing Record",
      p_start "Date",
      m.status "Statut"

    FROM v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 p
      LEFT JOIN v_espen_bf_lf_pretas_3_resultat_202106_v2_1 d on p.p_barcode_id = d.d_barcode_id
      LEFT JOIN metabase_lf_pretas_orphaned_202106 m on m.id_participant = p.id
      WHERE d.id isNULL 

    UNION ALL

    SELECT
      d_cluster_id "Code Site",
      NULL "Nom du Site",
      d_barcode_id "ID Participant",
      d_recorder_id "Code Opérateur",
      NULL "Age en années",
      NULL "Sexe",
      d_result1 "Diagnostic Results 1",
      d_result2  "Diagnostic Results 2",
      'FTS results' "Missing Record",
      d_start "Date",
      m.status "Statut"

    FROM v_espen_bf_lf_pretas_3_resultat_202106_v2_1 d
      LEFT JOIN v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 p on p.p_barcode_id = d.d_barcode_id
      LEFT JOIN metabase_lf_pretas_orphaned_202106 m on m.id_results = d.id
      WHERE p.id isNULL


