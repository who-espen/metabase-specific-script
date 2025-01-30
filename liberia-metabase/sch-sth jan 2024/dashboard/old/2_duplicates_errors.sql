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
 * Variable to rename metabase_lr_sch_sth_202401_ia_duplicates, v_espen_lr_sch_sth_impact_202401_2_child_v2_1, v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1,
 * v_espen_lr_sch_sth_impact_202401_4_urine_v2_1
 */

SELECT
    "Form",
    "Council",
    "Ward",
    "School",
    "Barcode ID",
    "Recorder ID",
    "Age in Years",
    "Sex",
    date,
    "Status"

FROM (
        SELECT
            m.form "Form",
            p.p_district "Council",
            p.p_subdistrict "Ward",
            p.p_site "School",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sex",
            p.p_start date,
            status "Status"

FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    v_espen_lr_sch_sth_impact_202401_2_child_v2_1 AS p
WHERE p.id = m.id_participant

UNION ALL 

SELECT
    m.form "Form",
    k_district "Council",
    k_subdistrict "Ward",
    k_site_name "School",
    m.barcode_results_kk "Barcode ID",
    k.k_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    k.r_start date,
    status "Status"

FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    v_espen_lr_sch_sth_impact_202401_3_kato_katz_v2_1 AS k
WHERE k.id = m.id_results_kk

UNION ALL 

SELECT
    m.form "Form",
    u_district "Council",
    u_subdistrict "Ward",
    u_site_name "School",
    m.barcode_results_urine "Barcode ID",
    u.u_recorder "Recorder ID",
    null "Age in Years",
    null "Sex",
    u.u_start date,
    status "Status"

FROM
    metabase_lr_sch_sth_202401_ia_duplicates AS m,
    v_espen_lr_sch_sth_impact_202401_4_urine_v2_1 AS u
WHERE
    u.id = m.id_results_urine
) src

WHERE "Form" IS NOT NULL 