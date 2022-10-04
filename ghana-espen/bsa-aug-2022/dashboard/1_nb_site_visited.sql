with src as (
select s_site_id from public.v_espen_gn_oncho_bsc_1_capture_202208
group by s_site_id)

select count(*) from src 