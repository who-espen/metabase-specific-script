SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.d_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_ng_lf_2407_tas1_duplicates_kn m
    JOIN v_espen_ng_lf_tas_2406_2_fts_kn_v31 k ON k.id = m.id_results_fts :: int

GROUP BY k.d_recorder 

UNION all

SELECT 

p.c_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_ng_lf_2407_tas1_duplicates_kn m
    JOIN v_espen_ng_lf_tas_2406_1_sit_part_kn_v32 p ON (p.id = m.id_participant:: int)

group by p.c_recorder 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 