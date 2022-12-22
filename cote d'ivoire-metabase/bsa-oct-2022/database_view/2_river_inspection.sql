create view v_espen_gn_oncho_bsa_2_river_inspection_202210 as

SELECT 

id, 
r_recorder_id, 
r_province,

case when r_district = 'Other' then r_district_other else r_district end r_district,

case when (r_site = 'Other' or r_site isnull) then r_site_other else r_site end r_site,

r_gps_lat,
r_gps_lng, 
r_gps_alt,
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

FROM public.espen_gn_oncho_bsa_2_river_inspection_202210 r