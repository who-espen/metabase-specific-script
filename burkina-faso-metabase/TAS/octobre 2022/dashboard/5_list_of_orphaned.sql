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
 * Variable to rename v_espen_bf_lf_tas3_2_participant_202209_v1_y, v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y, metabase_bf_lf_tas3_orphaned_202209_y
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
 * Variable to rename metabase_bf_lf_tas3_duplicates_202209_y, v_espen_bf_lf_tas3_2_participant_202209_v1_y, v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y
 */
SELECT
  "Formulaire",
 -- "Code Site",
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
 -- p.nb_grappe "Code Site",
  m.barcode_participant "ID Participant",
  p.p_code_operateur "Code Opérateur",
  p.p_age "Age en années",
  p.p_scolarise "Scolarisé",
  p.p_sexe "Sexe",
  null "Résultat Final",
  p.p_debut_enreg date,
  status "Statut"

FROM metabase_bf_lf_tas3_duplicates_202209_y AS m, v_espen_bf_lf_tas3_2_participant_202209_v1_y AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  --d.nb_grappe::text "Code Site",
  m.barcode_results "ID Participant",
  d.d_code_operateur "Code Opérateur",
  null "Age en années",
  null "Scolarisé",
  null "Sexe",
  d_resultat_fts1 "Résultat Final",
  d.d_debut_enreg date,
  status "Statut"

FROM metabase_bf_lf_tas3_duplicates_202209_y AS m, v_espen_bf_lf_tas3_3_resultat_fts_202209_v1_y AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL
