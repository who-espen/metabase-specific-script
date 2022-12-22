SELECT 
r_larvae_evidence "Existence des larves",
sum(id) "Total"

FROM public.v_espen_civ_oncho_bsa_1_river_inspection_20221102_v1

where r_larvae_evidence is not null

group by r_larvae_evidence

order by r_larvae_evidence desc