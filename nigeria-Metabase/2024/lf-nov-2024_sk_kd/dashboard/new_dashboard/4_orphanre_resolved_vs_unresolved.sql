 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23 p
	            LEFT JOIN v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_ng_lf_tas_2411_1_sit_part_sk_kd_v23 p
	            RIGHT JOIN v_espen_ng_lf_tas_2411_2_fts_yb_v2_3 d on p.p_code_id = d.d_code_id
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
count(*) from public.metabase_ng_lf_2411_tas1_orphaned_sk_kd 

