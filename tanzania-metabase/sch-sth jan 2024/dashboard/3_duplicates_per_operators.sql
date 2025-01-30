SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.k_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_tz_sch_sth_202401_ia_duplicates m
    JOIN public.v_espen_tz_sch_sth_impact_202311_3_kk_v4 k ON k.id = m.id_results_kk :: int

GROUP BY k.k_recorder 

UNION 

SELECT 

p.p_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_tz_sch_sth_202401_ia_duplicates m
    JOIN public.v_espen_tz_sch_sth_impact_202311_2_child_v4 p ON (p.id = m.id_participant:: int)

group by p.p_recorder 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 