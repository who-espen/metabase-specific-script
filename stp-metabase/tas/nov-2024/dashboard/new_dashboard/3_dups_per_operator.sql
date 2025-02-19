SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM ( SELECT 

k.d_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_st_lf_2412_tas2_duplicates m
    JOIN v_espen_st_lf_tas2_2412_3_fts_result_v2 k ON k.id = m.id_results_fts :: int

GROUP BY k.d_recorder 

UNION all

SELECT 

p.p_recorder "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_st_lf_2412_tas2_duplicates m
    JOIN v_espen_st_lf_tas2_2412_2_partcipants_v2 p ON (p.id = m.id_participant:: int)

group by p.p_recorder 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 