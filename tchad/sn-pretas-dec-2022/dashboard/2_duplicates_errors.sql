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
 * Variable to rename metabase_td_lf_pretas_duplicates_202212, v_espen_td_lf_pretas_2_participant_202208_v2, v_espen_td_lf_pretas_3_resultat_fts_202208_v2
 */

SELECT
  "Formulaire",
  "Code Site",
  "Nom Site",
  "ID Participant",
  "Code Opérateur",
  "Age en années",
  "Nbr année vécue dans le site",
  "Sexe",
  "Résultat Final",
  date,
  "Statut"

FROM (
  SELECT
  m.form "Formulaire",
  p.p_site_id "Code Site",
  p.p_site_name "Nom Site",
  m.barcode_participant "ID Participant",
  p.p_recorder_id "Code Opérateur",
  p.p_age_annee "Age en années",
  p.p_reside_annee "Nbr année vécue dans le site",
  p.p_sex "Sexe",
  null "Résultat Final",
  p.p_start date,
  status "Statut"

FROM metabase_td_lf_pretas_duplicates_202212 AS m, v_espen_td_lf_pretas_2_participant_202208_v2 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  d.d_site_id "Nom Site",
  d.d_site "Nom Site",
  m.barcode_results "ID Participant",
  d.d_recorder_id "Code Opérateur",
  null "Age en années",
  null "Nbr année vécue dans le site",
  null "Sexe",
  d_result "Résultat Final",
  d.d_start date,
  status "Statut"

FROM metabase_td_lf_pretas_duplicates_202212 AS m, v_espen_td_lf_pretas_3_resultat_fts_202208_v2 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL
