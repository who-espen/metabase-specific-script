 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_demo_lf_tas_9999_1_site_v3 as 
 p
	            LEFT JOIN v_espen_demo_lf_itas_9999_3_fts d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_demo_lf_tas_9999_1_site_v3 as 
 p
	            RIGHT JOIN v_espen_demo_lf_itas_9999_3_fts d on p.p_code_id = d.d_code_id
	        WHERE
	            p.id isnull
)
as cumul)

select 

'Residual Orphaned' as "Type",
 cumul as "Total"
from cumulative_orph

union all

select

'Cumulative Orphaned'  as "Type",
count(*) from public.metabase_demo_lf_2411_tas1_orphaned_sk_kd 

