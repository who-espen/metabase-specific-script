/*
 * File: 1_duplicate_per_recorder.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:08:15 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */



/*
 * A query to display the number of duplicates per recorder
 * Variable to rename v_espen_bj_oncho_prestop_2_participants
 */
SELECT

  "Recorders",
   sum("# Dulicates") "# Dulicates"

FROM (
      SELECT
      	count(m.id) "# Dulicates",
      	p.p_recorder_id "Recorders",
      	p_district district,
      	p_cluster_id cluster_id,
      	p_cluster_name cluster_name
      FROM metabase_oncho_prestop_duplicates_202012 m, v_espen_bj_oncho_prestop_2_participants p
        WHERE m.id_participant = p.id AND barcode_participant IS NOT NULL
        GROUP BY p.p_recorder_id, p_district, p_cluster_id, p_cluster_name

      UNION

      SELECT
      	count(m.id) "# Dulicates",
      	d.d_recorder_id "Recorders",
      	d_district district,
      	d_cluster_id cluster_id,
      	d_cluster_name cluster_name
      FROM metabase_oncho_prestop_duplicates_202012 m, v_espen_bj_oncho_prestop_2_participants d
        WHERE m.id_results = p.id AND barcode_results IS NOT NULL
        GROUP BY d.d_recorder_id, d_district, d_cluster_id, d_cluster_name
) src

WHERE "Recorders" IS NOT NULL
------ Metabase filter -------
-- [[and {{district}}]]
-- [[and {{cluster_id}}]]
-- [[and {{cluster_name}}]]

GROUP BY "Recorders"

ORDER BY "# Dulicates" DESC

