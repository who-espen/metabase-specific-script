SELECT 
b_district "District",
b_site "Site",
b_river_basin_name "Bassin",
sum(b_nb_blackflies) "Total Mouches Capturées"
FROM public.v_espen_cg_oncho_bsc_2_capture_202208
group by  "b_district", "b_site", "b_river_basin_name"

order by  "b_district", "b_site", "b_river_basin_name"