SELECT 
c_village "Site",
r_abundance "Existence des larves"

FROM public.v_espen_civ_oncho_bsa_1_river_inspection_20221102_v1

where r_abundance is not null

group by r_abundance, c_village

order by r_abundance desc