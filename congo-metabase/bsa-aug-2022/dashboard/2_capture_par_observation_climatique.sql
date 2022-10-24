SELECT 
b_weather "Observation climatique",
sum(b_nb_blackflies) "Total Mouches Capturé"

FROM public.v_espen_cg_oncho_bsc_2_capture_202208

group by b_weather

order by b_weather desc



