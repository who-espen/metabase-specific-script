/*
 * File: 9_participant_per_village.sql
 * File Created: Tuesday, 5th May 2020 8:04:12 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 8:06:16 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename espen_ng_ng_oncho_prestop_1_site_202304_v2, v_espen_ng_oncho_stop_5_participant_202206
 */

SELECT
    DISTINCT ON (c_cluster_id) c_recorder_id "Recorder ID",
    c_district "LGA",
    c_cluster_id "Site IF",
    c_cluster_name "Site",
    count (p.id) "Total Participants",
    c_population "Total Population"
FROM
    public.v_espen_ng_oncho_stop_4_site_202306 c
    JOIN v_espen_ng_oncho_stop_5_participant_202206 p ON p.p_cluster_id = c.c_cluster_id --WHERE id IS NOT NULL+
GROUP BY
    c_recorder_id,
    c_cluster_name,
    c_cluster_id,
    c_district,
    c_population