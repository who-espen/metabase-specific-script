
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
 * Variable to rename metabase_lf_tas_duplicates_202011? espen_bf_lf_tas1_3_resultat_fts_202010
 */
 SELECT

  "Opérateurs",
  sum("Total des doublants") as "Total des doublants"

FROM (
  SELECT

    d.code_operateur "Opérateurs",
    count(m.id) "Total des doublants",
    d_district district,
    d_cluster_id::int cluster_id,
    d_cluster_name cluster_name

    FROM public.metabase_lf_tas_duplicates_202011 m
    JOIN v_espen_bf_lf_tas1_3_resultat_fts_202010 d ON d.id = m.id_results

    GROUP BY d.code_operateur, d_district, d_cluster_id, d_cluster_name

  UNION

  SELECT

    p.code_operateur "Opérateurs",
    count(m.id) "Total des doublants",
   	p_district district,
   	nb_grappe::int cluster_id,
   	nom_grappe cluster_name

    FROM public.metabase_lf_tas_duplicates_202011 m
    JOIN espen_bf_lf_tas1_2_enrolement_202010 p ON p.id = m.id_participant

  group by p.code_operateur, p_district, nb_grappe, nom_grappe

) src

WHERE "Opérateurs" IS NOT NULL
------ Metabase filter -------
-- [[and {{district}}]]
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]

GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC