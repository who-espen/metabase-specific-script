/*
 * File: 2_duplicates_errors.sql
 * File Created: Tuesday, 5th May 2020 3:57:42 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 5th May 2020 5:06:34 pm
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_ng_oncho_stop_duplicates_202404, v_espen_ng_oncho_stop_202404_2_part_adam_v2, v_espen_ng_oncho_stop_3_rdtov16_202404
 */

SELECT
    "Form",
    "Code Site",
    "Nom Site",
    "ID Participant",
    "Recorder ID",
    "Age (yrs)",
    -- "Nbr of years lived in the site",
    "Sex",
    "Final Result",
    date,
    "Status"
FROM (
        SELECT
            m.form "Form",
            p.p_cluster_id "Code Site",
            p.p_cluster_name "Nom Site",
            m.barcode_participant "ID Participant",
            p.p_recorder_id "Recorder ID",
            p.p_age_yrs "Age (yrs)",
            -- p.p_how_long_lived "Nbr of years lived in the site",
            p.p_sex "Sex",
            null "Final Result",
            p.p_date date,
            status "Status"
        FROM
            metabase_ng_oncho_stop_duplicates_202404 AS m,
            v_espen_ng_oncho_stop_202404_2_part_adam_v2 AS p
        WHERE
            p.id = m.id_participant -- UNION ALL
            --  SELECT
            --     m.form "Form",
            --     d.d_cluster_id "Nom Site",
            --     d.d_cluster_name "Nom Site",
            --     m.barcode_results "ID Participant",
            --     d.d_recorder_id "Recorder ID",
            --     null "Age (yrs)",
            -- null "Nbr of years lived in the site",
            --   null "Sex",
            -- d_final_result "Final Result",
            --     d.d_date date,
            --     status "Status"
            -- FROM
            --     metabase_ng_oncho_stop_duplicates_202404 AS m,
            --     public.v_espen_ng_oncho_stop_3_rdtov16_202404 AS d
            -- WHERE
            --     d.id = m.id_results
    ) src
WHERE "Form" IS NOT NULL