 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_demo_lf_tas_9999_2_part_v2 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_demo_lf_tas_9999_2_part_v2 inr
        WHERE
            src.p_code_id = inr.p_code_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_demo_lf_tas_9999_3_fts_v2 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_demo_lf_tas_9999_3_fts_v2 inr
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
count(*) from public.metabase_demo_lf_9999_tas1_duplicates






