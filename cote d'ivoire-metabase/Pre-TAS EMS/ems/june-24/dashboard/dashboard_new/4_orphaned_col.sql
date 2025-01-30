 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_ci_lf_pretas_2406_3_part_v4 p
	            LEFT JOIN v_espen_ci_lf_pretas_2406_4_fts_v4 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_ci_lf_pretas_2406_3_part_v4 p
	            RIGHT JOIN v_espen_ci_lf_pretas_2406_4_fts_v4 d on p.p_code_id = d.d_code_id
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
count(*) from public.metabase_ci_lf_2406_ems_orphaned





