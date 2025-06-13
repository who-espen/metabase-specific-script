 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_lr_lf_pretas_2_child_202506 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_lr_lf_pretas_2_child_202506 inr
        WHERE
            src.p_code_id = inr.p_code_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_lr_lf_pretas_3_results_fts_mf_202506 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_lr_lf_pretas_3_results_fts_mf_202506 inr
                WHERE
                    src.d_code_id = inr.d_code_id
            ) > 1
)

as cumul_dups)

select 

'Residual Duplicates' as "Type",
 cumul_dups as "Total"
from cumulative_dups

union all

select

'Cumulative Duplicates'  as "Type",
count(*) from public.metabase_lr_lf_2506_pretas_duplicates






