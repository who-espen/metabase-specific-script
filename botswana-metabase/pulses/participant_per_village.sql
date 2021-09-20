
/*
 * File: participant_per_village.sql
 * File Created: Tuesday, 12th May 2020 6:08:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 6:09:15 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participant per district by the total population
 * Variable to rename v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1, v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1
 */
SELECT

  w_district "District",
  w_school_id "School ID",
  w_school_name "School Name",
  COUNT(p.id) "Enrolled",
  COUNT(CASE WHEN p_sex = 'Male' THEN 1 ELSE NULL END) "Male",
  COUNT(CASE WHEN p_sex = 'Female' THEN 1 ELSE NULL END) "Female"

FROM v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1 p
LEFT JOIN v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 w on w.w_school_id = p.p_school_id

where p.p_date > CURRENT_DATE - 1
