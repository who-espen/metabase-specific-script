/*
 * File: 2_duplicates_errors.sql
 * File Created: Monday, 11th May 2020 8:13:38 pm
 * Author: Dyesse YUMBA
 * Last Modified: Tuesday, 12th May 2020 9:40:48 am
 * Modified By: Dyesse YUMBA
 * -----
 * (c) 2020, WHO/AFRO/UCN/ESPEN
 */

/*
 * A query for listing all records that use the same ID twice
 * Variable to rename metabase_tg_202309_sch_sth_impact_duplicates, v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2, v_espen_tg_sch_sth_ia_202404_2_kk_v3_1,
 * v_espen_tg_sch_sth_ia_202404_3_ur_v3_1
 */

SELECT
    "Form",
    "District",
    "USP",
    "Village",
    "Barcode ID",
    "Opérateur",
    "Age in Years",
    "Sexe",
    date,
    "Status"
FROM (
        SELECT
            m.form "Form",
            p.p_district "District",
            p.p_usp "USP",
            p.p_site "Village",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Opérateur",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sexe",
            p.p_start date,
            status "Status"
        FROM
            metabase_tg_202309_sch_sth_impact_duplicates AS m,
            v_espen_tg_sch_sth_ia_202404_1_scho_ch_v3_2 AS p
        WHERE
            p.id = m.id_participant
        UNION ALL
        SELECT
            m.form "Form",
            k_district "District",
            k_usp "USP",
            k_site_name "Village",
            m.barcode_results_kk "Barcode ID",
            k.k_recorder "Opérateur",
            null "Age in Years",
            null "Sexe",
            k.k_start date,
            status "Status"
        FROM
            metabase_tg_202309_sch_sth_impact_duplicates AS m,
            v_espen_tg_sch_sth_ia_202404_2_kk_v3_1 AS k
        WHERE
            k.id = m.id_results_kk
        UNION ALL
        SELECT
            m.form "Form",
            u_district "District",
            u_usp "USP",
            u_site_name "Village",
            m.barcode_results_urine "Barcode ID",
            u.u_recorder "Opérateur",
            null "Age in Years",
            null "Sexe",
            u.u_start date,
            status "Status"
        FROM
            metabase_tg_202309_sch_sth_impact_duplicates AS m,
            v_espen_tg_sch_sth_ia_202404_3_ur_v3_1 AS u
        WHERE
            u.id = m.id_results_urine
    ) src
WHERE "Form" IS NOT NULL