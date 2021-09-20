
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
 * Variable to rename metabase_lf_pretas_duplicates_202010? espen_bf_lf_pretas_3_resultat_202007_v2
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

    FROM public.metabase_lf_pretas_duplicates_202010 m
    JOIN v_espen_bf_lf_pretas_3_resultat_202007_v2 d ON d.id = m.id_results

    GROUP BY d.d_recorder_id, d_district, d_cluster_id, d_cluster_name

  UNION

  SELECT

    p.p_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
   	p_district district,
   	p_cluster_id::int cluster_id,
   	p_cluster_name cluster_name

    FROM public.metabase_lf_pretas_duplicates_202010 m
    JOIN espen_bf_lf_pretas_2_enrollement_202007_v2 p ON p.id = m.id_participant

  group by p.p_recorder_id, p_district, p_cluster_id, p_cluster_name

) src

WHERE "Opérateurs" IS NOT NULL
------ Metabase filter -------
-- [[and {{district}}]]
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]

GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC