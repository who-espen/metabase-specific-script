create view v_espen_gn_oncho_bsa_1_vector_community_question_202210_v3

as

SELECT 

id, 
c_recorder_id, 

case when c_district = 'Other' then c_district_other else c_district end c_district,

case when (c_site = 'Other' or c_site isnull)  then c_site_other else c_site end c_site,

c_consent, 
c_gender,
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

FROM public.espen_gn_oncho_bsa_1_vector_community_question_202210 c

union all 

SELECT 

id, 
c_recorder_id, 

case when c_district = 'Other' then c_district_other else c_district end c_district,

case when (c_site = 'Other' or c_site isnull)  then c_site_other else c_site end c_site,

c_consent, 
c_gender,
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

FROM public.espen_gn_oncho_bsa_1_vector_community_question_202210_v3 c
