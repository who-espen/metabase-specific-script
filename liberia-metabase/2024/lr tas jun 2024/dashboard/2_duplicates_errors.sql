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
 * Variable to rename metabase_lr_lf_pre_duplicates_202406, v_espen_lr_lf_tas1_2_child_202406_v1, v_espen_lr_lf_tas1_3_fts_202406
 */
 
 
SELECT
  "Forms",
  "EU",
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
  p.p_eu "EU",
  p.p_cluster_id "Code Site",
  p.p_cluster_name "Site Name",
  m.barcode_participant "ID Participant",
  p.p_recorder"Operator",
  p.p_age_yrs "Age",
  p.p_how_long_lived "Nbr year lived in the site",
  p.p_sex "Sex",
  null "Final result",
  p.p_start date,
  status "Status"

FROM metabase_lr_lf_pre_duplicates_202406 AS m, v_espen_lr_lf_tas1_2_child_202406_v1 AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Forms",
  d_eu "EU",
  d.d_cluster_id "Site Name",
  d.d_cluster_name "Site Name",
  m.barcode_results "ID Participant",
  d.d_recorder "Operator",
  null "Age",
  null "Nbr year lived in the site",
  null "Sex",
  d_final_result "Final result",
  d.d_start date,
  status "Status"

FROM metabase_lr_lf_pre_duplicates_202406 AS m, v_espen_lr_lf_tas1_3_fts_202406 AS d
  WHERE d.id = m.id_results
) src

WHERE "Forms" IS NOT null