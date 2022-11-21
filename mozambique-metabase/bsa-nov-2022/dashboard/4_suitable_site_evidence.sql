SELECT 
"Provas de larvas",
sum(id) "Total"

FROM public.v_espen_mz_oncho_bsa_2_river_inspection_202211_v1_2

where "Provas de larvas" is not null

group by "Provas de larvas"

order by "Provas de larvas" desc