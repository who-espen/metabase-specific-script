 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_ng_oncho_stop_2507_2_part_ia_ba src
WHERE (
        SELECT count (*)
        FROM
            v_espen_ng_oncho_stop_2507_2_part_ia_ba inr
        WHERE
            src.p_code_id = inr.p_code_id
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
count(*) from public.metabase_ng_oncho_2507_ia_duplicates