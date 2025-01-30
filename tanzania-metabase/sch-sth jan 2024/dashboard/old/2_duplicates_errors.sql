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
 * Variable to rename metabase_tz_sch_sth_202401_ia_duplicates, v_espen_tz_sch_sth_impact_202311_2_child_v4, v_espen_tz_sch_sth_impact_202311_3_kk_v4,
 * v_espen_tz_sch_sth_impact_202311_4_urine_v4
 */

SELECT
    "Form",
    "District",
    "Ward",
    "School",
    "Barcode ID",
    "Recorder ID",
    "Age in Years",
    "Sexe",
    date,
    "Status"

FROM (
        SELECT
            m.form "Form",
            p.p_district "District",
            p.p_ward "Ward",
            p.p_site "School",
            m.barcode_participant "Barcode ID",
            p.p_recorder "Recorder ID",
            p.p_age_yrs "Age in Years",
            p.p_sex "Sexe",
            p.p_start date,
            status "Status"

FROM
    metabase_tz_sch_sth_202401_ia_duplicates AS m,
    v_espen_tz_sch_sth_impact_202311_2_child_v4 AS p
WHERE p.id = m.id_participant

UNION ALL 

SELECT
    m.form "Form",
    k_district "District",
    k_ward "Ward",
    k_site_name "School",
    m.barcode_results_kk "Barcode ID",
    k.k_recorder "Recorder ID",
    null "Age in Years",
    null "Sexe",
    k.r_start date,
    status "Status"

FROM
    metabase_tz_sch_sth_202401_ia_duplicates AS m,
    v_espen_tz_sch_sth_impact_202311_3_kk_v4 AS k
WHERE k.id = m.id_results_kk

UNION ALL 

SELECT
    m.form "Form",
    u_district "District",
    u_ward "Ward",
    u_site_name "School",
    m.barcode_results_urine "Barcode ID",
    u.u_recorder "Recorder ID",
    null "Age in Years",
    null "Sexe",
    u.u_start date,
    status "Status"

FROM
    metabase_tz_sch_sth_202401_ia_duplicates AS m,
    v_espen_tz_sch_sth_impact_202311_4_urine_v4 AS u
WHERE
    u.id = m.id_results_urine
) src

WHERE "Form" IS NOT NULL 