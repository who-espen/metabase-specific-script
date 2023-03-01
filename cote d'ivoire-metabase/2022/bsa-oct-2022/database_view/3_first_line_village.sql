create view v_espen_gn_oncho_bsa_3_village_registration_202210_v3 as

SELECT 

id, 
v_recorder_id, 
v_region, 

case when v_district = 'Other' then v_district_other else v_district end v_district,

case when (v_site = 'Other' or v_site isnull) then v_site_other else v_site end v_site,

  v_gps_lat,
  v_gps_lng,
  v_gps_acc,
  
 v_total_population, 
 v_has_health_center,
 v_has_health_center_type v_has_health_center_other, 
 v_black_flies_present,
 v_mda_carried, 
 v_mda_year, 
 v_mda_month, 
 
 v_notes, 
 v_start

FROM public.espen_gn_oncho_bsa_3_village_registration_202210 v

union all

SELECT 

id, 
v_recorder_id, 
v_region, 

case when v_district = 'Other' then v_district_other else v_district end v_district,

case when (v_site = 'Other' or v_site isnull) then v_site_other else v_site end v_site,

 v_gps_lat, 
 v_gps_lng, 
 v_gps_acc, 
 
 v_total_population, 
 v_has_health_center,
 v_has_health_center_other, 
 v_black_flies_present,
 v_mda_carried, 
 v_mda_year, 
 v_mda_month, 
 
 v_notes, 
 v_start

FROM public.espen_gn_oncho_bsa_3_village_registration_202210_v3 v


