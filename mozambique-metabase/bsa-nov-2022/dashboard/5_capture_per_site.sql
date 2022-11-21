SELECT 
"Sítio",
"Abundância"

FROM public.v_espen_mz_oncho_bsa_2_river_inspection_202211_v1_2

where "Abundância" is not null

group by "Abundância", "Sítio"

order by "Abundância" desc