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
 * Variable to rename  espen_tg_oncho_stop_202304_2_participants, v_espen_tg_oncho_stop_202304_2_participants
 */
create view v_espen_tg_oncho_stop_202304_2_participants as

SELECT 

id,
p_recorder_id,
p_region,
p_district,
p_subdistrict,
p_site,
p_consent,
p_live_to_village,
p_code_id,
p_sex,
p_age_yrs,
p_5_ans_dans_village,
p_contact_tuteur,
p_prelevement,
p_text_end_note,
p_additional_notes,
p_start_time

FROM public.espen_tg_oncho_stop_202304_2_participants p


