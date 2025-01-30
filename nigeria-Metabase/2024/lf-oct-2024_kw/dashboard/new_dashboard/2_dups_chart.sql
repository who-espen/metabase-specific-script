 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_ng_lf_tas_2410_1_sit_part_kw src
WHERE (
        SELECT count (*)
        FROM
            v_espen_ng_lf_tas_2410_1_sit_part_kw inr
        WHERE
            src.p_code_id = inr.p_code_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_ng_lf_tas_2410_2_fts_kw src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_ng_lf_tas_2410_2_fts_kw inr
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
count(*) from public.metabase_ng_lf_2410_tas1_duplicates_kw






