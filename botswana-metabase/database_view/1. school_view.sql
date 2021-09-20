/*
 * File: school_view.sql
 * File Created: Monday, 11th May 2020 12:39:08 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 12:41:13 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1
 */
 CREATE view v_espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 as

SELECT 
  id, 
  w_recorder_id, 
  "date", 
  w_region, 
  w_district, 
  w_dist_abbr,
  w_school_name, 
  w_school_id, 
  w_gps_lat, 
  w_gps_lng, 
  w_gps_acc, 
  w_deworming_alb, 
  w_deworming_pzq, 
  w_source_exist, 
  w_source_drinkable,
  w_source_type, 
  w_accessible_water, 
  w_toilet, 

  CASE WHEN w_toilet_type = 'Other' THEN w_toilet_type_other ELSE w_toilet_type END w_toilet_type,

  w_toilet_has_paper,
  w_toilet_has_washing_water, 
  w_toilet_has_soap, 
  w_obs_toilet_condition, 
  w_obs_toilet_has_water, 
  w_obs_has_hand_provision,
  w_obs_washing_hand_type, 
  w_remarks, 
  w_start

FROM public.espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1 w

