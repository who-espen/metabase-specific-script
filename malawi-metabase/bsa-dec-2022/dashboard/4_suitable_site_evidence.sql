SELECT 
r_larvae_evidence "Existence des larves",
sum(id) "Total"

FROM public.v_espen_mw_oncho_bsa_2_river_inspection_202211

where r_larvae_evidence is not null

group by r_larvae_evidence

order by r_larvae_evidence desc