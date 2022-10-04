SELECT 
weather "Weather observation",
sum(nb_collected) "Total Flies Captured"

FROM public.v_espen_gn_oncho_bsc_1_capture_202208

where nb_collected is not null

group by weather

order by weather desc
