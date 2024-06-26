/*
 * File: 5_list_of_orphaned.sql
 * File Created: Tuesday, 5th May 2020 6:29:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 6:33:56 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename v_espen_sn_lf_itas_2405_1_sit_part_v3_1, espen_sn_lf_itas_20305_2_fts_v4, metabase_sn_lf_itas_20405_orphaned
 */

SELECT
    p.c_cluster_id "Code Site",
    NULL "Nom du Site",
    p_generate_id "ID Participant",
    c_recorder "Code Opérateur",
    p_age_yrs "Age en années",
    p_sex "Sexe",
    NULL "Diagnostic Results",
    'Participant data' "Missing Record",
    p_start "Date",
    status "Statut"
FROM
    v_espen_sn_lf_itas_2405_1_sit_part_v3_1 p
    LEFT JOIN espen_sn_lf_itas_20305_2_fts_v4 d on p.p_generate_id = d.d_generate_id
    LEFT JOIN metabase_sn_lf_itas_20405_orphaned m on m.id_participant = p.id
WHERE
    d.id isNULL ------ Metabase filter -------
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]
UNION ALL
SELECT
    d_cluster_id "Code Site",
    NULL "Nom du Site",
    d_generate_id "ID Participant",
    d_recorder_id:: int "Code Opérateur",
    NULL "Age en années",
    NULL "Sexe",
    d_final_result "Diagnostic Results",
    'FTS results' "Missing Record",
    d_start "Date",
    status "Statut"
FROM
    espen_sn_lf_itas_20305_2_fts_v4 d
    LEFT JOIN v_espen_sn_lf_itas_2405_1_sit_part_v3_1 p on p.p_generate_id = d.d_generate_id
    LEFT JOIN metabase_sn_lf_itas_20405_orphaned m on m.id_results = d.id
WHERE
    p.id isNULL ------ Metabase filter -------
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]