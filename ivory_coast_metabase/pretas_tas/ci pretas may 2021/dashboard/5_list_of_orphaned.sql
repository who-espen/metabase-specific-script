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
 * Variable to rename v_espen_ci_pretas_lf_enrollement_v7, v_espen_ci_pretas_lf_resultats_v7, metabase_lf_pretas_orphaned_202008
 */

    SELECT
      p.code_site "Code Site",
      p.site "Site",
      p.code_id "Code ID",
      p.code_operateur "Code Operateur",
      p.age "Age In Years",
      p.sexe "Sexe",
      NULL "Résultats FTS",
      'Enrollé' "Enregistrement Manquant",
      p.date_end "Date",
      status "Statut"

    FROM v_espen_ci_pretas_lf_enrollement_v7 p
      LEFT JOIN v_espen_ci_pretas_lf_resultats_v7 d on p.code_id = d.code_id
      LEFT JOIN metabase_lf_pretas_orphaned_202008 m on m.id_enrollement = p.id
      WHERE d.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

    UNION ALL

    SELECT
      d.code_site "Code Site",
      d.site "Site",
      d.code_id "Code ID",
      d.code_operateur "Code Operateur",
      NULL "Age In Years",
      NULL "Sexe",
      d.resultat_fts "Résultats FTS",
      'FTS results' "Enregistrement Manquant",
      d."end" "Date",
      status "Status"

    FROM v_espen_ci_pretas_lf_resultats_v7 d
      LEFT JOIN v_espen_ci_pretas_lf_enrollement_v7 p on p.code_id = d.code_id
      LEFT JOIN metabase_lf_pretas_orphaned_202008 m on m.id_fts_results = d.id
      WHERE p.id isNULL

  ------ Metabase filter -------
  -- [[and {{cluster_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]
