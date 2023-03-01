SELECT 
c_bites_number "Bites Number",
count(c_bites_number) "Ratio"

FROM public.v_espen_gn_oncho_bsa_1_vector_community_question_202210_v3

where c_bites_number is not null

group by c_bites_number

order by c_bites_number desc