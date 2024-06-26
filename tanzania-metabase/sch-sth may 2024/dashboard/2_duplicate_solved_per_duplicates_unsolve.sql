 with cumulative_dups as (select 
 (
SELECT
    count(*)
FROM
    v_espen_tz_sch_sth_impact_2405_2_child src
WHERE (
        SELECT count (*)
        FROM
            v_espen_tz_sch_sth_impact_2405_2_child inr
        WHERE
            src.p_barcode_id = inr.p_barcode_id
    ) > 1
) 

+

(
select 
	count(*)
FROM
            v_espen_tz_sch_sth_impact_2405_3_kato_katz src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_2405_3_kato_katz inr
                WHERE
                    src.k_barcode_id = inr.k_barcode_id
            ) > 1
)

+

(
select count(*)
	FROM
            v_espen_tz_sch_sth_impact_2405_4_urine_filtration src
        WHERE (
                SELECT
                    count (*)
                FROM
                    v_espen_tz_sch_sth_impact_2405_4_urine_filtration inr
                WHERE
                    src.u_code_id = inr.u_code_id
            ) > 1
) as cumul_dups)

select 

'Residual Duplicates' as "Type",
 cumul_dups as "Total"
from cumulative_dups

union all

select

'Cumulative Duplicates'  as "Type",
count(*) from public.metabase_tz_sch_sth_202405_ia_duplicates






