SELECT 
c_village "Site",
r_abundance "Existence des larves"

FROM public.v_espen_mw_oncho_bsa_2_river_inspection_202211

where r_abundance is not null

group by r_abundance, c_village

order by r_abundance desc