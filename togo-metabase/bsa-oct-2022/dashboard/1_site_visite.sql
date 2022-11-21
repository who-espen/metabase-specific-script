with src as (SELECT 
distinct on ("Site")
"District",
"Site"
FROM public.v_espen_cg_oncho_bsc_2_capture_202209_v2)

select count(*) from src

