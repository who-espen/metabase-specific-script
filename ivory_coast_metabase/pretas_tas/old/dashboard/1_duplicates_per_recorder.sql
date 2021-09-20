
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
 * Variable to rename metabase_lf_pretas_duplicates_202008? <%ab_cde_fgh_3_fts%>
 */
 SELECT

  "Code Operateur",
  sum("# Duplicates")

FROM (
  SELECT

    d.code_operateur "Code Operateur",
    count(m.id) "# Duplicates",
    ue district,
    d_cluster_id cluster_id,
    d_cluster_name cluster_name

    FROM public.metabase_lf_pretas_duplicates_202008 m
    JOIN <%ab_cde_fgh_3_fts%> d ON d.id = m.id_fts_results

    GROUP BY d.code_operateur, ue, d_cluster_id, d_cluster_name

  UNION

  SELECT

    p.code_operateur "Code Operateur",
    count(m.id) "# Duplicates",
   	p_district district,
   	p_cluster_id cluster_id,
   	p_cluster_name cluster_name, p_district, p_cluster_id, p_cluster_name

    FROM public.metabase_lf_pretas_duplicates_202008 m
    JOIN espen_ci_pretas_lf_enrollement_v7 p ON p.id = m.id_enrollement

  group by p.code_operateur

) src

WHERE "Code Operateur" IS NOT NULL
------ Metabase filter -------
-- [[and {{district}}]]
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]

GROUP BY "Code Operateur"

ORDER BY "# Dulicates" DESC
