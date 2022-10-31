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
 * Variable to rename metabase_gn_lf_pretas_duplicates_202209, v_espen_gn_lf_pretas_1_site_participant_202210, v_espen_gn_lf_pretas_2_resultat_fts_202210_fts
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
  p.c_cluster_id "Code Site",
  p.c_cluster_name "Site Name",
  m.barcode_participant "ID Participant",
  p.c_recorder "Operator",
  p.p_age_yrs "Age",
  p.p_how_long_lived "Nbr year lived in the site",
  p.p_sex "Sex",
  null "Final result",
  p.created_at date,
  status "Status"

FROM metabase_gn_lf_pretas_duplicates_202209 AS m, v_espen_gn_lf_pretas_1_site_participant_202210 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Forms",
  d.d_cluster_id "Site Name",
  d.d_cluster_name "Site Name",
  m.barcode_results "ID Participant",
  d.d_recorder_id "Operator",
  null "Age",
  null "Nbr year lived in the site",
  null "Sex",
  d_final_result "Final result",
  d.created_at date,
  status "Status"

FROM metabase_gn_lf_pretas_duplicates_202209 AS m, v_espen_gn_lf_pretas_2_resultat_fts_202210_fts AS d
  WHERE d.id = m.id_results
) src

WHERE "Forms" IS NOT null