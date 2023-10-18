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
 * Variable to rename <%ab_cde_fgh_3_rdt_ov16%>, v_espen_civ_oncho_ia_202309_2_participant_v4
 */

SELECT
    p_recorder_id "Recorder ID",
    c_district "Duistrict",
    c_cluster_id "Cluster ID",
    s_site "Cluster Name",
    COUNT(p.id) "# Participant"
FROM
    v_espen_civ_oncho_ia_202309_1_site_v4 p
    LEFT JOIN v_espen_civ_oncho_ia_202309_2_participant_v4 c ON c.c_cluster_id = p.p_cluster_id :: INT
where
    p.p_date > CURRENT_DATE - 1
GROUP BY
    p_recorder_id,
    c_district,
    c_cluster_id,
    s_site