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
 * Variable to rename  espen_bw_sch_sth_mid_term_evaluation_1_school_v2_1, v_espen_tg_sch_sth_impact_1_school_202110_v6_1
 */
 CREATE OR REPLACE VIEW public.v_espen_tg_sch_sth_impact_1_school_202110_v6_1
AS SELECT s.meta_instance_id,
    s.w_recorder,
    s.w_region,
    s.w_district,
    s.w_subdistrict,
    s.w_site_name,
    s.w_gps_lat,
    s.w_gps_lng,
    s.w_gps_alt,
    s.w_gps_acc,
    s.w_source_exist,
    s.w_source_drinkable,
    s.w_source_type,
    s.w_accessible_water,
    s.w_toilet,
    s.w_toilet_type,
    s.w_obs_toilet_condition,
    s.w_obs_flies_access_faeces,
    s.w_obs_washing_hand_type,
    s.w_remarks,
    s.w_start,
    s.w_end,
    s.created_at,
    s.updated_at
   FROM espen_tg_sch_sth_impact_1_school_202110_v6_1 s;