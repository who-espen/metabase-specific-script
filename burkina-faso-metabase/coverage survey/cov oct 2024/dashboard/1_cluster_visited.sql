 with site as (select distinct "Code Grappe" from public.v_espen_bf_lf_cov_1_village_202211_v2)
 
select COUNT("Code Grappe")
FROM site