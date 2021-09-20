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
 * Variable to rename  espen_bj_lf_pretas_2_participant_202009_v3, v_espen_bj_lf_pretas_2_participant_202009_v3
 */
create view v_espen_bj_lf_pretas_2_participant_202009_v3
as SELECT
  id,
  p_recorder_id,
  p_district,
  p_cluster_name,
  p_cluster_id,
  p_consent,
  p_sex,
  p_age_yrs,
  p_how_long_lived,

  p_code_id,

  p_notes,
  c_end p_date

FROM public.espen_bj_lf_pretas_2_participant_202009_v3 p

