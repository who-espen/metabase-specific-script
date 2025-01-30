 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_st_lf_tas2_2412_2_partcipants_v2 p
	            LEFT JOIN v_espen_st_lf_tas2_2412_3_fts_result_v2 d on p.p_code_id = d.d_code_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_st_lf_tas2_2412_2_partcipants_v2 p
	            RIGHT JOIN v_espen_st_lf_tas2_2412_3_fts_result_v2 d on p.p_code_id = d.d_code_id
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
count(*) from public.metabase_st_lf_2412_tas2_orphaned 

