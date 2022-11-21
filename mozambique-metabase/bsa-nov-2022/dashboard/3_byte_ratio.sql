SELECT 
"Número de mordidas",
count("Número de mordidas") "Ratio"

FROM public.v_espen_mz_oncho_bsa_1_vector_community_question_202211_v1

where "Número de mordidas" is not null

group by "Número de mordidas"

order by "Número de mordidas" desc