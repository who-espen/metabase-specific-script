create view v_espen_demo_lf_tas_9999_1_site_v3 as 

SELECT 

id, 
c_recorder,
c_date_visit, 
c_admin1, 
c_eu,
c_iu, 
case when c_health_facility = 'Other' then c_health_facility_2
else c_health_facility end as c_health_facility,

c_site, 
c_site_id, 

case when c_site_type_2 is null or c_site_type_2 = '' then c_site_type else c_site_type_2 end as c_site_type,

c_site_leader,
c_population, 
c_present, 
c_absent,
c_eligible, 
c_toilet, 
c_type_toilet, 
c_has_water, 
c_src_water_school, 
c_last_mad, 
c_gps_lat,
c_gps_lng, 
c_gps_acc, 
c_notes, 
c_start

FROM espen_demo_lf_tas_9999_1_site_v3 c