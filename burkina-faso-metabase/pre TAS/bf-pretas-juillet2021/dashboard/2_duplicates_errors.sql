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
 * Variable to rename metabase_lf_pretas_duplicates_202106, v_espen_bf_lf_pretas_2_enrolement_202106_v2_2, v_espen_bf_lf_pretas_3_resultat_202106_v2_1
 */
SELECT
  "Formulaire",
  "Code Site",
  "Nom Site",
  "ID Participant",
  "Code Opérateur",
  "Age en années",
  "Sexe",
  "Résultat Final 1",
  "Résultat Final 2",
  date,
  "Statut"

FROM (
  SELECT
  m.form "Formulaire",
  p.p_cluster_id "Code Site",
  p.p_cluster_name "Nom Site",
  m.barcode_participant "ID Participant",
  p.p_recorder_id "Code Opérateur",
  p.p_age_yrs "Age en années",
  p.p_sex "Sexe",
  null "Résultat Final 1",
  null "Résultat Final 2",
  p.p_start date,
  m.status "Statut"

FROM metabase_lf_pretas_duplicates_202106 AS m, v_espen_bf_lf_pretas_2_enrolement_202106_v2_2 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  d.d_cluster_id "Code Site",
  d.village "Nom Site",
  m.barcode_results "ID Participant",
  d.d_recorder_id "Code Opérateur",
  null "Age en années",
  null "Sexe",
  d_result1 "Résultat Final 1",
  d_result2 "Résultat Final 2",
  d.d_start date,
  status "Statut"

FROM metabase_lf_pretas_duplicates_202106 AS m, v_espen_bf_lf_pretas_3_resultat_202106_v2_1 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL
------ Metabase filter -------
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]
-- [[and {{district}}]]
-- [[and {{date}}]]
