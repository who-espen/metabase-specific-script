 SELECT

  "Opérateurs",
  sum("Total Doulons") "Total Doulons"

FROM (
  SELECT

    k.k_recorder_id "Opérateurs",
    count(m.id) "Total Doulons"

    FROM public.metabase_sch_sth_mapping_duplicates_202204 m
    JOIN v_espen_cd_sch_sth_baseline_3_kato_katz_202202_v2_1 k ON k.id = m.id_results_kk::int

    GROUP BY k.k_recorder_id

  UNION

  SELECT

    p.p_recorder_id "Opérateurs",
    count(m.id) "Total Doulons"

    FROM public.metabase_sch_sth_mapping_duplicates_202204 m
    JOIN v_espen_cd_sch_sth_baseline_2_child_202202_v2_1 p ON (p.id = m.id_participant::int)

  group by p.p_recorder_id

  UNION

   SELECT

    u.u_recorder_id "Opérateurs",
    count(m.id) "Total Doulons"

    FROM public.metabase_sch_sth_mapping_duplicates_202204 m
    JOIN v_espen_cd_sch_sth_baseline_4_urinefiltration_202202_v2_1 u ON u.id = m.id_results_urine::int

    GROUP BY u.u_recorder_id

  

) src

WHERE "Opérateurs" IS NOT NULL

GROUP BY "Opérateurs"

ORDER BY "Total Doulons" DESC