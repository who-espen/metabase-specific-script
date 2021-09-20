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
 * Variable to rename  v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1, v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1
 */
CREATE view v_espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1 as

SELECT 
  c.id, 
  p_recorder_id, 
  p_region, 
p_district, 
  p_dist_abbr, 
p_school_name, 
p_school_id, 
 c.p_consent, 
  c.p_generateid, 
c.p_age_yrs, 
c.p_sex, 

CASE WHEN  c.p_urinate_place = 'Other' THEN c.p_urinate_place_other ELSE c.p_urinate_place END p_urinate_place,

 c.p_urinate_wash, 
  c.p_urinate_wash_noreason,

  
CASE WHEN  c.p_defecate_place = 'Other' THEN c.p_defecate_place_other ELSE c.p_defecate_place END p_defecate_place,

  
  c.p_defecate_wash,
  c.p_defecate_wash_noreason,
 c.p_water_activities, 
  c.p_remarks, 
  p_start

FROM public.espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1 p
  RIGHT JOIN public.espen_bw_sch_sth_mid_term_evaluation_2_participant_v2_1_p_sac c on c.parent_id::int = p.id

