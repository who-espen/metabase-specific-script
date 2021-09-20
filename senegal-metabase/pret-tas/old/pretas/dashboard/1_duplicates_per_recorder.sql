
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
 * Variable to rename metabase_lf_tas1_duplicates_202009? espen_bj_lf_tas1_3_fts_result_202009
 */
 SELECT

  "Opérateurs",
  sum("Total des doublants") as "Total des doublants"

FROM (
  SELECT

    d.d_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
    d_district district,
    d_cluster_id::int cluster_id,
    d_cluster_name cluster_name

    FROM public.metabase_lf_tas1_duplicates_202009 m
    JOIN espen_bj_lf_tas1_3_fts_result_202009 d ON d.id = m.id_results

    GROUP BY d.d_recorder_id, d_district, d_cluster_id, d_cluster_name

  UNION

  SELECT

    p.p_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
   	p_district district,
   	p_cluster_id cluster_id,
   	p_cluster_name cluster_name

    FROM public.metabase_lf_tas1_duplicates_202009 m
    JOIN espen_sn_lf_tas1_2_partcipants_202009_manual p ON p.id = m.id_participant

  group by p.p_recorder_id, p_district, p_cluster_id, p_cluster_name

) src

WHERE "Opérateurs" IS NOT NULL
------ Metabase filter -------
-- [[and {{district}}]]
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]

GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC