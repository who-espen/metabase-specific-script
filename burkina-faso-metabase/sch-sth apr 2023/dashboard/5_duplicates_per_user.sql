	 SELECT
 COUNT(*),
 p.p_start::date
FROM public.metabase_bf_202301_sch_sth_mapping_duplicates_202304 AS m, public.v_espen_bf_202301_sch_impact_assessment_2_enrolement_v2 AS p
WHERE m.id IS NOT NULL AND m.id_participant::int = p.id

GROUP BY p.p_start::DATE

UNION ALL

SELECT
 COUNT(*),
 d.k_start::date
FROM metabase_bf_202301_sch_sth_mapping_duplicates_202304 AS m, public.v_espen_bf_202301_sch_impact_assessment_3_resultat_selles_v3 AS d
WHERE m.id IS NOT NULL AND m.id_results_kk::int = d.id

GROUP BY d.k_start::DATE

UNION ALL

SELECT
 COUNT(*),
 d.u_start::date
FROM metabase_bf_202301_sch_sth_mapping_duplicates_202304 AS m, public.v_espen_bf_202301_sch_impact_assessment_4_resultat_urines_v3 AS d
WHERE m.id IS NOT NULL AND m.id_results_urine::int = d.id

GROUP BY d.u_start::DATE