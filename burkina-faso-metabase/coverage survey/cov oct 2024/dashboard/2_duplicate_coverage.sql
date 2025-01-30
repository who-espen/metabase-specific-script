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


FROM public.v_espen_bf_lf_cov_2_couverture_202211_v2 src
where (select count (*)  FROM v_espen_bf_lf_cov_2_couverture_202211_v2 inr 
WHERE src."Code Enqueté" = inr."Code Enqueté" and src."Code Grappe" = inr."Code Grappe" ) > 1
order by "Code Grappe", "Code Enqueté"