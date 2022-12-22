create view v_espen_mw_oncho_bsa_2_river_inspection_202211 as

SELECT 

id, 
 r_recorder_id, 
 
case when r_district = 'Other' then r_district_other else r_district end r_district,
 
case when r_site = 'Other' then r_site_other else r_site end r_site,

r_gps_lat, 
r_gps_lng, 
 r_gps_acc, 
 
case when r_river = 'Other' then r_river_other else r_river end r_river,

 r_river_bassin, 
 r_water_temperature,
 r_water_ph, 
 r_inspection_time, 
 r_larvae_evidence,
 r_abundance,
 r_note,
 r_start


FROM public.espen_mw_oncho_bsa_2_river_inspection_202211 r
