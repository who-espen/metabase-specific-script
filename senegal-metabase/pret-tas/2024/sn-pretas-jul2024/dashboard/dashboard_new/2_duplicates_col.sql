 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_sn_lf_pretas_2407_1_sit_part_v3 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_sn_lf_pretas_2407_1_sit_part_v3 inr
        WHERE
            src.p_code_id = inr.p_code_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_sn_lf_pretas_20407_2_fts_v3 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_sn_lf_pretas_20407_2_fts_v3 inr
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
count(*) from public.metabase_sn_lf_2407_pretas_duplicates




