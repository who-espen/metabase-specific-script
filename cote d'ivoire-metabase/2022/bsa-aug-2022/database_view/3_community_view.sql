create view v_espen_civ_oncho_bsa_3_community_form_202208_v3_1 as

SELECT 

id, 
c_recorder_id, 
c_region, 
c_district, 
c_site,
c_consent, 
c_sexe, 
c_age, 
c_profession, 
c_time_community, 
c_black_flie_issue,
c_bite_nbr, 
c_month, 
c_notes, 
c_start

FROM public.espen_civ_oncho_bsa_3_community_form_202208_v3_1 c