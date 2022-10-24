with src as (SELECT 
distinct on (b_site)
b_site
FROM public.v_espen_cg_oncho_bsc_2_capture_202208)

select count(*) from src