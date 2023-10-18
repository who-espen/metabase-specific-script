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
 * Variable to rename espen_cm_oncho_pre_stop_1_202309_village_v2, v_espen_cm_oncho_pre_stop_2_202309_couverture_v2
 */


SELECT
    DISTINCT ON (c_village) c_recorder_id "Recorder ID",
    c_district "District",
    --c_village_id "Code Site",
    c_village "Site",
    count (p.id) "Total Participants"
    --c_village_pop "Total Population"
FROM
    v_espen_cm_oncho_pre_stop_1_202309_village_v2 c
    JOIN v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 p ON p.p_village = c.c_village

    
GROUP BY
    c_recorder_id,
    c_village,
    c_district
   -- c_village_pop