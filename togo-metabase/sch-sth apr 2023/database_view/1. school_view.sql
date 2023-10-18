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
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_tg_sch_sth_impact_202309_1_school_v2
 */

create view v_espen_tg_sch_sth_impact_202309_1_school_v2 as

SELECT 

id, 
w_recorder, 
w_region, 
w_district,
w_usp_group, 
w_usp, 
w_site_name, 
w_gps_lat, 
w_gps_lng, 
w_gps_acc,
w_source_exist, 
w_source_drinkable, 
w_source_type, 
w_accessible_water, 
w_toilet, 
w_toilet_type, 
w_obs_toilet_condition, 
w_obs_flies_access_faeces, 
w_obs_washing_hand_type,
w_remarks, 
w_start

FROM public.espen_tg_sch_sth_impact_202309_1_school_v2 b