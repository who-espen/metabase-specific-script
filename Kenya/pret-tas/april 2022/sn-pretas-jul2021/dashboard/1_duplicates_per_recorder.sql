
/*
 * File: 1_duplicates_per_enumerator.sql
 * File Created: Tuesday, 5th May 2020 3:50:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 3:56:53 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query to display the number of duplicates per recorder
 * Variable to rename metabase_lf_pretas_duplicates_202204? espen_ke_lf_pretas_3_resultat_fts_202203_v4
 */
  SELECT

  "Operators",
  sum("Total duplicates") as "Total duplicates"

FROM (
  SELECT

    d.d_enumerator "Operators",
    count(m.id) "Total duplicates",
    d_subcounty district,
    d_cluster_id cluster_id,
    d_cluster_name cluster_name

    FROM public.metabase_lf_pretas_duplicates_202204 m
    JOIN v_espen_ke_lf_pretas_3_resultat_fts_202203_v4 d ON d.id = m.id_results

    GROUP BY d.d_enumerator, d_subcounty, d_cluster_id, d_cluster_name

  UNION

  SELECT

    p.p_enumerator "Operators",
    count(m.id) "Total duplicates",
   	p_subcounty district,
   p_cluster_id cluster_id,
   	p_cluster_name cluster_name

    FROM public.metabase_lf_pretas_duplicates_202204 m
    JOIN v_espen_ke_lf_pretas_2_participant_202203_v4 p ON p.id = m.id_participant::int

  group by p.p_enumerator, p_subcounty, p_cluster_id, p_cluster_name

) src

WHERE "Operators" IS NOT NULL

GROUP BY "Operators"

ORDER BY "Total duplicates" DESC