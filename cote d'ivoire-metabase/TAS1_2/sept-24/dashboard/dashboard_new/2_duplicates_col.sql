 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_ci_lf_tas1_2409_2_partcipants src
WHERE (
        SELECT count (*)
        FROM
            v_espen_ci_lf_tas1_2409_2_partcipants inr
        WHERE
            src.p_code_id = inr.p_code_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_ci_lf_tas1_2409_3_fts_result src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ci_lf_tas1_2409_3_fts_result inr
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
count(*) from public.metabase_ci_lf_2409_tas_duplicates




