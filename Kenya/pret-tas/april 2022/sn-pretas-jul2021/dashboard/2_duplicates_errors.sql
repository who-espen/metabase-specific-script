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
 * Variable to rename metabase_lf_pretas_duplicates_202204, v_espen_ke_lf_pretas_2_participant_202203_v4, v_espen_ke_lf_pretas_3_resultat_fts_202203_v4
 */
SELECT
  "Forms",
  "Code Site",
  "Site Name",
  "ID Participant",
  "Operator",
  "Age",
  "Nbr year lived in the site",
  "Sex",
  "Final result",
  date,
  "Status"

FROM (
  SELECT
  m.form "Forms",
  p.p_cluster_id "Code Site",
  p.p_cluster_name "Site Name",
  m.barcode_participant "ID Participant",
  p.p_enumerator "Operator",
  p.p_age_yrs "Age",
  p.p_lived_last_1yr "Nbr year lived in the site",
  p.p_sex "Sex",
  null "Final result",
  p.p_start date,
  status "Status"

FROM metabase_lf_pretas_duplicates_202204 AS m, v_espen_ke_lf_pretas_2_participant_202203_v4 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Forms",
  d.d_cluster_id "Site Name",
  d.d_cluster_name "Site Name",
  m.barcode_results "ID Participant",
  d.d_enumerator "Operator",
  null "Age",
  null "Nbr year lived in the site",
  null "Sex",
  d_final_result "Final result",
  d.d_start date,
  status "Status"

FROM metabase_lf_pretas_duplicates_202204 AS m, v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 AS d
  WHERE d.id = m.id_results
) src

WHERE "Forms" IS NOT null