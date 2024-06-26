SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.k_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates m
    JOIN public.v_espen_tz_sch_sth_impact_2405_3_kato_katz k ON k.id = m.id_results_kk :: int

GROUP BY k.k_recorder 

UNION all

 SELECT 

k.u_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates m
    JOIN public.v_espen_tz_sch_sth_impact_2405_4_urine_filtration k ON k.id = m.id_results_urine :: int

GROUP BY k.u_recorder 

UNION all

SELECT 

p.p_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_tz_sch_sth_202405_ia_duplicates m
    JOIN public.v_espen_tz_sch_sth_impact_2405_2_child p ON (p.id = m.id_participant:: int)

group by p.p_recorder 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 