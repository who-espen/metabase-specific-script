SELECT 

"Opérateurs", sum("Total Doublons") "Total Doublons" 

FROM ( SELECT 

k.r_recorder "Opérateurs", count(m.id) "Total Doublons" 

FROM
    public.metabase_sn_sch_sth_202309_mapping_duplicates m
    JOIN public.v_espen_sn_sch_sth_impact_3_resultats_202308_v3 k ON k.id = m.id_results_kk :: int

GROUP BY k.r_recorder 

UNION 

SELECT 

p.p_recorder "Opérateurs", count(m.id) "Total Doublons" 

FROM
    public.metabase_sn_sch_sth_202309_mapping_duplicates m
    JOIN public.v_espen_sn_sch_sth_impact_2_child_202308_v3_2 p ON (p.id = m.id_participant:: int)

group by p.p_recorder 


) src 

WHERE "Opérateurs" IS NOT NULL 

GROUP BY "Opérateurs" 

ORDER BY "Total Doublons" DESC 