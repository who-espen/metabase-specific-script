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
 * Variable to rename v_espen_bf_lf_tas3_2_enrolement_202109, v_espen_bf_lf_tas3_3_resultat_fts_202109, metabase_lf_tas3_orphaned_202109
 */
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
 * Variable to rename metabase_lf_tas3_duplicates_202109, v_espen_bf_lf_tas3_2_enrolement_202109, v_espen_bf_lf_tas3_3_resultat_fts_202109
 */
SELECT
  "Formulaire",
  "Code Site",
  "ID Participant",
  "Code Opérateur",
  "Age en années",
  "Scolarisé",
  "Sexe",
  "Résultat Final",
  date,
  "Statut"

FROM (
  SELECT
  m.form "Formulaire",
  p.nb_grappe "Code Site",
  m.barcode_participant "ID Participant",
  p.code_operateur "Code Opérateur",
  p.age "Age en années",
  p.scolarise "Scolarisé",
  p.sexe "Sexe",
  null "Résultat Final",
  p.date_enregistrement date,
  status "Statut"

FROM metabase_lf_tas3_duplicates_202109 AS m, v_espen_bf_lf_tas3_2_enrolement_202109 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  d.nb_grappe::text "Code Site",
  m.barcode_results "ID Participant",
  d.code_operateur "Code Opérateur",
  null "Age en années",
  null "Scolarisé",
  null "Sexe",
  resultat_fts1 "Résultat Final",
  d.date_enregistrement date,
  status "Statut"

FROM metabase_lf_tas3_duplicates_202109 AS m, v_espen_bf_lf_tas3_3_resultat_fts_202109 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL
------ Metabase filter -------
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]
-- [[and {{district}}]]
-- [[and {{date}}]]
