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
 * Variable to rename  v_espen_tg_sch_sth_impact_202309_2_child_v2, v_espen_tg_sch_sth_impact_202309_2_child_v2
 */

create view v_espen_tg_sch_sth_impact_202309_2_child_v2 as

SELECT 

id, 
p_recorder, 
p_region, 
p_district, 
p_usp, 
p_site, 
p_consent_note, 
p_consent, 
p_barcodeid, 
p_barcodeid2, 
p_age_yrs, 
p_sex, 
p_collected_stool, 
p_collected_urine, 
p_grading, 
p_urine_conserve, 
p_sample_note, 
p_remarks, 
p_start

FROM public.espen_tg_sch_sth_impact_202309_2_child_v2 p