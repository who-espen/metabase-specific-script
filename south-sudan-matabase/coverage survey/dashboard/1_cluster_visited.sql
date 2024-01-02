 with site as (select distinct "Village" from public.v_espen_ss_oncho_cov_3_202309_full_v2)
 
select COUNT("Village")
FROM site