create view v_espen_civ_oncho_bsa_2501_4_community_form_oem_v1 as

SELECT 

id, 
c_recorder_id, 
c_region, 
c_district, 
c_district_id, 
c_health_facility, 
c_health_facility_other, 
c_site, 
c_site_id,
c_consent,
c_sexe, 
c_age, 
c_profession, 
c_time_community, 
c_black_flie_issue, 
c_bite_nbr, 
c_month, 
b_temps_presence,
b_savoir_oncho,
c_notes, 
c_start

FROM public.espen_civ_oncho_bsa_2501_4_community_form_oem_v1 c

