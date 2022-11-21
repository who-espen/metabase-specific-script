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
 * Variable to rename  espen_tg_oncho_stop_2_participants_202209_v1, v_espen_tg_oncho_stop_2_participants_202209_v1
 */
create view v_espen_tg_oncho_stop_2_participants_202209_v1 as

SELECT 

id, 
p_recorder_id, 
p_district, 
p_site,
p_site_id,
p_bassin_fluvial,
p_nom_riviere_fleuve, 
p_consent,
p_live_to_village, 
p_code_id, 
p_sex, 
p_age_yrs,
p_contact_tuteur, 
p_prelevement,
 p_additional_notes,
 p_start_time

FROM public.espen_tg_oncho_stop_2_participants_202209_v1 p


