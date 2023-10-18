/*
 * File: 1_participant_per_village.sql
 * File Created: Monday, 4th May 2020 2:18:07 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:10:55 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return a table that will contain the number of participants per village surveyed the day before.
 * Variable to rename <%ab_cde_fgh_3_rdt_ov16%>, v_espen_cm_oncho_pre_stop_2_202309_couverture_v2
 */

SELECT
    p_recorder_id "Recorder ID",
    c_district "Duistrict",
    c_village_id "Cluster ID",
    c_village "Cluster Name",
    COUNT(p.id) "# Participant"
FROM
    v_espen_cm_oncho_pre_stop_1_202309_village_v2 p
    LEFT JOIN v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 c ON c.c_village_id = p.p_village_id:: INT
where
    p.p_date > CURRENT_DATE - 1
GROUP BY
    p_recorder_id,
    c_district,
    c_village_id,
    c_village