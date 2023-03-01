create view v_espen_civ_oncho_bsa_3_village_registration_20221102_v1 as

SELECT 

id, 
v_recorder_id, 
v_region, 

case when v_district = 'Other' then v_district_other else v_district end v_district,

case when v_health_facility = 'Other' then v_health_facility_other else v_health_facility end v_health_facility,

case when v_village = 'Other' then v_village_other else v_village end v_village,

v_gps_lat, 
v_gps_lng, 
 v_gps_acc, 
 v_total_population,
 v_has_health_center,
 v_has_health_center_type, 
 v_black_flies_present, 
 v_mda_carried, 
 v_mda_year, 
 v_mda_month, 
 v_mda_everyone_receive_drugs,
 v_notes, 
 v_start

FROM public.espen_civ_oncho_bsa_3_village_registration_20221102_v1 v
