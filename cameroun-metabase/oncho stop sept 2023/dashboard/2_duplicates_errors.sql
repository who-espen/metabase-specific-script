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
 * Variable to rename v_espen_cm_oncho_pre_stop_2_202309_couverture_v2
 */

 SELECT
  m.form "Form",
  p.p_district district,
  --p.p_village_id "Code Site",
  p.p_village "Site",
  m.barcode_participant "Barcode ID",
  p.p_recorder_id "Recorder ID",
  p.p_age "tranche d'âge",
  p.p_annees_vecu_village "Année vécu au village",
  p.p_sexe "Sex",
  null "OV 16 result",
  p.p_start date,
  status "Status"

FROM public.metabase_oncho_stop_cm_202309_duplicates AS m, public.v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 AS p
  WHERE p.id = m.id_participant

