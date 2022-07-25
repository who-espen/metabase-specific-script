
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
 * Variable to rename metabase_lf_tas1_duplicates_202206? espen_ke_lf_tas1_3_resultat_fts_202206_v2
 */
 SELECT

  "Opérateurs",
  sum("Total des doublants") as "Total des doublants"

FROM (
  SELECT

    d.d_enumerator"Opérateurs",
    count(m.id) "Total des doublants"

    FROM public.metabase_lf_tas1_duplicates_202206 m
    JOIN v_espen_ke_lf_tas1_3_resultat_fts_202206_v2 d ON d.id = m.id_results

    GROUP BY d.d_enumerator

  UNION

  SELECT

    p.p_enumerator "Opérateurs",
    count(m.id) "Total des doublants"

    FROM public.metabase_lf_tas1_duplicates_202206 m
    JOIN v_espen_ke_lf_tas1_2_participant_202206_v2 p ON p.id = m.id_participant

  group by p.p_enumerator

) src

WHERE "Opérateurs" IS NOT NULL
GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC