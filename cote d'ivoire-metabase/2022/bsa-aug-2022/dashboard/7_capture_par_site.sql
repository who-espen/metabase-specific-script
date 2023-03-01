SELECT 
b_district "District",
b_site "Site",
b_capture_point "Point de capture",
sum(b_nb_blackflies1) "Total Mouches Capturées"
FROM public.v_espen_civ_oncho_bsa_2_capture_form_202208_v4
group by  b_district, b_site, b_capture_point

order by  b_district, b_site, b_capture_point