/*
 * File: participant_view.sql
 * File Created: Thursday, 23rd April 2020 2:11:14 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 28th April 2020 5:29:11 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */


  /*
 * Variable to rename  espen_bj_oncho_prestop_2_participants, espen_bj_oncho_prestop_1_site, v_espen_bj_oncho_prestop_2_participants
 */

CREATE view v_espen_bj_oncho_prestop_2_participants as

SELECT 

  id,
  p_recorder_id, 
  p_region, 
  p_district, 
  p_cluster_name, 
  p_cluster_id, 
  p_consent, 
  p_sex, 
  p_age_yrs, 
  p_born_to_village, 
  p_how_long_lived, 
  p_travel, 
  p_ivm, 
  p_ivm_where, 
  p_barcode_id,
  p_ending_survey_note,
  p_additional_notes, 
  p_end_time 

FROM public.espen_bj_oncho_prestop_2_participants p

