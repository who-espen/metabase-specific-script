SELECT 
r_larvae_evidence "Evidence of Larvae",
sum(id) "Total"

FROM public.v_espen_gn_oncho_bsa_2_river_inspection_202210

where r_larvae_evidence is not null

group by r_larvae_evidence

order by r_larvae_evidence desc