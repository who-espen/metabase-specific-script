/*
 * File: 2_duplicates_errors.sql
 * File Created: Saturday, 2nd May 2020 4:42:43 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:08:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * A query for listing all records that use the same ID twice
 * Variable to rename v_espen_bj_oncho_prestop_2_participants
 */
 SELECT
  "Form",
  district,
  "Code Site",
  "Site",
  "Barcode ID",
  "Recorder ID",
  "Age in Years",
  "Year lived in the village",
  "Sex",
  "OV 16 result",
  date,
  "Status"

FROM (
  SELECT
  m.form "Form",
  p.p_district district,
  p.p_cluster_id "Code Site",
  p.p_cluster_name "Site",
  m.barcode_participant "Barcode ID",
  p.p_recorder_id "Recorder ID",
  p.p_age_yrs "Age in Years",
  p.p_how_long_lived "Year lived in the village",
  p.p_sex "Sex",
  null "OV 16 result",
  p.p_end_time date,
  status "Status"

FROM metabase_oncho_prestop_duplicates_202012 AS m, v_espen_bj_oncho_prestop_2_participants AS p
  WHERE p.id = m.id_participant

UNION ALL

SELECT
  m.form "Form",
  d.d_district district,
  d.d_cluster_id "Code Site",
  d.d_cluster_name "Site",
  m.barcode_results "Barcode ID",
  d.d_recorder_id "Recorder ID",
  null "Age in Years",
  null "Year lived in the village",
  null "Sex",
  null "OV 16 result",
  d.d_date date,
  status "Status"

FROM metabase_oncho_prestop_duplicates_202012 AS m, <%v_ab_cde_fgh_3_rdt_ov16%> AS d
  WHERE d.id = m.id_results
) src

WHERE "Form" IS NOT NULL
------ Metabase filter -------
-- [[and {{"Code Site"}}]]
-- [[and {{"Site"}}]]
-- [[and {{district}}]]
-- [[and {{date}}]]
