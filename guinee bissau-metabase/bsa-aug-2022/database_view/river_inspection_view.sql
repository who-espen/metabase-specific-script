create view v_espen_gw_oncho_bsc_1_river_inspection_202209 as

select

id, 
r_recorder_id, 
r_province, 
r_district, 
r_site, 
r_date,
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

FROM public.espen_gw_oncho_bsc_1_river_inspection_202209 r
