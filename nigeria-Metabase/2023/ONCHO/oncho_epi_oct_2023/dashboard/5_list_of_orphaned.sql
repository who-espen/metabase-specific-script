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
 * Variable to rename v_espen_ng_oncho_stop_2_participant_202310, v_espen_ng_oncho_stop_3_rdtov16_202310, metabase_ng_oncho_prestop_orphaned_202304
 */

SELECT
    p.p_cluster_id "Code Site",
    NULL "Nom du Site",
    p_code_id "ID Participant",
    p_recorder_id "Recorder ID",
    p_age_yrs "Age (yrs)",
    p_sex "Sex",
    NULL "Diagnostic Results",
    'Participant data' "Missing Record",
    p_date "Date",
    status "Status"
FROM
    v_espen_ng_oncho_stop_2_participant_202310 p
    LEFT JOIN v_espen_ng_oncho_stop_3_rdtov16_202310 d on p.p_code_id = d.d_code_id
    LEFT JOIN metabase_ng_oncho_prestop_orphaned_202304 m on m.id_participant = p.id
WHERE
    d.id isNULL --and p_date > '2020-09-25'
UNION ALL
SELECT
    d_cluster_id "Code Site",
    NULL "Nom du Site",
    d_code_id "ID Participant",
    d_recorder_id:: int "Recorder ID",
    NULL "Age (yrs)",
    NULL "Sex",
    d_final_result "Diagnostic Results",
    'FTS results' "Missing Record",
    d_date "Date",
    status "Status"
FROM
    v_espen_ng_oncho_stop_3_rdtov16_202310 d
    LEFT JOIN v_espen_ng_oncho_stop_2_participant_202310 p on p.p_code_id = d.d_code_id
    LEFT JOIN metabase_ng_oncho_prestop_orphaned_202304 m on m.id_results = d.id
WHERE p.id isNULL --and p_date > '2020-09-25'