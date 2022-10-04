with src as (
select s_site_id from public.v_espen_ng_oncho_bsc_1_capture_202208_v2
group by s_site_id)

select count(*) from src 