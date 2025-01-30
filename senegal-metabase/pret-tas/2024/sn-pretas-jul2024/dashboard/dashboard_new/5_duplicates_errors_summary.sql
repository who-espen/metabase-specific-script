 
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
  date

FROM (
  SELECT
  m.form "Formulaire",
  p.c_cluster_id "Code Site",
  p.c_cluster_name "Nom Site",
  m.barcode_participant "ID Participant",
  p.c_recorder "Code Opérateur",
  p.p_age_yrs "Age en années",
  p.p_how_long_lived "Nbr année vécue dans le site",
  p.p_sex "Sexe",
  null "Résultat Final",
  p.c_start date

FROM metabase_sn_lf_2407_pretas_duplicates AS m, v_espen_sn_lf_pretas_2407_1_sit_part_v3 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulaire",
  d.d_cluster_id "Code Site",
  d.d_cluster_name "Nom Site",
  m.barcode_results_fts "ID Participant",
  d.d_recorder_id "Code Opérateur",
  null "Age en années",
  null "Nbr année vécue dans le site",
  null "Sexe",
  d_result1 "Résultat Final",
  d.d_start date

FROM metabase_sn_lf_2407_pretas_duplicates AS m, v_espen_sn_lf_pretas_20407_2_fts_v3 AS d
  WHERE d.id = m.id_results_fts
) src

WHERE "Formulaire" IS NOT NULL



