create view v_espen_civ_oncho_bsa_1_river_inspection_20221102_v1 as

SELECT

 id,
 r_recorder_id c_recorder_id,
 c_region, 
 
 case when c_district = 'Other' then c_district_other else c_district end c_district,
  
 case when c_health_facility = 'Other' then c_health_facility_other else c_health_facility end c_health_facility,
 
 case when c_village = 'Other' then c_village_other else c_village end c_village,
 
 r_gps_lat,
 r_gps_lng, 
r_gps_acc, 
r_river, 
r_river_bassin, 
r_water_temperature,
r_water_ph, 
r_inspection_time, 
r_larvae_evidence,
r_abundance, 
r_note, 
r_start

FROM public.espen_civ_oncho_bsa_1_river_inspection_20221102_v1 r