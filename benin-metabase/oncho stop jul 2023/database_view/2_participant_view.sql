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
 * Variable to rename  espen_bj_oncho_stop_2_202306_questions_v3, espen_bj_oncho_stop_1_202306_site_v3, v_espen_bj_oncho_stop_2_202306_questions_v3
 */

create view v_espen_bj_oncho_stop_2_202306_questions_v3 as 

select

id, 
 p_recorder_id, 
 p_region,
 p_district, 
 p_site_name,
 p_consent,
 p_inf_gen,
p_num_maison, 

case when p_id_type = 'Scanner' then p_barecode_id else p_manual_id end p_barecode_id,

 p_sex,
 p_age_yrs_tranche,
 p_age_yrs_1_4_yrs,
 p_age_yrs_5_9_yrs, 
 p_age_yrs_10_15_yrs,
 p_age_yrs_16_yrs, 
 p_age_yrs_mois, 
 p_nb_child_5_9_yrs,
 p_time_in_village,
 p_ivm_distributed, 
 p_ivm_distributed_last_yrs, 
 p_took_ivm,
 p_took_ivm_last_yrs, 
 p_note, 
 p_start_time p_start

FROM public.espen_bj_oncho_stop_2_202306_questions_v3 p
