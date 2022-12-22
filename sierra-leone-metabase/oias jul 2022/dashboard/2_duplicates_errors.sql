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
 * Variable to rename metabase_sr_oncho_oem_duplicates_202212, v_espen_sr_oncho_oem_2_participant_202211_v1_3, v_espen_ng_ng_oncho_oias_3_resultat_fts_202212_v2
 */
  SELECT
  m.form "Form",
  p.p_cluster_id "Code Site",
  p.p_cluster_name "Nom Site",
  m.barcode_participant "ID Participant",
  p.p_recorder_id "Recorder ID",
  p.p_age_yrs "Age (yrs)",
  p.p_how_long_lived "Nbr of years lived in the site",
  p.p_sex "Sex",
  null "Final Result",
  p.p_start date,
  status "Status"

FROM metabase_sr_oncho_oem_duplicates_202212 AS m, v_espen_sr_oncho_oem_2_participant_202211_v1_3 AS p
  WHERE p.id = m.id_participant