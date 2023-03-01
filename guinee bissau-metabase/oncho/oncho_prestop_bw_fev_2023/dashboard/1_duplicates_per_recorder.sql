
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
 * Variable to rename metabase_gw_oncho_prestop_duplicates_202302? espen_ng_ng_oncho_prestop_3_resultat_fts_202302_v2
 */
  SELECT

    p.p_recorder_id "Recorders",
    count(m.id) "Total duplicates",
   	p_district district,
   	p_cluster_id::int cluster_id,
   	p_cluster_name cluster_name

    FROM public.metabase_gw_oncho_prestop_duplicates_202302 m
    JOIN public.v_espen_gw_oncho_202302_prestop_2_participant_v1_2 p ON p.id = m.id_participant

  group by p.p_recorder_id, p_district, p_cluster_id, p_cluster_name