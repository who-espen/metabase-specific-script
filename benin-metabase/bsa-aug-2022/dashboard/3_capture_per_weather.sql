SELECT 
"Observation climatique",
sum("Nombre des mouches noires") "Total Mouches Capturé"

FROM public.v_espen_bj_oncho_bsa_2_capture_form_202207_v3

group by "Observation climatique"

order by "Observation climatique" desc
