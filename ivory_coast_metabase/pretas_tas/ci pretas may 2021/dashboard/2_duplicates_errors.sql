/*
 * File: 2_duplicates_errors.sql
 * File Created: Tuesday, 5th May 2020 3:57:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 5:06:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_lf_pretas_duplicates_202008, v_espen_ci_pretas_lf_enrollement_v7, v_espen_ci_pretas_lf_resultats_v7
 */
SELECT
  "Formulaire",
  "Code Site",
  "Site",
  "Code ID",
  "Code Operateur",
  "Age en Année",
  "Migration",
  "Sexe",
  "Résultat Final",
  date,
  "Statut"

FROM (
  SELECT
  m.form "Formulaire",
  p.code_site "Code Site",
  p.site "Site",
  m.code_id_enrollement "Code ID",
  p.code_operateur "Code Operateur",
  p.age "Age en Année",
  p.migration "Migration",
  p.sexe "Sexe",
  null "Résultat Final",
  p.date_end date,
  status "Statut"

FROM metabase_lf_pretas_duplicates_202008 AS m, v_espen_ci_pretas_lf_enrollement_v7 AS p
  WHERE p.id = m.id_enrollement

UNION ALL

SELECT
  m.form "Formulaire",
  d.code_site "Code Site",
  d.site "Site",
  m.code_id_fts_results "Code ID",
  d.code_operateur "Code Operateur",
  null "Age en Année",
  null "Migration",
  null "Sexe",
  d.final_result "Résultat Final",
  d."end" date,
  status "Statut"

FROM metabase_lf_pretas_duplicates_202008 AS m, v_espen_ci_pretas_lf_resultats_v7 AS d
  WHERE d.id = m.id_fts_results
) src

WHERE "Formulaire" IS NOT NULL
------ Metabase filter -------
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]
-- [[and {{district}}]]
-- [[and {{date}}]]
