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
 * Variable to rename v_espen_bi_oncho_prestop_2_202307_questions_v3, v_espen_bi_oncho_prestop_3_202307_diag_v2, metabase_oncho_prestop_orphaned_202307
 */

SELECT
    p.p_site_id "Code Site",
    NULL "Nom du Site",
    p_barecode_id "Code Participant",
    p_recorder_id "Code Opérateur",
    p_age_yrs "Age en Années",
    p_sex "Sexe",
    NULL "Diagnostic Results",
    'Participant data' "Missing Record",
    p_start_time "Date",
    status "Status"
FROM
    v_espen_bi_oncho_prestop_2_202307_questions_v3 p
    LEFT JOIN v_espen_bi_oncho_prestop_3_202307_diag_v2 d on p.p_barecode_id = d.d_barecode_id
    LEFT JOIN metabase_oncho_prestop_orphaned_202307 m on m.id_participant = p.id
WHERE
    d.id isNULL ------ Metabase filter -------
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]
UNION ALL
SELECT
    d_site_id "Code Site",
    NULL "Nom du Site",
    d_barecode_id "Code Participant",
    d_recorder_id:: int "Code Opérateur",
    NULL "Age en Années",
    NULL "Sexe",
    d_lab_elisa "Diagnostic Results",
    'FTS results' "Missing Record",
    d_start_time "Date",
    status "Status"
FROM
    v_espen_bi_oncho_prestop_3_202307_diag_v2 d
    LEFT JOIN v_espen_bi_oncho_prestop_2_202307_questions_v3 p on p.p_barecode_id = d.d_barecode_id
    LEFT JOIN metabase_oncho_prestop_orphaned_202307 m on m.id_results = d.id
WHERE
    p.id isNULL ------ Metabase filter -------
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]