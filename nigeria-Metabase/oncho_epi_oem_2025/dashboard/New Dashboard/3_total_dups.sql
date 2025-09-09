SELECT 

"Recorder ID", sum("Total Duplicates") "Total Duplicates" 

FROM (

SELECT 

p.p_recorder_id "Recorder ID", count(m.id) "Total Duplicates" 

FROM
    public.metabase_ng_oncho_2507_oem_duplicates m
    JOIN v_espen_ng_oncho_stop_2507_2_part_oem p ON (p.id = m.id_participant:: int)

group by p.p_recorder_id 


) src 

WHERE "Recorder ID" IS NOT NULL 

GROUP BY "Recorder ID" 

ORDER BY "Total Duplicates" DESC 