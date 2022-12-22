with src as (SELECT 
distinct on (r_site)
r_district,
r_site
FROM public.v_espen_mw_oncho_bsa_2_river_inspection_202211)

select count(*) from src
