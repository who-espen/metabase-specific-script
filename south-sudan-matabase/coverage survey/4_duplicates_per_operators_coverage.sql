with dups_cov as (SELECT 

id,
"Opérateur",
"District",
"Village",
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
WHERE src."Code Enqueté" = inr."Code Enqueté" and src."Village" = inr."Village" ) > 1
order by "Village", "Code Enqueté")

select 
"Opérateur",
count(id) "Total Doublons"
from dups_cov

group by "Opérateur"

order by "Total Doublons" desc