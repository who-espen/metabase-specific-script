select 

b_recorder_id "Enregistreur",
b_code_team "Code Equipe",
b_district "District",
b_site "Site",
b_river_basin_name "Bassin",
sum(b_nb_blackflies) "Total de mouche capturé"
from public.v_espen_cg_oncho_bsc_2_capture_202208

group by "b_recorder_id","b_code_team","b_district","b_site", b_river_basin_name

order by sum(b_nb_blackflies) desc
