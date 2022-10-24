SELECT 
b_weather "Observations Climatiques",
sum(b_nb_blackflies1) "Total Mouches Capturées"

FROM public.v_espen_civ_oncho_bsa_2_capture_form_202208_v4

where b_nb_blackflies1 is not null

group by b_weather

order by b_weather desc
