
/*
 * File: 1_duplicates_per_recorder.sql
 * File Created: Tuesday, 5th May 2020 3:50:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 3:56:53 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the number of duplicates per recorder
 * Variable to rename metabase_mz_lf_tas_duplicates_202209? espen_mz_lf_tas1_3_resultat_fts_202209_v1
 */
 SELECT
  "Gravadors",
  sum("Dobradores totais") as "Dobradores totais"

FROM (
  SELECT

    d.d_recorder_id "Gravadors",
    count(m.id) "Dobradores totais",
    --d_eu eu,
    d_cluster_id::int cluster_id,
    d_cluster_name cluster_name,
    d.id id_key

    FROM public.metabase_mz_lf_tas_duplicates_202209 m
    JOIN v_espen_mz_lf_tas1_3_resultat_fts_202209_v1 d ON d.id = m.id_results
    
    --where survey_designation ='TAS2'

    GROUP BY d.d_recorder_id,d_cluster_id, d_cluster_name, d.id

  UNION

  SELECT

    p.p_recorder_id "Gravadors",
    count(m.id) "Dobradores totais",
  -- 	p_eu eu,
   	p_cluster_id::int cluster_id,
   	p_cluster_name cluster_name,
   	p.id id_key

    FROM public.metabase_mz_lf_tas_duplicates_202209 m
    JOIN v_espen_mz_lf_tas1_2_participant_202209_v1 p ON p.id = m.id_participant
    
     --where survey_designation ='TAS2'

  group by p.p_recorder_id,p_cluster_id, p_cluster_name, p.id

) src

WHERE "Gravadors" IS NOT NULL

GROUP BY "Gravadors"

ORDER BY "Dobradores totais" DESC