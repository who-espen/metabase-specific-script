/*
 * File: 9_participant_per_village.sql
 * File Created: Saturday, 2nd May 2020 11:05:52 am
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:10 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will display the number of participants per village
 * Variable to rename espen_gn_oncho_oem_202310_1_site_v3, v_espen_gn_oncho_oem_202310_2_participant_v2
 */


SELECT
    DISTINCT ON (c_cluster_name) c_recorder_id "Recorder ID",
    c_district "District",
    --c_cluster_name_id "Code Site",
    c_cluster_name "Site",
    count (p.id) "Total Participants"
    --c_cluster_name_pop "Total Population"
FROM
    v_espen_gn_oncho_oem_202310_1_site_v3 c
    JOIN v_espen_gn_oncho_oem_202310_2_participant_v2 p ON p.p_cluster_name = c.c_cluster_name

    
GROUP BY
    c_recorder_id,
    c_cluster_name,
    c_district
   -- c_cluster_name_pop