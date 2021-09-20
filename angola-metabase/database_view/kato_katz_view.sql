/*
 * File: kato_katez_view.sql
 * File Created: Monday, 11th May 2020 1:29:32 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:31:24 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8, v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8
 */
CREATE VIEW v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8
AS
SELECT
  id,
  k_recorder_id,
  k_district,
  k_school_id,
  CASE WHEN k_id_type = 'Scanner' THEN k_barcode_id ELSE k_generate_id END AS k_barcode_id,
  k_sch_man_sa,
  k_sch_man_sb,
  k_ascaris_lumb_sa,
  k_ascaris_lumb_sb,
  k_hookworm_sa,
  k_hookworm_sb,
  k_trichuris_sa,
  k_trichuris_sb,
  k_other_name_1,
  k_other_quantity_1a,
  k_other_quantity_1b,
  k_other_name_2,
  k_other_quantity_2a,
  k_other_quantity_2b,
  k_remarks,
  k_end k_date

FROM v_espen_ao_sch_sth_baseline_3_kato_katz_202105_v5_8 k
