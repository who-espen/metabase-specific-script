select 

s_province,
s_district,
s_river_basin_name,
s_river_name,
s_gps_lat,
s_gps_lng


from public.v_espen_cg_oncho_bsc_1_site_202208

where s_density <> '-'
