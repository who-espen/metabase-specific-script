 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_st_lf_tas2_2412_2_partcipants_v2 src
WHERE (
        SELECT count (*)
        FROM
            v_espen_st_lf_tas2_2412_2_partcipants_v2 inr
        WHERE
            src.p_code_id = inr.p_code_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_st_lf_tas2_2412_3_fts_result_v2 src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_st_lf_tas2_2412_3_fts_result_v2 inr
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
count(*) from public.metabase_st_lf_2412_tas2_duplicates






