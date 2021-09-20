/*
 * File: 17_urine_filtration_per_district.sql
 * File Created: Tuesday, 12th May 2020 4:39:51 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 5:28:39 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


/*
 * This query will will display urine result per site
 * Variable to rename v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8, v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8, v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8
 */

 SELECT

  w_district "District",
  w_school_id "School Id",
  w_school_name "School Name",
  COUNT(u.id) "Examined",
  COUNT(CASE WHEN u_grading = '+' OR u_grading = '++' OR u_grading = '+++' or u_cca = 'Positive'
  THEN 1 ELSE NULL END) "Positives",
  COUNT(CASE WHEN u_grading = '+' OR u_grading = '++' OR u_grading = '+++' or u_cca = 'Positive' and p.p_sex = 'Male'
  THEN 1 ELSE NULL END) "Positives Male",
  COUNT(CASE WHEN u_grading = '+' OR u_grading = '++' OR u_grading = '+++' or u_cca = 'Positive' and p.p_sex = 'Female'
  THEN 1 ELSE NULL END) "Positives Female",
  COUNT(CASE WHEN u_grading <> '+' AND u_grading <> '++' AND u_grading <> '+++' AND u_cca <> 'Positive'
  THEN 1 ELSE NULL END) "Negative",
  COUNT(CASE WHEN u_grading <> '+' AND u_grading <> '++' AND u_grading <> '+++' AND u_cca <> 'Positive' and p.p_sex = 'Male'
  THEN 1 ELSE NULL END) "Negative Male",
  COUNT(CASE WHEN u_grading <> '+' AND u_grading <> '++' AND u_grading <> '+++' AND u_cca <> 'Positive' and p.p_sex = 'Female'
  THEN 1 ELSE NULL END) "Negative Female"

FROM v_espen_ao_sch_sth_baseline_4_urine_202105_v5_8 u
LEFT JOIN v_espen_ao_sch_sth_baseline_1_school_wash_202105_v5_8 w ON w.w_school_id = u.u_school_id
LEFT JOIN v_espen_ao_sch_sth_baseline_2_child_kap_202105_v5_8 p ON p.p_barcode_id = u.u_barcode_id

WHERE u.id IS NOT NULL

  ------ Metabase filter -------
  -- [[and {{c_school_id}}]]
  -- [[and {{school_name}}]]
  -- [[and {{district}}]]
  -- [[and {{date}}]]

GROUP BY w_district, w_school_id, w_school_name
