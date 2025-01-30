SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

d_recorder_id"Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_ci_lf_2409_tas_duplicates m
    JOIN v_espen_ci_lf_tas1_2409_3_fts_result k ON k.id = m.id_results_fts :: int

GROUP BY d_recorder_id

UNION all

SELECT 

p.p_recorder_id"Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_ci_lf_2409_tas_duplicates m
    JOIN v_espen_ci_lf_tas1_2409_2_partcipants p ON (p.id = m.id_participant:: int)

group by p.p_recorder_id


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 









