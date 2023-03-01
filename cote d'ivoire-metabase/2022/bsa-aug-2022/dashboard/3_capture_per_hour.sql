SELECT 
b_hour "Temps",
sum(b_nb_blackflies1) "Total Mouches Capturées"
FROM public.v_espen_civ_oncho_bsa_2_capture_form_202208_v4

where b_hour is not null

group by b_hour

ORDER BY SUBSTRING(b_hour FROM '([0-9]+)')::BIGINT ASC, b_hour;