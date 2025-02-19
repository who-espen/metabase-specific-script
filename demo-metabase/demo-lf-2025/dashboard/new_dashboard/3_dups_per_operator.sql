SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.d_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_demo_lf_9999_tas1_duplicates m
    JOIN v_espen_demo_lf_tas_9999_3_fts_v2 k ON k.id = m.id_results_fts :: int

GROUP BY k.d_recorder 

UNION all

SELECT 

p.c_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_demo_lf_9999_tas1_duplicates m
    JOIN v_espen_demo_lf_tas_9999_2_part_v2 p ON (p.id = m.id_participant:: int)

group by p.c_recorder 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 