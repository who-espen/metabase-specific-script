/*
 * File: participant_view.sql
 * File Created: Monday, 4th May 2020 3:30:18 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 1:16:57 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  espen_ng_ng_oncho_oias_2_participant_202207_v2, v_espen_lr_oncho_ias_2_participant_202112_v2_2
 */
create view v_espen_lr_oncho_ias_2_participant_202112_v2_2

as 

SELECT 

  id, 
  p_recorder_id,
  p_district,
  p_cluster_name, 
  p_cluster_id, 
  p_accent, 
  p_consent,
  p_sex, 
  p_age_yrs, 
  p_how_long, 
  p_ever_taken_ivm, 
  p_times_took_ivm, 
  p_ivm_last_time_month,
  p_ivm_last_time_year, 

    case when p_id_method = 'Scanner' then p_barcode_id else p_generate_id end p_barcode_id,

  p_additional_notes,
  p_start

FROM public.espen_lr_oncho_ias_2_participant_202112_v2_2 p


