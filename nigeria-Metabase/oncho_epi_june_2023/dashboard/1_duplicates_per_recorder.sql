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
 * Variable to rename metabase_ng_oncho_pre_duplicates_202306? espen_ng_oncho_stop_6_rdtov16_202206
 */

SELECT
    p.p_recorder_id "Recorders",
    count(m.id) "Total duplicates",
    p_district district,
    p_cluster_id:: int cluster_id,
    p_cluster_name cluster_name
FROM
    public.metabase_ng_oncho_pre_duplicates_202306 m
    JOIN public.v_espen_ng_oncho_stop_5_participant_202206 p ON p.id = m.id_participant
group by
    p.p_recorder_id,
    p_district,
    p_cluster_id,
    p_cluster_name