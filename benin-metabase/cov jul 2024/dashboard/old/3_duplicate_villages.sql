
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

FROM v_espen_bj_sct_lf_1_cov_2406_v3_3 src
where (select count (*)  FROM public.v_espen_bj_sct_lf_1_cov_2406_v3_3 inr 
WHERE  src."Code Grappe" = inr."Code Grappe" ) > 1
order by "Code Grappe"