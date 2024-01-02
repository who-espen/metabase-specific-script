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
 * Variable to rename espen_sn_lf_pretas_1_sites_202307, v_espen_sn_lf_pretas_2_partcipants_202307_v1_3
 */

SELECT
    DISTINCT ON (c_cluster_id) c_recorder "Code Opérateur",
    c_district "District",
    c_cluster_id "Cluster ID",
    c_cluster_name "Nom du Site",
    count (p.id) "Total Participants",
    c_population "Total Population"
FROM
    v_espen_sn_lf_pretas_1_sites_202307 c
    JOIN v_espen_sn_lf_pretas_2_partcipants_202307_v1_3 p ON p.p_cluster_id = c.c_cluster_id
WHERE c.id IS NOT NULL
GROUP BY
    c_recorder,
    c_cluster_id,
    c_district,
    c_population,
    c_cluster_name