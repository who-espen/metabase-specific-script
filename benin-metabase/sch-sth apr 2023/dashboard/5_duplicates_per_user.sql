	 SELECT
 COUNT(*),
 p.p_start::date
FROM public.metabase_sch_sth_mapping_duplicates_202304 AS m, public.v_espen_bj_sch_sth_impact_202304_2_child AS p
WHERE m.id IS NOT NULL AND m.id_participant::int = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(*),
 d.k_start::date
FROM metabase_sch_sth_mapping_duplicates_202304 AS m, public.v_espen_bj_sch_sth_impact_202304_3_kato_katz_v1 AS d
WHERE m.id IS NOT NULL AND m.id_results_kk::int = d.id

GROUP BY d.k_start::DATE

UNION ALL

SELECT
 COUNT(*),
 d.u_start::date
FROM metabase_sch_sth_mapping_duplicates_202304 AS m, public.v_espen_bj_sch_sth_impact_202304_4_urine_filtration_v1 AS d
WHERE m.id IS NOT NULL AND m.id_results_urine::int = d.id

GROUP BY d.u_start::DATE