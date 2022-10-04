SELECT 
"Heure",
sum("Nombre des mouches noires") "Total Mouches Capturé"
FROM public.v_espen_bj_oncho_bsa_2_capture_form_202207_v3
group by "Heure"

ORDER BY SUBSTRING("Heure" FROM '([0-9]+)')::BIGINT ASC, "Heure";