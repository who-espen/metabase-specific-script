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
 * Variable to rename v_espen_sn_lf_itas_2405_1_sit_part_v3_1, v_espen_sn_lf_itas_2405_1_sit_part_v3_1
 */

SELECT
    c_recorder "Code Opérateur",
    c_eu_name "Duistrict",
    c_cluster_id "Cluster ID",
    c_cluster_name "Nom du Site",
    COUNT(p.id) "# Participant"
FROM
    v_espen_sn_lf_itas_2405_1_sit_part_v3_1 c
    LEFT JOIN v_espen_sn_lf_itas_2405_1_sit_part_v3_1 p ON c.c_cluster_id = p.c_cluster_id:: INT
where
    p.p_start > CURRENT_start - 1
GROUP BY
    c_recorder,
    c_eu_name,
    c_cluster_id,
    c_cluster_name