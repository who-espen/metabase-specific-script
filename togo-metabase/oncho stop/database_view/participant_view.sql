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
 * Variable to rename  espen_tg_oncho_stop_2_participants_202204, v_espen_tg_oncho_stop_2_participants_202204
 */
create view v_espen_tg_oncho_stop_2_participants_202204 as 

SELECT 

id, 
p_recorder_id, 
p_district,
p_formation_sanitaire, 
p_cluster_name, 
p_cluster_id, 
p_consent, 
p_live_to_village, 
p_code_id, 
p_sex, 
p_age_yrs, 
p_contact_tuteur, 
p_prelevement,
p_additional_notes,
p_start_time


FROM public.espen_tg_oncho_stop_2_participants_202204 p

