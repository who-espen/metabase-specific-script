
SELECT 

"Code Equipe",
"District",
"List Grappe",
"CSPS",
"Grappe",
"Numero Grappe",
"Code Grappe",
"Nombre Menage",
"Nombre Segment",
"Lat",
"Long",
"Précision"

FROM v_espen_bf_lf_cov_1_village_202211_v2 src
where (select count (*)  FROM public.v_espen_bf_lf_cov_1_village_202211_v2 inr 
WHERE  src."Code Grappe" = inr."Code Grappe" ) > 1
order by "Code Grappe"