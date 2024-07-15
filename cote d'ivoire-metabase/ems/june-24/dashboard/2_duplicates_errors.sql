 
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
  p.p_age_yrs "Age en années",
  p.p_how_long_lived "Nbr année vécue dans le site",
  p.p_sex "Sexe",
  null "Résultat Final",
  p.p_start date,
  status "Statut"

FROM metabase_ci_lf_2407_ems_duplicates AS m, v_espen_ci_lf_pretas_2406_3_part_v4 AS p
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

FROM metabase_ci_lf_2407_ems_duplicates AS m, v_espen_ci_lf_pretas_2406_4_fts_v4 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulaire" IS NOT NULL



