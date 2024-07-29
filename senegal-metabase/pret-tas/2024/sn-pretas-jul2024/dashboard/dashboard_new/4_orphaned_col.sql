 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
	            LEFT JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_sn_lf_pretas_2407_1_sit_part_v3 p
	            RIGHT JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 d on p.p_code_id = d.d_code_id
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
count(*) from public.metabase_sn_lf_2407_pretas_orphaned





