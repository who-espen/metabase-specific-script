create view v_espen_civ_oncho_bsa_2_vector_community_question_20221102_v1 as

SELECT 

id, 
c_recorder_id, 
c_region, 

case when c_district = 'Other' then c_district_other else c_district end c_district,

case when c_health_facility = 'Other' then c_health_facility_other else c_health_facility end c_health_facility,

case when c_village = 'Other' then c_village_other else c_village end c_village,

c_consent, 
c_sexe, 
c_age, 
c_occupation, 
c_how_lng_lived, 
c_black_fly_problem, 
c_bites_number, 
c_month, 
c_time, 
c_know_oncho, 
c_oncho_explanation,
c_note, 
 c_start

FROM public.espen_civ_oncho_bsa_2_vector_community_question_20221102_v1 c
