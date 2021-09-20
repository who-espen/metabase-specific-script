/*
 * File: child_view.sql
 * File Created: Monday, 11th May 2020 1:05:59 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:11:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8, v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8
 */
 CREATE VIEW v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8
AS
SELECT
  id,
  p_recorder_id,
  p_district,
  p_school_id,
  p_consent,
  CASE WHEN p_id_method = 'Scanner' THEN p_barcode_id ELSE p_generate_id END AS p_barcode_id,
  p_age_yrs,
  p_sex,
  CASE WHEN p_urinate_place = 'Other' THEN p_urinate_place_other  ELSE p_urinate_place END AS p_urinate_place,
  p_urinate_wash,
  p_urinate_wash_noreason,
  CASE WHEN p_defecate_place = 'Other' THEN p_defecate_place_other  ELSE p_urinate_place END AS p_defecate_place,
  p_defecate_wash,
  p_defecate_wash_noreason,
  p_water_activities,
  s_remarks,
  p_end p_date

FROM v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p
