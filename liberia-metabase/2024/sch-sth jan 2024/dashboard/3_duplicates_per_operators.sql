SELECT 

"Registrer", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.k_recorder "Registrer", count(m.id) "Total Duplicates" 

FROM
    public.metabase_lr_sch_sth_202401_ia_duplicates m
    JOIN public.v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 k ON k.id = m.id_results_kk :: int

GROUP BY k.k_recorder 

UNION 

SELECT 

p.p_recorder "Registrer", count(m.id) "Total Duplicates" 

FROM
    public.metabase_lr_sch_sth_202401_ia_duplicates m
    JOIN public.v_espen_lr_sch_sth_impact_202401_2_child_v2_1 p ON (p.id = m.id_participant:: int)

group by p.p_recorder 


) src 

WHERE "Registrer" IS NOT NULL 

GROUP BY "Registrer" 

ORDER BY "Total Duplicates" DESC 