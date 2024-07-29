SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.d_recorder_id"Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_sn_lf_2407_pretas_duplicates m
    JOIN v_espen_sn_lf_pretas_20407_2_fts_v3 k ON k.id = m.id_results_fts :: int

GROUP BY k.d_recorder_id

UNION all

SELECT 

p.c_recorder  "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_sn_lf_2407_pretas_duplicates m
    JOIN v_espen_sn_lf_pretas_2407_1_sit_part_v3 p ON (p.id = m.id_participant:: int)

group by p.c_recorder  


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 


