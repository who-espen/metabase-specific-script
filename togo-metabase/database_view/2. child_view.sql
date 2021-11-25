/*
 * File: child_view.sql
 * File Created: Monday, 11th May 2020 1:05:59 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:11:50 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * Variable to rename  v_espen_tg_sch_sth_impact_2_child_202110_v6, v_espen_tg_sch_sth_impact_2_child_202110_v6
 */
CREATE OR REPLACE VIEW public.v_espen_tg_sch_sth_impact_2_child_202110_v6
 AS 
SELECT p1.meta_instance_id AS id,
    p1.p_recorder,
    p1.p_district,
    p1.p_subdistrict,
    p1.p_site,
    p1.p_consent_note,
    p1.p_consent,
    
    case when p1.p_barcode_ok = 'Oui' then p1.p_barcodeid else p1.p_manual_code_id end as p_barcodeid,
    
    p1.p_age_yrs,
    p1.p_sex,
    p1.p_collected_stool,
    p1.p_collected_urine,
    p1.p_grading,
    p1.p_urine_conserve,
    p1.p_ending_survey_note,
    p1.p_sample_note,
    p1.p_remarks,
    p1.p_start,
    p1.p_end,
    p1.created_at,
    p1.updated_at
   FROM espen_tg_sch_sth_impact_2_child_202110_v6 p1
UNION ALL
 SELECT p2.meta_instance_id AS id,
    p2.p_recorder,
    p2.p_district,
    p2.p_subdistrict,
    p2.p_site,
    p2.p_consent_note,
    p2.p_consent,
    
    case when p2.p_barcode_ok = 'Oui' then p2.p_barcodeid else p2.p_manual_code_id end as p_barcodeid,
    
    
    p2.p_age_yrs,
    p2.p_sex,
    p2.p_collected_stool,
    p2.p_collected_urine,
    p2.p_grading,
    p2.p_urine_conserve,
    p2.p_ending_survey_note,
    p2.p_sample_note,
    p2.p_remarks,
    p2.p_start,
    p2.p_end,
    p2.created_at,
    p2.updated_at
   FROM espen_tg_sch_sth_impact_2_child_202110_v6_2 p2
  ORDER BY 20;