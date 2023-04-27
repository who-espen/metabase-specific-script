
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
 * Variable to rename metabase_bj_lf_tas_202304_duplicates? espen_bj_lf_tas3_202304_3_fts_result_v1
 */
 SELECT
  "Opérateurs",
  sum("Total des doublants") as "Total des doublants"

FROM (
  SELECT

    d.d_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
    d_eu_name eu,
    d_cluster_id::int cluster_id,
    d_cluster_name cluster_name,
    d.id id_key

    FROM public.metabase_bj_lf_tas_202304_duplicates m
    JOIN v_espen_bj_lf_tas3_202304_3_fts_result_v1 d ON d.id = m.id_results
    
    where survey_designation ='TAS2'

    GROUP BY d.d_recorder_id, d_eu_name, d_cluster_id, d_cluster_name, d.id

  UNION

  SELECT

    p.p_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
   	p_eu_name eu,
   	p_cluster_id::int cluster_id,
   	p_cluster_name cluster_name,
   	p.id id_key

    FROM public.metabase_bj_lf_tas_202304_duplicates m
    JOIN v_espen_bj_lf_tas3_202304_2_partcipants_v1_1 p ON p.id = m.id_participant
    
     where survey_designation ='TAS2'

  group by p.p_recorder_id, p_eu_name, p_cluster_id, p_cluster_name, p.id

) src

WHERE "Opérateurs" IS NOT NULL

GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC