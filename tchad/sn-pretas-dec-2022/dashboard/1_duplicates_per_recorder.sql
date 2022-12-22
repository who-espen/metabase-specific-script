
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
 * Variable to rename metabase_td_lf_pretas_duplicates_202212? espen_td_lf_pretas_3_resultat_fts_202208_v2
 */
  SELECT

  "Opérateurs",
  sum("Total des doublants") as "Total des doublants"

FROM (
  SELECT

    d.d_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
    d_district district,
    d_site_id cluster_id,
    d_site cluster_name

    FROM public.metabase_td_lf_pretas_duplicates_202212 m
    JOIN v_espen_td_lf_pretas_3_resultat_fts_202208_v2 d ON d.id = m.id_results

    GROUP BY d.d_recorder_id, d_district, d_site_id, d_site

  UNION

  SELECT

    p.p_recorder_id "Opérateurs",
    count(m.id) "Total des doublants",
   	p_district district,
   p_site_id cluster_id,
   	p_site_name cluster_name

    FROM public.metabase_td_lf_pretas_duplicates_202212 m
    JOIN v_espen_td_lf_pretas_2_participant_202208_v2 p ON p.id = m.id_participant::int

  group by p.p_recorder_id, p_district, p_site_id, p_site_name

) src

WHERE "Opérateurs" IS NOT NULL

GROUP BY "Opérateurs"

ORDER BY "Total des doublants" DESC