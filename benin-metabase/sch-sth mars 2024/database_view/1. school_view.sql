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
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_bf_202403_sch_ia_1_sites
 */

create view v_espen_bf_202403_sch_ia_1_sites as

SELECT 

id, 
w_recorder,
"date",
w_region,
w_district, 
w_subdistrict,
w_site_name,
w_site_code, 
w_gps_lat, 
w_gps_lng,
w_gps_acc, 
w_source_exist, 
w_source_drinkable,
w_source_type,
w_toilet,

case when w_toilet_type = 'Autre' then w_toilet_type_other else w_toilet_type end w_toilet_type, 

w_obs_toilet_condition, 
w_toilet_usage, 
w_open_defecation, 
w_washing_hand_water, 
w_obs_washing_hand_type,
w_mesure_presentation,
w_tdm_acceptation, 
w_ci_number_start,
w_cp_number_start,
w_ce1_number_start,
w_ce2_number_start, 
w_cm1_number_start, 
w_cm2_number_start, 
w_total_number_start, 
w_ci_number_survey, 
w_cp_number_survey,
w_ce1_number_survey, 
w_ce2_number_survey, 
w_cm1_number_survey, 
w_cm2_number_survey,
w_total_number_survey, 
w_remarks, 
w_start

FROM public.espen_bf_202403_sch_ia_1_sites w

