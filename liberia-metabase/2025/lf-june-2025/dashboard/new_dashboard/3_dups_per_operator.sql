SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.d_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_lr_lf_2506_pretas_duplicates m
    JOIN v_espen_lr_lf_pretas_3_results_fts_mf_202506 k ON k.id = m.id_results_fts :: int

GROUP BY k.d_recorder 

UNION all

SELECT 

p.p_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_lr_lf_2506_pretas_duplicates m
    JOIN v_espen_lr_lf_pretas_2_child_202506 p ON (p.id = m.id_participant:: int)

group by p.p_recorder 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 