/*
 * File: 2_duplicates_errors.sql
 * File Created: Monday, 11th May 2020 8:13:38 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:48 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_sch_sth_mapping_duplicates_202204, v_espen_cd_sch_sth_baseline_2_child_202202_v2_1, v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1,
 * v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1
 */
SELECT
  "Form",
  "Zone Santé",
  "Ecole",
  "Barcode ID",
  "Opérateur",
  "Age in Years",
  "Sexe",
  date,
  "Status"

FROM (
  SELECT
  m.form "Form",
  p.p_zone_sante "Zone Santé",
  p.p_ecole "Ecole",
  m.barcode_participant "Barcode ID",
  p.p_recorder_id "Opérateur",
  p.p_age "Age in Years",
  p.p_sexe "Sexe",
  p.p_start date,
  status "Status"

FROM metabase_sch_sth_mapping_duplicates_202204 AS m, v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 AS p
  WHERE p.id = m.id_participant::int

UNION ALL

SELECT
  m.form "Form",
  k_zone_sante "USP",
  k_ecole "Ecole",
  m.barcode_results_kk "Barcode ID",
  k.k_recorder_id "Opérateur",
  null "Age in Years",
  null "Sexe",
  k.k_start date,
  status "Status"

FROM metabase_sch_sth_mapping_duplicates_202204 AS m, v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 AS k
  WHERE k.id = m.id_results_kk::int

UNION ALL

SELECT
  m.form "Form",
  u_zone_sante "Zone Santé",
  u_ecole "Ecole",
  m.barcode_results_urine "Barcode ID",
  u.u_recorder_id "Opérateur",
  null "Age in Years",
  null "Sexe",
  u.u_start date,
  status "Status"

FROM metabase_sch_sth_mapping_duplicates_202204 AS m, v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 AS u
  WHERE u.id = m.id_results_urine::int
) src

WHERE "Form" IS NOT NULL