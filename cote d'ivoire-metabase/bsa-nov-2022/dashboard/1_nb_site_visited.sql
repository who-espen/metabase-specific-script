with src as (SELECT 
distinct on (c_village)
c_district,
c_village
FROM public.v_espen_civ_oncho_bsa_1_river_inspection_20221102_v1)

select count(*) from src

