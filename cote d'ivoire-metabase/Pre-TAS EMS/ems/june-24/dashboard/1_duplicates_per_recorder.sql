
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
 * Variable to rename metabase_ci_lf_2407_ems_duplicates? espen_ci_lf_pretas_3_resultat_fts_202302
 */
 
 SELECT

  "Opérateurs",
  sum("Total des doublants") as "Total des doublants"

FROM (
  SELECT

    d.d_recorder_id "Opérateurs",
    count(m.id) "Total des doublants"

    FROM public.metabase_ci_lf_2407_ems_duplicates m
    JOIN v_espen_ci_lf_pretas_2406_4_fts_v4 d ON d.id = m.id_results

    GROUP BY d.d_recorder_id

  UNION

  SELECT

    p.p_recorder_id "Opérateurs",
    count(m.id) "Total des doublants"

    FROM public.metabase_ci_lf_2407_ems_duplicates m
    JOIN v_espen_ci_lf_pretas_2406_3_part_v4 p ON p.id = m.id_participant

  group by p.p_recorder_id

) src

WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC