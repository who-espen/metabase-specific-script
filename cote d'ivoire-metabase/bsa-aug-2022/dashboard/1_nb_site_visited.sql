with src as (
select b_site from public.v_espen_civ_oncho_bsa_2_capture_form_202208_v4
group by b_site)

select count(*) from src 