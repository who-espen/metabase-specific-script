SELECT 
c_bites_number "Nombre piqûre",
count(c_bites_number) "Ratio"

FROM public.v_espen_civ_oncho_bsa_2_vector_community_question_20221102_v1

where c_bites_number is not null

group by c_bites_number

order by c_bites_number desc