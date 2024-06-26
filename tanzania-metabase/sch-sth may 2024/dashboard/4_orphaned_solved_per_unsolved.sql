 with cumulative_orph as (select 
 (
SELECT
    count(*)
FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            LEFT JOIN v_espen_tz_sch_sth_impact_2405_3_kato_katz d on p.p_barcode_id = d.k_barcode_id
	        WHERE
	            d.id isnull
) 

+

(
select 
	count(*)
FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            RIGHT JOIN v_espen_tz_sch_sth_impact_2405_3_kato_katz d on p.p_barcode_id = d.k_barcode_id
	        WHERE
	            p.id isnull
)

+

(
select count(*)
	FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            LEFT JOIN v_espen_tz_sch_sth_impact_2405_4_urine_filtration d on p.p_barcode_id = d.u_code_id
	        WHERE
	            d.id isnull
)

+

(
select count(*)
	FROM
	            v_espen_tz_sch_sth_impact_2405_2_child p
	            RIGHT JOIN v_espen_tz_sch_sth_impact_2405_4_urine_filtration d on p.p_barcode_id = d.u_code_id
	        WHERE
	            p.id isnull
) as cumul)

select 

'Residual Duplicates' as "Type",
 cumul as "Total"
from cumulative_orph

union all

select

'Cumulative Orphaned'  as "Type",
count(*) from public.metabase_tz_sch_sth_202405_mapping_orphaned

