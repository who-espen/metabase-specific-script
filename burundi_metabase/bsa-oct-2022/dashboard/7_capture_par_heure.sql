SELECT 
b_hour "Heure",
sum(b_nb_blackflies) "Total Mouches Capturé"
FROM public.v_espen_cg_oncho_bsc_2_capture_202208
group by "b_hour"

ORDER BY SUBSTRING("b_hour" FROM '([0-9]+)')::BIGINT ASC, "b_hour";


