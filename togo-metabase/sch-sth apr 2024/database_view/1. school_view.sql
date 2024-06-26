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
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2
 */

create view v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 as SELECT 

c.id, 
p.w_recorder, 
p.w_district,
p.w_usp, 
p.w_site_name, 
p.w_source_exist_ecole, 
p.w_type_source_ecole, 
p.w_source_drinkable, 
p.w_accessible_water, 
p.w_toilet, 
p.w_toilet_type, 
p.w_obs_toilet_condition, 
p.w_obs_flies_access_faeces, 
p.w_obs_washing_hand_type, 
p.w_gps_lat, 
p.w_gps_lng, 
p.w_gps_alt,
p.w_gps_acc,
p.p_nb_children,  


 c.parent_id, 
 c.p_consent, 
 c.p_barcodeid, 
 c.p_age_yrs, 
 c.p_sex, 
 c.p_collected_stool, 
 c.p_collected_urine,
 c.p_macroscopique_hemat, 
 c.p_grading, 
 c.p_urine_conserve, 
 c.p_sample_note,
 c.p_remarks,


p.w_start

FROM espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 p, espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2_tg_sch_p_2404_v3_2 c

where p.id = c.parent_id::int