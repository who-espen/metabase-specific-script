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
 * Variable to rename espen_bj_oncho_stop_1_202306_site_v3, v_espen_bj_oncho_stop_2_202306_questions_v3
 */


SELECT
    DISTINCT ON (c_cluster_name) c_recorder_id "Recorder ID",
    c_district "District",
    --c_cluster_id "Code Site",
    c_cluster_name "Site",
    count (p.id) "Total Participants"
    --c_village_pop "Total Population"
FROM
    espen_bj_oncho_stop_1_202306_site_v3 c
    JOIN v_espen_bj_oncho_stop_2_202306_questions_v3 p ON p.p_site_name = c.c_cluster_name

    
GROUP BY
    c_recorder_id,
    c_cluster_name,
    c_district
   -- c_village_pop