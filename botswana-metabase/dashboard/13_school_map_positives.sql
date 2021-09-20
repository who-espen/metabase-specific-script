/*
 * File: 13_school_map_positives.sql
 * File Created: Tuesday, 12th May 2020 2:05:12 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 2:15:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will will display a pin Map of clusters with positive cases
 * Variable to rename v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2, v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca
 */

SELECT
DISTINCT

  w_regiON,
  w_district,
  w_school_id,
  w_school_name,
  w_gps_lat,
  w_gps_lng

FROM v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 w
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_3_kato_katz_v2 k ON k.k_school_id = w.w_school_id
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_4_urinefiltration_cca u ON u.u_school_id = w.w_school_id

where (k_sch_man_sa > 0 OR k_sch_man_sb > 0 OR k_ascaris_lumb_sa > 0 OR k_ascaris_lumb_sb > 0 OR
k_hookwORm_sa > 0 OR k_hookwORm_sb > 0 OR k_trichuris_sa > 0 OR k_trichuris_sb > 0 OR
k_other_quantity_1a > 0 OR k_other_quantity_1b > 0 OR k_other_quantity_2a > 0 OR k_other_quantity_2b > 0)
OR (u_grading = '+' OR u_grading = '++' OR u_grading = '+++'
OR u_cca = 'Positive')

  ------ Metabase filter -------
  -- [[and {{c_school_id}}]]
  -- [[and {{cluster_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

