 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 p
	            LEFT JOIN v_espen_ng_lf_tas_2406_2_fts_kn_v31 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 p
	            RIGHT JOIN v_espen_ng_lf_tas_2406_2_fts_kn_v31 d on p.p_code_id = d.d_code_id
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
count(*) from public.metabase_ng_lf_2407_tas1_orphaned_kn

