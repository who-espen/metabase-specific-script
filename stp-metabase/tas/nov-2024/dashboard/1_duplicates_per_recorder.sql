
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
 * Variable to rename metabase_st_lf_2412_tas2_duplicates? espen_ng_lf_tas2_202412_3_resultat_fts_jgw_v3
 */


 SELECT

  "Recorders",
  sum("Total duplicates") as "Total duplicates"

FROM (
  SELECT

    d.d_recorder_id "Recorders",
    count(m.id) "Total duplicates",
    d_district district,
    d_cluster_id::int cluster_id,
    d_cluster_name cluster_name

    FROM public.metabase_st_lf_2412_tas2_duplicates m
    JOIN v_espen_st_lf_tas2_2412_3_fts_result_v2 d ON d.id = m.id_results

    GROUP BY d.d_recorder_id, d_district, d_cluster_id, d_cluster_name

  UNION

  SELECT

    p.p_recorder_id "Recorders",
    count(m.id) "Total duplicates",
   	p_district district,
   	p_cluster_id::int cluster_id,
   	p_cluster_name cluster_name

    FROM public.metabase_st_lf_2412_tas2_duplicates m
    JOIN v_espen_st_lf_tas2_2412_3_fts_result_v2_v2 p ON p.id = m.id_participant

  group by p.p_recorder_id, p_district, p_cluster_id, p_cluster_name

) src

WHERE "Recorders" IS NOT NULL
GROUP BY "Recorders"

ORDER BY "Total duplicates" DESC
