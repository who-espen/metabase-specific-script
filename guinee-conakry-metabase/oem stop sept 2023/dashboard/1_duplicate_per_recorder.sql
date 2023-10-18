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
 * Variable to rename v_espen_gn_oncho_oem_202310_2_participant_v2
 */

  SELECT
      	count(m.id) "Doublons",
      	p.p_recorder_id "Opérateur"
--      	p_district district,
--      	p_cluster_name_id cluster_id,
--      	p_cluster_name_name cluster_name
      FROM public.metabase_oncho_oem_gn_202310_duplicates m,public.v_espen_gn_oncho_oem_202310_2_participant_v2  p
        WHERE m.id_participant = p.id AND barcode_participant IS NOT NULL
        GROUP BY p.p_recorder_id --, p_district, p_cluster_name_id, p_cluster_name_name

