/*
 * File: 5_orphaned_errors.sql
 * File Created: Wednesday, 6th May 2020 2:01:44 pm
 * Author: Dyesse YUMBA
 * Last Modified: Monday, 11th May 2020 1:09:03 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename v_espen_cm_oncho_pre_stop_2_202309_couverture_v2, <%v_ab_cde_fgh_3_rdt_ov16%>, <%metabase_oncho_oem_orphaned_202004%>
 */

SELECT
    p.p_village_id "Clustrer ID",
    NULL "Cluster Name",
    p_num_final "Barcode ID",
    p_recorder_id "Recorder ID",
    p_age_yrs "Age In Years",
    p_sexe "Sex",
    NULL "Diagnostic Results",
    'Participant data' "Missing Record",
    p_date "Date",
    status "Status"
FROM
    v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 p
    LEFT JOIN v_espen_cm_oncho_pre_stop_3_202309_diag_v2 d on p.p_num_final = d.d_num_final
    LEFT JOIN metabase_oncho_stop_cm_202309_orphaned m on m.id_participant = p.id
WHERE
    d.id isNULL ------ Metabase filter -------
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]
UNION ALL
SELECT
    d_village_id "Clustrer ID",
    NULL "Cluster Name",
    d_num_final "Barcode ID",
    d_recorder_id:: int "Recorder ID",
    NULL "Age In Years",
    NULL "Sex",
    d_lab_ov16 "Diagnostic Results",
    'OV16 results' "Missing Record",
    d_date "Date",
    status "Status"
FROM
    v_espen_cm_oncho_pre_stop_3_202309_diag_v2 d
    LEFT JOIN v_espen_cm_oncho_pre_stop_2_202309_couverture_v2 p on p.p_num_final = d.d_num_final
    LEFT JOIN metabase_oncho_stop_cm_202309_orphaned m on m.id_results = d.id
WHERE
    p.id isNULL ------ Metabase filter -------
    -- [[and {{cluster_id}}]]
    -- [[and {{cluster_name}}]]
    -- [[and {{district}}]]
    -- [[and {{date}}]]