SELECT 

id,
"Opérateur",
"District",
"Code Grappe",
"Num. Ménage",
"Numéro Enqueté",
"Code Enqueté",
"Répondant",
"Etait présent",
"Age (Années)",
"Age (Mois)",
"Sexe",
"Niveau Etude",
"Durée Séjour"


FROM public.v_espen_bj_sct_lf_1_cov_2406_v3_3 src
where (select count (*)  FROM v_espen_bj_sct_lf_1_cov_2406_v3_3 inr 
WHERE src."Code Enqueté" = inr."Code Enqueté" and src."Code Grappe" = inr."Code Grappe" ) > 1
order by "Code Grappe", "Code Enqueté"