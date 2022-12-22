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
 * Variable to rename  espen_td_lf_pretas_2_participant_202208_v2, v_espen_td_lf_pretas_2_participant_202208_v2
 */
create view v_espen_td_lf_pretas_2_participant_202208_v2 as

select

 id, 
 p_recorder_id, 
 p_region,
 p_district, 
 p_site_name, 
 p_site_id,
 p_consent,
 p_sex, 
 p_age_annee,
 p_reside_annee, 
 p_reside_mois, 
 p_id_type,
 p_barcode_id,
 p_num, 
 p_code_id, 
 p_notes, 
 c_start p_start

FROM public.espen_td_lf_pretas_2_participant_202208_v2 p
