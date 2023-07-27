/*
 * File: 1_participant_per_village.sql
 * File Created: Thursday, 7th May 2020 11:30:31 am
 * Author: Dyesse YUMBA
 * Last Modified: Thursday, 7th May 2020 11:33:12 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * This query will return a table that will contain the number of participants per village surveyed the day before.
 * Variable to rename v_espen_bi_oncho_prestop_1_202307_site_v3, v_espen_bi_oncho_prestop_2_202307_questions_v3
 */

SELECT
    p_recorder_id "Code Opérateur",
    c_district "Duistrict",
    c_site_id "Cluster ID",
    c_site "Nom du Site",
    COUNT(p.id) "# Participant"
FROM
    v_espen_bi_oncho_prestop_1_202307_site_v3 c
    LEFT JOIN v_espen_bi_oncho_prestop_2_202307_questions_v3 p ON c.c_site_id = p.p_site_id:: INT
where
    p.p_start_time > CURRENT_start - 1
GROUP BY
    p_recorder_id,
    c_district,
    c_site_id,
    c_site