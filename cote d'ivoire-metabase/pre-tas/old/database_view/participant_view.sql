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
 * Variable to rename  espen_ci_lf_pretas_2_participant_202302, v_espen_ci_lf_pretas_2_participant_202302
 */


create view v_espen_ci_lf_pretas_2_participant_202302 as
SELECT 

id, 
p_recorder_id,
p_region,
p_district,

case when p_site_name = 'Autre' then p_site_name2 else p_site_name end p_site_name, 

case when p_site_name = 'Autre' then p_site_id2 else p_site_id end p_site_id, 

 p_consent, 
 p_num, 
 p_sex,
 p_age_yrs,
 p_how_long_lived, 
 p_code_id,
 p_took_med,
 p_reason_med, 
 p_notes, 
 c_start p_start

FROM public.espen_ci_lf_pretas_2_participant_202302 p


