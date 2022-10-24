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
 * Variable to rename metabase_mz_lf_tas_duplicates_202209, v_espen_mz_lf_tas1_2_participant_202209_v1, v_espen_mz_lf_tas1_3_resultat_fts_202209_v1
 */
SELECT
  "Formulário",
  "Código do site",
  "Nome do site",
  "ID do participante",
  "Código do Operador",
  "Idade em anos",
  "Número de anos vivido no site",
  "Sexo",
  "Resultado final",
  date,
  "Status"

FROM (
  SELECT
  m.form "Formulário",
  p.p_cluster_id "Código do site",
  p.p_cluster_name "Nome do site",
  m.barcode_participant "ID do participante",
  p.p_recorder_id "Código do Operador",
  p.p_age_yrs "Idade em anos",
  p.p_how_long_lived "Número de anos vivido no site",
  p.p_sex "Sexo",
  null "Resultado final",
  p.p_start date,
  status "Status"

FROM metabase_mz_lf_tas_duplicates_202209 AS m, v_espen_mz_lf_tas1_2_participant_202209_v1 AS p
  WHERE p.id = m.id_participant -- and survey_designation ='TAS2'

UNION ALL

SELECT
  m.form "Formulário",
  d.d_cluster_id "Nome do site",
  d.d_cluster_name "Nome do site",
  m.barcode_results "ID do participante",
  d.d_recorder_id "Código do Operador",
  null "Idade em anos",
  null "Número de anos vivido no site",
  null "Sexo",
  d_final_result "Resultado final",
  d.d_start date,
  status "Status"

FROM metabase_mz_lf_tas_duplicates_202209 AS m, v_espen_mz_lf_tas1_3_resultat_fts_202209_v1 AS d
  WHERE d.id = m.id_results --and survey_designation ='TAS2'
) src

WHERE "Formulário" IS NOT NULL
