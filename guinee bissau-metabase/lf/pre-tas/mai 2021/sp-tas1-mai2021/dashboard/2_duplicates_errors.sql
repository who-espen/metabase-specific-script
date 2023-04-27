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
 * Variable to rename metabase_lf_pretas_duplicates_202206, v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
, v_espen_gw_lf_pretas_3_fts_result_202206_v2

 */
SELECT
  "Formulário",
  "Código do sítio",
  "Nome Site",
  "ID Participante",
  "Código Opérateur",
  "Idade em anos",
  "Nº de anos de vida no site",
  "Género",
  "Resultado final",
  date,
  "Estado"

FROM (
  SELECT
  m.form "Formulário",
  p.p_cluster_id "Código do sítio",
  p.p_cluster_name "Nome Site",
  m.barcode_participant "ID Participante",
  p.p_recorder_id "Código Opérateur",
  p.p_age_yrs "Idade em anos",
  p.p_how_long_lived "Nº de anos de vida no site",
  p.p_sex "Género",
  null "Resultado final",
  p.p_start date,
  status "Estado"

FROM metabase_lf_pretas_duplicates_202206 AS m, v_espen_gw_lf_pretas_2_partcipants_202206_v2_1
 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Formulário",
  d.d_cluster_id "Nome Site",
  d.d_cluster_name "Nome Site",
  m.barcode_results "ID Participante",
  d.d_recorder_id "Código Opérateur",
  null "Idade em anos",
  null "Nº de anos de vida no site",
  null "Género",
  d_result1 "Resultado final",
  d.d_start date,
  status "Estado"

FROM metabase_lf_pretas_duplicates_202206 AS m, v_espen_gw_lf_pretas_3_fts_result_202206_v2
 AS d
  WHERE d.id = m.id_results
) src

WHERE "Formulário" IS NOT NULL

