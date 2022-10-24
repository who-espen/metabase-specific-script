create view v_espen_gw_oncho_bsc_2_bs_community_question_202209 as 
SELECT 

id, 
c_recorder_id, 
c_district, 
c_site, 
c_consent, 
c_gender,
c_age, 
c_occupation,
c_how_lng_lived,
c_black_fly_problem,
c_bites_number, 
c_month,
c_notes,
c_start

FROM public.espen_gw_oncho_bsc_2_bs_community_question_202209 c
