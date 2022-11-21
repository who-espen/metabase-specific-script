SELECT 
"District",
"Site",
"Nom de la rivière",
sum("Nombre des mouches noires") "Total Mouches Capturées"
FROM public.v_espen_cg_oncho_bsc_2_capture_202209_v2
group by  "District", "Site", "Nom de la rivière"

order by  "District", "Site", "Nom de la rivière"