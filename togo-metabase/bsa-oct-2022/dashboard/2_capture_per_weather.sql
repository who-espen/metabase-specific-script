SELECT 
"Observation climatique",
sum("Nombre des mouches noires") "Total Mouches Capturé"

FROM public.v_espen_cg_oncho_bsc_2_capture_202209_v2

group by "Observation climatique"

order by "Observation climatique" desc
