 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_lr_lf_pretas_2_child_202506 p
	            LEFT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_lr_lf_pretas_2_child_202506 p
	            RIGHT JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 d on p.p_code_id = d.d_code_id
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
count(*) from public.metabase_lr_lf_2506_pretas_orphaned 

