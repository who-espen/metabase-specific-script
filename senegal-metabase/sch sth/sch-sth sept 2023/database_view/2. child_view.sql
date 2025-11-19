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
 * Variable to rename  v_espen_sn_sch_sth_impact_2_child_202308_v3_2, v_espen_sn_sch_sth_impact_2_child_202308_v3_2
 */

create view v_espen_sn_sch_sth_impact_2_child_202308_v3_2 as

SELECT 

e.id, 
p.p_recorder, 
p.p_district, 
p.p_subdistrict, 
p.p_site, 
p.p_site_code, 
-- p_consent_note, 
p.p_toilet, 
p.p_toilet_type, 
p.p_toilet_clean, 
p.p_washing_hand, 
p.p_soap, 
p.p_sanitizer, 
p.p_flies_access_faeces, 
p.p_washing_hand_2, 
p.p_soap_2,
p.p_sanitiser_2,
p.p_place_defecate,

e.parent_id,
e.p_consent,
e.p_barcodeid,
e.p_age_yrs,
e.p_sex,
e.p_residence,
e.p_annes_vecu_village,
e.p_mares_deau,
e.p_connait_bilh,
e.p_manif_bilh,
e.p_pisse_sang_1_fois,
e.p_pisse_sang_maintenant,
e.p_ending_survey_note,
e.p_remarks,
e.p_note_thanks,

created_at p_start

FROM public.espen_sn_sch_sth_impact_2_child_202308_v3_2 p, public.espen_sn_sch_sth_impact_2_child_202308_v3_2_part e
where p.id = e.parent_id::int


